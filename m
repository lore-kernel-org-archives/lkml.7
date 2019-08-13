Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A59BC32753
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F7A20663
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F+3YgV5i";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F+3YgV5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfHMIZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 04:25:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48640 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfHMIZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:25:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DB61A607DE; Tue, 13 Aug 2019 08:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565684740;
        bh=POHCskCBMH1ZdCeQ/s1wr7SV0EammuFdxrlrI4KWC7Y=;
        h=From:To:Cc:Subject:Date:From;
        b=F+3YgV5ieTKv1XlDc+0RfiorOfMs9Jmdg7l83A8gMSn9U/WiSNBOcj/08RHoIwMI9
         x6bBh7wpmImdlVlVllKNJ7cTvvmX7F8UvetSCNhPlL02lKBJpya1Zeudj2rXZ2IQFf
         On8BcVpcvGxB/ncL6TaPV22Qi1ffuFVocCqISdg0=
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A3F4E60709;
        Tue, 13 Aug 2019 08:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565684740;
        bh=POHCskCBMH1ZdCeQ/s1wr7SV0EammuFdxrlrI4KWC7Y=;
        h=From:To:Cc:Subject:Date:From;
        b=F+3YgV5ieTKv1XlDc+0RfiorOfMs9Jmdg7l83A8gMSn9U/WiSNBOcj/08RHoIwMI9
         x6bBh7wpmImdlVlVllKNJ7cTvvmX7F8UvetSCNhPlL02lKBJpya1Zeudj2rXZ2IQFf
         On8BcVpcvGxB/ncL6TaPV22Qi1ffuFVocCqISdg0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A3F4E60709
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     agross@kernel.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, swboyd@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org, ulf.hansson@linaro.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH 0/4] Add RSC power domain support
Date:   Tue, 13 Aug 2019 13:54:38 +0530
Message-Id: <20190813082442.25796-1-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resource State Coordinator (RSC) is responsible for powering off/lowering
the requirements from CPU subsystem for the associated hardware like buses,
clocks, and regulators when all CPUs and cluster is powered down.

RSC power domain uses last-man activities provided by genpd framework based on
Ulf Hansoon's patch series[1], when the cluster of CPUs enter deepest idle
states. As a part of domain poweroff, RSC can lower resource state requirements
by flushing the cached sleep and wake state votes for resources.

Dependencies:

[1] https://lkml.org/lkml/2019/5/13/839

Maulik Shah (4):
  drivers: qcom: rpmh: fix macro to accept NULL argument
  drivers: qcom: rpmh: remove rpmh_flush export
  dt-bindings: soc: qcom: Add RSC power domain specifier
  drivers: qcom: rpmh-rsc: Add RSC power domain support

 .../devicetree/bindings/soc/qcom/rpmh-rsc.txt |  7 ++
 drivers/soc/qcom/rpmh-internal.h              |  3 +
 drivers/soc/qcom/rpmh-rsc.c                   | 96 +++++++++++++++++++
 drivers/soc/qcom/rpmh.c                       | 22 ++---
 include/soc/qcom/rpmh.h                       |  5 -
 5 files changed, 116 insertions(+), 17 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.
