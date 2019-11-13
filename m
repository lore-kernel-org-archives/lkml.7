Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C5EC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F5E20818
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Nl+D5uPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfKMJx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 04:53:56 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39910 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfKMJxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 04:53:54 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAD9rWUZ089843;
        Wed, 13 Nov 2019 03:53:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573638812;
        bh=pquoh/f1Vxyy0nGdPMJBRGzCBO0bIUT0w+TVSovYYT8=;
        h=From:To:CC:Subject:Date;
        b=Nl+D5uPuIYePSPjkku6yM0gUhGjtWptnuPpsD+WJRxYPboFGauOqyaAsC8ixKHq2k
         vpG+qmnoLf6+xQNSOzx/BLnR2AOeFXBvcMUrIEDrFsg5Z5gpMtX7bszEAjCoz3KS+y
         OwA69mKljY8LKbqegp2My3xqjqVWHbO8EgIlyYQk=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAD9rWYm019250
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Nov 2019 03:53:32 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 13
 Nov 2019 03:53:14 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 13 Nov 2019 03:53:14 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAD9rUGS121188;
        Wed, 13 Nov 2019 03:53:30 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <lars@metafoo.de>
CC:     <vkoul@kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <jsarha@ti.com>
Subject: [PATCH 0/2] ASoC: Use dma_request_chan() directly for channel request
Date:   Wed, 13 Nov 2019 11:54:43 +0200
Message-ID: <20191113095445.3211-1-peter.ujfalusi@ti.com>
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

I'm going through the tree to remove dma_request_slave_channel_reason() as it
is just:
#define dma_request_slave_channel_reason(dev, name) \
	dma_request_chan(dev, name)

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: dmaengine: Use dma_request_chan() directly for channel request
  ASoC: ti: davinci-mcasp: Use dma_request_chan() directly for channel
    request

 sound/soc/soc-generic-dmaengine-pcm.c | 2 +-
 sound/soc/ti/davinci-mcasp.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

