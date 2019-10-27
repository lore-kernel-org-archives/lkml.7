Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DE3CA9EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD63214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210217;
	bh=ODeQV7D452RsJPvO/GCdLNCAnLcW+rLVjTUnNcBeBLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uqk4BDmyBkviuVNiEgEC+zDlLGv2iSuKUg5cd5y/WAx0fc2S1C6/tXi1T3Dz6P09j
	 vK7UY64jJJdL+V6K0zMAJPfK4H+IQ75pNxYVerzsjJScp3/MG6Gb5A87mFC8dNfQKr
	 K8uKuBblsUPXwdlDwyQlpf5O9z75YmPWFKSK0oQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfJ0VDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:03:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbfJ0VDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:03:31 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D21952064A;
        Sun, 27 Oct 2019 21:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210211;
        bh=ODeQV7D452RsJPvO/GCdLNCAnLcW+rLVjTUnNcBeBLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xHrDGfLGNQ/Vs18j0aBgA4Ga1xIfReaGEMrCg3vTRQHl486XsKRa5asny5CVCXHVZ
         Xvz3btusVWZ7Eu9r+U5qye7ZW/8IMXykcUUrhAo6qxsx4yWMt1rotQRN/Wkw6HaCoL
         0CFrMcFL1d8sT7i47ZJAT30Xh7CqnmQi3YA2TRew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 05/41] ARM: dts: am4372: Set memory bandwidth limit for DISPC
Date:   Sun, 27 Oct 2019 22:00:43 +0100
Message-Id: <20191027203103.062004692@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203056.220821342@linuxfoundation.org>
References: <20191027203056.220821342@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



