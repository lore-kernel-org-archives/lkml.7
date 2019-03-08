Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DD0C10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892A520684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TkiE1kDb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IZeuzw9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfCHMr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:47:56 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50240 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCHMrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:47:55 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0EE4E60264; Fri,  8 Mar 2019 12:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552049275;
        bh=2ZuAtNGZBflxJUzQ1oTHAeG4aHdGAoDOIi230pF+2a0=;
        h=From:To:Cc:Subject:Date:From;
        b=TkiE1kDbS36jsY2lg69PiY+Z6YqDhXIMcVhUzt/XDnD0fBD7OPXPFotAm63OQloqw
         frb8z5E7CwOUMGT50Kx+h8dXKfCnxM1S57sqqZNHUFUFE2Sp2LQ7OfmtkkEtB3+PG5
         XDAKmTd/q8TjTpnVpnSXE47CiDbuCf3R19jXdbLU=
Received: from c-hbandi-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: c-hbandi@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 24DA460264;
        Fri,  8 Mar 2019 12:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552049274;
        bh=2ZuAtNGZBflxJUzQ1oTHAeG4aHdGAoDOIi230pF+2a0=;
        h=From:To:Cc:Subject:Date:From;
        b=IZeuzw9/VXIl/0uvOY2TPfQG3DivtPla7k1v0yVhOy8TGLF/FOtdRuNeaouIBpwva
         UcPosfXBs7NCJMpnAICnunDY1BT1oYHui5/YY31ug3k4Omh4VPmWs8Vqvaqec+GZlM
         Hv3EZpVGuZe9/sKasB0ho/RReZr7fpaKqZS+97YM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24DA460264
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=c-hbandi@codeaurora.org
From:   Harish Bandi <c-hbandi@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        anubhavg@codeaurora.org, Harish Bandi <c-hbandi@codeaurora.org>
Subject: [PATCH v2 0/2] Enable Bluetooth functionality for wcn3998.
Date:   Fri,  8 Mar 2019 18:17:37 +0530
Message-Id: <1552049259-25429-1-git-send-email-c-hbandi@codeaurora.org>
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

