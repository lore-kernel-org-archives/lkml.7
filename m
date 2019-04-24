Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FB0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E718C214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HggUdC6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfDXWtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:49:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39287 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfDXWts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:49:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id l7so18438910ljg.6;
        Wed, 24 Apr 2019 15:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/z49LJ/T8Zar3+evR8ZrGril6xWv/cqi+vT7q6ZMxfU=;
        b=HggUdC6Gbjq4ECMzMoy3BX5+Iy/ZZIy6giPk1gq3wBex2+Kz0caH9i48kh+WgmCqv2
         glsWZbv3RAnbRcLb7Vumsc14N4RRwV/ykX3FW3Q3vKF5eNENVxYLCDAtebgodlUCVM5t
         DK2XcInts4WxB3cA5q3DfThN9HglqgzC9MHYRieEs/uERXWv6sIfxiMb7FGS7wD81MkJ
         MNs6ueYiTdsHvAkiRhHlHuqV9Ah3zTo00XKJJlHOdlFjT26tRwbqu5ajD1tzZ9BXH21v
         jQa1ZpGMvyqmow7C1nrwXcX0gHHvDgY4MJPQ2SHA4eMPTq8jHTz6gccz4oEMLB1Owcsg
         ehIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/z49LJ/T8Zar3+evR8ZrGril6xWv/cqi+vT7q6ZMxfU=;
        b=bazg45zgDwZoVhLFljfNcMlTNW4zpedCLGVRBNSj+eOKglUsL+1xeCiCV+HOlTGXTH
         DwHQkNQpswle/TbOHVrSm1M27vsgB27JR3qs/EmbvSAMWUqEoSZfeZPwbWJhz2OTAaW1
         vq+fGc88GDZQ7OqHMQH47WUSRl7pvWFMZxTiynsEEyVfbNZRTWu9LWKJ2y87cha4ujpV
         kHoI7Sq8TcSgQv9T4DTzBih0yLbfLIuQvyv8eCkHFsdpq9sT1wyYtbJKRU/LFUb7pnb0
         e340C1LX5Vvo6/W3Ux0ykpOlbOX1N10KI9CE0p1X+lBLzMgtVlxAV8M74gNzASFwU5cJ
         bN3w==
X-Gm-Message-State: APjAAAXOXYhXz+DxNCFnFGUf+oWHBNgJzDGtQbB5cBCXGLdmDAq/MHva
        D++DKXxFC7mHfsPDhQ8Y3l/YrMjB
X-Google-Smtp-Source: APXvYqzKWCPnAOKrrD03MAvrhsS86Tddtc9nkp1yY0cjghThE1hvFZMlcawjyexCM7hvvUeCQQ+FtQ==
X-Received: by 2002:a2e:9a02:: with SMTP id o2mr18714473lji.179.1556146185906;
        Wed, 24 Apr 2019 15:49:45 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id s24sm4219879ljs.30.2019.04.24.15.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 15:49:45 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] dt-bindings: mfd: max77620: Add maxim,system-power-controller property
Date:   Thu, 25 Apr 2019 01:48:59 +0300
Message-Id: <20190424224900.8018-6-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424224900.8018-1-digetx@gmail.com>
References: <20190424224900.8018-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new property that designates the PMIC as the system's power
controller.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/mfd/max77620.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documentation/devicetree/bindings/mfd/max77620.txt
index 9058499051e0..dda6d158b170 100644
--- a/Documentation/devicetree/bindings/mfd/max77620.txt
+++ b/Documentation/devicetree/bindings/mfd/max77620.txt
@@ -18,6 +18,9 @@ Optional properties:
 			IRQ numbers for different interrupt source of MAX77620
 			are defined at dt-bindings/mfd/max77620.h.
 
+- maxim,system-power-controller: Indicates that this PMIC is controlling the
+				 system power.
+
 Optional subnodes and their properties:
 =======================================
 
-- 
2.21.0

