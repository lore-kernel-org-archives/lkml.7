Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7762DC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C5020896
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEakgE0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfDVTTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:19:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43377 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbfDVTS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:18:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id f18so11216801lja.10;
        Mon, 22 Apr 2019 12:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/z49LJ/T8Zar3+evR8ZrGril6xWv/cqi+vT7q6ZMxfU=;
        b=UEakgE0Iby15sztNXCqfq4zDTDMJafLDuEXXT75N9Jzi2sNu859WYnxswFYx3f7gM1
         FG6E7Vgih7/YgMeSaFOJyVDI5CjkrxPitdWJ5FxuLe2LkNP+cH4lcyT/KKVPNqdxRS5B
         pa/5mD/eTA8SW1KRtsc3VvnIk46HwPS5Kw5ZzznHIx/ZLBcG0HZ6VPOzfw2UfqbpY41R
         YVAxjfnqstBJ/7Mpjf13YVVzOZ6ujE72MLHruegjcR2OoDXnHGqQO8tT2h/o5iHlKJr+
         nl29Qf68QbKIImDGZurnCebbaJaLAUXWpoiLcdV1SSeqD+8sAUyqwKRhxcJh3Lop8mpf
         Q5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/z49LJ/T8Zar3+evR8ZrGril6xWv/cqi+vT7q6ZMxfU=;
        b=Zo0q3GHM599f+Co1f0yqFCZyE1G+rer+cs5n00gc27RwHaxVM0360UBcmInCPPjB7I
         RaCUqUIaXZd77gcxnwci1dCSg5zbEc7yObFVndkfaxtwegiwQHH0yo83NNP8FLpaoykQ
         7UyyDPLhmlFXwXqQiGqoCHzHSBgjYhf05iqH24HosVlM3VstZ5S95RCif4WgjSiLkyV4
         6uaAIt7D2/I++/5eKyOJIjzq2ivRyiQR5VsPP0I/BVjFQX62xIqYhNAmldx0NUGEH18/
         Xt9/3l/A2gmON4jXHn0RlGG0hyoRcpqWV1paGpGbWoh90nIU8BQr059QjoNYZS2KlFP/
         Z2wQ==
X-Gm-Message-State: APjAAAUjhXI4j+pYsdBSqugICwT2vkjrAoa8AuAQ9ELvqtGymwSoe6l9
        +8TrEc4PM2A9A+kf1vgT8a4HU7wn
X-Google-Smtp-Source: APXvYqyszXDkh8LRMkXyLYNC1wmJ5wxpG4c6NwbqJj6sDSnQCHN7KSRsG85hSl/1hYoNbTk7Tfzhpw==
X-Received: by 2002:a2e:87cd:: with SMTP id v13mr10901502ljj.98.1555960735834;
        Mon, 22 Apr 2019 12:18:55 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l13sm2848762lji.39.2019.04.22.12.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 12:18:55 -0700 (PDT)
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
Subject: [PATCH v2 5/7] dt-bindings: mfd: max77620: Add maxim,system-power-controller property
Date:   Mon, 22 Apr 2019 22:13:48 +0300
Message-Id: <20190422191350.27527-6-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190422191350.27527-1-digetx@gmail.com>
References: <20190422191350.27527-1-digetx@gmail.com>
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

