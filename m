Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7ED5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 22:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D242087F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 22:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOcwJLtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfCQW4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 18:56:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41262 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfCQW4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 18:56:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id d25so9919178pfn.8;
        Sun, 17 Mar 2019 15:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JuH8Ap/N0CCqMGuBFEsBfvavZHslxZuq0RCbP2Dsuc4=;
        b=iOcwJLtJQnDLJiglzaTS+waJniGYwLA83xMREpG+k375gPYY4JP1CpdKaH0WW48J9D
         HwazE2Mt8U3/qVi2y6EMOSTYjfggq1G/pwXKubuc5/evx3RFBc6/FSKIYqTXRR1csoJc
         c62xnwSrCuuwwKZYRr96bKCym0IaUAXUfpf7dK9reOecNqCs2d+WeL2qB7YWMXXEih9j
         vwL+awOaTcP1q6tXXCB6B9tIhD0qCkGXJDvJEgkZJ/SZX2EAb1iTr4GWQLV+EHeRom5z
         dyuEXEoYtN+bYpsd6aQr1Z5H03UxwSrbh+W0ZONh85lBu2BGibrue6qMqiscTT1CwHOP
         gFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JuH8Ap/N0CCqMGuBFEsBfvavZHslxZuq0RCbP2Dsuc4=;
        b=h3HmNQ1696I0WHTPCdzx5pTZ069E7A/pSsSFevDdOEVna5mAtuGmTmQevYi/VmUn+4
         lsTnKsiUCYCmTAaCDCnEGA2iDuXui6aGn5rZd0HVvwTrQTsyMA+vVzyy+fXVCYhzkl7n
         iUG7xJSKKhTjTugLIK75AzBLFBZCJaDuuaBpokyWTEXDDzPFajaMlNXl4M/u/zwBlBWb
         3+Y736JYOOOt4sm2zDFzFdziR/KM5LdFCTpN0R3sFN7XhrmypjF821t8HKK96j/beQ5Q
         gI5BDXuwlCAXFXCTkRURVsapwsWITXK2U7midcerh2WAJbxGoglj0CkriwtnygbFAcTl
         BRMw==
X-Gm-Message-State: APjAAAUi5VjRVnAcT3cHRJAUXwD1FSQ9I+A/+pDlHBD1x+tkh3dTpOjz
        Wk+NrmpOz9dR4eJWZkkdgrU=
X-Google-Smtp-Source: APXvYqyZ9bjwZ3mO6XQE939//EtDOS9s43r7bv6jyV1ZA4rVpiUwoovnt0DAlggb/V2H5hxYhqU+8g==
X-Received: by 2002:aa7:8b12:: with SMTP id f18mr16501979pfd.240.1552863367692;
        Sun, 17 Mar 2019 15:56:07 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-37-86.pppoe.spdop.ru. [94.29.37.86])
        by smtp.gmail.com with ESMTPSA id v2sm13738838pfg.118.2019.03.17.15.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 15:56:07 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 6/7] ARM: tegra: Always boot CPU in ARM-mode
Date:   Mon, 18 Mar 2019 01:52:09 +0300
Message-Id: <20190317225211.23091-7-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190317225211.23091-1-digetx@gmail.com>
References: <20190317225211.23091-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU always jumps into reset handler in ARM-mode from the Trusted
Foundations firmware, hence let's make CPU to always jump into kernel
in ARM-mode regardless of the firmware presence. This is required to
make Thumb-2 kernel working with the Trusted Foundations firmware on
Tegra30.

Tested-by: Robert Yang <decatf@gmail.com>
Tested-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/reset-handler.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 809fbc200cef..31fb53f9ce13 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -113,6 +113,7 @@ ENTRY(__tegra_cpu_reset_handler_start)
  *       must be position-independent.
  */
 
+	.arm
 	.align L1_CACHE_SHIFT
 ENTRY(__tegra_cpu_reset_handler)
 
-- 
2.20.1

