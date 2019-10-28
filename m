Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AD7CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56F821721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPw09B5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733258AbfJ1U3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 16:29:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38586 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbfJ1U3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 16:29:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id w8so6243279plq.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 13:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=WeECtJnzslq+3WsgfzFxA4T6kzwJDi2w9834CWvUQDQ=;
        b=rPw09B5peYfusomKmiOxxzTbeVm0asYJLc9fmGRItXzuM4PpftzeBc+1d5ljPwz6y5
         GYwLs7z0lb1nXXX6kz+BqPjluz+bDq/WT+0f9W9PC0YwtJWllm4OTTBcZ57hNjQLYd6p
         7Qn95QOroC3qyN8HTpcaHoB+1tOCvzTbNFmCLmDiM7vM2/zyKHxOZQt/u+aacMro/lOB
         pZJfwAPg49plLKAAC7oZhcQCjZUfpokZZ5H+pMurD2UtWuJZUBT+VjFPRlh8+qqdpGe7
         a/sED/I4RvQ+2b3wfR7IhKx/T0SsLbo7ILPls68u6ORcvBCxFVm+5lcUIARZJ7ys5ll6
         1U+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WeECtJnzslq+3WsgfzFxA4T6kzwJDi2w9834CWvUQDQ=;
        b=GE+VdwU7tAiKwF3XjJxL5YoRRN7TJ9Tad5e3dEcSoBtfwLN5r3BEUYAjXTIon8+WBe
         4M4Nplxq3ZkmiupxJdd8N+psYx71orfRQdsxGeZ3szcXB6fU02bNXFHggxbHB/e4qbKL
         Su4QltIU8/VACf9VbtYeZyAcJvGgYvzTpMcgwJ98z6K0rKcIf+xdAE9lcmNfjokaPcVb
         4kvs2Rusne6uZLlvC1rXbC1hOFRr9t6yNcp+/sOlWATtbkdOdNey7E7jetnK4FNVzGIH
         PO2El2ieGeKmgY5HrZ5UR7fNESegt/vzD4jwdA1UB4yhZRG8pGua3iljUgW6by8vF6Ln
         kajA==
X-Gm-Message-State: APjAAAXdXhsuY+wcXtDQg86ypHc9f2/sDYzECq/+ye2ID6bKRAuLki+i
        tgbTdX7ivWmILzWMpE2lDlc=
X-Google-Smtp-Source: APXvYqwjNvJULb6kT/qC3Ov7B/zxAIizTKoZgE8m46ZWkE1T1hS3d0q3S+bN6qSAtCiEUJtbC/SKIA==
X-Received: by 2002:a17:902:6bc4:: with SMTP id m4mr21103928plt.103.1572294592207;
        Mon, 28 Oct 2019 13:29:52 -0700 (PDT)
Received: from saurav ([27.62.167.137])
        by smtp.gmail.com with ESMTPSA id j24sm10934315pff.71.2019.10.28.13.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 13:29:51 -0700 (PDT)
Date:   Tue, 29 Oct 2019 01:59:45 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     alcooperx@gmail.com, kishon@ti.com, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] phy: broadcom: phy-brcm-usb-init.c: Fix comparing pointer to
 0
Message-ID: <20191028202945.GA29284@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compare pointer-typed values to NULL rather than 0

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.c b/drivers/phy/broadcom/phy-brcm-usb-init.c
index 3c53625f8bc2..2ea1e84b544b 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.c
@@ -707,7 +707,7 @@ static void brcmusb_usb3_otp_fix(struct brcm_usb_init_params *params)
 	void __iomem *xhci_ec_base = params->xhci_ec_regs;
 	u32 val;
 
-	if (params->family_id != 0x74371000 || xhci_ec_base == 0)
+	if (params->family_id != 0x74371000 || xhci_ec_base == NULL)
 		return;
 	brcmusb_writel(0xa20c, USB_XHCI_EC_REG(xhci_ec_base, IRAADR));
 	val = brcmusb_readl(USB_XHCI_EC_REG(xhci_ec_base, IRADAT));
-- 
2.20.1

