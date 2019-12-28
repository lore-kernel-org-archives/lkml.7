Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC48C2D0C6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 18:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90A9218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 18:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBDWwT73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfL1SgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 13:36:18 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35525 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfL1Sfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 13:35:55 -0500
Received: by mail-pf1-f194.google.com with SMTP id i23so10907075pfo.2;
        Sat, 28 Dec 2019 10:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P8HOUTr3eF/0dZg+if1YFcXmVFAjMiDjsMoChiGwrOo=;
        b=qBDWwT735xPG/Q9VTH7Jk7ltHqJGzS3SIxRJyL/UGKLhT7cIiteBnbPNein0+zuYE8
         G5i8IlFW2hE7Oa2TgAYWyq/BO/6LSnQx3UVC/uxt/9u4n8IPFi3wj3qTM60uObs3vPDd
         jQv4IxlP2VO+QrcbqwkFMJqyHITKONYz4jXKqOm+U11JeG/N35CiFkMurclNO0EXtPQE
         Bw21iyPcB3S8P0FC3LPvm13lLMp4aiRHWpIiGIOVR/X04PmcBJrbgvC7yrtjFe+I217L
         5zkbf8OI+YCmGViTfmzsoEIVblJ47JqV2dp9CGtOzypeTVpEdtYAEcY1CAwd2SUPF0yj
         gAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P8HOUTr3eF/0dZg+if1YFcXmVFAjMiDjsMoChiGwrOo=;
        b=QlTRNMHYlHb4IM4HzEVX2l7tap1BbPaqLY9r9GOM473dqm3OTijAIpDY01vo/PBHpC
         DYYmljet6i8LXvad6ZdNbQuJ2muLTCUReGeR1uPYg2DMDvBxIEJc+V08UkWxYrQqOy1I
         cINLmONs5aKekCxE64RcBB8R+uMY3HDUQ0126iNevjDjQeNQsStOEd+L4y7wgJjWvQfB
         YBF/9gu5oT/dWhLaPbxoXX6xwBx7FiQAZNVClEUxQyr00+cuYx5Jw7NY1eALityM2KN+
         EP133bUVy68sajFt3WvAWxl8SO2YRgn++Ct0oK2ZTvm7d6hyRWgOVeZsE/2H12ri33gU
         Wtdg==
X-Gm-Message-State: APjAAAWaGl5F470hGgESo4HgkF7CTHFUTufqysjwyVU0KMh+AntqPo1N
        qf8SKrbPxcJzcxhpiD6XYwI=
X-Google-Smtp-Source: APXvYqxea8vWEh1FOmzdiLRfJsv6AzNkX2LzmseSeWMmZhHvq8Jq9qBoRVY01nxVBzYg5sRmju+cRw==
X-Received: by 2002:a63:c40c:: with SMTP id h12mr43297443pgd.77.1577558153578;
        Sat, 28 Dec 2019 10:35:53 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id n1sm45063313pfd.47.2019.12.28.10.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Dec 2019 10:35:53 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     jassisinghbrar@gmail.com, nsaenzjulienne@suse.de,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, lftan@altera.com,
        matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        nios2-dev@lists.rocketboards.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 09/13] mailbox: sti: do some cleanup
Date:   Sat, 28 Dec 2019 18:35:34 +0000
Message-Id: <20191228183538.26189-9-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191228183538.26189-1-tiny.windzz@gmail.com>
References: <20191228183538.26189-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.
'irq' and 'ret' are variables of the same type and there is no
need to use two lines.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/mailbox/mailbox-sti.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/mailbox-sti.c b/drivers/mailbox/mailbox-sti.c
index 2baf69a0b81c..2a2316dfdca0 100644
--- a/drivers/mailbox/mailbox-sti.c
+++ b/drivers/mailbox/mailbox-sti.c
@@ -408,9 +408,7 @@ static int sti_mbox_probe(struct platform_device *pdev)
 	struct sti_mbox_device *mdev;
 	struct device_node *np = pdev->dev.of_node;
 	struct mbox_chan *chans;
-	struct resource *res;
-	int irq;
-	int ret;
+	int irq, ret;
 
 	match = of_match_device(sti_mailbox_match, &pdev->dev);
 	if (!match) {
@@ -425,8 +423,7 @@ static int sti_mbox_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mdev);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mdev->base = devm_ioremap_resource(&pdev->dev, res);
+	mdev->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mdev->base))
 		return PTR_ERR(mdev->base);
 
-- 
2.17.1

