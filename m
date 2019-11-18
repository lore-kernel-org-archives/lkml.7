Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C85C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94F72186D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fsOlXwR0";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="YW7Hz7sU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfKRRkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:40:01 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:60286
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbfKRRkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574098800;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=khVJICny1VLj8QPoA556rE5CnWL4G2e7chj6ZTnXkI0=;
        b=fsOlXwR0cumbQ+z2QtGIaQ40zOTjxDCNlSVYMleUQIo9auVnYPpT78M1IPl5BcPW
        ko0oz9LFnsgyMGK/ftzm1COCuQBEpUwP/ccLyV2iN8EuQ2eQQEtHXbnIvL181hWAKqL
        kCb+v1qahO0bRox44YAE44ktseddRPhnA5UjME2I=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574098799;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=khVJICny1VLj8QPoA556rE5CnWL4G2e7chj6ZTnXkI0=;
        b=YW7Hz7sUZZcN6i5q8HKa6A4we20bO/glkOSAVkNK3RZfPyujWrEWs1nPPt1/+j8M
        vhJz1pzKxpNjm5qoeG1FpaeEkO+LFuoveOSczF6JVla0pPeb1bSWHCRWPJiWtn7g1H7
        kh4U4HYvcF/Sr4Ti+gO/bKkfRQkIAQBHm0zALRUE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7AC15C447A0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        ulf.hansson@linaro.org, rnayak@codeaurora.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mark.rutland@arm.com, swboyd@chromium.org, dianders@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 0/6] Add power-domain support for SC7180/SM8150 SoCs
Date:   Mon, 18 Nov 2019 17:39:59 +0000
Message-ID: <0101016e7f998be8-c2b4de92-4b3b-475b-bdd2-742dd18e1d4a-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.11.18-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds power-domain support for SC7180 and SM8150 SoCs.

Douglas Anderson (1):
  soc: qcom: rpmhpd: Set 'active_only' for active only power domains

Sibi Sankar (5):
  dt-bindings: power: Add rpmh power-domain bindings for SM8150
  soc: qcom: rpmhpd: Add SM8150 RPMH power-domains
  dt-bindings: power: Add rpmh power-domain bindings for sc7180
  soc: qcom: rpmhpd: Add SC7180 RPMH power-domains
  arm64: dts: sm8150: Add rpmh power-domain node

 .../devicetree/bindings/power/qcom,rpmpd.txt  |  2 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi          | 55 ++++++++++++++++++
 drivers/soc/qcom/rpmhpd.c                     | 57 +++++++++++++++++++
 include/dt-bindings/power/qcom-rpmpd.h        | 24 ++++++++
 4 files changed, 138 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

