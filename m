Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54D3C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97122208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfF0Or6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:47:58 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:54717 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfF0Or6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:47:58 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,424,1557212400"; 
   d="scan'208";a="37606820"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jun 2019 07:47:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex04.mchp-main.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Jun 2019 07:47:56 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Thu, 27 Jun 2019 07:47:52 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 0/4] add slow clock support for SAM9X60
Date:   Thu, 27 Jun 2019 17:47:17 +0300
Message-ID: <1561646841-7663-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series add slow clock support for SAM9X60. Apart from previous IPs, this
one uses different offsets in control register for different functionalities.
The series adapt current driver to work for all IPs using per IP
configurations initialized at probe.

Stephen,

I send a new version of this since I'm not seeing the patches on clk-next
and I though you may had issues with the previous version of this series.

Thank you,
Claudiu Beznea

Changes in v5:
- get rid of Content-Transfer-Encoding: base64
- collect Ack-by tag

Changes in v4:
- remove macros which were used to access IP specific bits for control
  register
- collect Acked-by, Reviewed-by tags

Changes in v3:
- add patch 1/1 that remove bypass code in the code specific to SAMA5D4
  (there is no bypass support on SAMA5D4)
- adapt review comments
- register clock with of_clk_hw_onecell_get to emphasize that this IP has
  2 output clocks MD_SLKC and TD_SLCK (I considered not necessary to
  introduce new constants to be shared b/w driver and DT bindings; if
  you consider otherwise, let me know)
- adapt dt-binding patch with clock-cells changes (thus didn't introduced
  Reviewed-by tag)
- renamed struct clk_slow_offsets to struct clk_slow_bits and the
  corresponding instances of it

Changes in v2:
- split patch 1/1 from v1 in 2 patches: one adding register bit offsets
  support (patch 1/3 from this series), one adding support for SAM9X60
  (patch 2/3 from this series)
- fix compatible string from "microchip,at91sam9x60-sckc" to
  "microchip,sam9x60-sckc"

Claudiu Beznea (4):
  clk: at91: sckc: sama5d4 has no bypass support
  clk: at91: sckc: add support to specify registers bit offsets
  dt-bindings: clk: at91: add bindings for SAM9X60's slow clock
    controller
  clk: at91: sckc: add support for SAM9X60

 .../devicetree/bindings/clock/at91-clock.txt       |   7 +-
 drivers/clk/at91/sckc.c                            | 173 ++++++++++++++++-----
 2 files changed, 139 insertions(+), 41 deletions(-)

-- 
2.7.4

