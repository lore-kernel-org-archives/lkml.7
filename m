Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8813AC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 09:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D0C2087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 09:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPZtb5a1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfD0JMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 05:12:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36382 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfD0JMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 05:12:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id l6so5092561ljb.3;
        Sat, 27 Apr 2019 02:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9xgHPH09YGJhCPvbuKiscLvKx1wCoR98FI2oDiSX2Ws=;
        b=GPZtb5a1+GwwjAGS9GaB8QEvI6hF6Bt65vyDloU6bDMGmCnHoNGgR15bK5WFgNfkoS
         S3g8qP/fSuGfP2wNkWcDJg+adnNQBv7jtMKf3ok5ovH6sxImCQKp422B+DAE3AZqdytr
         XkeTQbmN1h/FVr+W7w6s0bXZQLLr/ZiupZADGyPjRt3+4ItZrLqUT+9Bd3fouBfTHy7G
         W3RBwB+gJVkZri7phb5Rbca5lqhEJUFjTFBiKqNxieG18xXdYVtA75n9GkpGee+1Q5oC
         zKOelxlzW2Sfo8LILpuF2zax/Eb9t9HdceNO2DdlrXURwmjd7drSWsEAxiYSxntwlNFv
         H85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9xgHPH09YGJhCPvbuKiscLvKx1wCoR98FI2oDiSX2Ws=;
        b=K3fjSCkfx1Xo2rgI1KJiuLeQ3VFR9TJIsKcL518huKXdkMC9exdP9ceX2tlf4dl0AM
         RAinokqinNmTd0WBW+fWvsw9PcS7A+Iji4tESTlQST0/jT47aV7toXFmXzy3Rgf/qjte
         1MjV5q8zPPaLzroXQmW+AS3qA0UxNcKlMfpS6JZpbNGhhNQfrUzeb5iFuguS2XZNpO2Z
         6EOGEaW3D6rNsm4De+HO2DE3kRt1hrRRY8wLUU/3pum/KOVh3/x5BLXaEPL9YlUlpDFD
         /YKrtfcpY7uUiqFRARzq33VyL9xdA9BAdG0WEDE0ODSPgQD8/ZT70KnZ4onib4k8AgjC
         7fLw==
X-Gm-Message-State: APjAAAXqDHo0Y6FThwLDUwlVpUDfPSnT8pC4e4oo5JIU1sh4j9nYS4oY
        ks9J7iBbyEa12zqpphlvNpE=
X-Google-Smtp-Source: APXvYqw18cwZVYJuGF92dcW9cRRa+taT9kDCNYZUbyaGu/ljvbZGakThDVuilREIwDGCs0TEwXF/jA==
X-Received: by 2002:a2e:894e:: with SMTP id b14mr23758129ljk.158.1556356318675;
        Sat, 27 Apr 2019 02:11:58 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id y7sm6134228lfg.76.2019.04.27.02.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Apr 2019 02:11:57 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Richard Leitner <richard.leitner@skidata.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        kbuild test robot <lkp@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: usb251xb: Add an empty hub' i2c-bus segment checker
Date:   Sat, 27 Apr 2019 12:06:44 +0300
Message-Id: <20190427090645.30621-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's pointless to scan the hub' i2c-bus segment if GPIOs aren't supported
by the system, since no GPIO-driven reset could be cleared by the driver
then. Moreover if CONFIG_GPIOLIB is disabled the gpio_chip structure
definition won't be available, which causes the incomplete type pointer
dereference compilation error. In order to fix this we need to create an
empty usb251x_check_gpio_chip() method returning zero, so the driver would
skip the i2c-bus segment checking and proceed with further probing in this
case.

Fixes: 6e3c8beb4f92 ("usb: usb251xb: Lock i2c-bus segment the hub resides")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/usb/misc/usb251xb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
index 939b3bedd4c8..cdc80e8c2d8a 100644
--- a/drivers/usb/misc/usb251xb.c
+++ b/drivers/usb/misc/usb251xb.c
@@ -223,6 +223,7 @@ static const struct usb251xb_data usb2517i_data = {
 	.product_str = "USB2517i",
 };
 
+#ifdef CONFIG_GPIOLIB
 static int usb251xb_check_dev_children(struct device *dev, void *child)
 {
 	if (dev->type == &i2c_adapter_type) {
@@ -253,6 +254,12 @@ static int usb251x_check_gpio_chip(struct usb251xb *hub)
 
 	return 0;
 }
+#else
+static int usb251x_check_gpio_chip(struct usb251xb *hub)
+{
+	return 0;
+}
+#endif
 
 static void usb251xb_reset(struct usb251xb *hub, int state)
 {
-- 
2.21.0

