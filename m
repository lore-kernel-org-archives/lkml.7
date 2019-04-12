Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEA7C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C122084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IbNveT6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfDLKF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:05:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51672 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfDLKFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:05:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so10481331wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 03:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xkjuJ+A3CtbzpoH7Dj7v7XkShfP9AdFWRwTBjrR2ReU=;
        b=IbNveT6PuucTpm2oqxnyW64wMNqqNlJtc1DqH43P9FZnvru5wQfosjLm4YSMK4xiIG
         3IRGR1VmFf6BV2Aahic1B2JmezknK36y5KRaDuqxbTQsTLiKeTClvimVSKcRXW2pPb00
         xG4tZKAmpKEdKzhch0SO6B878bWvJS/nmAIfq/ycepdr1iNLASYrEBCc8ItLYX9pn4te
         6UND8+fyVTwRIwifI9++gD++fPjDITBXRIM+tt6JLI/Upd6L9ox5On1RBxwuh3PAMB9s
         qpxmW909QwSHUKn03zS0B0faaTXCE0YtIZki78D43sDaFvBgSjoSBG+7h9ERUQosz7gq
         xIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xkjuJ+A3CtbzpoH7Dj7v7XkShfP9AdFWRwTBjrR2ReU=;
        b=IkjpCoKxKWxOEw/Ixu6L8Q9S2syvppVViVW0OTTMVNCJiifcLygjyvXyWDq1sdjh+8
         8Z7kLVACuuyU6Jh37FB1rf7ABvPpI3Vgryo4eEbfHFrPEIlO0qwEMTwa5TPvwPeOg+aA
         xuMM3Ernk5mqS7v6+aoBzm+kzJHGdTub3/JBv2WuXE5y78M1shx+KiS12Ocnd9C/Jhwe
         ebP6sklP3EoQZTMUvOtI8N0imqTulspCYHN4XMZt2AcF7i5XHkZ3TBQm5Ywz2ajtm3DG
         BNenYcQ+YC+dhqwpJLCw8k40SG7d8xjTG/9iaoGQZLxuPtDYLuT0SCKvdtQHwp2hwvfY
         Fobw==
X-Gm-Message-State: APjAAAWhE42cWXwJZxLk9y31CiZpNZ5rD9P4JM7FPddYxYtO06id+SWi
        O3A2zBjDhghtPQQD+NRukctD9A==
X-Google-Smtp-Source: APXvYqxD0gka6EJ/WBVfVnuT3SeNRS7g0otlV4QuwZkGtqXe3xO0BTHvcELrCks6+9dMmOUDU13zHw==
X-Received: by 2002:a1c:2b41:: with SMTP id r62mr10842720wmr.94.1555063522721;
        Fri, 12 Apr 2019 03:05:22 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s10sm10545602wmh.0.2019.04.12.03.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 03:05:22 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: meson-g12a-x96-max: enable IR decoder
Date:   Fri, 12 Apr 2019 12:05:17 +0200
Message-Id: <20190412100518.24470-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412100518.24470-1-narmstrong@baylibre.com>
References: <20190412100518.24470-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the IR decoder input on the X96 Max board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index b3d913f28f12..5cdc263b03e6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -144,6 +144,12 @@
 	};
 };
 
+&ir {
+	status = "okay";
+	pinctrl-0 = <&remote_input_ao_pins>;
+	pinctrl-names = "default";
+};
+
 &uart_A {
 	status = "okay";
 	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
-- 
2.21.0

