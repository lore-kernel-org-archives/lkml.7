Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A4CC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 18:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95FB121479
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 18:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=upb.ro header.i=@upb.ro header.b="G6VL+S2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfEESOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 14:14:44 -0400
Received: from mail-sender200.upb.ro ([141.85.13.200]:43762 "EHLO mx.upb.ro"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726636AbfEESOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 14:14:44 -0400
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 May 2019 14:14:42 EDT
Received: from localhost (localhost [127.0.0.1])
        by mx.upb.ro (Postfix) with ESMTP id 5A920B560092;
        Sun,  5 May 2019 21:09:04 +0300 (EEST)
Received: from mx.upb.ro ([127.0.0.1])
        by localhost (mx.upb.ro [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qjAEdION00kg; Sun,  5 May 2019 21:09:02 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by mx.upb.ro (Postfix) with ESMTP id BF351B5618E0;
        Sun,  5 May 2019 21:09:02 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.upb.ro BF351B5618E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=upb.ro;
        s=96342B8A-77E4-11E5-BA93-D93D0963A2DF; t=1557079742;
        bh=LnDNlk6DOmQ1utGOMALPYd2kTfl57JKXKnsYulppIoo=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=G6VL+S2RyDWtmRUDM1Sp0UFCsMkRN2YKwnYEtbuNHZ5EmR7kKUBNgofSilJDR+K6C
         NWK//pLI0tBXa8ZjqtdSlA52BiMK1RxR/Zk7YYOSE6l02qEUWgbDIaMuvmHDuN/9k7
         fjbgxs6AVVi5DfFRz/IvfTrB2MUb4TNGRtW/5fQE=
X-Virus-Scanned: amavisd-new at upb.ro
Received: from mx.upb.ro ([127.0.0.1])
        by localhost (mx.upb.ro [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id POFBzA6OiHIj; Sun,  5 May 2019 21:09:02 +0300 (EEST)
Received: from localhost.localdomain (unknown [188.25.87.154])
        by mx.upb.ro (Postfix) with ESMTPSA id 93EDBB561841;
        Sun,  5 May 2019 21:09:02 +0300 (EEST)
From:   Radu Pirea <radu_nicolae.pirea@upb.ro>
To:     Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Richard Genoud <richard.genoud@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] DMA support for AT91 USART in SPI mode
Date:   Sun,  5 May 2019 21:06:44 +0300
Message-Id: <20190505180646.1442-1-radu_nicolae.pirea@upb.ro>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the version two of the patches with DMA support for
spi-at91-usart driver.=20

Changes in v2:
- specified in bindings order of dmas and dma-names
- changed DMA_FROM_DEVICE to DMA_DEV_TO_MEM and DMA_TO_DEVICE to
DMA_MEM_TO_DEV when dmaengine_prep_slave_sg is called

Changes in v1:
- added DMA support


Radu Pirea (2):
  dt-bindings: mfd: atmel-usart: add DMA bindings for USART in SPI mode
  spi: at91-usart: add DMA support

 .../devicetree/bindings/mfd/atmel-usart.txt   |  20 +-
 drivers/spi/spi-at91-usart.c                  | 221 +++++++++++++++++-
 2 files changed, 234 insertions(+), 7 deletions(-)

--=20
2.21.0

