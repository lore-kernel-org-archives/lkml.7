Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C52BECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A1E206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570641915;
	bh=ODeQV7D452RsJPvO/GCdLNCAnLcW+rLVjTUnNcBeBLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oRYeeCRzYhZz7LJDWnVfqRwN5HEIXL/9aulfPCfasb6bDEEtwpS7vUkqgfaQZed5G
	 q3lkYJvOeU2DYQ11dVIHxmLqXHpCm5ypNmYjvo0BHKEDCKO3Rcv4LdGlGOimTG7Hom
	 IUkxaDtT4sP3sYJ+H0KGr05u24/QpSC1cmv5dr70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732592AbfJIRZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732494AbfJIRYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:24:54 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABFDE21A4A;
        Wed,  9 Oct 2019 17:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570641893;
        bh=ODeQV7D452RsJPvO/GCdLNCAnLcW+rLVjTUnNcBeBLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e3wViPD4Gg6PR4sEqtyPCp76hWBYhvcxp7M/mfchjj1dtutbqybI2oP+35Ni0LLh+
         eiEOATpTBjpohpu1/RF6iAMp9lvt2FM+FkF8SgrPKTAoQpsFjtFBhd3DjfQZSTBLnA
         /qk/BaWtwmn7gML2GlxuGZD9ROZpgFNrZc8QnArE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 05/11] ARM: dts: am4372: Set memory bandwidth limit for DISPC
Date:   Wed,  9 Oct 2019 13:06:39 -0400
Message-Id: <20191009170646.696-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170646.696-1-sashal@kernel.org>
References: <20191009170646.696-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

[ Upstream commit f90ec6cdf674248dcad85bf9af6e064bf472b841 ]

Set memory bandwidth limit to filter out resolutions above 720p@60Hz to
avoid underflow errors due to the bandwidth needs of higher resolutions.

am43xx can not provide enough bandwidth to DISPC to correctly handle
'high' resolutions.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am4372.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 3ef1d5a26389c..3bb5254a227a3 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -1002,6 +1002,8 @@
 				ti,hwmods = "dss_dispc";
 				clocks = <&disp_clk>;
 				clock-names = "fck";
+
+				max-memory-bandwidth = <230000000>;
 			};
 
 			rfbi: rfbi@4832a800 {
-- 
2.20.1

