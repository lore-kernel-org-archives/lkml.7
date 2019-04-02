Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C42DC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F08D21473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731825AbfDBRyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:54:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46054 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbfDBRyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 13:54:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hBNbl-0004hR-OS; Tue, 02 Apr 2019 17:54:01 +0000
Date:   Tue, 2 Apr 2019 18:54:01 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>
Subject: Re: [PATCH v3 00/24] Convert vfs.txt to vfs.rst
Message-ID: <20190402175401.GL2217@ZenIV.linux.org.uk>
References: <20190327051717.23225-1-tobin@kernel.org>
 <20190402094934.5b242dc0@lwn.net>
 <20190402164824.GK2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402164824.GK2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 05:48:24PM +0100, Al Viro wrote:

> ->d_prune() must not drop/regain any of the locks held by caller.
> It must _not_ free anything attached to dentry - that belongs
> later in the shutdown sequence.  If anything, I'm tempted to
> make it take const struct dentry * as argument, just to make
> that clear.
> 
> No new (counted) references can be acquired by that point;
> lockless dcache lookup might find our dentry a match, but
> result of such lookup is not going to be legitimized - it's
> doomed to be thrown out as stale.
> 
> It really makes more sense as part of struct dentry lifecycle
> description...  
> 
> [1] in theory, ->d_time might be changed by overlapping lockless
> call of ->d_revalidate().  Up to filesystem - VFS doesn't touch
> that field (and AFAICS only NFS uses it these days).

One addition: ->d_prune() can overlap only with
	* lockless ->d_hash()/->d_compare()
	* lockless ->d_revalidate()
	* lockless ->d_manage()
So it must not destroy anything used by those without an RCU
delay.  The same goes for ->d_release() - both the list of
the things it can overlap with and requirements re RCU delays.

In-tree ->d_prune() instances are fine and so's the majority
of ->d_release().  However, autofs ->d_release() has something
that looks like an RCU use-after-free waiting to happen:
static void autofs_dentry_release(struct dentry *de)
{
        struct autofs_info *ino = autofs_dentry_ino(de);
        struct autofs_sb_info *sbi = autofs_sbi(de->d_sb);

        pr_debug("releasing %p\n", de);

        if (!ino)
                return;
...
        autofs_free_ino(ino);
}
with autofs_free_ino() being straight kfree().  Which means
that the lockless case of autofs_d_manage() can run into
autofs_dentry_ino(dentry) getting freed right under it.

And there we do have this reachable:
int autofs_expire_wait(const struct path *path, int rcu_walk)
{
        struct dentry *dentry = path->dentry;
        struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
        struct autofs_info *ino = autofs_dentry_ino(dentry);
        int status;
        int state;

        /* Block on any pending expire */
        if (!(ino->flags & AUTOFS_INF_WANT_EXPIRE))
                return 0;
        if (rcu_walk)
                return -ECHILD;

the second check buggers off in lockless mode; the first one
can be done in lockless mode just fine, so AFAICS we do have
a problem there.  Smells like we ought to make that kfree
in autofs_free_ino() RCU-delayed...  Ian, have you, by any
chance, run into reports like that?  Use-after-free or
oopsen in autofs_expire_wait() and friends, that is...

AFAICS, everything else is safe; however, looking through
those has turned up a fishy spot in ceph_d_revalidate():
        } else if (d_really_is_positive(dentry) &&
                   ceph_snap(d_inode(dentry)) == CEPH_SNAPDIR) {
                valid = 1;
Again, lockless ->d_revalidate() is called without anything
that would hold ->d_inode stable; the first part of the
condition does not guarantee that we won't run into
ceph_snap(NULL) and oops.  Sure, compiler is almost certainly
not going to reload here, but we ought to use d_inode_rcu(dentry)
there.

Sigh...
