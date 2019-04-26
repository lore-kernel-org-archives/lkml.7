Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FF4C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80671206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FANkGDq+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Jtxa8+qm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfDZN4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:56:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48042 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDZN4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:56:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 656E060740; Fri, 26 Apr 2019 13:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556286977;
        bh=vMZtQQrNnpP3ZZgOlaTOzP2ktUm86CkX7Vw+DEpBXHM=;
        h=From:To:Cc:Subject:Date:From;
        b=FANkGDq+4yZE38ssITz8togwHuxxz7mx5eT/YSnAiVFcmDyFh6KuXwDRZFmAny4RP
         QF9tVerOJdFKOtWWzZ+vBmXDttTwa5dlWxB9330OmbQsWRpm89kXMyCndI8BEzYGRS
         E9ZCPZEIwd3itu1IymwCyX4VW4XOZCGSrU7V8w2k=
Received: from c-hbandi-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: c-hbandi@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BABC56049C;
        Fri, 26 Apr 2019 13:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556286976;
        bh=vMZtQQrNnpP3ZZgOlaTOzP2ktUm86CkX7Vw+DEpBXHM=;
        h=From:To:Cc:Subject:Date:From;
        b=Jtxa8+qmcJtpQrCcq+LINx3fHMiA6UlagAuaSJHBXbIsE1d4PqVjBbZKdyXQYOP/Q
         EvSPKE0vxbGzQE+9NICkOK8WUXAGugC1L07Q44eD3OE31S8WqGJuPWujwKnE++sS9K
         grklj9mGi1tVXrAa3kxzj7S9CwMQHKQZ7LDkeaP0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BABC56049C
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
Subject: [PATCH v8 0/2] Enable Bluetooth functionality for WCN3998.
Date:   Fri, 26 Apr 2019 19:26:00 +0530
Message-Id: <1556286962-3132-1-git-send-email-c-hbandi@codeaurora.org>
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
Changes in V8:
Removed export of qca_is_wcn399x() and added as inline function
Added robh reviewed by tag in commit text
Changes in V7:
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
 drivers/bluetooth/btqca.c                          |  7 ++--
 drivers/bluetooth/btqca.h                          | 11 +++++-
 drivers/bluetooth/hci_qca.c                        | 40 ++++++++++++++--------
 4 files changed, 43 insertions(+), 20 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

