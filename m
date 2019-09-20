Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0052DC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1AC2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568990340;
	bh=4jnOnbSgoncpfxwxvRrt+cHmajzbaFT3GPsaMnN5pLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hmrBbV/y3MsBiYQQ+hlEGFNik1MdfbgEU91nHTOBeKjmBZRKTBY7wpif1R9k1g1HU
	 PuM74gmG380yA2K4oCL9dRZucTgeMMajVl7v7xTTggNhBlv5zqMckJ7ko+/k1wWJKQ
	 2DvlSMVhylJupUfjtJLgANRdD8UmWy5WGyjTCi3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393004AbfITOi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:38:59 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40217 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392991AbfITOi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:38:58 -0400
Received: by mail-lf1-f66.google.com with SMTP id d17so5226329lfa.7;
        Fri, 20 Sep 2019 07:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1NwZNGrFq7Ske7AKHAMHXfp5jVIM/N1XHPWygPRiKsw=;
        b=Qmbx3q6rr5GW3haSz0pXuhcIREr3vOuBPyzdsydDfzJvubS1QsRGvsjZb6oPhiwmif
         Zoghwvgp4isR14kdp5QykvGMTpBuDFnVPCJbM7SxfBjDDfxN5nkFTvGnZ46JwdOKS/ci
         fAbBzz8oY8J/iJ2fB/YM1CltN2PqyklIZK/Z9+EqMGzx6z+3V/faqNdE4ztR17rDIdWd
         5ePJcQuzJdKlfrwRyvdQ1otA93PNVAdIO6zxBfQFB4RRrdBKWLhfxqjFbo4yaUmr8m41
         FmQGhBA9k0J7Uy5CcdyfZjTZWYDqJ3S6XRIkXUqIOISsju+GfAqpwdT0wc3e19Qbirmy
         6Jmg==
X-Gm-Message-State: APjAAAVaJU4AsTKQvS90F80CR0K4WwCxWFEYBKdIH5Qj2gQ2+ISl/NFy
        CilZHo+oWlPCF5cDWlDNUoI=
X-Google-Smtp-Source: APXvYqyrWksLDkyTg5dVB9SLjdCI+otYDWhJFBhTS35VenIovutgZMQgP2xXMIi1zx/6Ro5p4OOWww==
X-Received: by 2002:a19:f24d:: with SMTP id d13mr9002449lfk.127.1568990335845;
        Fri, 20 Sep 2019 07:38:55 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id y26sm518834ljj.90.2019.09.20.07.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 07:38:55 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iBK3j-0004Ox-Fi; Fri, 20 Sep 2019 16:38:56 +0200
Date:   Fri, 20 Sep 2019 16:38:55 +0200
From:   Johan Hovold <johan@kernel.org>
To:     syzbot <syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, dmg@turingmachine.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in adu_disconnect
Message-ID: <20190920143855.GS30545@localhost>
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

Let's resend and retest using the latest usb-fuzzer kernel, which
includes the fix for a couple char dev races that we were now hitting:

#syz test: https://github.com/google/kasan.git e0bd8d79

I'll fix the failure to stop I/O at disconnect separately.

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

