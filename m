Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D02C73C66
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C932080C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfGJClV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 22:41:21 -0400
Received: from inva021.nxp.com ([92.121.34.21]:32870 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfGJClV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 22:41:21 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 40EE9200F40;
        Wed, 10 Jul 2019 04:41:19 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C507D200F3A;
        Wed, 10 Jul 2019 04:41:15 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2EFA4402C9;
        Wed, 10 Jul 2019 10:41:11 +0800 (SGT)
From:   han.xu@nxp.com
To:     han.xu@nxp.com, broonie@kernel.org, ashish.kumar@nxp.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 0/3] dynamically alloc AHB memory 
Date:   Wed, 10 Jul 2019 10:31:25 +0800
Message-Id: <20190710023128.13115-1-han.xu@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Han Xu <han.xu@nxp.com>

i.MX platforms reserved 256M memory area for FSPI/QSPI AHB memory, it
may failed to alloc all of them at once on some platforms. These patches
allow the controller alloc AHB as needed.

i.MX7D RX FIFO should be 128B rather than 512B.

Han Xu (3):
  spi: spi-nxp-fspi: dynamically alloc AHB memory for FSPI
  spi: spi-fsl-qspi: change i.MX7D RX FIFO size
  spi: spi-fsl-qspi: dynamically alloc AHB memory for QSPI

 drivers/spi/spi-fsl-qspi.c | 60 +++++++++++++++++++++++++++-----------
 drivers/spi/spi-nxp-fspi.c | 39 ++++++++++++++++++++-----
 2 files changed, 74 insertions(+), 25 deletions(-)

-- 
2.17.1

