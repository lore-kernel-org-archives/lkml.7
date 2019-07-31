Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E491C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124772089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR10pX9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfGaJHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:07:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36203 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfGaJHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:07:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so68860834wrs.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 02:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=wgmCRdWeMADRLl2IN83fRZAyv4ZPYOqJyJ/xhWpFO14=;
        b=hR10pX9A6eFvfG5f0HBxQA5S59jdaBx9Qt2Ykgoh3fTfCm3FKW6oO1gYqBPbPlI1bB
         dm6K2tlLqV3C5SylaJPfndAuitGmw/P3Qw/QFOF6nEN1C0oU9NImlw2FGTP0zVQefY9s
         l3dQ3ZsakarS22JPMgBIK2ogDEu6wD9z8olz1IUmRCiHgE4ydg+OZ3FEqW3bACz0G4MU
         CTiiGA92vzOIlFzxUMt3o9NvH5fvLXFSOxy3jC2qyhbyJhpFbLZTrN34QVP7ij0ibn/X
         Px//K8iE+ea6ig38kJAUHe0bDVO++dNFaxpSRkNZpUy7xi03Nfv5dsRGMHP16iAceNv6
         rmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=wgmCRdWeMADRLl2IN83fRZAyv4ZPYOqJyJ/xhWpFO14=;
        b=sc3V3J4VB34WX/7Xgivh/Hm0dTg7agnDKKcQD5jdCdobZ1bWp81wiPhQZ+4VZvdkah
         DVZBWbBBwEEitgBokMbpYLUGwoyQ6x0VKH7p2aW3vswdSwupsD4AOG02uYi6odZu157a
         gc3uf8zaNqOu5KFKqgFhQMJQNhNtCXerWeTm6Cq0MuwPr/lPReueQ7i+EKXUy6pEm/Ku
         yZibbOUC2J//NQu7x+/SERJGJ9T7OEEk/aXuPQsWq61a25Z17Ms1ZB/9LWOHNofPET9P
         VSuh0VAaehiAmyRE7G5lL0SP+bY2Ba4AwmZIL1yEM01hPfqRs2kskGXBWkKNxbe2EMcx
         /cLQ==
X-Gm-Message-State: APjAAAWgdh5mrKuwgxPGRkvYE++00Cj5al0Quk0Z098l2cV6nZpN1aPe
        FJOD5/9MytwHT84xZ9ViQAFptZNG
X-Google-Smtp-Source: APXvYqxyCu3zenvtQAJr9aJpHCER6OeqrfHvnuJj8nY9R+8TMdDZbES1rHHdgWC29Ej/q6ofQZ5TZA==
X-Received: by 2002:adf:c613:: with SMTP id n19mr76433751wrg.109.1564564052992;
        Wed, 31 Jul 2019 02:07:32 -0700 (PDT)
Received: from numan ([95.0.155.39])
        by smtp.gmail.com with ESMTPSA id b15sm83158248wrt.77.2019.07.31.02.07.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 02:07:32 -0700 (PDT)
Date:   Wed, 31 Jul 2019 12:07:28 +0300
From:   Numan =?UTF-8?B?RGVtaXJkw7bEn2Vu?= <if.gnu.linux@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: [regression, bisected] Keyboard not responding after resuming from
  suspend/hibernate
Message-ID: <20190731120728.656eb771@numan>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If laptop is put to suspend or hibernate by closing lid, via power
manager or by using any other method and then it is resumed/waked up,
keyboard is not responding but mouse or trackball can be used. Although
I can wake laptop up by keyboard, after that I am stuck at the password
prompt. This bug is present ever since using 4.10-rc1 kernel and mostly
on Sony laptops. The last working kernel version is 4.9.0-rc2.

git bisect points 9d659ae14b545c4296e812c70493bfdc999b5c1c 
as the first bad commit[1].

I tried some kernel parameters related to i8042 driver:
i8042.debug=1 i8042.reset=1	keyboard not working
i8042.debug=1 i8042.kbdreset=1	keyboard not working
i8042.debug=1 i8042.nomux=1	keyboard not working
i8042.debug=1 i8042.noaux=1	keyboard working, but touchpad not
working

A user reported that on some rare occasions, keyboard responded to key
press but it remained pressed forever even if stopped pressing it. And
another user reported that passing the options i8042.reset=1
i8042.dumbkbd=1 i8042.direct=1 resulted in the keyboard functioning
after resume. However, there was a long delay before the keyboard or
mouse responded to input on the lock screen.

This one line patch, which can be a hint, from Takashi Iwai essentially
reverts the commit 9d659ae14b545 mentioned in the above and keyboard is
working as expected after resuming from suspend/hibernate, if this
patch is applied. 

--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -59,7 +59,7 @@ EXPORT_SYMBOL(__mutex_init);
  * Bit2 indicates handoff has been done and we're waiting for pickup.
  */
 #define MUTEX_FLAG_WAITERS	0x01
-#define MUTEX_FLAG_HANDOFF	0x02
+#define MUTEX_FLAG_HANDOFF	0x00
 #define MUTEX_FLAG_PICKUP	0x04
 
 #define MUTEX_FLAGS		0x07
 
- The first bug report on bugzilla.kernel.org[2].
- LKML thread[3]
- Another report on OpenSUSE bugzilla[4]

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=9d659ae14b545c4296e812c70493bfdc999b5c1c
[2] https://bugzilla.kernel.org/show_bug.cgi?id=195471
[3] https://lkml.org/lkml/2018/8/31/707
[4]  https://bugzilla.opensuse.org/show_bug.cgi?id=1114588
