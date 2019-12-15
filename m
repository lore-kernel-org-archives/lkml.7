Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21821C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 19:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB28C24679
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 19:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="jQXFosFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfLOTIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 14:08:15 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:38934 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfLOTIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 14:08:14 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 47bYp55jh2z9vYkr
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 19:08:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lzjAtCPBLvWB for <linux-kernel@vger.kernel.org>;
        Sun, 15 Dec 2019 13:08:13 -0600 (CST)
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 47bYp54WVdz9vYkj
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 13:08:13 -0600 (CST)
Received: by mail-yb1-f197.google.com with SMTP id w201so249309ybg.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 11:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XQnSrcIIhJOTGUqMDg5EsVAaGnICzliwh0/ya8aApOI=;
        b=jQXFosFMYG5ogxi9afIkg2szA9l2hw/Ld13nDJzJqUz6MWbvgwglXP4jR9e0aqEdQj
         nhMmiTV2WkcEYEV6EPJVqb8YNZ0r4nPGwDK1u1ioj5KWXyazzRCCruU9c6Nvkz5UAa7b
         eScUHTLSmr9w+r3r+e9egWb6f7Wu9xg7ZYdGI2Xe1tWatZ7E7JfICTg7xiYfT7MtutDw
         zmTyfHVw3Nrcb7XHpteGlwgC2LA8jdwcq0r1wIwXk0zj4t3Ep/Et0hYn/lPZzksFFTaG
         6YmKSzewTKFWmRt0ajpkrz+x3ogEgYTbjhCVQNfik/+Z+q1FVbBuMov44EoT+82tQFzj
         2hMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XQnSrcIIhJOTGUqMDg5EsVAaGnICzliwh0/ya8aApOI=;
        b=hhlNoLABcvLTmd0PdD6RGuIRxJfKYF10cY4cMJbPx+35GJOsiswPIGqS1+efYr5Ikh
         2nOSuml8AI1Vfsxc2Qg9/5nhRj6TF059tP0MWyxSpBuPFYX/9RIApuSB+jCewcCSpgkd
         TaSypwQPTHXoBCsJ/OvqTSdrETpkWjO3Uzm8gsVGzK2y6tZeRG3CjMDUnF2yOZ6+giTh
         d5P5KducL9Yhl6OdtZ4FbPXLry1qLW3TwzbstrQ4fZEe6ZScDV/fTGnDPjEcZvLMvB+q
         Ttco63UPqqF3hYVquVdT3xo0qs/c+MvAFJoqPRLOqBfpKtBLl1LiCbn+4PWp5k+XRRgL
         t3yA==
X-Gm-Message-State: APjAAAU3zj1DDq10q4dOuc5CIjB4U0Gf1pf+SyV6gxI6xo/TWtmYxoMI
        5cluI3oOq3gWw8o47F0N6m0mzu+XDnwyntJz4PGjfS+Mq9NVIruHodTwxhNukhfi+J3YEcCQWec
        tUIygA7r3SuGF9Hze7sX+XVkPstHA
X-Received: by 2002:a81:33d0:: with SMTP id z199mr17486728ywz.53.1576436893159;
        Sun, 15 Dec 2019 11:08:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqycQO48OjpM4mR/9GWjlgauBo5Oeu5/tRO3liMoyZRwIC1Isy2D1RIxHEzxEet7GDtGr0MvfQ==
X-Received: by 2002:a81:33d0:: with SMTP id z199mr17486710ywz.53.1576436892942;
        Sun, 15 Dec 2019 11:08:12 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id l200sm7079409ywl.106.2019.12.15.11.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 11:08:12 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Richard Fontana <rfontana@redhat.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: cx231xx: replace BUG_ON with recovery code
Date:   Sun, 15 Dec 2019 13:08:04 -0600
Message-Id: <20191215190805.2491-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cx231xx_i2c_register, if dev->cx231xx_send_usb_command is NULL,
the code crashes. However, the callers in cx231xx-core are able to
handle the error without crashing. This patch fixes this issue.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/media/usb/cx231xx/cx231xx-i2c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/cx231xx/cx231xx-i2c.c b/drivers/media/usb/cx231xx/cx231xx-i2c.c
index f33b6a077d57..c6659253c6fb 100644
--- a/drivers/media/usb/cx231xx/cx231xx-i2c.c
+++ b/drivers/media/usb/cx231xx/cx231xx-i2c.c
@@ -515,7 +515,8 @@ int cx231xx_i2c_register(struct cx231xx_i2c *bus)
 {
 	struct cx231xx *dev = bus->dev;
 
-	BUG_ON(!dev->cx231xx_send_usb_command);
+	if (!dev->cx231xx_send_usb_command)
+		return -EINVAL;
 
 	bus->i2c_adap = cx231xx_adap_template;
 	bus->i2c_adap.dev.parent = dev->dev;
-- 
2.20.1

