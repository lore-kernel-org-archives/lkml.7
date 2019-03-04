Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE404C10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1CA2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="n6SgtuK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfCDNLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:11:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42462 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfCDNLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:11:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id r5so5474299wrg.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 05:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OrFGKmvdQsI+KI1EYx/jy8kl6OFXOGcUtXpV5mGC+WU=;
        b=n6SgtuK6ZI1hPdYec7KSCcwF64+UTbuk67mL76ndzhPFFOwA1HgcE/czpDVWQnfUGM
         4SRroladBEgxFu6oUeBH1KbXZ3lVCDv8aa12uXOI0HXLonPQm7GYsCZ64UzMw54opGy5
         5e2xORvztAEBV4C/0/aH4voosfcdGDimouyqD0ejRZz9jG6lmrzNBCHvYFt18QfByQIQ
         BSgRjOy9aCA4VEkPGDR7gNlPsmIa3JwQc+1Khs6bpIANMIV73DIDwfzPJafnOuo21WgI
         VKXNNS7WxI066bSnLEhysM4+7UdtkgTYPOvi2aovWk8yMYvPMSm8N2EPLYt/ETGEJyRX
         2Cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OrFGKmvdQsI+KI1EYx/jy8kl6OFXOGcUtXpV5mGC+WU=;
        b=cdPYe9ZsXAQgxZHm1sU03qj/8hrjIi3W9nxAiUfSovF4LGjR0i5X5gqxI54N7w33xo
         zIWy3wmn8B8RRCyUxpGYRlbYjCHa+ulc/aLs25R2xTNwYMXFHC8PqXjUqypICl7cR0Z0
         NW8RgkPnucG7HL8AWdtlgCG6un5y6++gLl1d/Z7Ba/8wpWKzz/XrWbDXznPOzTy/1PQk
         TE28hEosNUZYYy1B5bxMu10jeMz8ymnAHGwCfD8XzHeSzinGALAHkmzA+TprnCyvz9EL
         sO/rTHcgj5ngPFZKj3BVKGE+u+0BhtW404SLio2kbrQD2wYyZ16/BV8YMGEuUnOK2clQ
         BpIQ==
X-Gm-Message-State: APjAAAU62SazLfr/9lgrOTfz8w5bclTTrzjDAp7nRnq8j0/CVnM2AyMW
        R7x1Hw6/+oIxKBQoXtJqb+IQBA==
X-Google-Smtp-Source: APXvYqzvwVbi3zUS5C3lBD7Oxc/Sz1v2Z2fFgofmsF8Yxuxr7RU7gijJf0Q/lsiC4P+jiVF9YsHDjQ==
X-Received: by 2002:adf:efc8:: with SMTP id i8mr13378495wrp.164.1551705093614;
        Mon, 04 Mar 2019 05:11:33 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a8sm11695624wmh.26.2019.03.04.05.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 05:11:32 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] clk: meson-g12a: add cpu clock bindings
Date:   Mon,  4 Mar 2019 14:11:28 +0100
Message-Id: <20190304131129.7762-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190304131129.7762-1-narmstrong@baylibre.com>
References: <20190304131129.7762-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Amlogic G12A Family CPU clocks bindings, only export CPU_CLK since
it should be the only ID used.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/dt-bindings/clock/g12a-clkc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
index 83b657038d1e..d7bf0830c87d 100644
--- a/include/dt-bindings/clock/g12a-clkc.h
+++ b/include/dt-bindings/clock/g12a-clkc.h
@@ -131,5 +131,6 @@
 #define CLKID_MALI_1				174
 #define CLKID_MALI				175
 #define CLKID_MPLL_5OM				177
+#define CLKID_CPU_CLK				187
 
 #endif /* __G12A_CLKC_H */
-- 
2.20.1

