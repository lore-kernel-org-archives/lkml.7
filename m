Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E60C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4606A21726
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rga+lCVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbfDEOz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:55:59 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33314 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731153AbfDEOz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:55:57 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35EtqeZ105041;
        Fri, 5 Apr 2019 09:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554476152;
        bh=e7jrKBHIqK3iSX1RKjHunom92Ly+W9M/nLg7I2Xlwg8=;
        h=From:To:CC:Subject:Date;
        b=rga+lCVgCS3Bw3FtNg6ZaMGimGW+aTtYF6JH+U5HPXhUf6lLzLxwmJrpeky8ooT9n
         Tgze4za4XyY01z9KitJoj6F8MzgkTEZhvrSd0gWCaZKFoiH1KsEsYHtqbeuCjNtBEv
         wxuN0MioBOivHxDzi2WUkl/dA8grH6+TaeEVqT7s=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35EtpHx077884
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 09:55:52 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 09:55:51 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 09:55:51 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35EtpIj081040;
        Fri, 5 Apr 2019 09:55:51 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 0/6] LM36274 LMU Introduction
Date:   Fri, 5 Apr 2019 09:55:34 -0500
Message-ID: <20190405145540.27703-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This patch series adds the LM36274 to the TI LMU MFD driver as well as leverages
the TI LMU framework.

This work was done on top of v2 of the TI LMU rework series
https://lore.kernel.org/patchwork/project/lkml/list/?series=389483

I reused the lm363x regulator driver as I did not see it to be feasible to
rewrite a driver that kinda already exists.

Dan

Dan Murphy (6):
  regulator: lm363x: Make the gpio register enable flexible
  dt-bindings: mfd: Add lm36274 bindings to ti-lmu
  mfd: ti-lmu: Add LM36274 support to the ti-lmu
  regulator: lm363x: Add support for LM36274
  dt-bindings: leds: Add LED bindings for the LM36274
  leds: lm36274: Introduce the TI LM36274 LED driver

 .../devicetree/bindings/leds/leds-lm36274.txt |  82 +++++++++
 .../devicetree/bindings/mfd/ti-lmu.txt        |  54 ++++++
 drivers/leds/Kconfig                          |   9 +-
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-lm36274.c                   | 174 ++++++++++++++++++
 drivers/mfd/Kconfig                           |   5 +-
 drivers/mfd/ti-lmu.c                          |  14 ++
 drivers/regulator/Kconfig                     |   2 +-
 drivers/regulator/lm363x-regulator.c          |  56 +++++-
 include/linux/mfd/ti-lmu-register.h           |  23 +++
 include/linux/mfd/ti-lmu.h                    |   4 +
 11 files changed, 417 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm36274.txt
 create mode 100644 drivers/leds/leds-lm36274.c

-- 
2.19.0

