Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFE3C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CA62082C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GuL5k8VK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732387AbfIENuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:50:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34544 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731008AbfIENut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:50:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id s18so2904273wrn.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 06:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7lkoesH5emPCZ1WO3WioUS9Ej0K8oiEzZCArs+vDclk=;
        b=GuL5k8VK7SEUa+eInzXIJKoFOrY5XaFAmFl23toxiV9qAxemzM16AiY5hfan5632fD
         Ar2eIp2Upvmf7AHmPSJnRaZz7ftMWRdjsHuOXlZrLHn/Qu/j9XNJnng7FoZ3hChfhFK3
         hOaBNN7s5cqT3FS0T/Qmw5WNPAh2PbxyadZqHbHVd91S1FULPPx0wFL5+ba2EbHP8+28
         XpsvjJbsCOEYKO8eVcJGQ9o8ZpZHE9zUHsf9YGglvLcMsAhy4UgdcbhLxIHkMB5H/afR
         U2zqGMb3SeB8Xb02JsPQcHc4AkdUsVpcdyzi5EJO5VaPLwmy69xBAhSsIOJRB16JPT8T
         Wu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7lkoesH5emPCZ1WO3WioUS9Ej0K8oiEzZCArs+vDclk=;
        b=Fb9sdaaJ8EEZlR5HFKmKqEH/j/xwmUe8CTh7yCvHAz+RMbxZm/3XKY8+/CRYMg99s8
         I+9xU/0KvXcB/h4mfcMmQjfugZDHcLW7FGMwgPYJpHI3eltaloPBPhFTEoWxWr7e+ydn
         Gb992pohRhDlEo9TYxjyXG76VHDetKxMsuXVlUe5pYsQ4bEi/onjxUo2hhvgJT183f0b
         15rrzKS+65sEhZNOJSG+89fZr0ILP02xjfnxFNKvRaJfJu/kTy3i8WaSyrZtZ9Ejw1rC
         yHBVi71nXuQS4j8pnrEJ+dYxtKmPf9nxqK84Z1TXjld+vAGxUW+Ic93HR0SyxAfkpVGh
         wV8A==
X-Gm-Message-State: APjAAAUP5Pn9xSPbkfJiOTeXn0D82wH8VyN1b/WdkJnOTITTmWUnS5JF
        e3hJ0V6KbqIP9PXM2RFwrSuJ0A==
X-Google-Smtp-Source: APXvYqyKxa95xgFb51AsXEWgQity6G8T5bn82NLaGUMSLyirFtOPoyCtT+sjuAmBC+yu4d78xYsgOg==
X-Received: by 2002:a5d:4985:: with SMTP id r5mr2618861wrq.71.1567691446803;
        Thu, 05 Sep 2019 06:50:46 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id y3sm3324893wra.88.2019.09.05.06.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 06:50:46 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] reset: meson-audio-arb: add sm1 support
Date:   Thu,  5 Sep 2019 15:50:40 +0200
Message-Id: <20190905135040.6635-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190905135040.6635-1-jbrunet@baylibre.com>
References: <20190905135040.6635-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the new arb reset lines of the SM1 SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson-audio-arb.c | 43 +++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/reset/reset-meson-audio-arb.c b/drivers/reset/reset-meson-audio-arb.c
index c53a2185a039..1dc06e08a8da 100644
--- a/drivers/reset/reset-meson-audio-arb.c
+++ b/drivers/reset/reset-meson-audio-arb.c
@@ -19,6 +19,11 @@ struct meson_audio_arb_data {
 	spinlock_t lock;
 };
 
+struct meson_audio_arb_match_data {
+	const unsigned int *reset_bits;
+	unsigned int reset_num;
+};
+
 #define ARB_GENERAL_BIT	31
 
 static const unsigned int axg_audio_arb_reset_bits[] = {
@@ -30,6 +35,27 @@ static const unsigned int axg_audio_arb_reset_bits[] = {
 	[AXG_ARB_FRDDR_C]	= 6,
 };
 
+static const struct meson_audio_arb_match_data axg_audio_arb_match = {
+	.reset_bits = axg_audio_arb_reset_bits,
+	.reset_num = ARRAY_SIZE(axg_audio_arb_reset_bits),
+};
+
+static const unsigned int sm1_audio_arb_reset_bits[] = {
+	[AXG_ARB_TODDR_A]	= 0,
+	[AXG_ARB_TODDR_B]	= 1,
+	[AXG_ARB_TODDR_C]	= 2,
+	[AXG_ARB_FRDDR_A]	= 4,
+	[AXG_ARB_FRDDR_B]	= 5,
+	[AXG_ARB_FRDDR_C]	= 6,
+	[AXG_ARB_TODDR_D]	= 3,
+	[AXG_ARB_FRDDR_D]	= 7,
+};
+
+static const struct meson_audio_arb_match_data sm1_audio_arb_match = {
+	.reset_bits = sm1_audio_arb_reset_bits,
+	.reset_num = ARRAY_SIZE(sm1_audio_arb_reset_bits),
+};
+
 static int meson_audio_arb_update(struct reset_controller_dev *rcdev,
 				  unsigned long id, bool assert)
 {
@@ -82,7 +108,13 @@ static const struct reset_control_ops meson_audio_arb_rstc_ops = {
 };
 
 static const struct of_device_id meson_audio_arb_of_match[] = {
-	{ .compatible = "amlogic,meson-axg-audio-arb", },
+	{
+		.compatible = "amlogic,meson-axg-audio-arb",
+		.data = &axg_audio_arb_match,
+	}, {
+		.compatible = "amlogic,meson-sm1-audio-arb",
+		.data = &sm1_audio_arb_match,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, meson_audio_arb_of_match);
@@ -104,10 +136,15 @@ static int meson_audio_arb_remove(struct platform_device *pdev)
 static int meson_audio_arb_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	const struct meson_audio_arb_match_data *data;
 	struct meson_audio_arb_data *arb;
 	struct resource *res;
 	int ret;
 
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
 	arb = devm_kzalloc(dev, sizeof(*arb), GFP_KERNEL);
 	if (!arb)
 		return -ENOMEM;
@@ -126,8 +163,8 @@ static int meson_audio_arb_probe(struct platform_device *pdev)
 		return PTR_ERR(arb->regs);
 
 	spin_lock_init(&arb->lock);
-	arb->reset_bits = axg_audio_arb_reset_bits;
-	arb->rstc.nr_resets = ARRAY_SIZE(axg_audio_arb_reset_bits);
+	arb->reset_bits = data->reset_bits;
+	arb->rstc.nr_resets = data->reset_num;
 	arb->rstc.ops = &meson_audio_arb_rstc_ops;
 	arb->rstc.of_node = dev->of_node;
 	arb->rstc.owner = THIS_MODULE;
-- 
2.21.0

