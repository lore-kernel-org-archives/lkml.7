Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B013EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF18218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0/3Q67A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732028AbfB1Iq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:46:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51947 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731954AbfB1Iqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:46:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id n19so8320304wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 00:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=QUriBeUS/pr+zkilkAZ5xExiLBDUqcNRp+XAGTgvAFw=;
        b=f0/3Q67AXIO9Q6vwOOz8nOz64/70z1Px0xN6Ey+O+UrFPXLTO6k59SafqaGe7WRVfq
         GgAvWBGc//jteSi+3/7j9nMKy20c2fbJUZ62UKbao8T43sSysy1X9OqK4ZbiYD5gUTZR
         Nty1IJnFaTxYE/mSOeNrXSW2TxONQv9QpW8D3ljDMrvzpIhd/X3jiA+7/D/2bKGxpANQ
         e+3jiMcoKpcTEq8Sf+71SuzRTZ7/0BiW7PUjC4L25+oZfbPho1ecVyF6Y2ZOQmZQYfGu
         duXFo56K3NRToYzWFyOVEaeEXJ9NRYtUVEt3yt7xPvtpm6CFSYhXd8ns7G+Pk0x5ywBG
         /jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=QUriBeUS/pr+zkilkAZ5xExiLBDUqcNRp+XAGTgvAFw=;
        b=lGhRNQE5rUb07fxUuK7fd4wN396IP5T2W3ABiuuuKkqAcD437A/1fle0yvz2v6wf6G
         3S2KMngIOw3E9nB8Obyj3VOxHn/7gabau7oiR03zXjYY3kX9ImoubIq5nzI9YVLUXoqc
         nNiPuSUiKvaa0vqe2/b9wW6Bmm7o44SEZ0GZnywAbz3jsVcPMYPnfDeM3+bfwqG+WD1L
         dULonOji4OJ+lsHhmyOVLm0Y53XalDMOo+JEoqxmmIgVA6A99Y4CRklSWQhFTHlEsY6T
         shHXdWRtBLijrQHcACK4c4LHaKxIuHaVTlvUM6sHchgf4oZhn+zPWRR+KzGBbs5XOPXn
         nFnA==
X-Gm-Message-State: AHQUAuZed19ugYQSCdbC0vfyzIhv4jFXGaDEhOlDNHw/4dBHT1ZhW41w
        Qir1Q7WwaUYaD5b3jCKAAw8=
X-Google-Smtp-Source: APXvYqz/1b1l0zlREdb0Ph7CIE62gcS8LT5j/n1RVxkRjUNyIkgcWY+3NR/8eHygqYnNvHcA1khUmg==
X-Received: by 2002:a1c:6c0c:: with SMTP id h12mr2140693wmc.35.1551343609896;
        Thu, 28 Feb 2019 00:46:49 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h126sm4409305wmf.2.2019.02.28.00.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 00:46:49 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] habanalabs: print pointer using %p
Date:   Thu, 28 Feb 2019 10:46:20 +0200
Message-Id: <20190228084624.25288-12-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228084624.25288-1-oded.gabbay@gmail.com>
References: <20190228084624.25288-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
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

