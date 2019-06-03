Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAB1C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2159528039
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NDatLUAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfFCJrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:47:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51966 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbfFCJrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:47:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id f10so10448464wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 02:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ySITkoSpV5tz/0UidgwrcEdFJZVNdmdPr2B7jtp9jvc=;
        b=NDatLUATUjuiUD4hERuG9znRQfMuTUCAU4ggEVOIBP+FgVSRJt3WZaY0RrGa7Dwvb1
         tPXdCBOtf0m2SVVhC/s51PZUQLWyTn//g+w5QgkbouvAEZZfvo/hYS0Qvxc9mY1N3RDl
         12CLAjcT2rNrEYGTTAfmXLf/b4PMau58fO8Tf1EJrQQRkioz3g1D42ztA9XxEOAFB+W/
         su2WX/nD5EDsKD8vv14foqsrzziZLg0rVZSxVTe2nVknHPJXLy1BppZQLalDKIXavP16
         72N48w4vbmtGK60MSJzcw8yI8w33mpxO9I6dUgQOrevlX7znnciyGipSUQ3j2jUt1vHw
         bNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ySITkoSpV5tz/0UidgwrcEdFJZVNdmdPr2B7jtp9jvc=;
        b=OBAQnQUvbZxBRl2IRZ2JUqwYu7jMk/CVPoLjhTSnOK8wZVwT3VmGxXAZrkLatlTQRO
         m592HabhnZj10ckGZPGv6nKNnQXLRv4aBPsoL1EtLfZeiJDOS6lKWJv8Wu3y535P6mBp
         eBp+4X3ADTSXxKg065enquCPyWh16qDMcnL5Gmbi8DGMe0S9+pdeseo97K+pl1HzugIK
         CHpzrlrQETZxvt4NKsc12YnhJBoABROtCQ59bEOQDzDnfhMS3Y7BYAM7yaG4w8ZmFshy
         Im1hNkiD9uXh5tq8ac4TKv06CkAchEmehQNgBTERFqu/HDH0ThluiHwcmXLbUBVr2yXW
         AI4A==
X-Gm-Message-State: APjAAAUNI0/U3TDXBaJpOqApQXfTtFeq4gXgJHgEuORJtwDTGCnx+2/Z
        D0HLwUiFO/33dImdxK1mODBWOw==
X-Google-Smtp-Source: APXvYqyFQyOwq3NatVmnOTvLBdiP1Y15tNjKDOOA5BlWh3lX91HYLp+dMM229VRYhDYAQ5xrcfOheQ==
X-Received: by 2002:a1c:b046:: with SMTP id z67mr1498018wme.49.1559555271273;
        Mon, 03 Jun 2019 02:47:51 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z14sm11235375wrh.86.2019.06.03.02.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Jun 2019 02:47:50 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 4/4] arm64: dts: meson-g12a-x96-max: bump bluetooth bus speed to 2Mbaud/s
Date:   Mon,  3 Jun 2019 11:47:40 +0200
Message-Id: <20190603094740.12255-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603094740.12255-1-narmstrong@baylibre.com>
References: <20190603094740.12255-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting to 2Mbaud/s is the nominal bus speed for common usages.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index aa9da5de5c2d..300c29dad49f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -206,6 +206,7 @@
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		max-speed = <2000000>;
 		clocks = <&wifi32k>;
 		clock-names = "lpo";
 	};
-- 
2.21.0

