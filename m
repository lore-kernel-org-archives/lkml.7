Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569EEC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351232146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440789AbfIXLGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:06:05 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:53815 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438600AbfIXLGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 07:06:04 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46cyzZ4Bsxz1rLPh;
        Tue, 24 Sep 2019 13:06:02 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46cyzZ3dW3z1qqkG;
        Tue, 24 Sep 2019 13:06:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id mritbTMQesNz; Tue, 24 Sep 2019 13:06:01 +0200 (CEST)
X-Auth-Info: sCc3ghK+gZ5oOxkg3UznVI/8Y3ZyFTKYP/gfWzsOp0M=
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 24 Sep 2019 13:06:01 +0200 (CEST)
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk@kernel.org, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 0/2] spi: Fix problem with interrupted slave transmission
Date:   Tue, 24 Sep 2019 13:05:45 +0200
Message-Id: <20190924110547.14770-1-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes problem with recovering Vybrid's NXP DSPI
controller state after master transmission distortion.

It was tested with a setup where /dev/spidevX.Y devices were used in
a loopback mode (provided by proper HW connections). During this test
the distortion was introduced and the system was assessed if it is
possible to continue correct SPI transmission.

This series applies clearly on v5.2 (tag) and current mainline:
SHA1: 4c07e2ddab5b6b57dbcb09aedbda1f484d5940cc

Lukasz Majewski (2):
  spi: Add call to spi_slave_abort() function when spidev driver is
    released
  spi: Introduce dspi_slave_abort() function for NXP's dspi SPI driver

 drivers/spi/spi-fsl-dspi.c | 20 ++++++++++++++++++++
 drivers/spi/spidev.c       |  1 +
 2 files changed, 21 insertions(+)

-- 
2.20.1

