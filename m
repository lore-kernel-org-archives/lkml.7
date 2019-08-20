Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB0EC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BB722DD6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbfHTQYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 12:24:50 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:26172 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfHTQYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:24:47 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Codrin.Ciubotariu@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Codrin.Ciubotariu@microchip.com";
  x-sender="Codrin.Ciubotariu@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Codrin.Ciubotariu@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Codrin.Ciubotariu@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: fWI45YppRXL2cpH01hnpCc35g1Ub3xWS0ia640z7pOG9bho9JkilCCrM1QxwhvGUmjrDzgDRX6
 TxVKD/N1hrAsGaHqkJwwTCXRFj78iiO+EuhUTWIlNaV+a22DTk9683gB5rTrcrK1MrVdBXq0tI
 cGp3a3Oo1oSDd6pRzUQKMhILHo9ZkQNgs9kfH6UvJAhtNprxhKE3XVe1quppvJ1/m0B3f0xvhA
 zqhDXjCFvKhzLUL+5BzajbC4DA0w55INwMA3S4OwocNZjqxFV63LtMgwm5ZF6DhAFiUQcjjgIB
 hQM=
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="47246835"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2019 09:24:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 20 Aug 2019 09:24:46 -0700
Received: from rob-ult-m19940.microchip.com (10.10.85.251) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 20 Aug 2019 09:24:43 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 0/3] ASoC: mchp-i2s-mcc: Several fixes
Date:   Tue, 20 Aug 2019 19:24:08 +0300
Message-ID: <20190820162411.24836-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pathset fixes some issues detected while testing some more the
Microchip I2S multichannel controller. The first two patches fix some
issues that appear mostly when hw_free() and hw_params() callbacks
are called multiple times. The third patch fixes a problem caused
when the controller is in master mode and both capture and playback 
are played at the same time.

All three patches have a "Fixes" tag. Although they are independent,
some conflicts might appear if they are not applied in the order
presented in this patchset. If so, please let me know so I can rebase
them.

Codrin Ciubotariu (3):
  ASoC: mchp-i2s-mcc: Wait for RX/TX RDY only if controller is running
  ASoC: mchp-i2s-mcc: Fix unprepare of GCLK
  ASoC: mchp-i2s-mcc: Fix simultaneous capture and playback in master
    mode

 sound/soc/atmel/mchp-i2s-mcc.c | 111 +++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 47 deletions(-)

-- 
2.20.1

