Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8539FC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E12D22519
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DLhPbCDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbfKTNSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:18:08 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:32900 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbfKTNSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:18:08 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAKDHvnv033402;
        Wed, 20 Nov 2019 07:17:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574255877;
        bh=INPUix/PA4lNGQbVgLpq5OtLH0YUwbTwpFh3cUKqBH4=;
        h=From:To:CC:Subject:Date;
        b=DLhPbCDsBJ11M96TnHylZrP8Y9ydrLNqVdD56N7nx30ynFvfPGarVNM3bk7U0obml
         hKfFyYTSgss6J/dAebJy/0XC/wiVdJDPZ7hIDank7P8w9qJLktj05uZ6pXwm6JUVsI
         C4zisQV7yxE6iyHeQtYxpovsE9n03Yzc63ORumKs=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAKDHvOc091714
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Nov 2019 07:17:57 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 20
 Nov 2019 07:17:56 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 20 Nov 2019 07:17:56 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAKDHru5067880;
        Wed, 20 Nov 2019 07:17:54 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <kuninori.morimoto.gx@renesas.com>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] ASoC: pcm3168a: Update the reset GPIO handling
Date:   Wed, 20 Nov 2019 15:17:51 +0200
Message-ID: <20191120131753.6831-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Switch the rst-gpios to generic reset-gpios as suggested by Rob.

Based on other threads around GPIOs, revise the GPIO active vs assert/deassert
configuration: The RST pin is a reset pin and it is active low.

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: dt-bindings: pcm3168a: Update the optional RST gpio for clarity
  ASoC: pcm3168a: Update the RST gpio handling to align with
    documentation

 .../devicetree/bindings/sound/ti,pcm3168a.txt |  9 +++++----
 sound/soc/codecs/pcm3168a.c                   | 20 ++++++++++++++-----
 2 files changed, 20 insertions(+), 9 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

