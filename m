Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD71C33C9B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 03:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA6B2070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 03:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJxpo/SH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgAHDYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 22:24:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37937 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgAHDYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 22:24:08 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so884062pfc.5;
        Tue, 07 Jan 2020 19:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Yr7ow8GTmJkAHzIYaMaQkuIE5TitlU69AapCYxHxDps=;
        b=PJxpo/SHdwwoGkXr0J2qM59FCUCLggOZnuzUinBypKNTya68JfKqKnqrxRSzt8wlHL
         LjoUY1wArm6F+WoLHFjglR+sprDXVhrb7Z+BCgtliCTsjxv6F6wUoE+bjHpNvOrExaFr
         5YVQVoe0Ix1q668tsWmMrJath+A5yK+IRiSri00cYc47i6edLxX9B4YmZjMzATkcco6p
         BAZ/wYrLibXK5+zAlGLuIlfjvvBCx6KQnsBkeOXCE4VilnyHd/QRSwGFwfmKhJ++hHV1
         XYkUsOpsWYO/0FUO20MoZeSN24Jiv4Kyn3ejlQXagD1MRAAr6yr9dHKg8Cg+93gz6xEk
         15DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Yr7ow8GTmJkAHzIYaMaQkuIE5TitlU69AapCYxHxDps=;
        b=PFYIq0XXIb/N+lvwkFmNXx1IlW+/AMThtis8ixErvIebIVslH5evQ0gnsoWSa17485
         XCZ75OUhREVoe3XM0ytQ9h1XVoqc5EF8m4KkkK4A/jq1d80R7RRiLjchrEf6AUoLXR07
         IHHyLtlXKdBnQlvjhUEtEi72PsxE9SB+c8a5sm3K/OUFOCMtstsefvYhxdFaMjbJbhyu
         ETQYCtSwt2u+XRhQfy/LsCcyob5AjCfzhQ6yQalMuKz962tJ77sytv0QM00tdc8aCv/E
         flQQO5n5tkCPFJLnG4sWodUf66cb1VKU8UMjFrN1rbvnixiBf2tzm8FJo8kKk/L9I+7K
         xJrg==
X-Gm-Message-State: APjAAAUI6UC6iTdANLUIRh5ZJLvEa9i2Uw6RH4sUIxO/z3TKwuK35Y84
        rfJb9BUSx/t7P/VBPZCSAHc=
X-Google-Smtp-Source: APXvYqyagAGVADxDem+49GDTXFZMHJU/p7gFf50NwAr+NIMt6ry+FxLZ9Wx3VhxyRZHpmypX9eTPkw==
X-Received: by 2002:a63:1d1a:: with SMTP id d26mr2920384pgd.98.1578453847905;
        Tue, 07 Jan 2020 19:24:07 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id g7sm1077875pfq.33.2020.01.07.19.24.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jan 2020 19:24:07 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, baohua@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, baolin.wang7@gmail.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/3] hwspinlock: sirf: Change to use devm_platform_ioremap_resource()
Date:   Wed,  8 Jan 2020 11:23:44 +0800
Message-Id: <dfa043f317c609a6172468ac11598968dd751bce.1578453662.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1578453662.git.baolin.wang7@gmail.com>
References: <cover.1578453662.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1578453662.git.baolin.wang7@gmail.com>
References: <cover.1578453662.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together, which can simpify the code.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/hwspinlock/sirf_hwspinlock.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hwspinlock/sirf_hwspinlock.c b/drivers/hwspinlock/sirf_hwspinlock.c
index 1f625cd..8cb5fd4 100644
--- a/drivers/hwspinlock/sirf_hwspinlock.c
+++ b/drivers/hwspinlock/sirf_hwspinlock.c
@@ -69,9 +69,9 @@ static int sirf_hwspinlock_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* retrieve io base */
-	hwspin->io_base = of_iomap(pdev->dev.of_node, 0);
-	if (!hwspin->io_base)
-		return -ENOMEM;
+	hwspin->io_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(hwspin->io_base))
+		return PTR_ERR(hwspin->io_base);
 
 	for (idx = 0; idx < HW_SPINLOCK_NUMBER; idx++) {
 		hwlock = &hwspin->bank.lock[idx];
@@ -92,7 +92,6 @@ static int sirf_hwspinlock_probe(struct platform_device *pdev)
 
 reg_failed:
 	pm_runtime_disable(&pdev->dev);
-	iounmap(hwspin->io_base);
 
 	return ret;
 }
@@ -110,8 +109,6 @@ static int sirf_hwspinlock_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 
-	iounmap(hwspin->io_base);
-
 	return 0;
 }
 
-- 
1.7.9.5

