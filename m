Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F216C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F07A21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ii+6pZt+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfB1Jzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:55:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45885 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfB1Jzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:55:52 -0500
Received: by mail-wr1-f66.google.com with SMTP id w17so21173471wrn.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 01:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=zqpI/B5m5rMa9RUUj4JMXK0QX2rw2KjRN3wUHsQtjtc=;
        b=Ii+6pZt+yUKUiUaDbPGDjpcVZlH+Z0kPVLhHSQvel3HlM+AsFdKe5mEiHBoVhazo9Z
         kDVP13xcGq2pgCbUGWRtupwl7DFF7QAX6EXIDpGSpUn+Q13yMxgvWqV+0AYpAd73E9X5
         8o8kI7dO5sdOMoX2I77GNbhOH0PfmDfWyBT3/crrg1AAfZb/Jd7FY4HWy/ZvyEnNFdxx
         w4oQY85u+Bwp8D5Jsb0RAMzaPylGPvd4dQPUX27ZpmKqa4RHpWdGD+c3h5VV+WVeF1lq
         3gDAzAfPN6G0gsNHegAHG7nrs+GzsDVgs9clSSMnTRpSpAwBM+F+Nclj+JLBF0Y/i0yX
         wlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=zqpI/B5m5rMa9RUUj4JMXK0QX2rw2KjRN3wUHsQtjtc=;
        b=OPwUVAqcsSgBzSt5L18EgS5A8SNYVsRgdZkCofLljie7XCVNhy2UhgLLKZGnYK9JBa
         CtHeixLboF96yny0gWr/ZgTU84knyQ7GoHTohe+TvmKH7H3cFcvGX5IsUWRsXo7OTkCW
         C+c8IOez4DG96IFf026zR5KuuxAIosjcmDqDAaT0kg05HBpPX004a7qx24tmr4pZq4ZY
         J1lldjwh2pFTv3YKM+gUcAdHOIqRVbV5Q6fbCWUjuOBbUsfbsH89XFSGo5H2GjauSzLI
         WB3IfWsJl5/PiR4NoBggP1tlMM3AC16oMc5SMtknDIt5CDuVpfkTze6vu/bUMeyJORgB
         FquA==
X-Gm-Message-State: APjAAAWkfQ6KwDNF+4jhVqkB8kVbyXdLDlVXHOb4MMSsgPBckJ37QuEn
        Y4fugy8VKnuwfYt9Qgud4RKdzzCd
X-Google-Smtp-Source: APXvYqx4nJQ0iqDdNvNIvm2TYkB6vzBRq0D/tWo5aeYUOXCELkM1+mf26gI0VEOJ6ep45w+XoRuj3A==
X-Received: by 2002:a5d:668b:: with SMTP id l11mr5495943wru.116.1551347749809;
        Thu, 28 Feb 2019 01:55:49 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id p9sm4420406wmc.14.2019.02.28.01.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 01:55:49 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] habanalabs: print pointer using %p
Date:   Thu, 28 Feb 2019 11:55:45 +0200
Message-Id: <20190228095545.30842-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228095545.30842-1-oded.gabbay@gmail.com>
References: <20190228095545.30842-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't cast pointer to u64 to print it. Instead, print the pointer using
%p.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
Changes in v2:
  - Add changelog in the commit message
 
 drivers/misc/habanalabs/goya/goya.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 13923f4127af..39824214ce61 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4276,9 +4276,8 @@ static int goya_parse_cb_no_ext_quque(struct hl_device *hdev,
 			return 0;
 
 		dev_err(hdev->dev,
-			"Internal CB address 0x%llx + 0x%x is not in SRAM nor in DRAM\n",
-			(u64) (uintptr_t) parser->user_cb,
-			parser->user_cb_size);
+			"Internal CB address %p + 0x%x is not in SRAM nor in DRAM\n",
+			parser->user_cb, parser->user_cb_size);
 
 		return -EFAULT;
 	}
-- 
2.17.1

