Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F2DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0A32184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732138AbfJVNrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 09:47:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:55284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730540AbfJVNrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:47:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF95EAE86;
        Tue, 22 Oct 2019 13:47:01 +0000 (UTC)
Date:   Tue, 22 Oct 2019 14:47:00 +0100
From:   Luis Henriques <lhenriques@suse.com>
To:     "Yan, Zheng" <ukernel@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ceph: Fix use-after-free in __ceph_remove_cap
Message-ID: <20191022134700.GA23308@hermes.olymp>
References: <20191017144636.28617-1-lhenriques@suse.com>
 <a68eeb81a5b193be2da49b83dfedce7d2782fb40.camel@kernel.org>
 <87a79unocw.fsf@suse.com>
 <CAAM7YA=dg8ufUWqrD_V8pSdvxrnU+knOW4uW4io_b=Lwjhpg5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAM7YA=dg8ufUWqrD_V8pSdvxrnU+knOW4uW4io_b=Lwjhpg5Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 08:48:56PM +0800, Yan, Zheng wrote:
> On Mon, Oct 21, 2019 at 10:55 PM Luis Henriques <lhenriques@suse.com> wrote:
> 
> >
> > Jeff Layton <jlayton@kernel.org> writes:
> >
> > > On Thu, 2019-10-17 at 15:46 +0100, Luis Henriques wrote:
> > >> KASAN reports a use-after-free when running xfstest generic/531, with
> > the
> > >> following trace:
> > >>
> > >> [  293.903362]  kasan_report+0xe/0x20
> > >> [  293.903365]  rb_erase+0x1f/0x790
> > >> [  293.903370]  __ceph_remove_cap+0x201/0x370
> > >> [  293.903375]  __ceph_remove_caps+0x4b/0x70
> > >> [  293.903380]  ceph_evict_inode+0x4e/0x360
> > >> [  293.903386]  evict+0x169/0x290
> > >> [  293.903390]  __dentry_kill+0x16f/0x250
> > >> [  293.903394]  dput+0x1c6/0x440
> > >> [  293.903398]  __fput+0x184/0x330
> > >> [  293.903404]  task_work_run+0xb9/0xe0
> > >> [  293.903410]  exit_to_usermode_loop+0xd3/0xe0
> > >> [  293.903413]  do_syscall_64+0x1a0/0x1c0
> > >> [  293.903417]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >>
> > >> This happens because __ceph_remove_cap() may queue a cap release
> > >> (__ceph_queue_cap_release) which can be scheduled before that cap is
> > >> removed from the inode list with
> > >>
> > >>      rb_erase(&cap->ci_node, &ci->i_caps);
> > >>
> > >> And, when this finally happens, the use-after-free will occur.
> > >>
> > >> This can be fixed by protecting the rb_erase with the s_cap_lock
> > spinlock,
> > >> which is used by ceph_send_cap_releases(), before the cap is freed.
> > >>
> > >> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> > >> ---
> > >>  fs/ceph/caps.c | 4 ++--
> > >>  1 file changed, 2 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> > >> index d3b9c9d5c1bd..21ee38cabe98 100644
> > >> --- a/fs/ceph/caps.c
> > >> +++ b/fs/ceph/caps.c
> > >> @@ -1089,13 +1089,13 @@ void __ceph_remove_cap(struct ceph_cap *cap,
> > bool queue_release)
> > >>      }
> > >>      cap->cap_ino = ci->i_vino.ino;
> > >>
> > >> -    spin_unlock(&session->s_cap_lock);
> > >> -
> > >>      /* remove from inode list */
> > >>      rb_erase(&cap->ci_node, &ci->i_caps);
> > >>      if (ci->i_auth_cap == cap)
> > >>              ci->i_auth_cap = NULL;
> > >>
> > >> +    spin_unlock(&session->s_cap_lock);
> > >> +
> > >>      if (removed)
> > >>              ceph_put_cap(mdsc, cap);
> > >>
> > >
> > > Is there any reason we need to wait until this point to remove it from
> > > the rbtree? ISTM that we ought to just do that at the beginning of the
> > > function, before we take the s_cap_lock.
> >
> > That sounds good to me, at least at a first glace.  I spent some time
> > looking for any possible issues in the code, and even run a few tests.
> >
> > However, looking at git log I found commit f818a73674c5 ("ceph: fix cap
> > removal races"), which moved that rb_erase from the beginning of the
> > function to it's current position.  So, unless the race mentioned in
> > this commit has disappeared in the meantime (which is possible, this
> > commit is from 2010!), this rbtree operation shouldn't be changed.
> >
> > And I now wonder if my patch isn't introducing a race too...
> > __ceph_remove_cap() is supposed to always be called with the session
> > mutex held, except for the ceph_evict_inode() path.  Which is where I'm
> > seeing the UAF.  So, maybe what's missing here is the s_mutex.  Hmm...
> >
> >
> we can't lock s_mutex here, because i_ceph_lock is locked

Well, my idea wasn't to get s_mutex here but earlier in the stack.
Maybe in ceph_evict_inode, protecting the call to __ceph_remove_caps.
But I didn't really looked into that yet, so I'm not really sure if
that's feasible (or even if that would fix this UAF).  I suspect that's
not possible anyway, due to the comment above __ceph_remove_cap:

  caller will not hold session s_mutex if called from destroy_inode.

Cheers,
--
Luís
