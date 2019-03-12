Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E7CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9325E2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414440;
	bh=/rJgdU2pud1ahYGueo3MbrAYmysweVFgQXmwULKe6PI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zzhAPjkn58wPD8PV4w1KqEGtYhuYGpP0f0RIqNs5U7g2owgQAChY6dquCTFPEb/dp
	 uT/qe3Pfe/5lEPL3P/pKyruVyD139hchm5sbmXBwxzMIgkaitIeF+JaYXtFbDjcfWC
	 xLqmbN/HoHAmfns7sZAbYhSC4H4P4xHo4Haah/Yk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfCLSN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:13:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfCLRLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:23 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8BE32173C;
        Tue, 12 Mar 2019 17:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410682;
        bh=/rJgdU2pud1ahYGueo3MbrAYmysweVFgQXmwULKe6PI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BJaYriWMLlc7sZ0dTRwvWoMBrlyDea0xZLnUyhVLTkjDE995cxpLFbOuee2NjjshL
         1rNs4NydbsUPDvevy0Y6nzU/T+9iOXF5VhYhDbpzEtrdLWxCptriiM6GkUxJqxD2ur
         dyWD5KcSjJ5CX9c9tqPGxMQXw1+kdFux+AHxL0/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5.0 12/25] ARM: dts: exynos: Fix max voltage for buck8 regulator on Odroid XU3/XU4
Date:   Tue, 12 Mar 2019 10:08:50 -0700
Message-Id: <20190312170404.451980264@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170403.643852550@linuxfoundation.org>
References: <20190312170403.643852550@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -468,7 +468,7 @@
 			buck8_reg: BUCK8 {
 				regulator-name = "vdd_1.8v_ldo";
 				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1500000>;
+				regulator-max-microvolt = <2000000>;
 				regulator-always-on;
 				regulator-boot-on;
 			};


