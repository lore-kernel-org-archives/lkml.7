Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F39BC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C61721926
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xxjy88ue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfGXNSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:18:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40898 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfGXNSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:18:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so20946439pfp.7;
        Wed, 24 Jul 2019 06:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=30qJDnmCZ4/uvVlJ+Clx3gFmvQD0xujSfEYRo/JqAkM=;
        b=Xxjy88ue/S0k3dOrtCWTrdLRFLhpaxvyecCyQNVQR83iuol49E+cry9FaW+ccHNTsq
         to9scdoCVuEZJmvWtzodOB4kZOyDhn3Sh7IzCsRvYIPjhS4SHYzR7BjVZ8JA9hNoxtQE
         jE83AjBB2kV/MfqS8I0HEArR6rfBjAV2RarGp0KESkT2n87Lmm0+mgr0uevcWYoslfMs
         E4BAjxAqvGthv5KhEkU7+438c0OLGHR5J94owMT3XCHC4F2Sv/ZJzhkrpns0Rk+gQ6dO
         Dq9wde94GaspO+IwxxaRXO1/PSHbMTtV9zhS1SJSiLEfWXBtYrIOglyq9qEZRFvQwyyR
         mbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=30qJDnmCZ4/uvVlJ+Clx3gFmvQD0xujSfEYRo/JqAkM=;
        b=Bv7B3mqXnmidnIKcJDfrERGtZfUsjUl4w01RKv5D3RLyRQNxy8uoULiPVt0sFsia1h
         fRH3DBATK1PV0B92p5w1L4ePrmpbWrtH33Imqmsvyw7R4u+p0+cicpYgMA/AHbwJE2Hn
         PJSlk/9r+wNuyESaNJ0POyMMjIkBMSVrfl5jrNp7JwHOJsxOrRnLxRtDvCUb16UGj0m9
         f05iiqwzG4RTRLqisMW/RWWa5WZ7hsz4Q+vPahcJDEVcCnaXZJZJBsSV8cGx2xW7RNpx
         q82xvd6uGXQuHg7qI+rKEogx8Kf8Q8SJAMAk5FH33CjuRdG6JSC7hYZ17mXWit7IKkMK
         T9ng==
X-Gm-Message-State: APjAAAXnkjFiOgXYNtjiVK5n7AjtF0O1HEj3FFXhH0OArU69stcI9sRA
        8aYZM27RGoUcN5wetCFtyPU=
X-Google-Smtp-Source: APXvYqyzNuuvEeMRhwcWD6GBRIgZpBTcto6ixVYxiQ9UYrCMa+pEkUn2ULLgJeq/ummR6jbPAqkdfA==
X-Received: by 2002:a63:6f81:: with SMTP id k123mr83112839pgc.12.1563974334092;
        Wed, 24 Jul 2019 06:18:54 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id y23sm48371791pfo.106.2019.07.24.06.18.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 06:18:53 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] usb: gadget: pch_udc: Use dev_get_drvdata
Date:   Wed, 24 Jul 2019 21:18:49 +0800
Message-Id: <20190724131849.1985-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/usb/gadget/udc/pch_udc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index cded51f36fc1..265dab2bbfac 100644
--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -3046,8 +3046,7 @@ static void pch_udc_remove(struct pci_dev *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int pch_udc_suspend(struct device *d)
 {
-	struct pci_dev *pdev = to_pci_dev(d);
-	struct pch_udc_dev *dev = pci_get_drvdata(pdev);
+	struct pch_udc_dev *dev = dev_get_drvdata(d);
 
 	pch_udc_disable_interrupts(dev, UDC_DEVINT_MSK);
 	pch_udc_disable_ep_interrupts(dev, UDC_EPINT_MSK_DISABLE_ALL);
-- 
2.20.1

