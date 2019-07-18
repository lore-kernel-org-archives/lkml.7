Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7A2C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780562173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RGU1Xexg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KLJE4MXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390336AbfGRNCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 09:02:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41392 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfGRNCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 09:02:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3697D6074F; Thu, 18 Jul 2019 13:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563454971;
        bh=sgsFyHLcYoHrD5KxPdTjsgPzLSw0xPnXtobgkrmHXVs=;
        h=From:To:Cc:Subject:Date:From;
        b=RGU1XexgB6vEco53IQLkEIEws93mzzPXxadmjSstr0IjgRwY/wetlhC7CShIRJfkR
         zWZ4etKtTSv7S+F3ucot2uMEkIacFSs9Sf++/HuMZZrpaqLsj3Kro7onCxB9mm9Vw2
         DX1oHJFspN/xi8Gm7mDBY9GNqa3JCV7HIA2L3/Xw=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 56EBD6063A;
        Thu, 18 Jul 2019 13:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563454970;
        bh=sgsFyHLcYoHrD5KxPdTjsgPzLSw0xPnXtobgkrmHXVs=;
        h=From:To:Cc:Subject:Date:From;
        b=KLJE4MXBM7wLc2ww6DqgbpMeZEN2vsUva5bfrvSLK+c+Asz9Z78CKvm2ujJZ5pwSY
         naSH2NbCypYFmmCGN/OKxaepLidUOdObw33LgVNd7Xhkz7p9MeziCXM2RNzkwYJ/jW
         li3r/B1SGSYafZ82nbngDAdT5wDeKne9D6/AdlWM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 56EBD6063A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     agross@kernel.org, linux-arm-msm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, jcrouse@codeaurora.org,
        rishabhb@codeaurora.org, evgreen@chromium.org,
        linux-kernel@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH v2 0/3] soc: qcom: llcc cleanups
Date:   Thu, 18 Jul 2019 18:32:35 +0530
Message-Id: <20190718130238.11324-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To better support future versions of llcc, consolidating the
driver to llcc-qcom driver file, and taking care of the dependencies.
v1 series is availale at:
https://lore.kernel.org/patchwork/patch/1099573/

Changes since v1:
Addressing Bjorn's comments -
 * Not using llcc-plat as the platform driver rather using a single
   driver file now - llcc-qcom.
 * Removed SCT_ENTRY macro.
 * Moved few structure definitions from include/linux path to llcc-qcom
   driver as they are not exposed to other subsystems.

Vivek Gautam (3):
  soc: qcom: llcc cleanup to get rid of sdm845 specific driver file
  soc: qcom: Rename llcc-slice to llcc-qcom
  soc: qcom: Make llcc-qcom a generic driver

 drivers/soc/qcom/Kconfig                       |  14 +--
 drivers/soc/qcom/Makefile                      |   3 +-
 drivers/soc/qcom/{llcc-slice.c => llcc-qcom.c} | 155 +++++++++++++++++++++++--
 drivers/soc/qcom/llcc-sdm845.c                 | 100 ----------------
 include/linux/soc/qcom/llcc-qcom.h             | 104 -----------------
 5 files changed, 152 insertions(+), 224 deletions(-)
 rename drivers/soc/qcom/{llcc-slice.c => llcc-qcom.c} (64%)
 delete mode 100644 drivers/soc/qcom/llcc-sdm845.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

