Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF22C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC562183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fy/9XkPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfDXWtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:49:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45770 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfDXWtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:49:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id y6so18403277ljd.12;
        Wed, 24 Apr 2019 15:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wxo1mTlnG7HCW7qNviKHVt088dVN4BbKUg558KqhhM4=;
        b=Fy/9XkPOMq1yqeTye0ts8QJTTc2IFDE/YJ1Rg+/jFlVbcgceN41W/isH/sjy/1PB1A
         WicGhSqqlITCmWe36fgAXDBywxTmS7Nc0zmljrqTVzT/267gFjqtcLKBPudiNEDrcD0u
         rkPMQRm2hoEfy/vDDpoBHJLjOvwf6anBEonryBtpFvI1wA3b+2yBu6EOpn4xbAzRsXW4
         MXDGjhl90XHrVyCdzU7m+y2ttk/2ui67MhYh79fM6Tn9LHCyBo76myVJ8U2fHZm6r8pH
         LFWgDJixhY8fmIzBjlCho3LMvO4dKK+2VNafetI+96fi8fI9SkRdoCq50MXser0ZO+sz
         ANzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wxo1mTlnG7HCW7qNviKHVt088dVN4BbKUg558KqhhM4=;
        b=ZpjEiVx3dgvKTApUopzbS9XRNy2lm3gGD7KGwEINHa9MAt1R3S+zysHNFq9fO9XO9Z
         OGhMUX2SzZHKnvjG5fXGc4KoqazQhwg1S+kdtf9fdbP23X6VooYAPeKY01nrTDR9+Ucy
         NeaoqG10S2jSLr/3qXyteBjdQiN106hOLhTTWt4X4eob9yX64XL4QkBekc4em2YcjTbN
         fJHctcPj71/5lszE9VDN64K/YJNEL/Gdq+Th84MV9RBcCdiIFcxS4St73DSkF+418MDu
         gyUR0i2p4+rv7i0dnkV2Ts3X7tFpi1+bUFV27HUCO9kicynCXeU8sI+g9l4zX/8fWTXs
         2chQ==
X-Gm-Message-State: APjAAAXpGA5n95tHx5DR9mXHmEb3gHTQmIjoLsrpYUHxP5ns/ofInxSc
        oBhJXiLLpIKDJULoaWqFUtA=
X-Google-Smtp-Source: APXvYqyc0oAXxM/t5T6zmR5tBU4aWWH/SC6UG9R329mdCUCGmb8ScxNa0T3KexfXETAdcZJMTtPLCg==
X-Received: by 2002:a2e:82d0:: with SMTP id n16mr497430ljh.180.1556146181129;
        Wed, 24 Apr 2019 15:49:41 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id s24sm4219879ljs.30.2019.04.24.15.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 15:49:40 -0700 (PDT)
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
Subject: [PATCH v3 1/6] mfd: max77620: Fix swapped FPS_PERIOD_MAX_US values
Date:   Thu, 25 Apr 2019 01:48:55 +0300
Message-Id: <20190424224900.8018-2-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424224900.8018-1-digetx@gmail.com>
References: <20190424224900.8018-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FPS_PERIOD_MAX_US definitions are swapped for MAX20024 and MAX77620,
fix it.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/mfd/max77620.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/max77620.h b/include/linux/mfd/max77620.h
index ad2a9a852aea..b4fd5a7c2aaa 100644
--- a/include/linux/mfd/max77620.h
+++ b/include/linux/mfd/max77620.h
@@ -136,8 +136,8 @@
 #define MAX77620_FPS_PERIOD_MIN_US		40
 #define MAX20024_FPS_PERIOD_MIN_US		20
 
-#define MAX77620_FPS_PERIOD_MAX_US		2560
-#define MAX20024_FPS_PERIOD_MAX_US		5120
+#define MAX20024_FPS_PERIOD_MAX_US		2560
+#define MAX77620_FPS_PERIOD_MAX_US		5120
 
 #define MAX77620_REG_FPS_GPIO1			0x54
 #define MAX77620_REG_FPS_GPIO2			0x55
-- 
2.21.0

