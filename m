Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45339C2D0C8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 17:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD0821D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 17:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="XkdlJ1QF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfLTRUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:20:39 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:36976 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727402AbfLTRUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 12:20:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576862437; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=8lb7u4pIqzZCjWOLka6953ykRh2XMMlgiHAM4lzleUg=; b=XkdlJ1QFwdukWFrjBFcs2qB30RNRPBy9L8s8YzfThjYAOg7PVRsGPg0EI/k7uJyXfdQgg70A
 nMxMSXvBiPtrb0+FUoCeMZv2JuwYlpAW2+NPChQyEMzVERz5c8OxHqIOihPEKsLn/Q5fElgm
 QFa1UNw715gu8kpXDmOeSHNqyHM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfd02e3.7fee557c9298-smtp-out-n01;
 Fri, 20 Dec 2019 17:20:35 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A9491C4479D; Fri, 20 Dec 2019 17:20:34 +0000 (UTC)
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC432C43383;
        Fri, 20 Dec 2019 17:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC432C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, srinivas.kandagatla@linaro.org,
        robh+dt@kernel.org, tsoni@codeaurora.org
Cc:     agross@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 0/3] Introduce Protection Domain Restart (PDR) Helpers
Date:   Fri, 20 Dec 2019 22:50:16 +0530
Message-Id: <20191220172019.11774-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm SoCs (starting with MSM8998) allow for multiple protection
domains (PDs) to run on the same Q6 sub-system. This allows for
services like AVS AUDIO to have their own separate address space and
crash/recover without disrupting the other PDs running on the same Q6
ADSP. This patch series introduces pdr helper library and adds PD
tracking functionality for "avs/audio" allowing apr services to register
themselves asynchronously once the dependent PDs are up.

V2:
 * fixup pd_status callback to return void.
 * return 0 from pdr_get_domain_list on success.
 * introduce status_lock to linearize the pd_status reported back
   to the clients.
 * use the correct service name length across various string operations
   performed.
 * service locator will now schedule the pending lookups registered
   when it comes up.
 * other minor cleanups that Bjorn suggested.
 * use pr_warn to indicate that the wait for service locator timed
   out.
 * add Bjorn/Srini's "Reviewed-by" for the dt-bindings.

To Do:
 * Add support for pd tracking in fastrpc driver.

Sibi Sankar (3):
  soc: qcom: Introduce Protection Domain Restart helpers
  dt-bindings: soc: qcom: apr: Add protection domain bindings
  soc: qcom: apr: Add avs/audio tracking functionality

 .../devicetree/bindings/soc/qcom/qcom,apr.txt |  59 ++
 drivers/soc/qcom/Kconfig                      |   6 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/apr.c                        | 100 ++-
 drivers/soc/qcom/pdr_interface.c              | 691 ++++++++++++++++++
 drivers/soc/qcom/pdr_internal.h               | 375 ++++++++++
 include/linux/soc/qcom/apr.h                  |   1 +
 include/linux/soc/qcom/pdr.h                  | 105 +++
 include/linux/soc/qcom/qmi.h                  |   1 +
 9 files changed, 1328 insertions(+), 11 deletions(-)
 create mode 100644 drivers/soc/qcom/pdr_interface.c
 create mode 100644 drivers/soc/qcom/pdr_internal.h
 create mode 100644 include/linux/soc/qcom/pdr.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
