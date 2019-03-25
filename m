Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9736FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6078F2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="URpzP5+f";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nkh2ebKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbfCYLcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:32:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59264 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbfCYLcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:32:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 01CAE616B8; Mon, 25 Mar 2019 11:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553513522;
        bh=LttS5ksvw4WD9LXP4UxOJLuiqK3WZMHDyjYSUGG+Ygs=;
        h=From:To:Cc:Subject:Date:From;
        b=URpzP5+fyHY8xQxbtBiHTMBeh4i2btTIqosu0kZ2ctFc+Ic92itNLsPFCYdf0dyys
         yW/cJs/GYiFC0iRT/UDYgxL4CsaK3/KpyXbTcIl9clMpTZWgON/Qkhitx8shKVVXfS
         SrJ1Vrwh2wJSaEjRfQ3TwI6h113yFkz0OCT+TBR0=
Received: from c-hbandi-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: c-hbandi@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5BE7B616B8;
        Mon, 25 Mar 2019 11:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553513518;
        bh=LttS5ksvw4WD9LXP4UxOJLuiqK3WZMHDyjYSUGG+Ygs=;
        h=From:To:Cc:Subject:Date:From;
        b=nkh2ebKgrXY45Ug7f5iDubGjgIzuqod5oARwojhDl+Vz/9IRhyVH1JRHA68YojA2M
         W0CfDnH7Hjceil17unGh+sBaigTr9VbeZmGmpIrc1oJRgb1TSReMAwtsq+Af81X/u1
         fXHymL6TFW7WNaaKMdPcmFvSKSGD3HoIMS8N9EFE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5BE7B616B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=c-hbandi@codeaurora.org
From:   Harish Bandi <c-hbandi@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        anubhavg@codeaurora.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, obh+dt@kernel.org,
        Harish Bandi <c-hbandi@codeaurora.org>
Subject: [PATCH v4 0/2] Enable Bluetooth functionality for WCN3998.
Date:   Mon, 25 Mar 2019 17:01:29 +0530
Message-Id: <1553513491-25763-1-git-send-email-c-hbandi@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series we add support for WCN3998 BT chip set. This new chip set
is based from the WCN3990 with minimal power numbers. So here in this patch
The major difference between wcn3990 and WCN3998 is only power numbers. where
as init process and fw download is same with wcn3990.So we add new compatible 
for WCN3998. 
Removed the Reading of regulator values from dts.
Added new compatible for WCN3998. 
Changes in V4:
Added is_qca_soc_type_wcn399x_family helper function 
to get the soc type is wcn399x or not.
Changes in V3:
updated to latest code base.


Harish Bandi (2):
  Bluetooth: hci_qca: Added support for WCN3998
  dt-bindings: net: bluetooth: Add device tree bindings for QTI chip
    WCN3998

 .../devicetree/bindings/net/qualcomm-bluetooth.txt |  7 ++--
 drivers/bluetooth/btqca.c                          |  4 +-
 drivers/bluetooth/btqca.h                          |  3 +-
 drivers/bluetooth/hci_qca.c                        | 48 +++++++++++++++-------
 4 files changed, 42 insertions(+), 20 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

