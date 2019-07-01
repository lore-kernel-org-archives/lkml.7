Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2DFC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4912145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nVj4kZjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfGAJOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 05:14:00 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:37023 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728408AbfGAJNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:13:21 -0400
Received: by mail-wr1-f41.google.com with SMTP id v14so12911203wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 02:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lvCQg8fkf4AhMPMA11E/TDsr9RLDhACmfamGvoLo6Us=;
        b=nVj4kZjPsghODf8pIYMBdQTJlSwuNFTN6LsNESZwAy+s3XPZgxLAc9G5YNpLsK8F8l
         MFC2qNPQCvPYWeIssqBDmsmeTnJ+sQE4t8OQK1OkFv58nn4CaTGmOt4Om5+AEw5oxrAg
         viqJz3Gz9bdBpEJRK5faApunYLOKpkyBcsb/S7OY2py+WNG6ThDKp4krYMduM1gficTU
         ZZin5WAl30gP7LP/+mmIC1mipA120aXCYbxX4o/bZX2fc+zVCW+OQ0x99IA8Im2x2e8D
         MsfXe37/sDUycbobHLlc9L4ugM+YZypY+3CH9exoSzbbLH/bi0ShBQpgh8cG5ZzpysSX
         iDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lvCQg8fkf4AhMPMA11E/TDsr9RLDhACmfamGvoLo6Us=;
        b=dJI8uTyFZSEzRQ+FRuIGkt4Mb3lcdaRgrYGqiViqDiSVFMsTtrG6duLeQtOjm5l2t6
         0MLsPFAl27tVHal3r88hDSsxEyTafgkGv89MKST2Vwf9Yzd8W3546/IaGHPjMVvdPsw+
         NgtSpS8PboIzgFhFoewsuHb1teO9szXD/HyYex57yBOIObfRP+TLhEF81iBCvh7OpiXT
         t01AVdlC+dtZniUi4ZzwpHFSbp/dMUuD9tMyxF6uGB4UfUOUOc1J6o5sUebeokWwlD7V
         xAxh8pmUq8czYt2s6L9VjRfGwcE6eC/EYgBYjfhjFnE2+linHzL8ukf0xRsMcX3ZSokb
         TRIg==
X-Gm-Message-State: APjAAAVv1bFde4P8MY/+Wejt1kl5UUOZ7yyooOjLJz0yGopeD84mHJ4O
        U6lhNfmqVSEvRkxaDsb88Tyoqw==
X-Google-Smtp-Source: APXvYqzv3VoNE0QJ3qVFoa2fNSEmM/eDXNEDXdsWqAqO9ZhU482BSwxibAPMdy0qG7HfgH7P4bBC7A==
X-Received: by 2002:adf:c541:: with SMTP id s1mr17881931wrf.44.1561972399431;
        Mon, 01 Jul 2019 02:13:19 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id i16sm6305659wrm.37.2019.07.01.02.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 02:13:18 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC/RFT v3 08/14] clk: meson: g12a: expose CPUB clock ID for G12B
Date:   Mon,  1 Jul 2019 11:12:52 +0200
Message-Id: <20190701091258.3870-9-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190701091258.3870-1-narmstrong@baylibre.com>
References: <20190701091258.3870-1-narmstrong@baylibre.com>
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

