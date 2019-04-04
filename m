Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FADC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C3820882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="orUATwCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfDDPFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:05:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37986 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbfDDPFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:05:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so3817031wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 08:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Af+jmp4TxV/QvWrI8cMBNBX8b92F7d39H2RU/VUPuWE=;
        b=orUATwChTASPdHYfwTB7I0LB+HwbbvmzOPE5mGVbekd7ZK180nKS4YYUFiGPYz9aJw
         14gf3J+dsx/J7iZagdSXdiSovF2dbuQme+GdTMM2BEI1DtSlUBrx4C0lSCCgVMEBCQ6m
         LHxMhcGkd2YDYLoxi129toCuz7GHtMpx/OWsVIhO1ZaRtlmgYH9P4J7E1N5pu7hnP/8R
         pa1Ogo6zQF+fwDIzFTulg1H5J/PKlW/LJIwb/Ojm+c4fwJ0KSh3uW6tMkAAAttCwNFLE
         5Z1Lku13gC6r6RO/Xi9gbetV9vIH54P5AQzvBbuNFmbXf89CCNF57sIb6Zxyk+hu/9F4
         IVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Af+jmp4TxV/QvWrI8cMBNBX8b92F7d39H2RU/VUPuWE=;
        b=bFkvzEhrXXsE5KryYqAZ5KLRTLUsg3HXBva5ve3IzoLE9XEm0CVh4yvrw9Rw9Q0/kP
         EfIxfGVPzHdC9ST3glO4/p/cvzoYSG3ULPJd5omZ9I6mOO+RBD/X/y99Lujdm397VAwV
         WU5l53skseBsAzRAT8l/NWaH9n1fttkWskmGky4qPa0yMC1/q9fmQSuuAoiHMiU7x3jL
         b76C0I5mb0snWoQ6r9B70caY2Id8n8j+Wt8dDe2+Mv55f2NyPC1qOgFV09bp6T4ImhzU
         ECczA9K/tG85w6Ccl48+QrOS68nptl5z5Ul6KTm1WcCnghSYURGxalZwdugo8mtrmDaZ
         aPlQ==
X-Gm-Message-State: APjAAAW0UmkW8iqaZb1ZnqmXPm2Fc0A9VyYQ8OeIXJUKeiZR6oszQ+Fv
        d/SbJ9eI5+3zB8N8vvrYQvdE3Q==
X-Google-Smtp-Source: APXvYqwxXqanvZ8gCr13G4rHzWLM8JaM55lN2GWp22sMBFDs785fPY1/LNLPsCXZiNAJGmLqRtwysQ==
X-Received: by 2002:a1c:41d6:: with SMTP id o205mr4764633wma.2.1554390352542;
        Thu, 04 Apr 2019 08:05:52 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id z23sm9880981wma.0.2019.04.04.08.05.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Apr 2019 08:05:50 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org,
        jbrunet@baylibre.com
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 5/6] dt-bindings: arm: amlogic: add Odroid-N2 binding
Date:   Thu,  4 Apr 2019 17:05:17 +0200
Message-Id: <20190404150518.30337-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404150518.30337-1-narmstrong@baylibre.com>
References: <20190404150518.30337-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for the Amlogic G12B (S922X) SoC based Odroid-N2 SBC
from HardKernel.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 94bbcc646e10..eff41128268e 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -116,6 +116,8 @@ Board compatible values (alphabetically, grouped by SoC):
   - "amediatech,x96-max" (Meson g12a s905x2)
   - "seirobotics,sei510" (Meson g12a s905x2)
 
+  - "hardkernel,odroid-n2" (Meson g12b s922x)
+
 Amlogic Meson Firmware registers Interface
 ------------------------------------------
 
-- 
2.21.0

