Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A4FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49CB2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCXhSvCb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbfB1Iqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:46:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37573 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731578AbfB1Iql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:46:41 -0500
Received: by mail-wr1-f66.google.com with SMTP id w6so17704316wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 00:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=DqTQEoYPVcLGXO5om5bUuuwyHl+vyYnJVGDY78wRtGs=;
        b=FCXhSvCb3VLI70AO/xvdV6ZwQz6xVK3E72xYjW53t4CdXHlqOA1ZChr++QSXptvmef
         CX/Rnqufbn/rO7D7K0oBv04XeAanjQoqJmVUVZVEGaPk9h79swkN5T/1qNJAlwk1OU36
         S/Y9GHzE1PfQ3yMhe23oRO7R9iZx0J0+Z2nrtNi2IqaiLxJMOR3+PzN3JcWvohMQqz2i
         gThrCSXUYGBVNXeFhJV4CZcPvVaLjZxANXIRI8iEJm+jpKSjesKde9PIb6Xv+G/4USrq
         4WPfaXST2T+lvFnWvL2Ry6H3sbEHLDsnlqG3l3w8Aed6GCIZNf+MICiUltJ+DF9Rs3ug
         WC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=DqTQEoYPVcLGXO5om5bUuuwyHl+vyYnJVGDY78wRtGs=;
        b=DMjgcMU48m1QiAWNfyqbzV8Q9cLoLX7MMSLS3mjlc578MwGb96r08amorPfCqxn2u0
         aLPZQfY5gfHoqLNpASys8yJOn0ymhfqbRZGRwsOeF1usYxJsAoFoAbsKlp2Ps61BOclc
         yheXzpU0UrG6NsPWE1X0G/7j/GTtZpyweq/riyfeLLiRUZwTA8OuHN8Cl+eMYimSccZ5
         tMQJqlPV+GDhu+bFQWuqaj5ATW1Nqs0mPwPVQJLg6ejoTYVLiiWJhbUAFwdlgGhtN3tW
         9pL9xNppGR3Nu9YTrwXGI56s3SlPiLJR+s4HtYnCAlKb/bXclE78Q1gA4Q3f8hfHPfUp
         +6iA==
X-Gm-Message-State: APjAAAX7XIQ1aYoBDmJ6rHHgTAu/o1QxmU2u0n4eDgEuzzMyA7XA6X09
        bo5bBXsVOtVoHrqwNiWRe6E=
X-Google-Smtp-Source: APXvYqyVNugW87tiW9wvyk+I3xFN95VFluw9TOK9TrGAG+pRMcY4eSukLqQIRCshvnlWIG4WKrmILA==
X-Received: by 2002:adf:e50e:: with SMTP id j14mr5618792wrm.262.1551343600041;
        Thu, 28 Feb 2019 00:46:40 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h126sm4409305wmf.2.2019.02.28.00.46.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 00:46:39 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] habanalabs: fix validation of WREG32 to DMA completion
Date:   Thu, 28 Feb 2019 10:46:14 +0200
Message-Id: <20190228084624.25288-6-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228084624.25288-1-oded.gabbay@gmail.com>
References: <20190228084624.25288-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix a bug in the validation of WREG32 in DMA queues. The
validation was too strict. It allowed the user to set the completion
address only for DMA channel 1.

The fix allows the user to set the completion address for all 5 DMA
channels.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 5444cd0824b4..6f0075c4e935 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3769,7 +3769,7 @@ static int goya_validate_wreg32(struct hl_device *hdev,
 	dev_dbg(hdev->dev, "reg_offset == 0x%x\n", reg_offset);
 	dev_dbg(hdev->dev, "value      == 0x%x\n", wreg_pkt->value);
 
-	if (reg_offset != (mmDMA_CH_1_WR_COMP_ADDR_LO & 0xFFFF)) {
+	if (reg_offset != (mmDMA_CH_0_WR_COMP_ADDR_LO & 0x1FFF)) {
 		dev_err(hdev->dev, "WREG32 packet with illegal address 0x%x\n",
 			reg_offset);
 		return -EPERM;
-- 
2.17.1

