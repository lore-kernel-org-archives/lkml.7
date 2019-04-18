Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82F9C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 03:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3372184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 03:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQCZG8vc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387929AbfDRDiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 23:38:06 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35969 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732325AbfDRDiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 23:38:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id s83so397095qke.3;
        Wed, 17 Apr 2019 20:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBYuFnwbcjYOpiEKrKPQVkOk6Eg+rvfTC74KUi0ag2Q=;
        b=mQCZG8vcWogE0a1HYzn20xOQKcuCNRxxH2AwF8vuDENsU8QTs0XFmBICzQttAmFvxL
         v6deNdqbEPWk3sYPzQQVmXvBJwPk2wMVeGCQMjCFQGKc3kDx4QEjfYB2JU0uObqHkhR2
         znPm3bydtuLLi0trR8Qh+9oCogasgIbFDi5L9RoXsaZgh7D0Dr0CWxkVzR60T/VPO+5D
         9oCk0mAlYYy+Yk5tPBAXTTKnijmr0jIUJotqQyogBrenLTDYMsiAZf8xX9Tmk9a3kFTH
         dgkjuqLwGOSuC31drcsZJ4no4jP5KkMLcTmy+JOJIr+wfZkxDfa6gM6EzKm9qxLiATaL
         OJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBYuFnwbcjYOpiEKrKPQVkOk6Eg+rvfTC74KUi0ag2Q=;
        b=nPqZvQvmSDXuBW38UoQ93uUW2FYnMnZ/7q7rC7KQSPKDPwBFYwol1B4GcI/ziPj+o6
         bqvU9Y9rnUZplbUixadLdBKEw18jMvwdrCIcBTfp3mL5i43t0kF7Gqv7pFS+fUmVmIYN
         s1ZpTWN2h2ryIGhkNNGzghhhcQLH8Z7iZjOAP7yM32alPQZ25qXlLhoiH+CX9gbapEBq
         GVvzgoItfVNwL5rtl9aoH7nYbA9EEwGCiYDQSf2nuJBqpD8sRkHDfkW0opNF9uoRxvx6
         kBL3xKawzSMa4iH5A9EiEtTSwD70hwNkcmooKCsjg38Hk+mDNYYyxoqLXWPG2cmwoxgI
         3H/Q==
X-Gm-Message-State: APjAAAVmF1JhBe1GqOxmZMcCJKsePAE8ZB/SZXXydKy02o+4mY/OHDeU
        Ep9gT6Zqa/sSejexPIizm0yOsmziyRZWK/dNQLADlESXYiQ=
X-Google-Smtp-Source: APXvYqykd2uUYNctyvy9ymieqCW0BkA5GCMA8jyzjgFPvWcgrLIEbF8jnRb15+XWll6rgQ3Ro7SEySxj6FddhCTwIg0=
X-Received: by 2002:a37:9fc6:: with SMTP id i189mr71827628qke.246.1555558683979;
 Wed, 17 Apr 2019 20:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190315111107.15154-1-lhenriques@suse.com> <CAAM7YAnD_dK2py+95N8Z7T+Vgr2ZbBJne+tNYivEeUGObhpiCQ@mail.gmail.com>
 <87r2b4zd2q.fsf@suse.com> <CAAM7YAkhA6ddto3KESWm8yw3D6f02ev7oYmEto=nK3mXZeUy4A@mail.gmail.com>
 <87lg1c17b2.fsf@suse.com> <CAAM7YAnhJUey6eX6zeWuPCVgyG9JghGQetJ-hk5R8nONivZzkg@mail.gmail.com>
 <87a7hr19v7.fsf@suse.com> <87o963jkcj.fsf@suse.com> <CAAM7YAko8qnfjWEdEqX=XE3azDZLpO_+egxDEsqowK9ByYZxwg@mail.gmail.com>
 <878swre7xz.fsf@suse.com> <87d0lm6psq.fsf@suse.com>
In-Reply-To: <87d0lm6psq.fsf@suse.com>
From:   "Yan, Zheng" <ukernel@gmail.com>
Date:   Thu, 18 Apr 2019 11:37:52 +0800
Message-ID: <CAAM7YAmGzYM0wKGKJ3Z_uHOTgcmEjXhXtuu8NwE+sbRhiRj=Mg@mail.gmail.com>
Subject: Re: [PATCH] ceph: Fix a memory leak in ci->i_head_snapc
To:     Luis Henriques <lhenriques@suse.com>
Cc:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 9:30 PM Luis Henriques <lhenriques@suse.com> wrote:
>
> Luis Henriques <lhenriques@suse.com> writes:
>
> > "Yan, Zheng" <ukernel@gmail.com> writes:
> >
> >> On Fri, Mar 22, 2019 at 6:04 PM Luis Henriques <lhenriques@suse.com> wrote:
> >>>
> >>> Luis Henriques <lhenriques@suse.com> writes:
> >>>
> >>> > "Yan, Zheng" <ukernel@gmail.com> writes:
> >>> >
> >>> >> On Tue, Mar 19, 2019 at 12:22 AM Luis Henriques <lhenriques@suse.com> wrote:
> >>> >>>
> >>> >>> "Yan, Zheng" <ukernel@gmail.com> writes:
> >>> >>>
> >>> >>> > On Mon, Mar 18, 2019 at 6:33 PM Luis Henriques <lhenriques@suse.com> wrote:
> >>> >>> >>
> >>> >>> >> "Yan, Zheng" <ukernel@gmail.com> writes:
> >>> >>> >>
> >>> >>> >> > On Fri, Mar 15, 2019 at 7:13 PM Luis Henriques <lhenriques@suse.com> wrote:
> >>> >>> >> >>
> >>> >>> >> >> I'm occasionally seeing a kmemleak warning in xfstest generic/013:
> >>> >>> >> >>
> >>> >>> >> >> unreferenced object 0xffff8881fccca940 (size 32):
> >>> >>> >> >>   comm "kworker/0:1", pid 12, jiffies 4295005883 (age 130.648s)
> >>> >>> >> >>   hex dump (first 32 bytes):
> >>> >>> >> >>     01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
> >>> >>> >> >>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >>> >>> >> >>   backtrace:
> >>> >>> >> >>     [<00000000d741a1ea>] build_snap_context+0x5b/0x2a0
> >>> >>> >> >>     [<0000000021a00533>] rebuild_snap_realms+0x27/0x90
> >>> >>> >> >>     [<00000000ac538600>] rebuild_snap_realms+0x42/0x90
> >>> >>> >> >>     [<000000000e955fac>] ceph_update_snap_trace+0x2ee/0x610
> >>> >>> >> >>     [<00000000a9550416>] ceph_handle_snap+0x317/0x5f3
> >>> >>> >> >>     [<00000000fc287b83>] dispatch+0x362/0x176c
> >>> >>> >> >>     [<00000000a312c741>] ceph_con_workfn+0x9ce/0x2cf0
> >>> >>> >> >>     [<000000004168e3a9>] process_one_work+0x1d4/0x400
> >>> >>> >> >>     [<000000002188e9e7>] worker_thread+0x2d/0x3c0
> >>> >>> >> >>     [<00000000b593e4b3>] kthread+0x112/0x130
> >>> >>> >> >>     [<00000000a8587dca>] ret_from_fork+0x35/0x40
> >>> >>> >> >>     [<00000000ba1c9c1d>] 0xffffffffffffffff
> >>> >>> >> >>
> >>> >>> >> >> It looks like it is possible that we miss a flush_ack from the MDS when,
> >>> >>> >> >> for example, umounting the filesystem.  In that case, we can simply drop
> >>> >>> >> >> the reference to the ceph_snap_context obtained in ceph_queue_cap_snap().
> >>> >>> >> >>
> >>> >>> >> >> Link: https://tracker.ceph.com/issues/38224
> >>> >>> >> >> Cc: stable@vger.kernel.org
> >>> >>> >> >> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> >>> >>> >> >> ---
> >>> >>> >> >>  fs/ceph/caps.c | 7 +++++++
> >>> >>> >> >>  1 file changed, 7 insertions(+)
> >>> >>> >> >>
> >>> >>> >> >> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> >>> >>> >> >> index 36a8dc699448..208f4dc6f574 100644
> >>> >>> >> >> --- a/fs/ceph/caps.c
> >>> >>> >> >> +++ b/fs/ceph/caps.c
> >>> >>> >> >> @@ -1054,6 +1054,7 @@ int ceph_is_any_caps(struct inode *inode)
> >>> >>> >> >>  static void drop_inode_snap_realm(struct ceph_inode_info *ci)
> >>> >>> >> >>  {
> >>> >>> >> >>         struct ceph_snap_realm *realm = ci->i_snap_realm;
> >>> >>> >> >> +
> >>> >>> >> >>         spin_lock(&realm->inodes_with_caps_lock);
> >>> >>> >> >>         list_del_init(&ci->i_snap_realm_item);
> >>> >>> >> >>         ci->i_snap_realm_counter++;
> >>> >>> >> >> @@ -1063,6 +1064,12 @@ static void drop_inode_snap_realm(struct ceph_inode_info *ci)
> >>> >>> >> >>         spin_unlock(&realm->inodes_with_caps_lock);
> >>> >>> >> >>         ceph_put_snap_realm(ceph_sb_to_client(ci->vfs_inode.i_sb)->mdsc,
> >>> >>> >> >>                             realm);
> >>> >>> >> >> +       /*
> >>> >>> >> >> +        * ci->i_head_snapc should be NULL, but we may still be waiting for a
> >>> >>> >> >> +        * flush_ack from the MDS.  In that case, we still hold a ref for the
> >>> >>> >> >> +        * ceph_snap_context and we need to drop it.
> >>> >>> >> >> +        */
> >>> >>> >> >> +       ceph_put_snap_context(ci->i_head_snapc);
> >>> >>> >> >>  }
> >>> >>> >> >>
> >>> >>> >> >>  /*
> >>> >>> >> >
> >>> >>> >> > This does not seem right.  i_head_snapc is cleared when
> >>> >>> >> > (ci->i_wrbuffer_ref_head == 0 && ci->i_dirty_caps == 0 &&
> >>> >>> >> > ci->i_flushing_caps == 0) . Nothing do with dropping ci->i_snap_realm.
> >>> >>> >> > Did you see 'reconnect denied' during the test? If you did, the fix
> >>> >>> >> > should be in iterate_session_caps()
> >>> >>> >> >
> >>> >>> >>
> >>> >>> >> No, I didn't saw any 'reconnect denied' in the test.  The test actually
> >>> >>> >> seems to execute fine, except from the memory leak.
> >>> >>> >>
> >>> >>> >> It's very difficult to reproduce this issue, but last time I managed to
> >>> >>> >> get this memory leak to trigger I actually had some debugging code in
> >>> >>> >> drop_inode_snap_realm, something like:
> >>> >>> >>
> >>> >>> >>   if (ci->i_head_snapc)
> >>> >>> >>         printk("i_head_snapc: 0x%px\n", ci->i_head_snapc);
> >>> >>> >
> >>> >>> > please add code that prints i_wrbuffer_ref_head, i_dirty_caps,
> >>> >>> > i_flushing_caps. and try reproducing it again.
> >>> >>> >
> >>> >>>
> >>> >>> Ok, it took me a few hours, but I managed to reproduce the bug, with
> >>> >>> those extra printks.  All those values are set to 0 when the bug
> >>> >>> triggers (and i_head_snapc != NULL).
> >>> >>>
> >>> >>
> >>> >> Thanks, which test triggers this bug?
> >>> >
> >>> > That's generic/013.  It usually triggers after a few hours of running it
> >>> > in a loop (I'm using a vstart cluster for that).
> >>> >
> >>> >>
> >>> >> I searched that code, found we may fail to cleanup i_head_snap in two
> >>> >> places. One is in ceph_queue_cap_snap, Another is in
> >>> >> remove_session_caps_cb().
> >>> >
> >>> > Ah, great!  I spent a lot of time looking but I couldn't really find it.
> >>> > My bet was that ceph_queue_cap_snap was doing the ceph_get_snap_context
> >>> > and that the corresponding ceph_put_snap_context would be done in
> >>> > handle_cap_flush_ack. That's why I mentioned the missing flush_ack from
> >>> > MDS.
> >>>
> >>> Something that I didn't said explicitly is that I *know* that the
> >>> unbalanced ceph_get_snap_context() is the one in function
> >>> ceph_queue_cap_snap().  I know this for sure because I've managed to
> >>> reproduce the issue several times with an instrumented kernel (with
> >>> tracepoints) that allowed me to keep track of all ceph_snap_context
> >>> operations (create, get, put, delete).
> >>>
> >>
> >> Sorry for the delay. please try
> >
> > Thank you, I'll try the test with your patch applied and see if I still
> > see the issue (obviously, this will take some time as it takes several
> > hours for the bug to trigger).
>
> Ok, after several hours of running it, I confirm that I was not able to
> reproduce the issue with your patch.  It took me a while because my test
> environment changed a bit and I was failing to reproduce it even without
> the patch.
>

Thanks, I pushed the patch to testing branch.

Yan, Zheng

> Cheers,
> --
> Luis
