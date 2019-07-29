Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E83FC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D222075B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tvjDYKlM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfG2JsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 05:48:04 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33384 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfG2JsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 05:48:03 -0400
Received: by mail-io1-f66.google.com with SMTP id z3so8857776iog.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 02:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Rw2BWyG599Bkhavz/sQ+o4mMfyoJ00aNO31/BIgOjY=;
        b=tvjDYKlMKW9WNCIwBUxwRBIDjQSCzulXqlzdoOCQfBMvRRG4ppwsRfTkc37gA9ewGf
         hrzTpkI8X2ONvWblpvqvb9OgXvzzJsUKdoayIY2f9viHaFiNbFUQmhOWuFfWuI1sSwLy
         4MX0orjd8H4cNLPnD/3FRy+kLHKbZ9MyJ94iHUguPp5P34XWg8b/qULOdadF6TtK9L97
         +n0dgJa4emlS1JBnWvLI8vu+L8s8HnzL6qvvHkDoxXH5360ybogbFETUu5W2/rQ8BeW8
         KawPJHdjKrsf01eB/trvVQREDUoQ5E0ybDHbFuapJeDHmKpca3qskmETSXVIQRW5CAFk
         YJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Rw2BWyG599Bkhavz/sQ+o4mMfyoJ00aNO31/BIgOjY=;
        b=SOLQlLjD5yezgiclFWmJILzUjDCIYUsBvwbBMGBe3xhlbd6xVkymaGEg+c1P2QY7q0
         Us6pbHl03whqH2cwBbD5p0kFbYFpUxxjpiTQKuPhlNtHfnzSgDa/Ep2wsq+xayleEdKc
         U3DK8sl5J6D8QIT6DnUkMq/rsm+hUtcCxaEVp4QIWzXG7j3SGZeMuWW9H4tj9e4Qnpxk
         WQbNYUlLQBhZEv9SL2whHPGzMofd+NCFrui8jqZglT59Mu7z1WXUjGw4GfaHZXnxMK9q
         Ult4VZXpmPxKsUtxgk8Cg0jb5lfYw5lbTD3UpqCLbmoS4uHKaKsnnN3fkXqD3O9V5Lsm
         lBhA==
X-Gm-Message-State: APjAAAUQZ2+80mVUDg8G1RGXYBz40ToksUXqQQF7HczQ5BumDU1yGtDO
        9LABhQq9XRJxPmCDaxGAjvlYyqYmT/WvHjiVa/E=
X-Google-Smtp-Source: APXvYqzpTB/5Yw8dvagNRCkISfTkP/vJaXeh5bYd+fkbYO9zlJDw/0ybbAMCd5ucTdurkc3tqVRF5YanRHQrfVTOHpU=
X-Received: by 2002:a5d:9e48:: with SMTP id i8mr99148747ioi.51.1564393682927;
 Mon, 29 Jul 2019 02:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1906291443070.2577@hadrien>
In-Reply-To: <alpine.DEB.2.21.1906291443070.2577@hadrien>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 29 Jul 2019 11:50:56 +0200
Message-ID: <CAOi1vP9RGuYvb_sDjqMtxiOfkbabGg8NuH+60dhs8MGQHzXuXg@mail.gmail.com>
Subject: Re: fs/ceph/export.c:459:3-12: code aligned with following code on
 line 461 (fwd)
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     "Yan, Zheng" <zyan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kbuild-all@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 29, 2019 at 4:09 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
> There is no bug here, but some code starting on line 461 seems to be
> incorrectly indented.
>
> julia
>
> ---------- Forwarded message ----------
> Date: Sat, 29 Jun 2019 19:51:04 +0800
> From: kbuild test robot <lkp@intel.com>
> To: kbuild@01.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: fs/ceph/export.c:459:3-12: code aligned with following code on line 461
>
> CC: kbuild-all@01.org
> CC: linux-kernel@vger.kernel.org
> TO: "Yan, Zheng" <zyan@redhat.com>
> CC: Ilya Dryomov <idryomov@gmail.com>
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   249155c20f9b0754bc1b932a33344cfb4e0c2101
> commit: 570df4e9c23f861aa3f8f2954468c534a033bf1a ceph: snapshot nfs re-export
> date:   8 weeks ago
> :::::: branch date: 5 days ago
> :::::: commit date: 8 weeks ago
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
>
> >> fs/ceph/export.c:459:3-12: code aligned with following code on line 461
>
> # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=570df4e9c23f861aa3f8f2954468c534a033bf1a
> git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git remote update linus
> git checkout 570df4e9c23f861aa3f8f2954468c534a033bf1a
> vim +459 fs/ceph/export.c
>
> a8e63b7d Sage Weil  2009-10-06  401
> 570df4e9 Yan, Zheng 2017-11-15  402  static int __get_snap_name(struct dentry *parent, char *name,
> 570df4e9 Yan, Zheng 2017-11-15  403                        struct dentry *child)
> 570df4e9 Yan, Zheng 2017-11-15  404  {
> 570df4e9 Yan, Zheng 2017-11-15  405     struct inode *inode = d_inode(child);
> 570df4e9 Yan, Zheng 2017-11-15  406     struct inode *dir = d_inode(parent);
> 570df4e9 Yan, Zheng 2017-11-15  407     struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
> 570df4e9 Yan, Zheng 2017-11-15  408     struct ceph_mds_request *req = NULL;
> 570df4e9 Yan, Zheng 2017-11-15  409     char *last_name = NULL;
> 570df4e9 Yan, Zheng 2017-11-15  410     unsigned next_offset = 2;
> 570df4e9 Yan, Zheng 2017-11-15  411     int err = -EINVAL;
> 570df4e9 Yan, Zheng 2017-11-15  412
> 570df4e9 Yan, Zheng 2017-11-15  413     if (ceph_ino(inode) != ceph_ino(dir))
> 570df4e9 Yan, Zheng 2017-11-15  414             goto out;
> 570df4e9 Yan, Zheng 2017-11-15  415     if (ceph_snap(inode) == CEPH_SNAPDIR) {
> 570df4e9 Yan, Zheng 2017-11-15  416             if (ceph_snap(dir) == CEPH_NOSNAP) {
> 570df4e9 Yan, Zheng 2017-11-15  417                     strcpy(name, fsc->mount_options->snapdir_name);
> 570df4e9 Yan, Zheng 2017-11-15  418                     err = 0;
> 570df4e9 Yan, Zheng 2017-11-15  419             }
> 570df4e9 Yan, Zheng 2017-11-15  420             goto out;
> 570df4e9 Yan, Zheng 2017-11-15  421     }
> 570df4e9 Yan, Zheng 2017-11-15  422     if (ceph_snap(dir) != CEPH_SNAPDIR)
> 570df4e9 Yan, Zheng 2017-11-15  423             goto out;
> 570df4e9 Yan, Zheng 2017-11-15  424
> 570df4e9 Yan, Zheng 2017-11-15  425     while (1) {
> 570df4e9 Yan, Zheng 2017-11-15  426             struct ceph_mds_reply_info_parsed *rinfo;
> 570df4e9 Yan, Zheng 2017-11-15  427             struct ceph_mds_reply_dir_entry *rde;
> 570df4e9 Yan, Zheng 2017-11-15  428             int i;
> 570df4e9 Yan, Zheng 2017-11-15  429
> 570df4e9 Yan, Zheng 2017-11-15  430             req = ceph_mdsc_create_request(fsc->mdsc, CEPH_MDS_OP_LSSNAP,
> 570df4e9 Yan, Zheng 2017-11-15  431                                            USE_AUTH_MDS);
> 570df4e9 Yan, Zheng 2017-11-15  432             if (IS_ERR(req)) {
> 570df4e9 Yan, Zheng 2017-11-15  433                     err = PTR_ERR(req);
> 570df4e9 Yan, Zheng 2017-11-15  434                     req = NULL;
> 570df4e9 Yan, Zheng 2017-11-15  435                     goto out;
> 570df4e9 Yan, Zheng 2017-11-15  436             }
> 570df4e9 Yan, Zheng 2017-11-15  437             err = ceph_alloc_readdir_reply_buffer(req, inode);
> 570df4e9 Yan, Zheng 2017-11-15  438             if (err)
> 570df4e9 Yan, Zheng 2017-11-15  439                     goto out;
> 570df4e9 Yan, Zheng 2017-11-15  440
> 570df4e9 Yan, Zheng 2017-11-15  441             req->r_direct_mode = USE_AUTH_MDS;
> 570df4e9 Yan, Zheng 2017-11-15  442             req->r_readdir_offset = next_offset;
> 570df4e9 Yan, Zheng 2017-11-15  443             req->r_args.readdir.flags =
> 570df4e9 Yan, Zheng 2017-11-15  444                             cpu_to_le16(CEPH_READDIR_REPLY_BITFLAGS);
> 570df4e9 Yan, Zheng 2017-11-15  445             if (last_name) {
> 570df4e9 Yan, Zheng 2017-11-15  446                     req->r_path2 = last_name;
> 570df4e9 Yan, Zheng 2017-11-15  447                     last_name = NULL;
> 570df4e9 Yan, Zheng 2017-11-15  448             }
> 570df4e9 Yan, Zheng 2017-11-15  449
> 570df4e9 Yan, Zheng 2017-11-15  450             req->r_inode = dir;
> 570df4e9 Yan, Zheng 2017-11-15  451             ihold(dir);
> 570df4e9 Yan, Zheng 2017-11-15  452             req->r_dentry = dget(parent);
> 570df4e9 Yan, Zheng 2017-11-15  453
> 570df4e9 Yan, Zheng 2017-11-15  454             inode_lock(dir);
> 570df4e9 Yan, Zheng 2017-11-15  455             err = ceph_mdsc_do_request(fsc->mdsc, NULL, req);
> 570df4e9 Yan, Zheng 2017-11-15  456             inode_unlock(dir);
> 570df4e9 Yan, Zheng 2017-11-15  457
> 570df4e9 Yan, Zheng 2017-11-15  458             if (err < 0)
> 570df4e9 Yan, Zheng 2017-11-15 @459                     goto out;
> 570df4e9 Yan, Zheng 2017-11-15  460
> 570df4e9 Yan, Zheng 2017-11-15 @461              rinfo = &req->r_reply_info;
> 570df4e9 Yan, Zheng 2017-11-15  462              for (i = 0; i < rinfo->dir_nr; i++) {
> 570df4e9 Yan, Zheng 2017-11-15  463                      rde = rinfo->dir_entries + i;
> 570df4e9 Yan, Zheng 2017-11-15  464                      BUG_ON(!rde->inode.in);
> 570df4e9 Yan, Zheng 2017-11-15  465                      if (ceph_snap(inode) ==
> 570df4e9 Yan, Zheng 2017-11-15  466                          le64_to_cpu(rde->inode.in->snapid)) {
> 570df4e9 Yan, Zheng 2017-11-15  467                              memcpy(name, rde->name, rde->name_len);
> 570df4e9 Yan, Zheng 2017-11-15  468                              name[rde->name_len] = '\0';
> 570df4e9 Yan, Zheng 2017-11-15  469                              err = 0;
> 570df4e9 Yan, Zheng 2017-11-15  470                              goto out;
> 570df4e9 Yan, Zheng 2017-11-15  471                      }
> 570df4e9 Yan, Zheng 2017-11-15  472              }
> 570df4e9 Yan, Zheng 2017-11-15  473
> 570df4e9 Yan, Zheng 2017-11-15  474              if (rinfo->dir_end)
> 570df4e9 Yan, Zheng 2017-11-15  475                      break;
> 570df4e9 Yan, Zheng 2017-11-15  476
> 570df4e9 Yan, Zheng 2017-11-15  477              BUG_ON(rinfo->dir_nr <= 0);
> 570df4e9 Yan, Zheng 2017-11-15  478              rde = rinfo->dir_entries + (rinfo->dir_nr - 1);
> 570df4e9 Yan, Zheng 2017-11-15  479              next_offset += rinfo->dir_nr;
> 570df4e9 Yan, Zheng 2017-11-15  480              last_name = kstrndup(rde->name, rde->name_len, GFP_KERNEL);
> 570df4e9 Yan, Zheng 2017-11-15  481              if (!last_name) {
> 570df4e9 Yan, Zheng 2017-11-15  482                      err = -ENOMEM;
> 570df4e9 Yan, Zheng 2017-11-15  483                      goto out;
> 570df4e9 Yan, Zheng 2017-11-15  484              }
> 570df4e9 Yan, Zheng 2017-11-15  485
> 570df4e9 Yan, Zheng 2017-11-15  486              ceph_mdsc_put_request(req);
> 570df4e9 Yan, Zheng 2017-11-15  487              req = NULL;
> 570df4e9 Yan, Zheng 2017-11-15  488     }
> 570df4e9 Yan, Zheng 2017-11-15  489     err = -ENOENT;
> 570df4e9 Yan, Zheng 2017-11-15  490  out:
> 570df4e9 Yan, Zheng 2017-11-15  491     if (req)
> 570df4e9 Yan, Zheng 2017-11-15  492             ceph_mdsc_put_request(req);
> 570df4e9 Yan, Zheng 2017-11-15  493     kfree(last_name);
> 570df4e9 Yan, Zheng 2017-11-15  494     dout("get_snap_name %p ino %llx.%llx err=%d\n",
> 570df4e9 Yan, Zheng 2017-11-15  495          child, ceph_vinop(inode), err);
> 570df4e9 Yan, Zheng 2017-11-15  496     return err;
> 570df4e9 Yan, Zheng 2017-11-15  497  }
> 570df4e9 Yan, Zheng 2017-11-15  498

Fixed.

Thanks,

                Ilya
