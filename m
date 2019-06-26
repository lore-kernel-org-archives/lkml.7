Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96183C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B6D20663
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oIXF96R0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oIXF96R0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfFZIXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 04:23:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57578 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFZIXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 04:23:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D919A60A0A; Wed, 26 Jun 2019 08:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561537425;
        bh=RduO9xmvG3/0itXgBW05YQ0rOVZSvORHkd9+xMAZ6kg=;
        h=From:To:Cc:Subject:Date:From;
        b=oIXF96R00jZuxVf0qz4Wxd4KKlY0uxu2y5TqLZwTzypQyn5RCr8tV7RBP9ancTWcQ
         tYDTJOy6PR4d7V/SRd8sYIvGZVrUlYAUV7qgb2M+f6IqGB8hdkQ2+bzRSFTkW0g4YW
         rWA51XxAL3IZtAT4JvSwMjURLX4r/k5gfQN/2+OY=
Received: from amasule-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: amasule@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 989416019D;
        Wed, 26 Jun 2019 08:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561537425;
        bh=RduO9xmvG3/0itXgBW05YQ0rOVZSvORHkd9+xMAZ6kg=;
        h=From:To:Cc:Subject:Date:From;
        b=oIXF96R00jZuxVf0qz4Wxd4KKlY0uxu2y5TqLZwTzypQyn5RCr8tV7RBP9ancTWcQ
         tYDTJOy6PR4d7V/SRd8sYIvGZVrUlYAUV7qgb2M+f6IqGB8hdkQ2+bzRSFTkW0g4YW
         rWA51XxAL3IZtAT4JvSwMjURLX4r/k5gfQN/2+OY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 989416019D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=amasule@codeaurora.org
From:   Aniket Masule <amasule@codeaurora.org>
To:     linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, Aniket Masule <amasule@codeaurora.org>
Subject: [PATCH] media: venus: Update to bitrate based clock scaling
Date:   Wed, 26 Jun 2019 13:53:35 +0530
Message-Id: <1561537416-2067-1-git-send-email-amasule@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces bitrate based clock scaling. Also, clock scaling is now
triggered before buffer being queued to the device. This checks for frequency
requirement throughout the session and updates clock with correct frequency only
if requirement is changed.

Aniket Masule (1):
  media: venus: Update to bitrate based clock scaling

 drivers/media/platform/qcom/venus/core.c    | 16 +++++------
 drivers/media/platform/qcom/venus/core.h    |  1 +
 drivers/media/platform/qcom/venus/helpers.c | 43 +++++++++++++++++++++++++----
 3 files changed, 47 insertions(+), 13 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

