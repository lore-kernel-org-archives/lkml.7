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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D97C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19852086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rl13LvTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbfIIPCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:02:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40020 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfIIPCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:02:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id w13so14239140wru.7;
        Mon, 09 Sep 2019 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zWgZzxa7s7UwpFTcQ3sR+RE7GhMC4HUd7wnY9usj7WY=;
        b=rl13LvTv5slN1ykkacXuDEJNq+bmzXb5EzXmYi9NdskTB6cCmAcQUe23M1VAslyAmM
         P54wSrgR1lnaXYUb0911Auk9LS8tRdoxMSSqVGdYamzMjW6xxJwcZSiDfSgP50P539Qd
         0aHCsN9xLsYX59bvrfq+qPpV4/U33dEurc5EsNDykBROYO9bFIpLqcgZ5OJ5tnV2szuy
         OxQ0Q/FsPiYQcrK0CPA5DIJjeayTi9l0E9i9ynz5U98FFt+YhjHRdRPOpIggGqsMp3dn
         J2JNtgttzshsG+is6ua0vXmuExa/F8G7wTSwBIMRrPDokAf5EBMfEFVBSN7pPwAvUibe
         lJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zWgZzxa7s7UwpFTcQ3sR+RE7GhMC4HUd7wnY9usj7WY=;
        b=Me/qd7LWwiReBR0aTT6NgVCJlMquKEI+HZmgnd/FAVgNDVSJMJOzLOBfoj8jJ/Lo/2
         NoEccJwyMfLJ2EoqZHq7BHyYiy/X7mDOfy+vEE7DU/Mfdqetz9GOZwgaCkJcCPsbS8Ht
         KtjyQHD0R0Anihedh7jHPBMzu23h9Vu3QtgtLSrVi8ev49RJgpCLBICKSOAHEmVtaT4g
         aasLDz4lIPWzsyKmhOPy2xU2KYxkcLEGGbC4NKMhigs5w0yLw8V57wTp8iTOt7s9sPcO
         m4OwtnATAc6qnsPwJEFXrC6GE67NTke4QQyxCyvNJie8ok2vMLSl0bnkqkjKMoObOfAt
         ip5A==
X-Gm-Message-State: APjAAAU1zNRZZ2zMpZWtVjDC/d5Uq+i8VFVIhaoNVsS8aeEO064dEqCu
        47UUnOBPX/djT7sBiS5K78U=
X-Google-Smtp-Source: APXvYqzSYVyCPseD4bxHLDkzFaDr/7JihKFccFWxN6T2kst1FybqCjxiTv6NGRRIjFWDi138SQXwjg==
X-Received: by 2002:adf:f812:: with SMTP id s18mr20612825wrp.32.1568041340822;
        Mon, 09 Sep 2019 08:02:20 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id s26sm27755397wrs.63.2019.09.09.08.02.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Sep 2019 08:02:19 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/6] arm64: dts: meson-gxl-s905x-khadas-vim: fix gpio-keys-polled node
Date:   Mon,  9 Sep 2019 19:01:22 +0400
Message-Id: <1568041287-7805-2-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568041287-7805-1-git-send-email-christianshewitt@gmail.com>
References: <1568041287-7805-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix DTC warnings:

arch/arm/dts/meson-gxl-s905x-khadas-vim.dtb: Warning (avoid_unnecessary_addr_size):
   /gpio-keys-polled: unnecessary #address-cells/#size-cells
      without "ranges" or child "reg" property

Fixes: e15d2774b8c ("ARM64: dts: meson-gxl: add support for the Khadas VIM board")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index 5499e8d..41be2af 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -33,11 +33,9 @@
 
 	gpio-keys-polled {
 		compatible = "gpio-keys-polled";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		poll-interval = <100>;
 
-		button@0 {
+		power-button {
 			label = "power";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_LOW>;
-- 
2.7.4

