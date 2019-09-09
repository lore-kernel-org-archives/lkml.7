Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8532C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B035F21920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOaUNBRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733046AbfIIPC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:02:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34880 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfIIPCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:02:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id g7so14283672wrx.2;
        Mon, 09 Sep 2019 08:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J0MIJE6Nxl1hvH3C3OM5A0UBuuL5jPZmEXEDYcWfZcQ=;
        b=fOaUNBRlhtO421tZqNgdsHqwo014RGWh0CMAVSwQ5rfhfe8a2p7xbpi1RA9tPyhC/0
         b5S5vsZW2TM5ZWJvrbOZFXCSWTNpPz999UoQaVE5JZbFwnxNAbC8M9culoQkDkZYNMAr
         nXBfpc8GVayo9sNH6Ij6wJ5OtB6g5llsTlVRjzHPtRn8oWLxkRU8qK9n/1qv2kGTbJwU
         p++1sD5l1rSTJZbsI/CzpZsyTwQLfdcSlHxeTqcTbbQ1CGOe7oyKdu0BTF4Ql8YJwC8K
         zyjEXNI4pQZouYiVqeawgtV7a5ObmomZcbWfUF6YLdH6IGp0RVfpN09WG0IEDbvrIDkZ
         c5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J0MIJE6Nxl1hvH3C3OM5A0UBuuL5jPZmEXEDYcWfZcQ=;
        b=LkrUW1dM4v1TnJbbD8jVjZeckmzd3Cg4TwgVXoyVzVdBm1GUJi9lBToyr9ww4wnLHD
         B4r0KNWD7TCVqlNNrDZBDuJIDrtFgJBCGmd1d2pm2W9/RcHt2yH/+8+qwoIB6wCUEKtZ
         nzMhQf1O9gCfEeFwheSygazvmeTYRWwW9lZy2hDI4RND+ulicSjo1b8+3vUiqhssWPZ2
         y7h0F4XCKmftALLykqDL24qqFTNkw3cFivJ4iwGsuXl5CNZGLUNyshuXwPPpzppxWgmW
         wZ/fzeUf614YqMN00vTalol8BvFW5tnH2jN2jfVWfnCx7J5h6x+bhY90ynsdhq4cnObE
         dsZQ==
X-Gm-Message-State: APjAAAWOQTGsV5XqTLkK7p1CMUBHWJX1c0LBn0hZh4wGBb9x6hkYblYH
        6xSt3lc0TCKQG8fc12OIvkI=
X-Google-Smtp-Source: APXvYqwj34JpLBvf3nmmw4XC7VmKPtc9nqNLZYzTIOYcHNTEyllsd+TvEekzhHobqk3HodljNgJ0gg==
X-Received: by 2002:adf:f011:: with SMTP id j17mr19674585wro.131.1568041342945;
        Mon, 09 Sep 2019 08:02:22 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id s26sm27755397wrs.63.2019.09.09.08.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Sep 2019 08:02:22 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 2/6] arm64: dts: meson-gxl-s905x-khadas-vim: fix uart_A bluetooth node
Date:   Mon,  9 Sep 2019 19:01:23 +0400
Message-Id: <1568041287-7805-3-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568041287-7805-1-git-send-email-christianshewitt@gmail.com>
References: <1568041287-7805-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: dd5297cc8b8 ("arm64: dts: meson-gxl-s905x-khadas-vim enable Bluetooth")

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index 41be2af..2ab7d84 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -190,6 +190,9 @@
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		max-speed = <2000000>;
+		clocks = <&wifi32k>;
+		clock-names = "lpo";
 	};
 };
 
-- 
2.7.4

