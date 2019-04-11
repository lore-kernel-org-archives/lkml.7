Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34427C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12312184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfDKUC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:02:28 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59722 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfDKUC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:02:28 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hEftW-0001nm-Pi; Thu, 11 Apr 2019 20:01:58 +0000
Date:   Thu, 11 Apr 2019 21:01:58 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>, Theodore Ts'o <tytso@mit.edu>,
        Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 14/15] dcache: Implement partial shrink via Slab
 Movable Objects
Message-ID: <20190411200158.GG2217@ZenIV.linux.org.uk>
References: <20190411013441.5415-1-tobin@kernel.org>
 <20190411013441.5415-15-tobin@kernel.org>
 <20190411023322.GD2217@ZenIV.linux.org.uk>
 <20190411024821.GB6941@eros.localdomain>
 <20190411044746.GE2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411044746.GE2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 05:47:46AM +0100, Al Viro wrote:

> The reason for that dance is the locking - shrink list belongs to whoever
> has set it up and nobody else is modifying it.  So __dentry_kill() doesn't
> even try to remove the victim from there; it does all the teardown
> (detaches from inode, unhashes, etc.) and leaves removal from the shrink
> list and actual freeing to the owner of shrink list.  That way we don't
> have to protect all shrink lists a single lock (contention on it would
> be painful) and we don't have to play with per-shrink-list locks and
> all the attendant headaches (those lists usually live on stack frame
> of some function, so just having the lock next to the list_head would
> do us no good, etc.).  Much easier to have the shrink_dentry_list()
> do all the manipulations...
> 
> The bottom line is, once it's on a shrink list, it'll stay there
> until shrink_dentry_list().  It may get extra references after
> being inserted there (e.g. be found by hash lookup), it may drop
> those, whatever - it won't get freed until we run shrink_dentry_list().
> If it ends up with extra references, no problem - shrink_dentry_list()
> will just kick it off the shrink list and leave it alone.

FWIW, here's a braindump of sorts on the late stages of dentry
lifecycle (cut'n'paste from the local notes, with minimal editing;
I think the outright obscenities are all gone, but not much is done
beyond that):

        Events at the end of life

__dentry_kill() is called.  This is the point of no return; the victim
has no counting references left, no new ones are coming and we are
committed to tearing it down.  Caller is holding the following locks:
	a) ->d_lock on dentry itself
	b) ->i_lock on its inode, if dentry is positive
	c) ->d_lock on its parent, if dentry has a parent.
Acquiring those in the sane order (a nests inside of c, which nests inside of b)
can be rather convoluted, but that's the responsibility of callers.

State of dentry at that point:
        * it must not be a PAR_LOOKUP one, if it ever had been.  [See section
on PAR_LOOKUP state, specifically the need to exit that state before
dropping the last reference; <<the section in question is in too disorganised
state to include it here>>].
	* ->d_count is either 0 (eviction pathways - d_prune_aliases(),
shrink_dentry_list()) or 1 (when we are disposing of the last reference
and want it evicted rather than retained - dentry_kill(), called by
dput() or shrink_dentry_list()).  Note that ->d_lock stabilizes ->d_count.
        * its ->d_subdirs must be already empty (or we would've had
counting references from those).  Again, stabilized by ->d_lock.

We can detect dentries having reached that state by observing (under ->d_lock)
a negative ->d_count - that's the very first thing __dentry_kill() does.

At that point ->d_prune() is called - that's the last chance for a filesystem
to see a doomed dentry more or less intact.

After that dentry passes through several stages of teardown:
        * if dentry had been on LRU list, it is removed from there.
        * if dentry had been hashed, it is unhashed (and ->d_seq is
bumped)
        * dentry is made unreachable via d_child
        * dentry is made negative; if it used to be positive, inode
reference is dropped.  That's another place where filesystem might
get a chance to play (->d_iput(), as always for transitions from
positive to negative).  At that stage all spinlocks are dropped.
	* final filesystem call: ->d_release().  That's the time
to release whatever data structures filesystem might've had augmenting
that dentry.  NOTE: lockless accesses are still possible at that
point, so anything needed for those (->d_hash(), ->d_compare(),
lockless case of ->d_revalidate(), lockless case of ->d_manage())
MUST NOT be freed without an RCU delay.

At that stage dentry is essentially a dead body.  It might still
have lockless references hanging around and it might on someone's
shrink list, but that's it.  The next stage is body disposal,
either immediately (if not on anyone's shrink list) or once
the owner of shrink list in question gets around to
shrink_dentry_list().

Disposal is done in dentry_free().  For dentries not on any
shrink list it's called directly from __dentry_kill().  That's
the normal case.  For dentries currently on some shrink list
__dentry_kill() marks the dentry as fully dead (DCACHE_MAY_FREE)
and leave it for eventual shrink_dentry_list() to feed to
dentry_free().

Once dentry_free() is called, there can be only lockless references.
At that point the only things left in the sucker are
	* name (->d_name)
	* superblock it belongs to (->d_sb; won't be freed without
an RCU delay and neither will its file_system_type)
	* methods' table (->d_op)
	* ->d_flags and ->d_seq
	* parent's address (->d_parent; not pinned anymore - its
ownership is passed to caller, which proceeds to drop the reference.
However, parent will also not be freed without an RCU delay,
so lockless users can safely dereference it)
	* ->d_fsdata, if the filesystem had seen fit to leave it
around (see above re RCU delays for destroying anything used
by lockless methods)

Generally we don't get around to actually freeing dentry
(in __d_free()/__d_free_external()) without an RCU delay.

There is one important case where we *do* expedited freeing -
pipes and sockets (to be more precise, the stuff created by
alloc_file_pseudo()).  Those can't have lockless references
at all - they are never hashed, they are not anyone's parents
and they can't be a starting point of a lockless pathwalk
(see path_init() for details).  And they are created and
destroyed often enough to make RCU delays a noticable burden.
So for those we do freeing immediately.  In -next it's
marked by DCACHE_NORCU in flags; in mainline it's a bit of
a mess at the moment.

The reason for __d_free/__d_free_external separation is
somewhat subtle.  We obviously need an RCU delay between
dentry_free() and freeing an external name, but why not
do the "drop refcout on external name and free if it hits
zero" right in __d_free()?  The thing is, we need an RCU
delay between the last decrement of extname refcount and
its freeing.  Suppose we have two dentries that happen
to share an extname.  Initially:

d1->d_name.name == d2->d_name.name == &ext->name; ext->count == 2

CPU1:
dentry_free(d1)
call_rcu() schedules __d_free()

CPU2:
d_path() on child of d2: rcu_read_lock(),
start walking towards root, copying names
get to d2, pick d2->d_name.name (i.e. ext->name)

CPU3:
rename d2, dropping a reference to its old name.
ext->count is 1 now, nothing freed.

CPU2:
start copying ext->name[]

... and scheduled __d_free() runs, dropping the last reference to
ext and freeing it.  The reason is that call_rcu() has happened
*BEFORE* rcu_read_lock(), so we get no protection whatsoever.

In other words, we need the decrement and check of external name
refcount before the RCU delay.  We could do the decrement and
check in __d_free(), but that would demand an additional RCU
delay for freeing.  It's cheaper do decrement-and-check right
in dentry_free() and make the decision whether to free there.
Thus the two variants of __d_free() - one for "need to free
the external name", another for "no external name or not the
last reference to it".

In the scenario above the actual kernel gets ext->count to 1
in the dentry_free(d1) and schedules plain __d_free().  Then
when we rename d2 dropping the other reference gets ext->count
to 0 and we use kfree_rcu() to schedule its freeing.  And _that_
happens after ->d_name switch, so either d_path() doesn't see
ext at all, or we are guaranteed that RCU delay before freeing
ext has started after rcu_read_lock() has been done by d_path().
