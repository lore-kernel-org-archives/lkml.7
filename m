Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC11AC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE5A20665
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568970487;
	bh=N49GT38KjpHtgWRNMimdYy2HnJhVMyLZdlO+4c7bBWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gOZG4a+SRbn0K8OYCckw+74sd1rsJm20lZhy5mrpp4GBTFJ6nArLydu5eJAr+I5Ud
	 WBVmKRCM7T0OMdkdt0dymvpBGr4LcDwD5YMKmY4RntltWF4cIibokNlDf2Do8P7KXE
	 06QOsmXPf3b+WwmHcdTgjjdDJ5hi730Jyr4Sk27w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393332AbfITJIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 05:08:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32840 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393258AbfITJIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 05:08:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id a22so6398021ljd.0;
        Fri, 20 Sep 2019 02:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WtZ+s2htL/PqGjzx/td3338bsxor/4+6BeenmHqQdsc=;
        b=odKa+PpHLREBR2Uf2dqbOuJUPtc29TgI0rYN6DE3UJ5WFbU3LQNXE/NJZn8umPuhUp
         a6IDeRKLnGJJJKIEP7jSC4AsbcYxy1I3uWYupspfYTgifcJPAjWIn/BAAeB8olF6aMN8
         J+NmiihBU2IMT8YKwktd+DFGGmtmEz6Z4OQ/7ZFFzNAgK4A1eGFkH5FWc7Qx7Xx2m0qs
         o6qD84OGt7QQojUy9Zok+81BOn8GBwMIO2X9t0buWIzzceMx/euCu2p1O/L9UgZjr/7M
         onjy3wq1C0OHQr8HPLh1Jfc/bakIW2aPwdSJYvvpYTKt/d+xY8mNtTgAvcfJt8RRDlOB
         NbpA==
X-Gm-Message-State: APjAAAUHzgAj12uJ96kI0Vzlz1EswLfY9ABMGTbh5abIyOJrfpZPCgAF
        s2twPUHiJ4MFGrXJhoIp10cjt+z0
X-Google-Smtp-Source: APXvYqxf0yWPg81mmgrK4cffNz6qkm6SJw2aPVEXVmuzoLsP5eLzvujE+KzswKK6gqEneLA1WY0quA==
X-Received: by 2002:a2e:9eca:: with SMTP id h10mr1147819ljk.32.1568970484414;
        Fri, 20 Sep 2019 02:08:04 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id i11sm292853ljb.74.2019.09.20.02.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 02:08:03 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iBEtX-0001Ku-Au; Fri, 20 Sep 2019 11:08:04 +0200
Date:   Fri, 20 Sep 2019 11:08:03 +0200
From:   Johan Hovold <johan@kernel.org>
To:     syzbot <syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, dmg@turingmachine.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in adu_disconnect
Message-ID: <20190920090803.GM30545@localhost>
References: <000000000000d12d24058f5d6b65@google.com>
 <000000000000a12822058fb4f408@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a12822058fb4f408@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 01:24:04PM -0700, syzbot wrote:
> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=13871a4a600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
> dashboard link: https://syzkaller.appspot.com/bug?extid=0243cb250a51eeefb8cc
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c4c8e2600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d80d2c600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com
> 
> usb 1-1: USB disconnect, device number 4
> ==================================================================
> BUG: KASAN: use-after-free in atomic64_read  
> include/asm-generic/atomic-instrumented.h:836 [inline]
> BUG: KASAN: use-after-free in atomic_long_read  
> include/asm-generic/atomic-long.h:28 [inline]
> BUG: KASAN: use-after-free in __mutex_unlock_slowpath+0x96/0x670  
> kernel/locking/mutex.c:1211
> Read of size 8 at addr ffff8881d1d0aa00 by task kworker/0:1/12

Let's resend and retest with commit id from latest report to make sure
the patch was actually applied during the last run:

#syz test: https://github.com/google/kasan.git e96407b4

Johan


From 6f09430ae18085a1552fc641e53d3a3e678db6f3 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 19 Sep 2019 11:48:38 +0200
Subject: [PATCH] USB: adutux: fix use-after-free on disconnect

The driver was clearing its struct usb_device pointer, which it uses as
an inverted disconnected flag, before deregistering the character device
and without serialising against racing release().

This could lead to a use-after-free if a racing release() callback
observes the cleared pointer and frees the driver data before
disconnect() is finished with it.

This could also lead to NULL-pointer dereferences in a racing open().

Fixes: f08812d5eb8f ("USB: FIx locks and urb->status in adutux (updated)")
Reported-by: syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com
Cc: stable <stable@vger.kernel.org>     # 2.6.24
Signed-off-by: Johan Hovold <johan@kernel.org>
---

 drivers/usb/misc/adutux.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/misc/adutux.c b/drivers/usb/misc/adutux.c
index 344d523b0502..bcc138990e2f 100644
--- a/drivers/usb/misc/adutux.c
+++ b/drivers/usb/misc/adutux.c
@@ -762,14 +762,15 @@ static void adu_disconnect(struct usb_interface *interface)
 
 	dev = usb_get_intfdata(interface);
 
-	mutex_lock(&dev->mtx);	/* not interruptible */
-	dev->udev = NULL;	/* poison */
 	usb_deregister_dev(interface, &adu_class);
-	mutex_unlock(&dev->mtx);
 
 	mutex_lock(&adutux_mutex);
 	usb_set_intfdata(interface, NULL);
 
+	mutex_lock(&dev->mtx);	/* not interruptible */
+	dev->udev = NULL;	/* poison */
+	mutex_unlock(&dev->mtx);
+
 	/* if the device is not opened, then we clean up right now */
 	if (!dev->open_count)
 		adu_delete(dev);
-- 
2.23.0

