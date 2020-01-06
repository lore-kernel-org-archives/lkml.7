Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC552C2D0D1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4E72072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="h0sRlpMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgAFKS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 05:18:58 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:26875 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726212AbgAFKS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 05:18:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578305937; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=rFGBZ87fosedu6QgWERjhftd9fNtWdiGCpLSWREmmQs=; b=h0sRlpMtzO6rgQ4AvRbw5E94VH1U/Lb3PtGUMxntVoEXC0/YkGaIKpbAnBB7Kfy6iV0YP0a8
 yImFdu1b+ZRyIeZjwTCtbTxIuERil9H6jXAUHHW7wcbfzBKGuaaaMS7QynG2LnNI0RgYRFzM
 VYeeDQ8eLtNOFdasZBUQtHR6+lE=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e130990.7f3279e67dc0-smtp-out-n03;
 Mon, 06 Jan 2020 10:18:56 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CD687C4479C; Mon,  6 Jan 2020 10:18:54 +0000 (UTC)
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6B8BFC43383;
        Mon,  6 Jan 2020 10:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6B8BFC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2 0/2] Add support for IPA clock for SC7180
Date:   Mon,  6 Jan 2020 15:48:41 +0530
Message-Id: <1578305923-29125-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[v2]
 * After register clk_hw::init is NULL, save off the name before registering.

[v1]
 * Support IPA clock for SC7180 and also handle undefined clock registration
   in clk-rpmh driver.

Taniya Das (2):
  clk: qcom: rpmh: skip undefined clocks when registering
  clk: qcom: rpmh: Add IPA clock for SC7180

 drivers/clk/qcom/clk-rpmh.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
