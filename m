Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCAAC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED422206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZlKrVj+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfKUXid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:38:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32654 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726038AbfKUXic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:38:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574379511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ghZgmhA3nVCEWICxd7VTKOzTCHKcObUKDPVYCLTv4Ck=;
        b=ZlKrVj+9nZxbsCccnN7bXhSNnoFUsHnVQ6MkoQASGNs8zUfp5d2zCZ9xkFfvLDCqXtRWnT
        PDIRm8XWQhEhLc2LTKXmWCUq+xEQTmPD+hbcEXG3Kwd1jDrMYHIeDgbHXCCsOimfYJU+LX
        VpALlWRgzE8uUwCPlLy6QZHuglRw7tI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-Z-j3Ug8tOQu_Q-bSctTCQA-1; Thu, 21 Nov 2019 18:38:30 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BB9C80268B;
        Thu, 21 Nov 2019 23:38:28 +0000 (UTC)
Received: from suzdal.zaitcev.lan (ovpn-117-3.phx2.redhat.com [10.3.117.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B6825DA66;
        Thu, 21 Nov 2019 23:38:26 +0000 (UTC)
Date:   Thu, 21 Nov 2019 17:38:25 -0600
From:   Pete Zaitcev <zaitcev@redhat.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+56f9673bb4cdcbeb0e92@syzkaller.appspotmail.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <jrdr.linux@gmail.com>, <keescook@chromium.org>,
        <kstewart@linuxfoundation.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>, <tglx@linutronix.de>,
        <viro@zeniv.linux.org.uk>, zaitcev@redhat.com
Subject: Re: possible deadlock in mon_bin_vma_fault
Message-ID: <20191121173825.1527c3a5@suzdal.zaitcev.lan>
In-Reply-To: <Pine.LNX.4.44L0.1911211118450.1553-100000@iolanthe.rowland.org>
References: <20191121084842.095edf87@suzdal.zaitcev.lan>
        <Pine.LNX.4.44L0.1911211118450.1553-100000@iolanthe.rowland.org>
Organization: Red Hat, Inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Z-j3Ug8tOQu_Q-bSctTCQA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 11:20:20 -0500 (EST)
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Thu, 21 Nov 2019, Pete Zaitcev wrote:
>=20
> > Anyway... If you are looking at it too, what do you think about not usi=
ng
> > any locks in mon_bin_vma_fault() at all? Isn't it valid? I think I trie=
d
> > to be "safe", but it only uses things that are constants unless we're
> > opening and closing; a process cannot make page faults unless it has
> > some thing mapped; and that is only possible if device is open and stay=
s
> > open. Can you find a hole in this reasoning? =20
>=20
> I think you're right. [...]

How about the appended patch, then? You like?

Do you happen to know how to refer to a syzbot report in a commit message?

-- Pete

commit 628f3bbf37eee21cce4cfbfaa6a796b129d7736d
Author: Pete Zaitcev <zaitcev@kotori.zaitcev.us>
Date:   Thu Nov 21 17:24:00 2019 -0600

    usb: Fix a deadlock in usbmon between mmap and read
   =20
    Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>

diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
index ac2b4fcc265f..fb7df9810bad 100644
--- a/drivers/usb/mon/mon_bin.c
+++ b/drivers/usb/mon/mon_bin.c
@@ -1039,12 +1039,18 @@ static long mon_bin_ioctl(struct file *file, unsign=
ed int cmd, unsigned long arg
=20
 =09=09mutex_lock(&rp->fetch_lock);
 =09=09spin_lock_irqsave(&rp->b_lock, flags);
-=09=09mon_free_buff(rp->b_vec, rp->b_size/CHUNK_SIZE);
-=09=09kfree(rp->b_vec);
-=09=09rp->b_vec  =3D vec;
-=09=09rp->b_size =3D size;
-=09=09rp->b_read =3D rp->b_in =3D rp->b_out =3D rp->b_cnt =3D 0;
-=09=09rp->cnt_lost =3D 0;
+=09=09if (rp->mmap_active) {
+=09=09=09mon_free_buff(vec, size/CHUNK_SIZE);
+=09=09=09kfree(vec);
+=09=09=09ret =3D -EBUSY;
+=09=09} else {
+=09=09=09mon_free_buff(rp->b_vec, rp->b_size/CHUNK_SIZE);
+=09=09=09kfree(rp->b_vec);
+=09=09=09rp->b_vec  =3D vec;
+=09=09=09rp->b_size =3D size;
+=09=09=09rp->b_read =3D rp->b_in =3D rp->b_out =3D rp->b_cnt =3D 0;
+=09=09=09rp->cnt_lost =3D 0;
+=09=09}
 =09=09spin_unlock_irqrestore(&rp->b_lock, flags);
 =09=09mutex_unlock(&rp->fetch_lock);
 =09=09}
@@ -1093,11 +1099,11 @@ static long mon_bin_ioctl(struct file *file, unsign=
ed int cmd, unsigned long arg
 =09=09=09return ret;
 =09=09if (put_user(ret, &uptr->nfetch))
 =09=09=09return -EFAULT;
-=09=09ret =3D 0;
 =09=09}
 =09=09break;
=20
-=09case MON_IOCG_STATS: {
+=09case MON_IOCG_STATS:
+=09=09{
 =09=09struct mon_bin_stats __user *sp;
 =09=09unsigned int nevents;
 =09=09unsigned int ndropped;
@@ -1113,7 +1119,6 @@ static long mon_bin_ioctl(struct file *file, unsigned=
 int cmd, unsigned long arg
 =09=09=09return -EFAULT;
 =09=09if (put_user(nevents, &sp->queued))
 =09=09=09return -EFAULT;
-
 =09=09}
 =09=09break;
=20
@@ -1216,13 +1221,21 @@ mon_bin_poll(struct file *file, struct poll_table_s=
truct *wait)
 static void mon_bin_vma_open(struct vm_area_struct *vma)
 {
 =09struct mon_reader_bin *rp =3D vma->vm_private_data;
+=09unsigned long flags;
+
+=09spin_lock_irqsave(&rp->b_lock, flags);
 =09rp->mmap_active++;
+=09spin_unlock_irqrestore(&rp->b_lock, flags);
 }
=20
 static void mon_bin_vma_close(struct vm_area_struct *vma)
 {
+=09unsigned long flags;
+
 =09struct mon_reader_bin *rp =3D vma->vm_private_data;
+=09spin_lock_irqsave(&rp->b_lock, flags);
 =09rp->mmap_active--;
+=09spin_unlock_irqrestore(&rp->b_lock, flags);
 }
=20
 /*
@@ -1234,16 +1247,12 @@ static vm_fault_t mon_bin_vma_fault(struct vm_fault=
 *vmf)
 =09unsigned long offset, chunk_idx;
 =09struct page *pageptr;
=20
-=09mutex_lock(&rp->fetch_lock);
 =09offset =3D vmf->pgoff << PAGE_SHIFT;
-=09if (offset >=3D rp->b_size) {
-=09=09mutex_unlock(&rp->fetch_lock);
+=09if (offset >=3D rp->b_size)
 =09=09return VM_FAULT_SIGBUS;
-=09}
 =09chunk_idx =3D offset / CHUNK_SIZE;
 =09pageptr =3D rp->b_vec[chunk_idx].pg;
 =09get_page(pageptr);
-=09mutex_unlock(&rp->fetch_lock);
 =09vmf->page =3D pageptr;
 =09return 0;
 }

