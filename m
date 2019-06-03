Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E053BC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF79D24195
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="kST1sHwc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfFCW3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:29:42 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36766 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfFCW31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:29:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id q26so14854001lfc.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 15:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UjUSFd7aQdKxToFSdaPtLUOkedKCOVjOL48MGdTc4nI=;
        b=kST1sHwc64ZSCs8SYnRlC3eRj16PK7btR3jYrcwuilOwjcsztbqLtKLD3+CtwDyx9s
         K6KNfpNEC0gCI/s3YToyLuNjfH63GwcUvKFPkUermd6Vl1Z8GqETllQ3hcGGmSQFOAhU
         DhpWPuZ82sOKug8DSzqCEnnrbcPaWEgGiQciw+AnI90SEFpaQ9fjyqi+CyEj0Oj75DdW
         2uGQrFe0ImOZftzhrb22eBuyt1SEAv6wxg5/n74NtOHqxCVwEAKUL+2fTt5l4gKSS2Px
         x7L4AblI3Up3nzOK+VmGIeRO9rn+nYsMAFgabYzDocZQIJOphziEcvJx6GwFJOMTpI2/
         SnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UjUSFd7aQdKxToFSdaPtLUOkedKCOVjOL48MGdTc4nI=;
        b=tBATysShxD4DprGjDC/926kqdN0lgKPlL5mnFqcITMpHpuF9peVXRFhJplviHvWZ1c
         SeEWtLUJCbIOAwhyA97BgdbNO0kgRLvLdahSciFeNDcGocQ+7EwwJn//6k15eVGTtPGS
         RSZteJDtnS+326jFH0naxB5pe+aE5RZtAiA8SqxR0Ah46iI6CTmmZTIjg7XTZeaUKC5Y
         soZ0kT5OPKybDXLdmElk5CH0URwnmuGTBz840qTWcmV+nheWEXGr6reSb4VYLkFdttXr
         Lig7l3xfo8ohGe6ZQBx96LrOzQbvyTWj30OW+7m1PZ7hIaLd+KNqm8MQS3jxbIytzior
         X6CQ==
X-Gm-Message-State: APjAAAVDzSfOdxgOtivx15ekv12RD0KzKbV8isvN2oO2UZkqz5KRupC4
        aKl76GabqRj6vw6KtCB2WcK2fw==
X-Google-Smtp-Source: APXvYqw0ku2LIOk5AxJvPbEv/l1A40D7B8/99dV/mebt5NJDDFkoBATB9Xq5OFMTEtiGTclTd3OPRw==
X-Received: by 2002:ac2:5938:: with SMTP id v24mr4612177lfi.161.1559600966162;
        Mon, 03 Jun 2019 15:29:26 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id x20sm2175874ljj.14.2019.06.03.15.29.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 15:29:25 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] staging: kpc2000: use sizeof(var) in kzalloc call
Date:   Tue,  4 Jun 2019 00:29:15 +0200
Message-Id: <20190603222916.20698-7-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190603222916.20698-1-simon@nikanor.nu>
References: <20190603222916.20698-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl warning "Prefer kzalloc(sizeof(*pcard)...) over
kzalloc(sizeof(struct kp2000_device)...)".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc2000/kpc2000/core.c
index 3f17566a9d03..2d8d188624f7 100644
--- a/drivers/staging/kpc2000/kpc2000/core.c
+++ b/drivers/staging/kpc2000/kpc2000/core.c
@@ -317,7 +317,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	/*
 	 * Step 1: Allocate a struct for the pcard
 	 */
-	pcard = kzalloc(sizeof(struct kp2000_device), GFP_KERNEL);
+	pcard = kzalloc(sizeof(*pcard), GFP_KERNEL);
 	if (!pcard)
 		return -ENOMEM;
 	dev_dbg(&pdev->dev, "probe: allocated struct kp2000_device @ %p\n",
-- 
2.20.1

