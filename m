Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC3EC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A409420718
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574421422;
	bh=pkcEKusfz9+5qS3xEeIaSulh+3jZtNJAPw1hijWklJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zcDmWLut5SBmMIY46FrYbIKWVN/kYoTK7mZd6N9wlToRdVEBRIvHak/UQ+dN2HIY6
	 h5IKn+qdq5RjsyAdghULWFpJNBpMjxIR4+JCOiUDIw3oSjypTtwEs/RmH0vvhxEXwq
	 CoTlUVUF7qD9SwWIjTCh4CrJYXiq9Djxg+Aa1lIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbfKVLRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:17:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:58972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730021AbfKVKtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:49:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D35CC20715;
        Fri, 22 Nov 2019 10:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419771;
        bh=pkcEKusfz9+5qS3xEeIaSulh+3jZtNJAPw1hijWklJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pDjhsMlZimocLUqX08gaSC6TZeHYmbgjCow98mfCOEz1teU7lOfkNcL2ZEjxMLn9X
         LnybtSlI5l9kiMVGvxdtbCJUsdEi+Y+/Ps/o14acyONVQ7WBcFd/KnGkppzzNgqVPr
         U4X2KWXmRGS2N9obQvfvTaCZcZyXqx2hRe9BJZDs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 216/222] hwmon: (pwm-fan) Silence error on probe deferral
Date:   Fri, 22 Nov 2019 11:29:16 +0100
Message-Id: <20191122100918.107448103@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit 9f67f7583e77fe5dc57aab3a6159c2642544eaad ]

Probe deferrals aren't actual errors, so silence the error message in
case the PWM cannot yet be acquired.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pwm-fan.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index fb03449de2e07..aa6333620c37d 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -231,8 +231,12 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 	ctx->pwm = devm_of_pwm_get(&pdev->dev, pdev->dev.of_node, NULL);
 	if (IS_ERR(ctx->pwm)) {
-		dev_err(&pdev->dev, "Could not get PWM\n");
-		return PTR_ERR(ctx->pwm);
+		ret = PTR_ERR(ctx->pwm);
+
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Could not get PWM: %d\n", ret);
+
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, ctx);
-- 
2.20.1



