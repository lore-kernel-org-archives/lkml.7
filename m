Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4D3C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A783F205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7LLhqFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfLIVhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:37:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53140 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfLIVhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 16:37:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so948624wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 13:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xscmuM5jXnyY1oFZki+B/UrDCH4g2etPdgo0+OBsIng=;
        b=j7LLhqFuLwK+8zGtbJGGjmYP0DUg9cL+jEGLxbBMR61XHNk7eI5eqP7xINAdkpR+XP
         UvVHV3ta2lZ9YIRDVVRrnfAIYVIh8xG6ioVAirduEwUGaOJMAbYRaGFs2C6HbEv3Dq9F
         Jpg7JACT3lkdUKUcqq8pacIvsUH2KXYyJCtVlap4Pd/+M5iVzoSURzPVUtrS08wk5lHN
         vQTu8eDIuokyIXO+YZSQriRfMpgQFZB0+psZzCNhrBg4W+k1z5b7PAB0vJlOtusYG8lf
         9+ROn35Ua6khEXwiC52RZV6EjHLzliCAt5fo9zPkKPBzjNFs8f/gmb1mTOaienXv8fPS
         7Ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xscmuM5jXnyY1oFZki+B/UrDCH4g2etPdgo0+OBsIng=;
        b=GMV8Aruw1mjXEKKwGUus0XIeCq6QpU5Cqfi9vw29tcJmVn9U9a5qnmo9PjF1nXASmE
         88ALR6nHHhcw7QQj1ZeXfmCP/wUuRA6tEgVy0nB8v8b2wVlDBJVVTqeysOPwC+hrMySC
         pNZN6p7H7lNzJ3KoSFDZ1inLXD63BT+/vyIt1rpEQtMUsOcXgnxugBIQqlSkzd9HOUd9
         rrZaWC1PoGB2v2bHHb0nqPmjBql4/I0SuoGx8ky7a/0ekAKNWljZ8j5giOduEKDp3SZe
         IydxJ2Ah657mLo44XC3co7LRfAUh61WBXh94mCvyV/Q1AF8mMPnwdU58Az2N2sLfshv8
         xFEw==
X-Gm-Message-State: APjAAAVLKPpQRmT6hPY/9G5V7ML+z6O9lAfsye4kgJZZvqEDsB8T7BE6
        UZNg/4D9JuXtx0qFwpRgUEPMHU86
X-Google-Smtp-Source: APXvYqwVCSlNrWzbozHEmg+fRJ1Ck3mlGuR3DeIY/6a8vJPT8kriJdui9HC+H8OyV0LapTlR93D+RQ==
X-Received: by 2002:a1c:3b55:: with SMTP id i82mr1122188wma.76.1575927442721;
        Mon, 09 Dec 2019 13:37:22 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:40f6:4600:a51f:44c:fbfb:c44])
        by smtp.gmail.com with ESMTPSA id r15sm711152wmh.21.2019.12.09.13.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 13:37:22 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Subject: [PATCH v2] misc: xilinx_sdfec: add missing __user annotation
Date:   Mon,  9 Dec 2019 22:37:19 +0100
Message-Id: <20191209213719.58037-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second arg of xsdfec_set_order() is a 'void __user *'
and this pointer is then used in get_user() which expect
a __user pointer.

But get_user() can't be used with a void pointer, it a
pointer to the effective type. This is done here by casting
the argument to a pointer to the effective type but the
__user is missing in the cast.

Fix this by adding the missing __user in the cast.

CC: Derek Kiernan <derek.kiernan@xilinx.com>
CC: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Acked-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---

Greg,

Can you take this in your tree?
Thanks.

Change since v1:
- add Dragan's ack.


 drivers/misc/xilinx_sdfec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 11835969e982..f05e1b4c2826 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -733,7 +733,7 @@ static int xsdfec_set_order(struct xsdfec_dev *xsdfec, void __user *arg)
 	enum xsdfec_order order;
 	int err;
 
-	err = get_user(order, (enum xsdfec_order *)arg);
+	err = get_user(order, (enum xsdfec_order __user *)arg);
 	if (err)
 		return -EFAULT;
 
-- 
2.24.0

