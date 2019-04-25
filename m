Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF37C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08B4218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Hjsl2JcF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Hjsl2JcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbfDYMNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:13:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55778 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfDYMNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:13:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E1DE460790; Thu, 25 Apr 2019 12:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556194433;
        bh=xUiUZFGhDt5pQwMSFZX/Z8qWbJAU91u2+smb8LUX2aQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Hjsl2JcFsJGmwPMAdrBB0ddsVcWeieKFEYqQgl/v1zjqv6IGGp01Zrbe1VIE+5j6P
         NOAEHUfUwM6xIYgCfvb+VKADx4FeJQADJeltQD4zFDfKLkz0YnBjT87FNHDP7GSpiG
         MGW+N8j2MZj4LGgznG6hGUOTYuqUFEXvxFSbrkCQ=
Received: from c-hbandi-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: c-hbandi@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 458FC6034D;
        Thu, 25 Apr 2019 12:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556194433;
        bh=xUiUZFGhDt5pQwMSFZX/Z8qWbJAU91u2+smb8LUX2aQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Hjsl2JcFsJGmwPMAdrBB0ddsVcWeieKFEYqQgl/v1zjqv6IGGp01Zrbe1VIE+5j6P
         NOAEHUfUwM6xIYgCfvb+VKADx4FeJQADJeltQD4zFDfKLkz0YnBjT87FNHDP7GSpiG
         MGW+N8j2MZj4LGgznG6hGUOTYuqUFEXvxFSbrkCQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 458FC6034D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=c-hbandi@codeaurora.org
From:   Harish Bandi <c-hbandi@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        anubhavg@codeaurora.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        Harish Bandi <c-hbandi@codeaurora.org>
Subject: [PATCH v7 0/2] Enable Bluetooth functionality for WCN3998.
Date:   Thu, 25 Apr 2019 17:43:34 +0530
Message-Id: <1556194416-30842-1-git-send-email-c-hbandi@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series we add support for WCN3998 BT chip set. This new chip set
is based from the WCN3990 with minimal power numbers. So here in this patch
The major difference between wcn3990 and WCN3998 is only power numbers.
where as init process and fw download is same with wcn3990.
So we add new compatible for WCN3998. 
Removed the Reading of regulator values from dts.
Added new compatible for WCN3998.
Changes in V6:
Initialized rom_ver to 0 to fix compiler warning 
Changed Commit text for DT patch
Changes in V6:
changed return value to false in the qca_is_wcn399x()stub
Changes in V5:
changed is_qca_soc_type_wcn399x_family to
qca_is_wcn399x helper function 
Moved the qca_is_wcn399x function to btqca.c
modified the DT document for wcn399x as per driver code
Changes in V4:
Added is_qca_soc_type_wcn399x_family helper function 
to get the soc type is wcn399x or not.
Changes in V3:
updated to latest code base.

Harish Bandi (2):
  Bluetooth: hci_qca: Added support for WCN3998
  dt-bindings: net: bluetooth: Add device tree bindings for QTI chip
    WCN3998

 .../devicetree/bindings/net/qualcomm-bluetooth.txt |  5 +--
 drivers/bluetooth/btqca.c                          | 12 +++++--
 drivers/bluetooth/btqca.h                          |  8 ++++-
 drivers/bluetooth/hci_qca.c                        | 40 ++++++++++++++--------
 4 files changed, 45 insertions(+), 20 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

