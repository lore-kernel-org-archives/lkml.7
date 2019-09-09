Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CA3C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0578021D82
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfIIWWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 18:22:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbfIIWWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 18:22:23 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E351C058CBD
        for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2019 22:22:23 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id v143so18147174qka.21
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 15:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPNwyU/i5Hrqk518iMHxH7f+QUjV0R1yOPd/BqO65Co=;
        b=mUaSbZXYQTvrHZ85wg1JlbLPwvnQdY/ODgPDiArnCZ5x6WXO3RMfPGtiu6U9PU2GqD
         RnqChBxY60yn5YKIg5GxcAr4PSYsypPR2bcp5Y5tgin9vS/y/eOPc3g5TN3vRZ2/nCs7
         /4A+aQ2Bc7U2rggf9fjZDHVHMojsa3MyEmalARNV0RM+hsuBgqZnxdIoyU1edK02bdoR
         i0Ww756+FSwTk60LWLWUV/mWoPim7suXyNakAMFtEeeBT1qeRZ5mrFpIZ6fZCB9UjNfw
         4XSEqgBzxohIMYPb8YlA0BjBRCBoYs03zzpTY2Ix6sIE22FafYfP3MPslqnnIU/K1gHQ
         gSHQ==
X-Gm-Message-State: APjAAAVXIeQ/WUD/mn9oHhk97HUdmEy8X4bhP6ccImxcm69daopZtqLg
        alDsjRkM8wVYKq9z6qsCER4QBfaOVOzKCfUfE1jSKJ+KwyWFjQmghojOjmHFxBaPtw5Y+4rnknm
        PEWQzvmxFvTB7znoXwxtA/zUPL3v4ITlhP0ixG0wu
X-Received: by 2002:a37:a704:: with SMTP id q4mr8563256qke.385.1568067742238;
        Mon, 09 Sep 2019 15:22:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyGnOwm2ekp6jByIB3XOFxN2unWHvHlemsm8rvM+i9VYMDuMiI2JiyRDC/WJZGNljWt1aHGW1G97/hJZGLFmEk=
X-Received: by 2002:a37:a704:: with SMTP id q4mr8563216qke.385.1568067741764;
 Mon, 09 Sep 2019 15:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <87k1ahojri.fsf@suse.com> <20190909102834.16246-1-lhenriques@suse.com>
 <3f838e42a50575595c7310386cf698aca8f89607.camel@kernel.org> <87d0g9oh4r.fsf@suse.com>
In-Reply-To: <87d0g9oh4r.fsf@suse.com>
From:   Gregory Farnum <gfarnum@redhat.com>
Date:   Mon, 9 Sep 2019 15:22:10 -0700
Message-ID: <CAJ4mKGZVjJxQA69s92C+7DFbDxv87SOj10AUfyLXwVe9b+SDTw@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: allow object copies across different filesystems
 in the same cluster
To:     Luis Henriques <lhenriques@suse.com>
Cc:     Jeff Layton <jlayton@kernel.org>, IlyaDryomov <idryomov@gmail.com>,
        Sage Weil <sage@redhat.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 9, 2019 at 4:15 AM Luis Henriques <lhenriques@suse.com> wrote:
>
> "Jeff Layton" <jlayton@kernel.org> writes:
>
> > On Mon, 2019-09-09 at 11:28 +0100, Luis Henriques wrote:
> >> OSDs are able to perform object copies across different pools.  Thus,
> >> there's no need to prevent copy_file_range from doing remote copies if the
> >> source and destination superblocks are different.  Only return -EXDEV if
> >> they have different fsid (the cluster ID).
> >>
> >> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> >> ---
> >>  fs/ceph/file.c | 18 ++++++++++++++----
> >>  1 file changed, 14 insertions(+), 4 deletions(-)
> >>
> >> Hi,
> >>
> >> Here's the patch changelog since initial submittion:
> >>
> >> - Dropped have_fsid checks on client structs
> >> - Use %pU to print the fsid instead of raw hex strings (%*ph)
> >> - Fixed 'To:' field in email so that this time the patch hits vger
> >>
> >> Cheers,
> >> --
> >> Luis
> >>
> >> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> >> index 685a03cc4b77..4a624a1dd0bb 100644
> >> --- a/fs/ceph/file.c
> >> +++ b/fs/ceph/file.c
> >> @@ -1904,6 +1904,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
> >>      struct ceph_inode_info *src_ci = ceph_inode(src_inode);
> >>      struct ceph_inode_info *dst_ci = ceph_inode(dst_inode);
> >>      struct ceph_cap_flush *prealloc_cf;
> >> +    struct ceph_fs_client *src_fsc = ceph_inode_to_client(src_inode);
> >>      struct ceph_object_locator src_oloc, dst_oloc;
> >>      struct ceph_object_id src_oid, dst_oid;
> >>      loff_t endoff = 0, size;
> >> @@ -1915,8 +1916,17 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
> >>
> >>      if (src_inode == dst_inode)
> >>              return -EINVAL;
> >> -    if (src_inode->i_sb != dst_inode->i_sb)
> >> -            return -EXDEV;
> >> +    if (src_inode->i_sb != dst_inode->i_sb) {
> >> +            struct ceph_fs_client *dst_fsc = ceph_inode_to_client(dst_inode);
> >> +
> >> +            if (ceph_fsid_compare(&src_fsc->client->fsid,
> >> +                                  &dst_fsc->client->fsid)) {
> >> +                    dout("Copying object across different clusters:");
> >> +                    dout("  src fsid: %pU dst fsid: %pU\n",
> >> +                         &src_fsc->client->fsid, &dst_fsc->client->fsid);
> >> +                    return -EXDEV;
> >> +            }
> >> +    }
> >
> > Just to be clear: what happens here if I mount two entirely separate
> > clusters, and their OSDs don't have any access to one another? Will this
> > fail at some later point with an error that we can catch so that we can
> > fall back?
>
> This is exactly what this check prevents: if we have two CephFS from two
> unrelated clusters mounted and we try to copy a file across them, the
> operation will fail with -EXDEV[1] because the FSIDs for these two
> ceph_fs_client will be different.  OTOH, if these two filesystems are
> within the same cluster (and thus with the same FSID), then the OSDs are
> able to do 'copy-from' operations between them.
>
> I've tested all these scenarios and they seem to be handled correctly.
> Now, I'm assuming that *all* OSDs within the same ceph cluster can
> communicate between themselves; if this assumption is false, then this
> patch is broken.  But again, I'm not aware of any mechanism that
> prevents 2 OSDs from communicating between them.

Your assumption is correct: all OSDs in a Ceph cluster can communicate
with each other. I'm not aware of any plans to change this.

I spent a bit of time trying to figure out how this could break
security models and things and didn't come up with anything, so I
think functionally it's fine even though I find it a bit scary.

Also, yes, cluster FSIDs are UUIDs so they shouldn't collide.
-Greg

>
> [1] Actually, the files will still be copied because we'll fallback into
> the default VFS generic_copy_file_range behaviour, which is to do
> reads+writes operations.
>
> Cheers,
> --
> Luis
>
>
> >
> >
> >>      if (ceph_snap(dst_inode) != CEPH_NOSNAP)
> >>              return -EROFS;
> >>
> >> @@ -1928,7 +1938,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
> >>       * efficient).
> >>       */
> >>
> >> -    if (ceph_test_mount_opt(ceph_inode_to_client(src_inode), NOCOPYFROM))
> >> +    if (ceph_test_mount_opt(src_fsc, NOCOPYFROM))
> >>              return -EOPNOTSUPP;
> >>
> >>      if ((src_ci->i_layout.stripe_unit != dst_ci->i_layout.stripe_unit) ||
> >> @@ -2044,7 +2054,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
> >>                              dst_ci->i_vino.ino, dst_objnum);
> >>              /* Do an object remote copy */
> >>              err = ceph_osdc_copy_from(
> >> -                    &ceph_inode_to_client(src_inode)->client->osdc,
> >> +                    &src_fsc->client->osdc,
> >>                      src_ci->i_vino.snap, 0,
> >>                      &src_oid, &src_oloc,
> >>                      CEPH_OSD_OP_FLAG_FADVISE_SEQUENTIAL |
