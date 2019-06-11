Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16209C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D794821734
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mxUBh4pQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfFKM3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 08:29:20 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48050 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfFKM3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 08:29:19 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5BCTCTs128301;
        Tue, 11 Jun 2019 07:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560256152;
        bh=3M2n/FZG3A+3YVnUYTVB7tAFganaUi8JUEkw3leCMek=;
        h=From:To:CC:Subject:Date;
        b=mxUBh4pQ7ZN1CbxeZ/bMcne5Z5j2N2vnK9f91x6+xoq6K97ddFlrXPePMWBoLXhuX
         17S2XRZGITPOdAsArm1FXhvIYc9kn91Bad1Q6hOIkKdsGdZdbqqx0V+m3aOXqH5R0V
         R/jQsvRLvMbglDnoBrIZwHDSQgiLNZOlIQ4PQMpo=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5BCTCci054605
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jun 2019 07:29:12 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 11
 Jun 2019 07:29:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 11 Jun 2019 07:29:12 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5BCT9s6010308;
        Tue, 11 Jun 2019 07:29:10 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <misael.lopez@ti.com>,
        <jsarha@ti.com>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] ASoC: ti: davinci-mcasp: Master AUXCLK FS ration support
Date:   Tue, 11 Jun 2019 15:29:39 +0300
Message-ID: <20190611122941.10708-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The AUXCLK of McASP which is used as the master clock for I2S signal generation
usually is a static clock.
The driver (and bindings) assumes this setup, however if the AUXCLK can change
with the stream's FS then this assumption breaks the audio support as it sets
constraint rules in startup, these rules run pre hw_params and in hw_params we
are going to be notified of the new reference clock (which is some multiple of
the FS).

Regards,
Peter
---
Peter Ujfalusi (2):
  bindings: sound: davinci-mcasp: Add support for optional
    auxclk-fs-ratio
  ASoC: ti: davinci-mcasp: Support for auxclk-fs-ratio

 .../bindings/sound/davinci-mcasp-audio.txt    |  3 ++
 sound/soc/ti/davinci-mcasp.c                  | 52 ++++++++++++++++---
 2 files changed, 47 insertions(+), 8 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

