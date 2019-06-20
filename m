Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6281DC48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39AE720673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZkNBuemC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbfFTPBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:01:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36031 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732023AbfFTPAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:00:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so2178155wrs.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 08:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lvCQg8fkf4AhMPMA11E/TDsr9RLDhACmfamGvoLo6Us=;
        b=ZkNBuemC27/s9vbgndDsGwjRRSiLq96YdfPINqqKzDjQn90Qcm8t0Lj58ZfQBZYKGg
         8bcR/XvPsILe892VTo0OmoSCiekCJCX3TlbRmHEHJ3vzE9+sGXw+vnKAhBs45P2SI07v
         e3Oxz+tucuq69krMLV2LUbPRErpWXYbw1Js/nnOYU/94RZS05BAgy3h/bPO6/zfrOwZ4
         F7pNiAUgM8QtuJCVp8ilAjUhGe61FLORLA8seVVdFd2cslK6440TD2MBCqoSVTL6xu0X
         wVzWvyWRK4E0sVAODLvJRbX8E+NbHm9dcASo78JP08wjbXVEPa1TxBSF3Hg3xqEq4xUN
         RHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lvCQg8fkf4AhMPMA11E/TDsr9RLDhACmfamGvoLo6Us=;
        b=ENZkn/LQXMe3tBvurwLhaITKga5hqhXBWOIJ+e/bWZHs7vjOLqoNtSoTBB+rlv7OX5
         Cnk2swt+OsFHTIl3Hs86TVp8B1D8FzgRZRqhdhb7MEjyjW7f2AyFXpsFZE614PtEQj62
         95wgJxxMjkmZYDDVp5vzJRkxTNPek31u1tm1cm2AgDAOyIp4blaEF3kAf4e4Pj5ytnmQ
         5qUNqjYK+NuC1Ccx5Pcax6A49oYDfNmKxl84FuTym5cMAuAsuQKKPEB3heiF7DiJB2M0
         R73SUm2vO3bvp5Di1WBllXCXEBkVezDGhyjjuVxicaAKp0RYXWv9RTwTbSIHg4Xc1FaH
         Jbgg==
X-Gm-Message-State: APjAAAVZTTsFakFY6q5MHRe0cHsA3GEGMDnClEwTdD111lYKUFSyizmH
        j/uCyoqUysC+HbqnAjBWcyHubg==
X-Google-Smtp-Source: APXvYqzLYovsxFjf46DbcbhAjqfq5ncPgOBrMCKwL4HgOuGrU6Zszy7/dmR3PIOLGHWu/FGiIBljIQ==
X-Received: by 2002:adf:df10:: with SMTP id y16mr4435320wrl.302.1561042829338;
        Thu, 20 Jun 2019 08:00:29 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o126sm6802520wmo.1.2019.06.20.08.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 08:00:28 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC/RFT 08/14] clk: meson: g12a: expose CPUB clock ID for G12B
Date:   Thu, 20 Jun 2019 17:00:07 +0200
Message-Id: <20190620150013.13462-9-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190620150013.13462-1-narmstrong@baylibre.com>
References: <20190620150013.13462-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the CPUB clock id to add DVFS to the second CPU cluster of
the Amlogic G12B SoC.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/dt-bindings/clock/g12a-clkc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
index b6b127e45634..8ccc29ac7a72 100644
--- a/include/dt-bindings/clock/g12a-clkc.h
+++ b/include/dt-bindings/clock/g12a-clkc.h
@@ -137,5 +137,6 @@
 #define CLKID_VDEC_HEVC				207
 #define CLKID_VDEC_HEVCF			210
 #define CLKID_TS				212
+#define CLKID_CPUB_CLK				224
 
 #endif /* __G12A_CLKC_H */
-- 
2.21.0

