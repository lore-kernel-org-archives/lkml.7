Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B8EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AF52177E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="lO/InjvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfC1MCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:02:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39408 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfC1MCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:02:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id i17so11252615pfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 05:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=5gNYYA09oyHB/2ANf77nCikAFBWILRyo7E8wbgyK/Tw=;
        b=lO/InjvZDWVAwhHz/rr53388vx82TUPQqDgQR1q8qzHq+ickPVLlDyg5MDK0pyAkFe
         Oj38tJBQApP/KkZO8uLRYWoonbt0vR1t6i5ZlV5QxcZK6f8f1pIJw+U11jYoGp2QnWsd
         mPeZc5Ran+nHTbqmTfng9jtUQsbAHDpfySADq1nm0o/ZdY0f2c+h2hb28LFxvshLLdd4
         a4Urp9biJNrjNQ57bSw/AsKmC+BbBXxS2hSro3VbBHPM+dq2VoFpnpbKDSCd8QSmCmKQ
         4ip7pYwMVfVVF9VtjcOO9wMeSBQuowMKV3zZSZX7rnWBTPMtEWGVsHtgDgRR6BYh58Aw
         /6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5gNYYA09oyHB/2ANf77nCikAFBWILRyo7E8wbgyK/Tw=;
        b=EFUYCVuWpSEKq7mcDGjPOgSe3qpZakCJtss6IGyrpWZvUCMXBXOyfQBTOaPUTnT6l4
         rQ9UFIq7+oGRax+aZAYvqBRmsWGmE3RKO8LfXsPH1qkrlDRP65Y3xEwpY/SC3Q36bVJA
         ZiRFJT0eLs5G/68LaXNcYzRfSPLHR6tzF0y0JdhxDo3xMWhcZgSTdSZZmO2qAfG0HUoX
         rHa+G2y8AFv2AKs/xKYfbY60vM1W0I+4y68mGv4ByGSxLPW8zYZjPvHKFz7zIo46d37L
         6S4g1/qC+rYD7hUW4jj/vF5IWcmgUlu5qJFP0iYX6HwdkaAG2nI7pna8EIwt+1HHPD+e
         ia/A==
X-Gm-Message-State: APjAAAU8SvpXQWvCoYdk8FwD0R3O5vkSakhaxBwSdz9qAlmmOP6YwQHT
        fzWtRsDHrT8s/xenzLtmL3rNPw==
X-Google-Smtp-Source: APXvYqwDWtFc1QyECeDfrISHK0BP7FGlphcp8XTjUb3WFSnlsQieNzgM+GCErRcz+jt0LCMxqc2d2w==
X-Received: by 2002:a62:292:: with SMTP id 140mr7856454pfc.206.1553774556002;
        Thu, 28 Mar 2019 05:02:36 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id l63sm36859856pfc.89.2019.03.28.05.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 05:02:34 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Anuj Aggarwal <anuj.aggarwal@ti.com>,
        Todd Fischer <todd.fischer@ridgerun.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/3] regulator: tps6507x: Constify tps6507x_pmic_ops
Date:   Thu, 28 Mar 2019 20:02:23 +0800
Message-Id: <20190328120225.32556-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tps6507x_pmic_ops never need to be modified, make it const so compiler
can put it to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/tps6507x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/tps6507x-regulator.c b/drivers/regulator/tps6507x-regulator.c
index c179a3a221af..2b3064faaaf3 100644
--- a/drivers/regulator/tps6507x-regulator.c
+++ b/drivers/regulator/tps6507x-regulator.c
@@ -349,7 +349,7 @@ static int tps6507x_pmic_set_voltage_sel(struct regulator_dev *dev,
 	return tps6507x_pmic_reg_write(tps, reg, data);
 }
 
-static struct regulator_ops tps6507x_pmic_ops = {
+static const struct regulator_ops tps6507x_pmic_ops = {
 	.is_enabled = tps6507x_pmic_is_enabled,
 	.enable = tps6507x_pmic_enable,
 	.disable = tps6507x_pmic_disable,
-- 
2.17.1

