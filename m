Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F43AC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3861C20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X8jAVk52";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mvjviy2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfCGMRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:17:12 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58900 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCGMRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:17:11 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 33ABC6028D; Thu,  7 Mar 2019 12:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551961031;
        bh=I0OYafYW2t5EUHcmHWJ/LQyiRzfz1b14JHSHEOR7xzo=;
        h=From:To:Cc:Subject:Date:From;
        b=X8jAVk52HB4RDNnOfBEOT4hoYwyd+fc3CasyQxLxht0jaq0aec640e8EeHOd6rXYz
         /199p1BgazVkm2DM9XdJJ+KoG7jsBAGbQvO84CWKEaEQcnOhonqJKEGgu1gzoadzxr
         YtxZdJw2RtApEJKtLCew43bre0OrUSUFLdomxcn4=
Received: from c-hbandi-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: c-hbandi@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 709E060264;
        Thu,  7 Mar 2019 12:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551961030;
        bh=I0OYafYW2t5EUHcmHWJ/LQyiRzfz1b14JHSHEOR7xzo=;
        h=From:To:Cc:Subject:Date:From;
        b=Mvjviy2qcWREW/89zH3CG1QcwxNIfbkosantWISfLbOwd+ogmzg1wlBBIxBdnvaQG
         nCLgt37sh1GvY0wPKl9ofI2vRUu1X7t9YLq00cEwGO0kedIM5kojwdTTwyb0Xi7Mua
         wHeYHOSGaww6K5TBggXJrZGEbrHyGXmo0ocWXVXE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 709E060264
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=c-hbandi@codeaurora.org
From:   Harish Bandi <c-hbandi@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        anubhavg@codeaurora.org, Harish Bandi <c-hbandi@codeaurora.org>
Subject: [PATCH v1 0/2] Enable Bluetooth functionality for wcn3998. 
Date:   Thu,  7 Mar 2019 17:46:50 +0530
Message-Id: <1551961012-23898-1-git-send-email-c-hbandi@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series we add support for wcn3998 BT chip set. This new chipset
is based from the wcn3990 with minimal power numbers. So here in this patch
The major difference between wcn3990 and wcn3998 is only power numbers. where
as init process and fw download is same with wcn3990.So we are leveraging the 
existing code of wcn3990 along with readiing the voltages from the dts file. 


Harish Bandi (2):
  Bluetooth: hci_qca: Added support to read the regulator values from
    DTS
  dt-bindings: net: bluetooth: Add device tree bindings for QTI chip
    wcn3990

 .../devicetree/bindings/net/qualcomm-bluetooth.txt | 12 ++++
 drivers/bluetooth/hci_qca.c                        | 76 +++++++++++++++++++---
 2 files changed, 80 insertions(+), 8 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

