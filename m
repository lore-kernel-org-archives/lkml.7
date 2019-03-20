Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0569DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B0C2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LZfidXK5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EWU5gm68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfCTJti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:49:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50026 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfCTJth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:49:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A973360907; Wed, 20 Mar 2019 09:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553075375;
        bh=WUOnpQWVWKOF3RH2q4gUBD4xXGNGK8eEmbtT75FnkiI=;
        h=From:To:Cc:Subject:Date:From;
        b=LZfidXK5NwPDiA8RNA7mtoEIjRXsUVUdWxMepqroiylZd3ZmusRXSYw9mGwqH+dU1
         0EEX6t2OACiIVVJA+0RGtZKpWMwHonWIXouNVVHg6cSYNrBa0nlHQiUiyxUbzYc/Gb
         gGdlXIXTqimCTvcSHblzdaLUkqlPLv0l8Onp9Kwg=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 459E360312;
        Wed, 20 Mar 2019 09:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553075374;
        bh=WUOnpQWVWKOF3RH2q4gUBD4xXGNGK8eEmbtT75FnkiI=;
        h=From:To:Cc:Subject:Date:From;
        b=EWU5gm689kq3LU+tzlw343C2kmonPv4wYMzz0dd0Rs4wsGVYdNkOgnQNmVp6gYs99
         +9VS9hWkQ3jrCRSsuKaa1n9H4FQ6Am1eq4sRrw1KLUolr1dQldpXZHYNLH0799rehf
         fsMq+eh27ip08r5AUBlIzkInN0R7NO94bw6AiPJA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 459E360312
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-scsi@vger.kernel.org,
        swboyd@chromium.org, ulf.hansson@linaro.org,
        viresh.kumar@linaro.org, dianders@chromium.org, rafael@kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [RFC v2 00/11] DVFS in the OPP core
Date:   Wed, 20 Mar 2019 15:19:07 +0530
Message-Id: <20190320094918.20234-1-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a v2 of the RFC posted earlier by Stephen Boyd [1]

As part of v2 I still follow the same approach of dev_pm_opp_set_rate()
API using clk framework to round the frequency passed and making it
accept 0 as a valid frequency indicating the frequency isn't required
anymore. It just has a few more drivers converted to use this approach
like dsi/dpu and ufs.
ufs demonstrates the case of having to handle multiple power domains, one
of which is scalable.

The patches are based on 5.1-rc1 and depend on some ufs fixes I posted
earlier [2] and a DT patch to include the rpmpd header [3]

[1] https://lkml.org/lkml/2019/1/28/2086
[2] https://lkml.org/lkml/2019/3/8/70
[3] https://lkml.org/lkml/2019/3/20/120

Rajendra Nayak (10):
  OPP: Make dev_pm_opp_set_rate() with freq=0 as valid
  tty: serial: qcom_geni_serial: Use OPP API to set clk/perf state
  spi: spi-geni-qcom: Use OPP API to set clk/perf state
  arm64: dts: sdm845: Add OPP table for all qup devices
  scsi: ufs: Add support to manage multiple power domains in
    ufshcd-pltfrm
  scsi: ufs: Add support for specifying OPP tables in DT
  arm64: dts: sdm845: Add ufs opps and power-domains
  drm/msm/dpu: Use OPP API to set clk/perf state
  drm/msm: dsi: Use OPP API to set clk/perf state
  arm64: dts: sdm845: Add DSI and MDP OPP tables and power-domains

Stephen Boyd (1):
  OPP: Don't overwrite rounded clk rate

 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 194 +++++++++++++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c |   7 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |   9 +
 drivers/gpu/drm/msm/dsi/dsi.h                 |   2 +
 drivers/gpu/drm/msm/dsi/dsi_cfg.c             |   4 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c            |  88 +++++++-
 drivers/opp/core.c                            |  26 ++-
 drivers/scsi/ufs/ufshcd-pltfrm.c              |  52 ++++-
 drivers/scsi/ufs/ufshcd.c                     |  21 +-
 drivers/scsi/ufs/ufshcd.h                     |   3 +
 drivers/spi/spi-geni-qcom.c                   |  14 +-
 drivers/tty/serial/qcom_geni_serial.c         |  15 +-
 12 files changed, 406 insertions(+), 29 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

