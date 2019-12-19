Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D27BC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 05:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6FC2072B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 05:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="wWMYbG/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfLSFpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 00:45:25 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:20767 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbfLSFpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 00:45:25 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576734324; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=x6DO8XFiQIG79wBQeDvjsylUmPKRxCL8a0jiGOwzMNc=; b=wWMYbG/ZLde+PXWIEz/w7mgfZc5nYLpfzaw1/pXZTjOKnk534S2dgsLQ8aDUQIXO4riZWAxh
 wETbu5dKfdoBZXZesst57CK8oBrO/QMrx9CCwi8HXhhf8B+rmLn0h5ehDha/ePRryWOk6QnH
 GV4pzM1n8pb4bKi21OOjzk4HdXI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfb0e73.7f4943671730-smtp-out-n02;
 Thu, 19 Dec 2019 05:45:23 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C5EC8C48B01; Thu, 19 Dec 2019 05:45:23 +0000 (UTC)
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D5CA0C2BB93;
        Thu, 19 Dec 2019 05:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5CA0C2BB93
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org
Cc:     ohad@wizery.com, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 0/2] Add Modem support on SC7180 SoCs
Date:   Thu, 19 Dec 2019 11:15:04 +0530
Message-Id: <20191219054506.20565-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for booting the Modem Q6 DSP found in
Qualcomm's SC7180 SoCs.

V2:
 * split the series according to SoC
 * Duplicate code across q6v5proc_reset
 * add Rob's 'Reviewed-by' tag

Sibi Sankar (2):
  dt-bindings: remoteproc: qcom: Add Q6V5 Modem PIL binding for SC7180
  remoteproc: mss: q6v5-mss: Add modem support on SC7180

 .../bindings/remoteproc/qcom,q6v5.txt         |  23 +-
 drivers/remoteproc/qcom_q6v5_mss.c            | 199 +++++++++++++++++-
 2 files changed, 219 insertions(+), 3 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
