Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7827C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D528215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGpvkRMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732130AbfFYKvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:51:19 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:34256 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbfFYKvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:51:17 -0400
Received: by mail-wr1-f51.google.com with SMTP id k11so17341952wrl.1;
        Tue, 25 Jun 2019 03:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TndtnfmApuDT+rImk2MQBf+vOdTdX2NNKvYRPqDE0/4=;
        b=QGpvkRMVw9U+eurBmzmN6gxdi0h+CLbLwaPoQl9W1j/a9mq3H43903weNxSLAKeNor
         jv3AT0Rlo/keJWGkp6ds73sanSyQEptNG2A/lP7rzmFzcvUtRBmAoPzpM5cUqRUxqX8o
         VwrcSaXoGkU6J89J5RqS7AypxOo9x3hOuwh06zKvnt2MEdyjia1mgAhrG+AahzoDVjmq
         uwfu7V54LYl2T/YBQn1d+mXFpx2MyCXJf+9EjffzkQB1knyeRvMFKvlhN+qkHp7QsJj3
         cmBIiREbm0oi4QGrComMAtQ9AYCbAIg1dHsgpJYIAj32qUTYNNVmiB9IT4UuXRlo+/lp
         9ABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TndtnfmApuDT+rImk2MQBf+vOdTdX2NNKvYRPqDE0/4=;
        b=LtcS6hRuCM/zEFuBpLsyCYXgL4prAvkXKXN1Y11z8n6EEi17q8ymAjrG/IArWm/5T1
         XjB8ZUX0ynYCWypOr9qALMQmPRnz/0T+jm2Q6XaT3YxdDJBSQ4o5RaX6iT6Kh0mxlMhx
         Cl6gK6KgyMNaj938vUI9myS0a6W6iyQDSjEDbbeZ8xZ/c0CK3QymKlPjBDj4N9LXPSLC
         NdbfFeVYT7tG2YacKDBIMyrYmq9WR1U8Sku8gZOcSOBNTTiGCBw/K/9nFgUd+Q3/AsxV
         BQhtRJeGVdbApl+XW3HveVXVrXR4hTpkqfr0yNpOXjCvpoAm1uvXV+evZquWgxkKjgTe
         WeTQ==
X-Gm-Message-State: APjAAAXPMJq9GO8v50rcMjc7Ax5XYfVFBIE9j7Woh8Pyj5/L4Ke0pSNx
        4QpsKQ4Y2HM3g3him/4BNME=
X-Google-Smtp-Source: APXvYqxmRAMMtmtHChbfYlxbpFqMNNibh1/nuXVO1g6/xOhRVk+yasfrd10IznDqaU4i28PiHxHCJA==
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr55959928wrj.51.1561459875651;
        Tue, 25 Jun 2019 03:51:15 -0700 (PDT)
Received: from sausage ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id x11sm2284894wmg.23.2019.06.25.03.51.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 03:51:15 -0700 (PDT)
Date:   Tue, 25 Jun 2019 11:51:13 +0100
From:   Jeeeun Evans <jeeeunevans@gmail.com>
To:     mchehab@kernel.org, gregkh@linuxfoundation.org, code@wizofe.uk,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: media: davinci_vpfe: prefer using BIT macro
Message-ID: <20190625105113.GA22430@sausage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use BIT(x) instead of (1<<x), reported by checkpatch.pl.

Signed-off-by: Jeeeun Evans <jeeeunevans@gmail.com>
---
 drivers/staging/media/davinci_vpfe/dm365_ipipe.h     | 2 +-
 drivers/staging/media/davinci_vpfe/dm365_isif.h      | 4 ++--
 drivers/staging/media/davinci_vpfe/dm365_isif_regs.h | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/davinci_vpfe/dm365_ipipe.h b/drivers/staging/media/davinci_vpfe/dm365_ipipe.h
index 866ae12aeb07..de9b04683d82 100644
--- a/drivers/staging/media/davinci_vpfe/dm365_ipipe.h
+++ b/drivers/staging/media/davinci_vpfe/dm365_ipipe.h
@@ -99,7 +99,7 @@ struct ipipe_module_params {
 #define IPIPE_PADS_NUM			2
 
 #define IPIPE_OUTPUT_NONE		0
-#define IPIPE_OUTPUT_RESIZER		(1 << 0)
+#define IPIPE_OUTPUT_RESIZER		BIT(0)
 
 enum ipipe_input_entity {
 	IPIPE_INPUT_NONE = 0,
diff --git a/drivers/staging/media/davinci_vpfe/dm365_isif.h b/drivers/staging/media/davinci_vpfe/dm365_isif.h
index 0e1fe472fb2b..288a1211b387 100644
--- a/drivers/staging/media/davinci_vpfe/dm365_isif.h
+++ b/drivers/staging/media/davinci_vpfe/dm365_isif.h
@@ -172,8 +172,8 @@ enum isif_input_entity {
 };
 
 #define ISIF_OUTPUT_NONE	(0)
-#define ISIF_OUTPUT_MEMORY	(1 << 0)
-#define ISIF_OUTPUT_IPIPEIF	(1 << 1)
+#define ISIF_OUTPUT_MEMORY	BIT(0)
+#define ISIF_OUTPUT_IPIPEIF	BIT(1)
 
 struct vpfe_isif_device {
 	struct v4l2_subdev		subdev;
diff --git a/drivers/staging/media/davinci_vpfe/dm365_isif_regs.h b/drivers/staging/media/davinci_vpfe/dm365_isif_regs.h
index 6695680817b9..e64b75dc1e5a 100644
--- a/drivers/staging/media/davinci_vpfe/dm365_isif_regs.h
+++ b/drivers/staging/media/davinci_vpfe/dm365_isif_regs.h
@@ -284,8 +284,8 @@
 #define ISIF_LIN_ENTRY_MASK			0x3ff
 
 /* masks and shifts*/
-#define ISIF_SYNCEN_VDHDEN_MASK			(1 << 0)
-#define ISIF_SYNCEN_WEN_MASK			(1 << 1)
+#define ISIF_SYNCEN_VDHDEN_MASK			BIT(0)
+#define ISIF_SYNCEN_WEN_MASK			BIT(1)
 #define ISIF_SYNCEN_WEN_SHIFT			1
 
 #endif		/* _DAVINCI_VPFE_DM365_ISIF_REGS_H */
-- 
2.22.0

