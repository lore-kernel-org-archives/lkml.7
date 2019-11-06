Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB7BC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12892173B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FKzoUri5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AVW/9z6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbfKFJsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:48:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34926 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfKFJsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:48:47 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6000B6034E; Wed,  6 Nov 2019 09:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573033724;
        bh=7Fa4KLGpuWu2XqKN6rBEyfcnXNTo3pjgBLUXrzJpO4Y=;
        h=From:To:Cc:Subject:Date:From;
        b=FKzoUri5y1JuV5tkAaj3bDKyMiyQvDSFcxHwSUc6Qje0rzBqQsu4bX8xOhwf9AhGi
         TyW+Fa7ND+FNBEtG06FZva1x18cyZ2o57laq3ZdKFg92Q7jpDQzdSEnVgKA7HgW11P
         +wCzjupCKae3YFzK5bdfp5RXMIMRV7P5C4EeX8YQ=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CBDAD6034E;
        Wed,  6 Nov 2019 09:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573033722;
        bh=7Fa4KLGpuWu2XqKN6rBEyfcnXNTo3pjgBLUXrzJpO4Y=;
        h=From:To:Cc:Subject:Date:From;
        b=AVW/9z6BcwUh7tIPNraDCQab6JNPor6J02YmTCYePSiHcJ92iFwKGEFwqblhQY0OC
         ySORoEs2T6TyYJ9S7cloe12q1k7s/WS4KUZnZAEAOvDNcHAwo7LAWGEZApZO9X7tcn
         LJ6nc86DE5Z2q9n/PyRIaI2zb625rvD4XwTbznow=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CBDAD6034E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        tientzu@chromium.org, seanpaul@chromium.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v2 0/2] Enable Bluetooth functionality for WCN3991
Date:   Wed,  6 Nov 2019 15:18:30 +0530
Message-Id: <20191106094832.482-1-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches enables Bluetooth functinalties for new Qualcomm
Bluetooth chip wnc3991. As this is latest chip with new features,
along with some common features to old chip "qcom,qcawcn3991-bt".
Major difference between old BT SoC's with WCN3991 is WCN3991 
will not send any VSE for the VSC instead is sends the data on CC
packet.

v2:
* updated review comments

Balakrishna Godavarthi (2):
  Bluetooth: btqca: Rename ROME specific variables to generic variables
  Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC WCN3991

 drivers/bluetooth/btqca.c   | 92 ++++++++++++++++++++++++++-----------
 drivers/bluetooth/btqca.h   | 32 +++++++------
 drivers/bluetooth/hci_qca.c | 16 ++++++-
 3 files changed, 97 insertions(+), 43 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

