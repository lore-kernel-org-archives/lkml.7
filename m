Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E0DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D3A206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412822;
	bh=tWLPXllXn+aiEysrFirzKbOsNju6+tySAn9QQxLjZ+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xRb0WAjHlsrz/9txtJzD/JOSOOCi0qWpnbMv0I16HBk9wnzRydhkcJWOTRzZhr82Q
	 S241MNBxapTCOpAPGLdRmJG/9Mmto3HJQCsiT8Ny/SUz0hV0TFEu0UXOq7NoUnjlej
	 caMEegEAC7huPK/GvuF1WK7V3dlGdytng1F3xbEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfCLRrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:47:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728658AbfCLRPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:16 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62FB721741;
        Tue, 12 Mar 2019 17:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410915;
        bh=tWLPXllXn+aiEysrFirzKbOsNju6+tySAn9QQxLjZ+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VtUvBVcc+mCp5rMBlIBI6kVQX6dZmYwftAUxppIg9Kh8Td4q3iWwsghFDQ0F9Fbsm
         IAIqkaIEiSjEDWlsrk/Uv84y/oB3EOb8JB49djYvBNhdLrQAwOnIoVAJqV2JhtFKJN
         eLJ92x4Q+KqrW+for1FRgzUN0vEEZKVhIgBy9RTo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.19 133/149] ARM: dts: exynos: Fix max voltage for buck8 regulator on Odroid XU3/XU4
Date:   Tue, 12 Mar 2019 10:09:11 -0700
Message-Id: <20190312170400.519827729@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit a3238924a820c1d7c977b632b769f3b5690cba09 upstream.

The maximum voltage value for buck8 regulator on Odroid XU3/XU4 boards is
set too low. Increase it to the 2000mV as specified on the board schematic.
So far the board worked fine, because of the bug in the PMIC driver, which
used incorrect step value for that regulator. It interpreted the voltage
value set by the bootloader as 1225mV and kept it unchanged. The regulator
driver has been however fixed recently in the commit 56b5d4ea778c
("regulator: s2mps11: Fix steps for buck7, buck8 and LDO35"), what results
in reading the proper buck8 value and forcing it to 1500mV on boot. This
is not enough for proper board operation and results in eMMC errors during
heavy IO traffic. Increasing maximum voltage value for buck8 restores
original driver behavior and fixes eMMC issues.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 86a2d2ac5e5d ("ARM: dts: Add dts file for Odroid XU3 board")
Fixes: 56b5d4ea778c ("regulator: s2mps11: Fix steps for buck7, buck8 and LDO35")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -334,7 +334,7 @@
 			buck8_reg: BUCK8 {
 				regulator-name = "vdd_1.8v_ldo";
 				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1500000>;
+				regulator-max-microvolt = <2000000>;
 				regulator-always-on;
 				regulator-boot-on;
 			};


