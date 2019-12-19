Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D68C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3E42465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9rrtlIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfLSRhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:37:00 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38670 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfLSRg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:36:59 -0500
Received: by mail-pj1-f67.google.com with SMTP id l35so2863727pje.3;
        Thu, 19 Dec 2019 09:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:date:message-id:subject;
        bh=0EhzHVZdAL4+SJpaxhiYiXdYM3Q3vCDbLj5SL6A2gjY=;
        b=c9rrtlItDq/jeA9Ppe5rtjYGxk85yhBY7lO4X5XkdswvSBdn7uDbubD31sJhTyPrG7
         C8Z4sbSVw1ElSvl9xdtKyRnXrAe63Ah7dKPMKWNUb/a+l33QzGf9sqqCi14uoHK9lFLQ
         QGr9yr9Rs9yOoshHCP2LnWGKaFpXuOPJRedIBcPExnJPSYFeweVhjjeaJ4Dd9IPuHnTu
         yoiQPtw1ewUV5HxxQzWYKhfmvnx+mKvMxZAE8VHdMLnqyy+Sls/LU51EKUjsrjpHBpDS
         435syYFi64MI82PEEyVPwJepOTx+VQ8ZvUH1ob6ufAPGj6Fw3lUfeAfnzbvuqEvKM9oW
         DuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:subject;
        bh=0EhzHVZdAL4+SJpaxhiYiXdYM3Q3vCDbLj5SL6A2gjY=;
        b=XD0CpMR7wLCkC92bqpilZEDbhWK7CeEWzAXom4W8djCOoGW820rcNUexvpM6QD3qjS
         FhD8CnKzLBeaoO8dLfk2d5gTiYsiO8wIA7GOpaAxU8HS34Uzlcy5imSS1Al2jIcrszxw
         Xe+g+U+8oxuGPimdvZVDhucEscjfcK4/+ZS6OjryeqPfFIL3/eTKIymMogda3GgPMwQa
         MusTJrBd9pPNoQmVE4j/weeFyEVY2jx3YvFxwXcyf2+1weJ+wkdQYdGSokOceE+xHhmV
         PBwqB1JAa20qqpIGY4mwiamwL7ecynpRYPa/8AR6uB33R+JvJe1Oww/vOZ0PGk+jJ7eW
         RqXA==
X-Gm-Message-State: APjAAAVJdGxDGSsV8T3iz1ZB2yZs0Vm/yC7eET/nsbTlwQJkXK8xR6D7
        H9Yy9SYdiaQrSF2poyZ8XwE=
X-Google-Smtp-Source: APXvYqwL8DuMhAF3UoshaIoQuGD+dwRvjy6k3dfszvghFEOXP7YEa4UcdBt9lJqxVeqcabd1ZBLBfA==
X-Received: by 2002:a17:90a:2203:: with SMTP id c3mr10632927pje.68.1576777018823;
        Thu, 19 Dec 2019 09:36:58 -0800 (PST)
Received: from [127.0.0.1] (s214090.ppp.asahi-net.or.jp. [220.157.214.90])
        by smtp.gmail.com with ESMTPSA id 3sm8523185pfi.13.2019.12.19.09.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 09:36:57 -0800 (PST)
From:   Magnus Damm <magnus.damm@gmail.com>
To:     valentina.manea.m@gmail.com
Cc:     Magnus Damm <magnus.damm@gmail.com>, linux-usb@vger.kernel.org,
        shuah@kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Dec 2019 02:35:25 +0900
Message-Id: <157677692518.684.15385402529285904844.sendpatchset@octo>
Subject: [PATCH] tools: usb: usbip: Get rid of driver name printout in README
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Driver name is no longer printed out so update the README
examples to avoid confusion.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 tools/usb/usbip/README |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- 0001/tools/usb/usbip/README
+++ work/tools/usb/usbip/README	2019-12-04 16:40:54.999822223 +0900
@@ -138,28 +138,28 @@ attached to this host.
     Local USB devices
     =================
      - busid 1-1 (05a9:a511)
-	     1-1:1.0 -> ov511
+	     1-1:1.0
 
      - busid 3-2 (0711:0902)
-	     3-2:1.0 -> none
+	     3-2:1.0
 
      - busid 3-3.1 (08bb:2702)
-	     3-3.1:1.0 -> snd-usb-audio
-	     3-3.1:1.1 -> snd-usb-audio
+	     3-3.1:1.0
+	     3-3.1:1.1
 
      - busid 3-3.2 (04bb:0206)
-	     3-3.2:1.0 -> usb-storage
+	     3-3.2:1.0
 
      - busid 3-3 (0409:0058)
-	     3-3:1.0 -> hub
+	     3-3:1.0
 
      - busid 4-1 (046d:08b2)
-	     4-1:1.0 -> none
-	     4-1:1.1 -> none
-	     4-1:1.2 -> none
+	     4-1:1.0
+	     4-1:1.1
+	     4-1:1.2
 
      - busid 5-2 (058f:9254)
-	     5-2:1.0 -> hub
+	     5-2:1.0
 
 A USB storage device of busid 3-3.2 is now bound to the usb-storage
 driver. To export this device, we first mark the device as
@@ -180,7 +180,7 @@ Mark the device of busid 3-3.2 as export
     ...
 
      - busid 3-3.2 (04bb:0206)
-	     3-3.2:1.0 -> usbip-host
+	     3-3.2:1.0
     ...
 
 ---------------------------
