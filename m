Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296D1C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 15:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A1621874
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 15:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nVdc0orh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S/fZescN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfHXPLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 11:11:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46534 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfHXPLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 11:11:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0D2DA60740; Sat, 24 Aug 2019 15:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566659495;
        bh=pXOJr5ShE7iOEk7J667xinG+FyP4FlLtYOC8UYtWXC8=;
        h=From:To:Cc:Subject:Date:From;
        b=nVdc0orhuJIiGEOzepDV8sxvAaB+kYoTDmNxWL6DXXeU+hG43oAoHk2BIcsOi5QVA
         nakGLQXIEa1eVR5GR/nsNZ5h1RedJxlQVIM8GAK08Xy5gGIomGYNO5V9ukTCfUNonx
         6uTB2RLKLgX9f/iTVkCYFWk6v3Mwn0YQjmpDZL3I=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A4415608CC;
        Sat, 24 Aug 2019 15:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566659494;
        bh=pXOJr5ShE7iOEk7J667xinG+FyP4FlLtYOC8UYtWXC8=;
        h=From:To:Cc:Subject:Date:From;
        b=S/fZescN+LEyxiCPTAoVge6k5txiOoJPWTdQ3sxUb8Cf34uxeDfb8B1jDdO7D5wd7
         fSb8BEUabz8Ik0FFr/tAL3WRho0QzNd2Nx7Y3caKFis8F7FrmTIFESOEsndzpDQ+IX
         2RuFN2KT6oCUbjB35tVB+CR27BKHsgKiFEkLUFlQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A4415608CC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        bjorn.andersson@linaro.org
Cc:     agross@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 0/2] Add PDC Global and AOSS reset support
Date:   Sat, 24 Aug 2019 20:41:15 +0530
Message-Id: <20190824151117.18906-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds PDC Global and AOSS reset support on SC7180 SoCs.

v2:
 * Addressed Philipp's review comments

Sibi Sankar (2):
  dt-bindings: reset: aoss: Add AOSS reset binding for SC7180 SoCs
  dt-bindings: reset: pdc: Add PDC Global binding for SC7180 SoCs

 Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt | 4 ++--
 Documentation/devicetree/bindings/reset/qcom,pdc-global.txt | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

