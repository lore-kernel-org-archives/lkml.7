Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698DBC282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38219206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IV91+R20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfDWJPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:15:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53934 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfDWJPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:15:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id q16so17706928wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kkUDwieGRa4xy6E/VKbLAgsfuBu2dxapI4Hsa3FktCU=;
        b=IV91+R20zWjSQlEuZrO3g8etfRHutsoozXzEdbqjIHZ3+Z6rWF9oPnf+U/q658HO5T
         sytBmgxsHjDanQiUrguBtqmlPygjyMM0BMModhWyUm6r/i+NMJQ1+4LsiV3LbQvW89DZ
         ruBl31h018yvKj+1F29cdpnhv5htWJ4t8GcIHjjsFC2NyOAbuR+59cv33o8U+nGsqwyq
         v7+N8EjghiwRWp9AY2yoeeQ67Dnc7HFudUGOqG6RBur6Opug0WfsNr6Tuq5g4lmU8nzl
         +3zI6CRUJgIc1WOX8JWr+SNyetTj34UB9d/4WX9YQ8IxW1vLSCBEVnCDA9EZzm1mesxt
         x47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kkUDwieGRa4xy6E/VKbLAgsfuBu2dxapI4Hsa3FktCU=;
        b=lWA06NBy9CkNCCufNi2iZ94JMLx3UTSSR96R/EfpXldH8WoVWLm/EZCuwgew0TYJCU
         tvFxdqLgLgWvb5BLtOr/EuSspVFIaB7CK+phxW849tjgXov6sHD//w4rCPhYYaaSk92b
         AZlnOhg573xXls784XCHmrkPyUU7rcH8iYejx2aZZGOkDVcJsB+WdEOdn27kDh6mA6mt
         Qj1XAVjUz7rEj2gg3Zj0GAjNKlXv0Tw0gMaxAGj+4bLJ+jFN/UvZCMBEWXiI0BvWDfK8
         COJRwI9mUYmGOAlErP4WRhnPEgEnvHQEq22CkDCj7Z4hMya57SRdVSiw46JU3IJdsy0W
         gcEQ==
X-Gm-Message-State: APjAAAW1a9JtjWqlPSsyLQNsXs3kp3pTCiAnLTEmvQEnH5x46JeQhSqX
        XvzDPe2MxtjTMK3o7dxLGjze8w==
X-Google-Smtp-Source: APXvYqw8xuKFpjTT8ePJ8vDEetCs3KVYsTTUTKEC8mDHO5jbufn4z3i3Slzi7myQ1Cb7mfg8m4oD3Q==
X-Received: by 2002:a1c:9c03:: with SMTP id f3mr1524336wme.67.1556010911649;
        Tue, 23 Apr 2019 02:15:11 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t17sm12241272wrr.26.2019.04.23.02.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 02:15:11 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 3/6] clk: meson: g12a: mark fclk_div3 as critical
Date:   Tue, 23 Apr 2019 11:15:00 +0200
Message-Id: <20190423091503.10847-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423091503.10847-1-narmstrong@baylibre.com>
References: <20190423091503.10847-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Amlogic Meson G12b platform, the fclk_div3 seems to be necessary for
the system to operate correctly.

Disabling it cause the entire system to freeze, including peripherals.

This patch patch marks this clock as critical, fixing boot on G12b platforms.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/g12a.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 4bc16868b471..2e16cdf71ab4 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -1060,6 +1060,16 @@ static struct clk_regmap g12a_fclk_div3 = {
 		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "fclk_div3_div" },
 		.num_parents = 1,
+		/*
+		 * This clock is used by the resident firmware and is required
+		 * by the platform to operate correctly.
+		 * Until the following condition are met, we need this clock to
+		 * be marked as critical:
+		 * a) Mark the clock used by a firmware resource, if possible
+		 * b) CCF has a clock hand-off mechanism to make the sure the
+		 *    clock stays on until the proper driver comes along
+		 */
+		.flags = CLK_IS_CRITICAL,
 	},
 };
 
-- 
2.21.0

