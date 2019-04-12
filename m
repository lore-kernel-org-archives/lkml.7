Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56087C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 21:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270362083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 21:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfDLVxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 17:53:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50208 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfDLVxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 17:53:40 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hF476-0005e7-TN; Fri, 12 Apr 2019 21:53:36 +0000
Date:   Fri, 12 Apr 2019 22:53:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        axboe@kernel.dk
Subject: Re: [PATCH REPOST] docs: Add struct file refcounting and SCM_RIGHTS
 mess info
Message-ID: <20190412215336.GL2217@ZenIV.linux.org.uk>
References: <20190411142308.179247a4@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411142308.179247a4@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 02:23:08PM -0600, Jonathan Corbet wrote:
> +======================
> +Lifecycles and locking
> +======================
> +
> +This manual aspires to cover the lifecycles of VFS objects and the locking
> +that protects them.
> +
> +Reference counting for file structures
> +======================================
> +
> +(The following text derives from `this email from Al Viro
> +<https://lwn.net/ml/linux-fsdevel/20190207040058.GW2217@ZenIV.linux.org.uk/>`_).
> +
> +The :c:type:`struct file` type represents an open file in the kernel.  Its

That wants a separate section in the beginning, with overview of notions for
which the word "file" gets misused ;-)  I have something, but it's too much
of a rant at the moment (mostly regarding the unknown linguistic genius
somewhere in the bowels of POSIX committees, responsible for the term
"file description" used along with and in contrast to "file descriptor").

> +lifetime is controlled by a simple reference count (f_count) in that
> +structure.  References are obtained with functions like fget(), fdget(),
> +and fget_raw(); they are returned with fput().

... and fdput().  BTW, are you sure that "returned" is the right verb here?
Would "released" or "dropped" be less overloaded?

The set is actually
	fget{,_raw}()		fput()
	fdget{,_raw}()		fdput()
	fdget_pos()		fdput_pos()
	get_file()		fput()
	get_file_rcu()		fput()		[not for general use]

Not sure if it's worth putting here, but _raw variants are the ones that
accept O_PATH files and fdget_pos() is "with XSI 2.9.7-inflicted exclusion".

> +.. FIXME we should have kerneldoc comments for those functions
> +

> +Descriptor tables
> +-----------------

That wants an overview of WTF those are and what are they for; again, fodder
for the overview section in the beginning...

> +execve() does almost the same thing: if the pre-exec descriptor table is
> +shared, it will switch to a new copy first.  In case of success the
> +reference to the original table is dropped, in case of failure we revert to
> +the original and drop the copy.  Note that handling of close-on-exec is
> +done in the *copy*; the original is unaffected, so failing in execve() does
> +not disrupt the descriptor table.

The last part is actually a bit misleading - close-on-exec is handled only after
the point of no return on execve(), so any execve() failure either happens
before we get to doing that, or the caller gets killed.

What that really gives is that descriptor table sharing is terminated by
execve(), even if it had been across the thread group boundary, and those
who used to share it are unaffected by our close-on-exec (everyone in the
same thread group will be simply killed by execve(); however, other processes
might be sharing the damn thing as well and _they_ will keep going - with
the original table).

> +The SCM_RIGHTS datagram option with Unix-domain sockets can be used to
> +transfer a file descriptor, and its associated struct file reference, to
> +the receiving process.

"transfer X and Y to Z" implies that both X and Y are transferred; in reality
only Y is...   I'm not sure how to put it in one sentence, though ;-/

Perhaps something along the lines of "to pass opened files between the
processes" might be better, with details explained after that?  Those who
understand what SCM_RIGHTS is will be fine either way, but I had a bad
experience explaining what SCM_RIGHTS was to people who'd never looked
into that thing before.  And most of the problems had been precisely
because of confusion re what gets passed around...  The variant I'd
found to work best is along the lines of

################
	Sender has an opened file and wants to give it to recepient.
Of course, telling recepient "the file I want you to use is
descriptor 42" is useless - _their_ descriptor 42 has nothing to do
with yours, to start with.  What's needed is
	* getting the opened file reference from sender's descriptor
table into recepients'
	* telling the recepient where in _their_ descriptor table
has it ended up.
	The way it's done is
1) sender specifies which of its opened files should be passed (by
their locations in sender's descriptor table, i.e. their file descriptors).
2) references to these opened files are attached to a packet and sent
over.
3) the packet is received; unused slots in recepient's descriptor table
are chosen (same as open(2), pipe(2), etc. would have done),
opened file references from the packet are inserted into those slots
and their numbers (i.e. file descriptors for recepient to use) are
given to recepient.  They are more than likely to be different
from whatever descriptors sender used, of course; it's the opened
files they refer to that got passed.
	That requires cooperation from recepient, of course - if
nothing else, they need to tell recvmsg(2) where to put that
array of descriptors.  Details are more than slightly clumsy;
look around in csmg_data(3) for sad boilerplate.
################

I think it's too verbose to use here, though, and I've no idea how to do it
in more concise form...

[snip]

> +Note that, in both cases, the leaks are caused by loops passing through

s/loops/loops in the graph of references/, maybe?

> +some SCM_RIGHTS datagrams that can never be received.  So locating those,
> +removing them from the queues they sit in and then discarding the suckers,
> +is enough to resolve the situation. Furthermore, in both cases the loop
> +passes through the unix_sock of something that got sent over in an
> +SCM_RIGHTS datagram.  So we can do the following:

I wonder if the subsequent discussion of the garbage collector guts (as
opposed to the need to have it + "the strategy is to find a set of undeliverable
SCM_RIGHTS datagrams and kick them out, breaking the unreachable loops")
would better off living separately...
