Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89417C48BD8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6191020659
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="a30c8DGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfFZJHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:07:32 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:43147 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfFZJGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:06:47 -0400
Received: by mail-wr1-f50.google.com with SMTP id p13so1753192wru.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 02:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lvCQg8fkf4AhMPMA11E/TDsr9RLDhACmfamGvoLo6Us=;
        b=a30c8DGxnt4ylB0Mmk238bZxwi3a5YpWwbJrwN62x5e6CuIG5Scn8PIKIxfG0tUsXh
         QRBt4rnHgkyg35xASa73uAW4ZkLEIrHnNtyYZBZfK6kmELIExmw5MhOrqlblGFqtPVMF
         Ffhsb1fkN+onB1QqEVt3IahLdsQ/zN/Igcs3BJ3e9+JGoy4p34ba9d6ALTCjV9p+hj2S
         iBzW4pCl4wsYkgs6t8RFiHOj8qWqr9oQ9Z61nrL72fJRuPIppVAELWSFg4YVgcCX6LR7
         CigTgM8RMLv7fOjfr71feX/nmbHCwiS7LLCFdHgfjJJhEHmfGsFb2s9ycRt4xc7hqSZb
         v5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lvCQg8fkf4AhMPMA11E/TDsr9RLDhACmfamGvoLo6Us=;
        b=XOmxJ9O2qXyGvP1Vb4yN/hEn3LSzbGluu/IdRsyd8kqoXCPQKGyh1mlqcih2BTQZ+L
         K7nGt8gIueSDgRP0SgTUXDSNyVuExmekUk4+2jK7qhFT3bJ6iDlNy5Mge88DFmnRcAio
         tjSY4b7BNpLIyMOTvqKFOIwtEhI25zqwSKjsRNlmMm78HfWxOisdjDNJUKMoDghAleDH
         NFS2mMjg5ci1vvKhgrcfg0TAkCE/ApREHmem2hcP0AGD02XbXWegVCZM26O7K5Nwl6T1
         qBP0UD6Sz5Jb4dr+AKiBfclsL7clnGevKyx0YNMaBuSZE47hGmT25plS9ja2FhDO5Zg/
         AnCw==
X-Gm-Message-State: APjAAAVsoObEndKhVlQ074xK87vQx32HQwb4o6z8fAHqqHZQfEhI7xdR
        PSYV3vzAMP+ZGRn8fAV9L6UyLA==
X-Google-Smtp-Source: APXvYqzd+pHsHBIReUyJC87gldN99wQMDEQzxY2CeH7Qw6uiKNnQ0Fla5ojXQIGERhKAPYSQESKZgw==
X-Received: by 2002:adf:fb81:: with SMTP id a1mr2541965wrr.329.1561540005294;
        Wed, 26 Jun 2019 02:06:45 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o6sm1925797wmc.46.2019.06.26.02.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jun 2019 02:06:44 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC/RFT v2 08/14] clk: meson: g12a: expose CPUB clock ID for G12B
Date:   Wed, 26 Jun 2019 11:06:26 +0200
Message-Id: <20190626090632.7540-9-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626090632.7540-1-narmstrong@baylibre.com>
References: <20190626090632.7540-1-narmstrong@baylibre.com>
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

