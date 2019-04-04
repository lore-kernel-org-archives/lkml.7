Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B1CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AFE20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bR2KjCTP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E8xom3s7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfDDHRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:17:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58248 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfDDHRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:17:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5981160721; Thu,  4 Apr 2019 07:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362255;
        bh=K67NBvKibMoR1HlT2c1oGPm2czTKhqwfRzK2KSeFl9U=;
        h=From:To:Cc:Subject:Date:From;
        b=bR2KjCTPKN6su0yGVX0kpOdakEKWKoeNMpvi8faAdEyxSLBxXfDfxy8uRyQ5DFBx9
         e2lVMu3BJAd0HrV9CwIqqjHKiE/dxJw0P8w45TmCMOPUWOeYo2mnBQGiGGhSseRXMD
         jaZNDJNij/+vyqRrg/orCnlMNzElePH4MgNZMTRY=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2CAB560721;
        Thu,  4 Apr 2019 07:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362254;
        bh=K67NBvKibMoR1HlT2c1oGPm2czTKhqwfRzK2KSeFl9U=;
        h=From:To:Cc:Subject:Date:From;
        b=E8xom3s7KlvO3X2/GexNvfbQs1r9n75Toxd9IcQTXmx+rbOVHwk3nKRwseyMjicYC
         etIe2ibcc3PvareicVt9RTAe8qXMvP6TZEXffZITAIavf0HYhxfg6wBTVRFjvFmVTF
         7NJhjZsbGXGBZUTwaP8fuRyBiw9BgzKzcP5mOaXM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2CAB560721
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     dmitry.torokhov@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-imx@nxp.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 0/5] Input: Use devm_platform_ioremap_resource()
Date:   Thu,  4 Apr 2019 12:47:18 +0530
Message-Id: <1554362243-2888-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is just a minor change to promote using of this api
devm_platform_ioremap_resource() and nothing else functional
change it does.

Also, there are patches where only ioremap is used without requesting
the mem region so this devm_platform_ioremap_resource() take cares all
of that in single call.


Mukesh Ojha (5):
  Input: fsl-imx25-tcq: Use devm_platform_ioremap_resource()
  Input: mxs-lradc-ts.c: Use devm_platform_ioremap_resource()
  Input: s3c2410_ts: Use devm_platform_ioremap_resource()
  Input: sun4i-ts: Use devm_platform_ioremap_resource()
  Input: ts4800-ts: Use devm_platform_ioremap_resource()

 drivers/input/touchscreen/fsl-imx25-tcq.c |  4 +---
 drivers/input/touchscreen/mxs-lradc-ts.c  |  6 +-----
 drivers/input/touchscreen/s3c2410_ts.c    | 10 +---------
 drivers/input/touchscreen/sun4i-ts.c      |  3 +--
 drivers/input/touchscreen/ts4800-ts.c     |  4 +---
 5 files changed, 5 insertions(+), 22 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

