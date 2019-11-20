Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC481C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922D1208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W31OjeQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbfKTRMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:12:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59579 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729119AbfKTRMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574269960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=muEDxGsq3Waz+P8qcWcdXwG2KGs2kkylLGjOIkRBOxY=;
        b=W31OjeQI+CFWQuxcWzvnCjfIOOYiCXcE35vuFM4OaBWKMUlmas6L4f82Szrhxq5d9myr32
        VkDAWJviaD9XphQWkhI0vqtK26NGWXpFKZ6KBnS3kHpmQNDp+NjaIxY97Ob+quj8AreFfF
        SvGDC803VOHgKTEedXezWBO+xWiL5dk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-WNi31rFYNkSnbaUHU89kgg-1; Wed, 20 Nov 2019 12:12:39 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92936802689;
        Wed, 20 Nov 2019 17:12:36 +0000 (UTC)
Received: from suzdal.zaitcev.lan (ovpn-117-3.phx2.redhat.com [10.3.117.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A183FA7F0;
        Wed, 20 Nov 2019 17:12:35 +0000 (UTC)
Date:   Wed, 20 Nov 2019 11:12:35 -0600
From:   Pete Zaitcev <zaitcev@redhat.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+56f9673bb4cdcbeb0e92@syzkaller.appspotmail.com>,
        arnd@arndb.de, <gregkh@linuxfoundation.org>,
        <jrdr.linux@gmail.com>, <keescook@chromium.org>,
        <kstewart@linuxfoundation.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>, <tglx@linutronix.de>,
        <viro@zeniv.linux.org.uk>, zaitcev@redhat.com
Subject: Re: possible deadlock in mon_bin_vma_fault
Message-ID: <20191120111235.7d306f23@suzdal.zaitcev.lan>
In-Reply-To: <Pine.LNX.4.44L0.1911201109500.1498-100000@iolanthe.rowland.org>
References: <0000000000002da08e0597c5efbd@google.com>
        <Pine.LNX.4.44L0.1911201109500.1498-100000@iolanthe.rowland.org>
Organization: Red Hat, Inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: WNi31rFYNkSnbaUHU89kgg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019 11:14:05 -0500 (EST)
Alan Stern <stern@rowland.harvard.edu> wrote:

> As it happens, I spent a little time investigating this bug report just
> yesterday.  It seems to me that the easiest fix would be to disallow
> resizing the buffer while it is mapped by any users.  (Besides,
> allowing that seems like a bad idea in any case.)
>=20
> Pete, does that seem reasonable to you?

Yes, it does seem reasonable.

I think I understand it now. My fallacy was thinking that since everything
is nailed down as long as fetch_lock is held, it was okay to grab whatever
page from our pagemap. What happens later is an attempt to get pages of the
new buffer while looking at them through the old VMA, in mon_bin_vma_fault.

It seems to me that the use counter, mmap_active, is correct and sufficient
to check in the ioctl.

-- Pete

P.S. One thing that vaguely bothers me on this is that the bot
bisected to the commit that clearly fixed worse issues.

P.P.S. Like this?

diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
index ac2b4fcc265f..e27d99606adb 100644
--- a/drivers/usb/mon/mon_bin.c
+++ b/drivers/usb/mon/mon_bin.c
@@ -1020,6 +1020,9 @@ static long mon_bin_ioctl(struct file *file, unsigned=
 int cmd, unsigned long arg
                int size;
                struct mon_pgmap *vec;
=20
+               if (rp->mmap_active)
+                       return -EBUSY;
+
                if (arg < BUFF_MIN || arg > BUFF_MAX)
                        return -EINVAL;
=20

