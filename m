Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00111C17442
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AFD22459
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pXlv7oIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfKMMqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 07:46:31 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54212 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfKMMqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:46:31 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xADCkLiL119767;
        Wed, 13 Nov 2019 06:46:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573649181;
        bh=pRF7p8v054t/HDVdz8KBBBRwhrT3OT3e+Ov7Dq3EyOQ=;
        h=From:To:CC:Subject:Date;
        b=pXlv7oImuE/C6oRnXLibrgZFjh1nXHEIkiEAQ6Pa48LXx2dMfrclCs1fsA3rd7wfH
         lmM/k+fk0ZjymJCgHEStLTL/CS8+pfeuO8GaU4OvCZoWCbeVVFRlWwirJmt0cJj+RK
         STVY1nwmY/c6JHRsmpSiP2YVmVs9UFoa3AEbwF0c=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xADCkLed115017
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Nov 2019 06:46:21 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 13
 Nov 2019 06:46:03 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 13 Nov 2019 06:46:03 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xADCkIGE127078;
        Wed, 13 Nov 2019 06:46:19 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <kuninori.morimoto.gx@renesas.com>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] ASoC: pcm3168a: Poor man's RST gpio handling
Date:   Wed, 13 Nov 2019 14:47:32 +0200
Message-ID: <20191113124734.27984-1-peter.ujfalusi@ti.com>
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

when the codec RST input is connected to a GPIO it needs to be pulled high in
order to take the pcm3168a out from reset and to make it respond to register
accesses via i2c.

I have a board where one GPIO line is connected to two pcm3168a codec so runtime
handling of the RST gpio is not possible (one codec would place the other codec
to reset as well).

The only possible solution is to request the gpio with
GPIOD_FLAGS_BIT_NONEXCLUSIVE flag, ask it to be high initially and never touch
it again.

If the optinal GPIO is not described then issue the reset as the driver did.

Regards,
Peter
---
Peter Ujfalusi (2):
  bindings: sound: pcm3168a: Document optional RST gpio
  ASoC: pcm3168a: Add support for optional RST gpio handling

 .../devicetree/bindings/sound/ti,pcm3168a.txt |  7 ++++
 sound/soc/codecs/pcm3168a.c                   | 38 +++++++++++++++++--
 2 files changed, 41 insertions(+), 4 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

