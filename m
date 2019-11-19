Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36401C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06347218BA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142033;
	bh=CGJbKln3Rkg2sxB7qY0MAuLx3+hEzsvt48vMiraYkKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VpM/sZOxRNByDoVGPmLFv0rsfG0YAyw681HXu3LidKJA8dAuEofXU7FLQPno7ojpB
	 x05Ci8LjBwTGnfOGj9pLlvywKI3w3RYESSp+OIs1YXf0/lANmgLQbkcd2j8EoXWlw3
	 hCOHS81Dq7DftxqePGcTcPYX1cIvEhSlDqxhddXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbfKSFkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:40:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730410AbfKSFk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:40:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 019FE218BA;
        Tue, 19 Nov 2019 05:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142027;
        bh=CGJbKln3Rkg2sxB7qY0MAuLx3+hEzsvt48vMiraYkKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dDblZ0k0d5vUffNms0f+q/KX42sxbG/b4XbZAX6R9pUA0ehUFMlYCkJsbymM5HTEn
         ApHi7dOWNvqKIeXoF2LICGX7VJ6IcDlHAH5LMbwHuw9zirhYcbdj09y4xF9sPU/bmy
         Sggi6FF8Q7RlWXwGveUxDTVKJoBPRewOHBYR+AGM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 364/422] ARM: dts: meson8b: odroidc1: enable the SAR ADC
Date:   Tue, 19 Nov 2019 06:19:21 +0100
Message-Id: <20191119051422.602010042@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit fd6643142a0c5ab4d423ed7173a0be414d509214 ]

Odroid-C1 exposes ADC channels 0 and 1 on the GPIO headers. NOTE: Due
to the SoC design these are limited to 1.8V (instead of 3.3V like all
other pins).
Enable the SAR ADC to enable voltage measurements on these pins.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 8fdeeffecbdbc..8a09071d712a5 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -153,6 +153,11 @@
 	pinctrl-names = "default";
 };
 
+&saradc {
+	status = "okay";
+	vref-supply = <&vcc_1v8>;
+};
+
 &sdio {
 	status = "okay";
 
-- 
2.20.1



