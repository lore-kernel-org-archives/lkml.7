Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A0CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 05:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30BC20693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 05:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfCMF5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 01:57:23 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:47201 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfCMF5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 01:57:21 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1h3wt7-0001nV-79 from Jiada_Wang@mentor.com ; Tue, 12 Mar 2019 22:57:13 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Tue, 12 Mar 2019 22:57:09 -0700
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <horms@verge.net.au>, <magnus.damm@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>,
        <geert@linux-m68k.org>
CC:     <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <jiada_wang@mentor.com>
Subject: [PATCH v2 0/5] use extended audio dmac register
Date:   Wed, 13 Mar 2019 14:57:15 +0900
Message-ID: <20190313055720.26082-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: svr-orw-mbx-08.mgc.mentorg.com (147.34.90.208) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to user reference manual for R-CAR H3, M3-W and M3-N SoCs,
in order to access busif4 ~ busif7, extended audio dmac registers
(PDMASAREn, PDMADAREn, PDMACHCREn)
need to be used, rather than basic audio dmac registers
(PDMASARn, PDMADARn, PDMACHCRn)

This patch set updates H3 (= r8a7795), M3-W (= r8a7796) and M3-N (=r8a77965)
to use extended audio dmac registers

R-CAR E3 only has extended register set and is already using it,
rename register set name to indicate this.

---
v2: update rsnd driver to use extended register set when available
    rename R-CAR E3 audio dmac regisetr

v1: initial version

Jiada Wang (5):
  arm64: dts: renesas: r8a7795: add extended audio dmac register
  arm64: dts: renesas: r8a7796: add extended audio dmac register
  arm64: dts: renesas: r8a77965: add extended audio dmac register
  arm64: dts: renesas: r8a77990: rename audio dmac register
  ASoC: rsnd: dma: use extended audio dmac registers when available

 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 5 +++--
 arch/arm64/boot/dts/renesas/r8a7796.dtsi  | 5 +++--
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 5 +++--
 arch/arm64/boot/dts/renesas/r8a77990.dtsi | 4 ++--
 sound/soc/sh/rcar/dma.c                   | 5 ++++-
 5 files changed, 15 insertions(+), 9 deletions(-)

-- 
2.19.2

