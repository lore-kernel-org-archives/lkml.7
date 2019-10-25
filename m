Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A0DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9BC21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="O1Zrkhgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504554AbfJYMmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:42:07 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45878 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504551AbfJYMle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:41:34 -0400
Received: by mail-lf1-f65.google.com with SMTP id v8so1610950lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 05:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OvUZNskoObmKKJYsbx/wH8iXu8sDYM+jDByiAdju3Rg=;
        b=O1Zrkhgig/GHdHnwKsmpqtbkvDL3Y1rbK+JGj+Cs0DZWtFaWKeld23eELOlF+fW35i
         ahKQ49AZ8AKtvvJqeiZLjoI7J8pcRbGnauSMHAK4OFjos9Ny65vqjsTi7H7vouL3ATlL
         cOrkitUQVw23vF5rAUldJcjlmIvXqFsHyVYjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OvUZNskoObmKKJYsbx/wH8iXu8sDYM+jDByiAdju3Rg=;
        b=lFBrjqG9k1WuUNF4Te33tC2WLNd/XGj7jNNR+CzVT7lw+Wiwg/ftvE8xucRYEWhgQS
         pyh5FbGfsynjj/QdBGWkJ1FnuP4Tmhmntk00HxSdHcV+s6MikGfWAp5A/Hl02QMl07fj
         lDsXeXfepK6JQ0/LA+TMV2CL7/CQNW5MeNcm+14JIyWEd8mt73sYfszTBOJb1qDhBcaM
         G3cPOH69SaGy/mI1pXHn1yEFOIUqXwb3miqg4ja9CLJt7aH0pN9qz3SYU4+0Q5JROLMd
         UHwzB4coClMOBHg018s+98fqcLjEDMx19CziVCMo1oLnCzECMzRS9vmmVYS+w05L+tkx
         Cd4A==
X-Gm-Message-State: APjAAAVtd+6I9PflWoxy/8Be5EswhjPpScuGpNtVPPDWEel7ppvLvng7
        b0JI+nn6bTOFWGA8H+VWKOZIpg==
X-Google-Smtp-Source: APXvYqzaZam+cJPG9bi7OgeGhos6Wma0vuM3s9YGw4M43Jx9w05f90bLjSb8WkcVyEkm6MHVqZnaoA==
X-Received: by 2002:a05:6512:40e:: with SMTP id u14mr2657599lfk.73.1572007292444;
        Fri, 25 Oct 2019 05:41:32 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 05:41:32 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 23/23] soc: fsl: qe: remove PPC32 dependency from CONFIG_QUICC_ENGINE
Date:   Fri, 25 Oct 2019 14:40:58 +0200
Message-Id: <20191025124058.22580-24-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025124058.22580-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core QE code now also builds for ARM, so replace the FSL_SOC &&
PPC32 dependencies by the more lax requirements OF && HAS_IOMEM.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
index cfa4b2939992..0c5b8b8e46b6 100644
--- a/drivers/soc/fsl/qe/Kconfig
+++ b/drivers/soc/fsl/qe/Kconfig
@@ -5,7 +5,7 @@
 
 config QUICC_ENGINE
 	bool "QUICC Engine (QE) framework support"
-	depends on FSL_SOC && PPC32
+	depends on OF && HAS_IOMEM
 	select GENERIC_ALLOCATOR
 	select CRC32
 	help
-- 
2.23.0

