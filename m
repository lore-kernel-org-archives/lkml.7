Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8DECA9EC1
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 04:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADAC20862
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 04:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mykernel.net header.i=cgxu519@mykernel.net header.b="GL3ZHtLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfJ2EhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 00:37:10 -0400
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25814 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726708AbfJ2EhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 00:37:10 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572323789; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=hnIVD3Nrd1iVpc4NsacGlsUikGiiU6ACLpW/kL7ZrkEFN8Bcn6aURSUbbf0OuMLlEGZkevuMhHeTnAqOG6pNLptVkOKjUJp0ii5Muf5ofDvujD39UwBtyT5wgXPBYW5qsf7Eru2G+EDqF9FKyiPNPHO0Px8rYAFITx2C3h4iYkc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1572323789; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To:ARC-Authentication-Results; 
        bh=zGTTGjvzby9dFyABJyJYmozNeosQNG0TLV7mNHWmM4c=; 
        b=QEPGQVJsh+/eeatPJ2+1fcHPUlle/MH34s4X37d1f0D4J+WnOOJxQAK4FwvwL3Gjz4f0bOKXtJ5hj+JJ2O4q6O+NA971G/xMBbSmX82WCh78dFIDxVu3NbpLVmdDTCaMZH3Tn6LtGsc9nAf+8dnH81YtUSfKT3xMIfgeDEYF0Yc=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1572323789;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=2315; bh=zGTTGjvzby9dFyABJyJYmozNeosQNG0TLV7mNHWmM4c=;
        b=GL3ZHtLjVC7IrsjDibsWZ+FswwMTNGE84r+0YK1cF006paZPRxi3v1ZvBwbqEavr
        e3H8uiHIaKgJIv1FmIgqdM5rK+X2HES2+cHZRgCnh50oBii8xXuR4sfXcI3g0/7MmP4
        vy+QreLDJ7ozX36F2qDx1r/CWA4h+NOuBlQgVRv4=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1572323786905120.1772891042325; Tue, 29 Oct 2019 12:36:26 +0800 (CST)
Date:   Tue, 29 Oct 2019 12:36:26 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Mike Kravetz" <mike.kravetz@oracle.com>
Cc:     "linux-mm" <linux-mm@kvack.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "David Howells" <dhowells@redhat.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
Message-ID: <16e15cd0096.1068d5c9f40168.8315245997167313680@mykernel.net>
In-Reply-To: <ba6cd4a4-a1cd-82c0-5ea1-5e20112f8f6b@oracle.com>
References: <20191017103822.8610-1-cgxu519@mykernel.net> <ba6cd4a4-a1cd-82c0-5ea1-5e20112f8f6b@oracle.com>
Subject: Re: [PATCH] hugetlbfs: fix error handling in init_hugetlbfs_fs()
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Priority: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2019-10-29 05:27:01 Mike Krave=
tz <mike.kravetz@oracle.com> =E6=92=B0=E5=86=99 ----
 > On 10/17/19 3:38 AM, Chengguang Xu wrote:
 > > In order to avoid using incorrect mnt, we should set
 > > mnt to NULL when we get error from mount_one_hugetlbfs().
 > >=20
 > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 >=20
 > Thanks for noticing this issue.  As mentioned in a previous e-mail,
 > there are additional issues that need to be addressed.  This loop
 > needs to initialize entries in the hugetlbfs_vfsmount array for all
 > hstates.  How about this patch?
 >=20
 > From 3144f0a9d18f1408e831fb3eb49a06636a11d902 Mon Sep 17 00:00:00 2001
 > From: Mike Kravetz <mike.kravetz@oracle.com>
 > Date: Mon, 28 Oct 2019 14:08:42 -0700
 > Subject: [PATCH] mm/hugetlbfs: fix error handling when setting up mounts
 >=20
 > It is assumed that the hugetlbfs_vfsmount[] array will contain
 > either a valid vfsmount pointer or NULL for each hstate after
 > initialization.  Changes made while converting to use fs_context
 > broke this assumption.
 >=20
 > Reported-by: Chengguang Xu <cgxu519@mykernel.net>
 > Fixes: 32021982a324 ("hugetlbfs: Convert to fs_context")
 > Cc: stable@vger.kernel.org
 > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
 > ---
 >  fs/hugetlbfs/inode.c | 10 ++++++----
 >  1 file changed, 6 insertions(+), 4 deletions(-)
 >=20
 > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
 > index a478df035651..178389209561 100644
 > --- a/fs/hugetlbfs/inode.c
 > +++ b/fs/hugetlbfs/inode.c
 > @@ -1470,15 +1470,17 @@ static int __init init_hugetlbfs_fs(void)
 >      i =3D 0;
 >      for_each_hstate(h) {
 >          mnt =3D mount_one_hugetlbfs(h);
 > -        if (IS_ERR(mnt) && i =3D=3D 0) {
 > +        if (IS_ERR(mnt)) {
 > +            hugetlbfs_vfsmount[i] =3D NULL;
 >              error =3D PTR_ERR(mnt);
 > -            goto out;
 > +        } else {
 > +            hugetlbfs_vfsmount[i] =3D mnt;
 >          }
 > -        hugetlbfs_vfsmount[i] =3D mnt;
 >          i++;
 >      }
 > =20
 > -    return 0;
 > +    if (hugetlbfs_vfsmount[default_hstate_idx] !=3D NULL)
 > +        return 0;

Maybe we should umount other non-null entries and release
used inodes for safety in error case.

Thanks,
Chengguang

 > =20
 >   out:
 >      kmem_cache_destroy(hugetlbfs_inode_cachep);
 > --=20
 > 2.20.1
 >=20
 >

