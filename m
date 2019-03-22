Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6CAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACC821917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="O7JyUlHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfCVNbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:31:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52093 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbfCVNbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:31:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so2182173wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 06:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DJCTKeU3jLYf3XASl//CRihnyc7HBAaFWnezC3bBpFc=;
        b=O7JyUlHVTfzXhDVBzgceJS//GqrcMMJjiGbhASA8Z32TZqQeau1RnLsqOlh78Kqc4O
         aSDf9hzj9GwrSAQg7VboNU9J8o0jBqH9591psheWNwrYI7kjvxx3BbIsTaEIOP5cZhU8
         Mk8deZ7e/d/MzeeSnwGEzDdKfTQ3JDLIoYK8O3amDFNaw9CEwjqG3y62/FOPfEYuPpTM
         gqTPXBvTYwtZ5vd3bleGl3lvkzQAPpwroK2iU8AEQ969yZPVNsvTHAAekzjH0NUI7qgK
         pCATx1hNPcwq+iitGQMFRoh1j1lovJ+efWCrOoOoxd5H22HHL10yGKbVzSdqkNv6gC2p
         29MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DJCTKeU3jLYf3XASl//CRihnyc7HBAaFWnezC3bBpFc=;
        b=OIHP+NDOGByJ9qHgO9MC2oRDz0mjUDnA77flH3jbU1adj2KvXA4F4Myrlg3bkI9RJm
         mW/BEUc8cbB37V0mzUCfhMbLQpF8a3qGWLyPT88zU3A1OMArwUv8HAXvxRtAmLMhWz6n
         5d5oE+ZM3HppESLjX0O+3WnT4tgCo+G6GkFc7aPsgav5HiM89aJoebzsnrf4OTmtq7h3
         kYT5BBk5SLYUer5h/kX43z5jWd6eN5WXkjM3M+cYKCk2enLcc2g1Bb8ZlDTZmbs5VMTK
         4jZPNQ8i/aUbJBhIuHKZcoElxpO/J98V7FBZmf899Ypt2dRJFad7Dl6FGRuNIztWLDPb
         VwaA==
X-Gm-Message-State: APjAAAUd2bREXf+vgFB+Z6n3enemcfDMftLXKT20lDFIiiHFKrn2btKN
        xTAn4pJkHv94BI3uayNgYzDXmA==
X-Google-Smtp-Source: APXvYqxZ25G1Ovx5K+8TLlzx+9ucwjR8c0oCh+u28ns7kSnoeYs4RIvUHrcETMl1d4HTiehN2jDD/Q==
X-Received: by 2002:a05:600c:210e:: with SMTP id u14mr3251607wml.50.1553261475318;
        Fri, 22 Mar 2019 06:31:15 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o15sm4684345wrj.59.2019.03.22.06.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 06:31:14 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 4/4] ARM: davinci_all_defconfig: Enable CPUFREQ_DT
Date:   Fri, 22 Mar 2019 14:31:05 +0100
Message-Id: <20190322133105.5945-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322133105.5945-1-brgl@bgdev.pl>
References: <20190322133105.5945-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lechner <david@lechnology.com>

This sets CONFIG_CPUFREQ_DT=m in davinci_all_defconfig. This is used for
frequency scaling on device tree boards.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/configs/davinci_all_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 207962a656a2..c3502236132e 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -45,6 +45,7 @@ CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_PERFORMANCE=m
 CONFIG_CPU_FREQ_GOV_POWERSAVE=m
 CONFIG_CPU_FREQ_GOV_ONDEMAND=m
+CONFIG_CPUFREQ_DT=m
 CONFIG_CPU_IDLE=y
 CONFIG_NET=y
 CONFIG_PACKET=y
-- 
2.20.1

