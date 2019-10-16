Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C715FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9782053B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JTpXEpkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394354AbfJPSrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 14:47:25 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:46110 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394329AbfJPSrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 14:47:24 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9GIlIZo082274;
        Wed, 16 Oct 2019 13:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571251638;
        bh=9qtMg4Ujoj7uLz0uW9F6ZZv2YQ82OKsxSuuQQhFRj8Q=;
        h=From:To:CC:Subject:Date;
        b=JTpXEpkfRc5ldi3y2XVdpJXtkmSIE/ee9KRu897EG3hkM0ZyL3WE266yCdMqAIGsx
         V1JOIeIdf+RFs9/6JyFhsrhwkUV0PAsumefl4wlyRG+LpGZJgtd0ye1MNZMgLC1yD2
         y1YEObTbby/FvV1ow4yttoXW7g5HBSxvsbwQXZzo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9GIlId6055319;
        Wed, 16 Oct 2019 13:47:18 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 13:47:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 13:47:18 -0500
Received: from uda0869644b.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9GIlIh8094854;
        Wed, 16 Oct 2019 13:47:18 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benoit Parrot <bparrot@ti.com>
Subject: [Patch 0/3] ARM: dts: am43x-vpfe/ov2659.patch
Date:   Wed, 16 Oct 2019 13:49:51 -0500
Message-ID: <20191016184954.14048-1-bparrot@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the missing camera endpoint (ov2659) as well as
the required source clocks nodes for the sensor.

On the am437x-sk-evm the camera sensor is sourced from clkout1 but that
clock nodes/tree was removed as it was unsed at the time, we are
re-adding the needed clock nodes here.

Benoit Parrot (2):
  ARM: dts: am437x-sk-evm: Add VPFE and OV2659 entries
  ARM: dts: am43x-epos-evm: Add VPFE and OV2659 entries

Tero Kristo (1):
  ARM: dts: am43xx: add support for clkout1 clock

 arch/arm/boot/dts/am437x-sk-evm.dts  | 27 +++++++++++++-
 arch/arm/boot/dts/am43x-epos-evm.dts | 23 +++++++++++-
 arch/arm/boot/dts/am43xx-clocks.dtsi | 54 ++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 2 deletions(-)

-- 
2.17.1

