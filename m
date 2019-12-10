Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ED5C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47E720838
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfLJNY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:24:57 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:38617 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfLJNY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:24:56 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 4wxkjymyrvYDtaXLV3wnwWnmM7qbBQlkZel1+UbW6Ixk6YfU4GFTmtHWThX180tLfzzCHb0ZC6
 b6KWrHSWCpgQPokrJtJ9XX58ZcGLAA5sLqjJU6+Aq8FizLFmem5lJ+DntbqUXi8Rsg72u/JXGa
 EMTreU98lD3HBJd1p4C+11FUSZNtSjcqAeRuUVCvaFKfCkg4l5/obxIwsRllGXfiEyDykG+ocI
 LOl3JIvw9JY0MG7PtTW5kfFf8JAaU8W19PwmDKA2Gexev0142/KBOkAm1EHey/2j7aD9RpYMiY
 V+M=
X-IronPort-AV: E=Sophos;i="5.69,299,1571727600"; 
   d="scan'208";a="59845981"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Dec 2019 06:24:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Dec 2019 06:24:55 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 10 Dec 2019 06:24:56 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <sam@ravnborg.org>, <bbrezillon@kernel.org>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <lee.jones@linaro.org>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/5] fixes for atmel-hlcdc
Date:   Tue, 10 Dec 2019 15:24:42 +0200
Message-ID: <1575984287-26787-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have few fixes for atmel-hlcdc driver in this series as well
as two reverts.
Revert "drm: atmel-hlcdc: enable sys_clk during initalization." is
due to the fix in in patch 2/5.

Thank you,
Claudiu Beznea

Claudiu Beznea (5):
  drm: atmel-hlcdc: use double rate for pixel clock only if supported
  drm: atmel-hlcdc: enable clock before configuring timing engine
  mfd: atmel-hlcdc: return in case of error
  Revert "drm/atmel-hlcdc: allow selecting a higher pixel-clock than
    requested"
  Revert "drm: atmel-hlcdc: enable sys_clk during initalization."

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 26 ++++++++++----------------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c   | 19 +------------------
 drivers/mfd/atmel-hlcdc.c                      | 14 ++++++++++----
 3 files changed, 21 insertions(+), 38 deletions(-)

-- 
2.7.4

