Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ECDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EEC720811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uMpOiluC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfC1HNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:13:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39880 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1HNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 03:13:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id t124so2634961wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 00:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=o5qQElj085UdXWk7+JCaUV3vxKmvFFqhyu+aF7t2M9U=;
        b=uMpOiluCzs1ZAPTIYCuL+YHUMT0PY2XL2qGC6we94kiBfZHZM+2b+7I5WX9yaz+Slh
         gUDE7urqF2vaA2zbbou6kgbd6r58n9EXiYeHpqY6OQBEkT9gUV3wMWFXm5F9q2OkUlHi
         A64r8n5FfcaulzFPrtkPmsY/7BHSPXsgyeChbHU320sVNU5z3/XsXg7YqwkvH4zZny0C
         f4z+/a9BTHEjRrGVa6V6V20m5M1YzwAnW4wGBoR/jodjGlpBkLh16qKzrPV/1tnMBRm5
         OcJEQ1Wxse7PdDiKePovuCIY4kidxqhKo6uYdwof8LQQgSCYY5qic+TH9sDlfWxS5Klb
         tPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o5qQElj085UdXWk7+JCaUV3vxKmvFFqhyu+aF7t2M9U=;
        b=s4WdHDPU2LFq406xutNJUDHZK718O+J8KwpDy1ukP7uwCvl9QI2DPbNSWZKO9GfI00
         IRYmbwXXTqJ0O/67ispsKxEIqr1hC43gJaoflhpqdnh2DMpcr4PNaS7L4jol46BcJcN4
         ZUlOmn8ffm7ENNz7rWrkmJnxytnAcAotlSgVGP+QyHAmDxDPFDUtPOYo5xtK3/lV6sdj
         wQGtXV9i0zK6uhoKmEmKlv6t5Ir2utdOYooxTM1FhJ11yevO00XNVqZmNJXOp4n+kSjJ
         EnxY3Q0FRju2pY/z5IxmsFYqmHI0YEjw3nh0s2uCuG0sBc7tBo/Arn+kekEylnAbywPB
         F7lA==
X-Gm-Message-State: APjAAAURUzcBC51rPW2pM+BRQ0VMuzqXykmYTeJ63nmZT8k6sbRlBjZl
        mJPg9RDUGeEAHPNeUujeMaMlZBZN
X-Google-Smtp-Source: APXvYqw/HCx/SWLwqefrQLuu9rbkKTCaCi3GvJE/xVEUkhyP0dqCLHddfR30Jj7LPtJHw8ejclk78g==
X-Received: by 2002:a05:600c:2294:: with SMTP id 20mr14043506wmf.56.1553757195821;
        Thu, 28 Mar 2019 00:13:15 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id e193sm4309816wmg.18.2019.03.28.00.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 00:13:15 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: improve error messages
Date:   Thu, 28 Mar 2019 09:13:13 +0200
Message-Id: <20190328071313.5306-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch improves two error messages to help the user to
better understand what error occurred.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c | 3 ++-
 drivers/misc/habanalabs/memory.c             | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index f908643f871f..02c48da0b645 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -261,7 +261,8 @@ static void cs_timedout(struct work_struct *work)
 	ctx_asid = cs->ctx->asid;
 
 	/* TODO: add information about last signaled seq and last emitted seq */
-	dev_err(hdev->dev, "CS %d.%llu got stuck!\n", ctx_asid, cs->sequence);
+	dev_err(hdev->dev, "User %d command submission %llu got stuck!\n",
+		ctx_asid, cs->sequence);
 
 	cs_put(cs);
 
diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
index ce1fda40a8b8..39788b1cf8d0 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -109,7 +109,7 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 							page_size);
 			if (!phys_pg_pack->pages[i]) {
 				dev_err(hdev->dev,
-					"ioctl failed to allocate page\n");
+					"Failed to allocate device memory (out of memory)\n");
 				rc = -ENOMEM;
 				goto page_err;
 			}
-- 
2.17.1

