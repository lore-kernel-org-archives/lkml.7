Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75189C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3639220882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fg1HQjei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfDDVOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:14:46 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35991 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfDDVOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 17:14:45 -0400
Received: by mail-oi1-f194.google.com with SMTP id l203so3163184oia.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 14:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=s8sC4Hmcy2TxEV3RFkWwYKEoQMnRQLJcygc+1mfffL4=;
        b=fg1HQjeiQioVkdjXj8KS+qx2h1oehCcb505C9T1Xhtaf/0zPHKbBeMkPjsm+0wTPq5
         JGhan/y7QPeBChQgcgqxdX6Xi9wipHPmV+qDBVP8XCfZxQ/VO1UfCCRy1ydNbjwJHQ6Q
         UGbdpawwYAhgbOLQsA2/EDfqQizuaj8DK2pk1kG6MdBQZPDcbrhfRU5CIF4ToHXEhBGG
         G2PLCnlZhU6TvJ4CUE4KzhJXgGGp2XqSzMdEMnyp74Nnp1vhS92fCrrJYxtB00Geakf4
         UvKYiXxvaoNS2sfJz4uK7fJ6yFHjaRxUKs/pIYWmRxicFvXwc0f3n5ssIgFt0nItVuDY
         CSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s8sC4Hmcy2TxEV3RFkWwYKEoQMnRQLJcygc+1mfffL4=;
        b=bxvDcP2Quznasb+ukmMBCzsRHKV3r60U3SrNnmSHXIWF1692xcJZv6pGF2dzUzO3Uy
         e0QnYb45ar5gLjf7Y9TcPYfWav3pJKvj1013nxeOEcrVJFF7PAPKWHYy1M50Y3/bGisn
         PjzHnU+mX+Ph1OTHgI+WTzcz28Ayf4ZfBhDmGl7uo+xOCI1aiiLf/lN/XwQg+FbVI5yg
         i4CNCfw6xoRre46CCx2GgfmPS7A8ecwrk7Ut00ZHiEPj+5iERRzMbDiXWggH4TGFV4nq
         o9wJFlOEBX99Skxoe2WSA0ivaZErgI/2EW/gZNIpbdOtrNAt0fVHLbweMbaS8duWatu9
         8niw==
X-Gm-Message-State: APjAAAWJGQcg0Scy/rEv9xEgUhOww+R1GYhsI03tCZ51dmkdPat90NJa
        ho8P5wNVNzo8aj+d/in9Ri0=
X-Google-Smtp-Source: APXvYqxzOfpU89GSxWdQCYX1OkjlHjlfBWHyy1qJ++TKOd3n+gGd7VI3qGDyFDSiYC/37g6gxfdFPQ==
X-Received: by 2002:aca:cc86:: with SMTP id c128mr4631424oig.119.1554412484914;
        Thu, 04 Apr 2019 14:14:44 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:7549:4e85:9095:b601])
        by smtp.gmail.com with ESMTPSA id c90sm8109584otb.71.2019.04.04.14.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 14:14:43 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH] Staging: rtlwifi: Remove & on function name
Date:   Thu,  4 Apr 2019 16:14:41 -0500
Message-Id: <20190404211441.17686-1-madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function name is otherwise used as pointers without &.

Issue suggested by Coccinelle.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
---
 drivers/staging/rtlwifi/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtlwifi/pci.c b/drivers/staging/rtlwifi/pci.c
index 4bb5703bd715..b97c76ec22ea 100644
--- a/drivers/staging/rtlwifi/pci.c
+++ b/drivers/staging/rtlwifi/pci.c
@@ -2134,7 +2134,7 @@ static int rtl_pci_intr_mode_msi(struct ieee80211_hw *hw)
 	if (ret < 0)
 		return ret;
 
-	ret = request_irq(rtlpci->pdev->irq, &_rtl_pci_interrupt,
+	ret = request_irq(rtlpci->pdev->irq, _rtl_pci_interrupt,
 			  IRQF_SHARED, KBUILD_MODNAME, hw);
 	if (ret < 0) {
 		pci_disable_msi(rtlpci->pdev);
@@ -2155,7 +2155,7 @@ static int rtl_pci_intr_mode_legacy(struct ieee80211_hw *hw)
 	struct rtl_pci *rtlpci = rtl_pcidev(pcipriv);
 	int ret;
 
-	ret = request_irq(rtlpci->pdev->irq, &_rtl_pci_interrupt,
+	ret = request_irq(rtlpci->pdev->irq, _rtl_pci_interrupt,
 			  IRQF_SHARED, KBUILD_MODNAME, hw);
 	if (ret < 0)
 		return ret;
-- 
2.17.1

