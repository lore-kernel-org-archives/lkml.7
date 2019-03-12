Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171ADC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D520920883
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VITWp9pJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VITWp9pJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfCLMXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:23:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53968 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfCLMXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:23:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 90C6860ACA; Tue, 12 Mar 2019 12:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552393410;
        bh=bDMi2SzT7hc6kFi7tkMU29Wn48BgaZ2QoLEFfVHtN6M=;
        h=From:To:Cc:Subject:Date:From;
        b=VITWp9pJH+Zye9mfqe76uhh8oABfq6DksEirXimt+OZPfCV9e5oqL4l2hftXIkRq5
         mhE9WG867oU3bSD7Hlc80/NzpaFB65ws6L/F4PgQhSVO/1HjFuY2sIbUKxkwJNBNfq
         o4qx6SI0TDQODvB/PXA7QESyoK6m/0tYwW8EmrbE=
Received: from c-hbandi-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: c-hbandi@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A3395609D4;
        Tue, 12 Mar 2019 12:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552393410;
        bh=bDMi2SzT7hc6kFi7tkMU29Wn48BgaZ2QoLEFfVHtN6M=;
        h=From:To:Cc:Subject:Date:From;
        b=VITWp9pJH+Zye9mfqe76uhh8oABfq6DksEirXimt+OZPfCV9e5oqL4l2hftXIkRq5
         mhE9WG867oU3bSD7Hlc80/NzpaFB65ws6L/F4PgQhSVO/1HjFuY2sIbUKxkwJNBNfq
         o4qx6SI0TDQODvB/PXA7QESyoK6m/0tYwW8EmrbE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A3395609D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=c-hbandi@codeaurora.org
From:   Harish Bandi <c-hbandi@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        anubhavg@codeaurora.org, Harish Bandi <c-hbandi@codeaurora.org>
Subject: [PATCH v3 0/2] Enable Bluetooth functionality for wcn3998.
Date:   Tue, 12 Mar 2019 17:52:57 +0530
Message-Id: <1552393379-26330-1-git-send-email-c-hbandi@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series we add support for wcn3998 BT chip set. This new chipset
is based from the wcn3990 with minimal power numbers. So here in this patch
The major difference between wcn3990 and wcn3998 is only power numbers. where
as init process and fw download is same with wcn3990.So we add new compatible 
for wcn3998. 
Removed the Reading of regulator values from dts.
Added new compatible for wcn3998. 
Changed in V3:
updated to latest code base.

Harish Bandi (2):
  Bluetooth: hci_qca: Added support for wcn3998
  dt-bindings: net: bluetooth: Add device tree bindings for QTI chip
    wcn3998

 .../devicetree/bindings/net/qualcomm-bluetooth.txt | 15 ++++++++
 drivers/bluetooth/btqca.c                          |  4 +--
 drivers/bluetooth/btqca.h                          |  3 +-
 drivers/bluetooth/hci_qca.c                        | 40 ++++++++++++++--------
 4 files changed, 45 insertions(+), 17 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

