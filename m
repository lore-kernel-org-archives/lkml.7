Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF0FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40595205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414286;
	bh=G0i/p45lYr0QvRiV+QVyaVdkbfWRGafgknrCrjpkdzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oe8+MFiogXVEczsOVyIIc1sNKh4UQxDHv2FKGyNLf4+RzesYRi/bLfQ/NWac4GxqD
	 DAra2mjQriNRNB8gK8LGuq+RtI6F6rW2C3IIzF1uH1z5f9sUmn3QCqseTrw/NWcOtJ
	 bZwkb50EFjqAYejX7oRDmhOANzbCKP+hcyffcsQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfCLRLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:11:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbfCLRLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:31 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03C1F2173C;
        Tue, 12 Mar 2019 17:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410691;
        bh=G0i/p45lYr0QvRiV+QVyaVdkbfWRGafgknrCrjpkdzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NSB4RjvxYupZF58tm0k3y6MrxP9TdTbMTK454j5yGEpLRHfIx9H+2Am1UxCJ8Zdlw
         jLRduSKU7T0ffTOgJFZQ/MFStMMFUJQkM/S2P435qFLWVmxZQIr/jm683jq/BDXgjG
         jJFjSpXSvxpkQwOHikhkHtVUhn4s2XoTs9GW2lGw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 5.0 07/25] arm64: dts: zcu100-revC: Give wifi some time after power-on
Date:   Tue, 12 Mar 2019 10:08:45 -0700
Message-Id: <20190312170404.099329748@linuxfoundation.org>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

commit 35a4f89cd4731ac6ec985cd29ddc1630903006b7 upstream.

Somewhere along recent changes to power control of the wl1831, power-on
became very unreliable on the Ultra96, failing like this:

wl1271_sdio: probe of mmc2:0001:1 failed with error -16
wl1271_sdio: probe of mmc2:0001:2 failed with error -16

After playing with some dt parameters and comparing to other users of
this chip, it turned out we need some power-on delay to make things
stable again. In contrast to those other users which define 200 ms,
Ultra96 is already happy with 10 ms.

Fixes: 5869ba0653b9 ("arm64: zynqmp: Add support for Xilinx zcu100-revC")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -101,6 +101,7 @@
 	sdio_pwrseq: sdio-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&gpio 7 GPIO_ACTIVE_LOW>; /* WIFI_EN */
+		post-power-on-delay-ms = <10>;
 	};
 };
 


