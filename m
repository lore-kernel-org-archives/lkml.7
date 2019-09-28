Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6A9C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 01:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D8C20869
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 01:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N32Lfa0Y";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O0L0ahWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfI1B3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 21:29:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43308 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfI1B27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 21:28:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 038616155F; Sat, 28 Sep 2019 01:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569634139;
        bh=kbPZarCkYnlJWtdPyEyjjRJbhqhbOcPRYQvgulMnMvY=;
        h=From:To:Cc:Subject:Date:From;
        b=N32Lfa0Y7LRi1uThRZ/7c7Srgdep5Yoos4XJTzy0HAf6KIJ6e3Z1rvkyBr7Y7eVSP
         ONpxLfF0k7bgoBP/KYW9kY8Eg98kzae7Fev+Fox6QzpolRzscKxf7a3MbcgTEoMczB
         mWcqbSwhxAKS6yka4vmpKMXEns8jmOVQYlaMrSgk=
Received: from jeykumar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jsanka@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DECE9611DC;
        Sat, 28 Sep 2019 01:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569634138;
        bh=kbPZarCkYnlJWtdPyEyjjRJbhqhbOcPRYQvgulMnMvY=;
        h=From:To:Cc:Subject:Date:From;
        b=O0L0ahWkKvLy6IZGm3VGL/RvsTxlYN41OBCib2zthF35LJ6AufeCnvVlpxMKsSCVf
         9CSQ1/1pRUq23Z+PTxErUhLG/+BKtAZzcyUhPH/aOJv58t5L7uBgPeAIM1wKeMZXVz
         Tf8JQDuMvPwoa/7EcEPHvZ3E5yKHNcTQbzDtCtO8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DECE9611DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jsanka@codeaurora.org
From:   Jeykumar Sankaran <jsanka@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Jeykumar Sankaran <jsanka@codeaurora.org>, narmstrong@baylibre.com,
        seanpaul@chromium.org, robdclark@gmail.com, jcrouse@codeaurora.org
Subject: [PATCH] Add framebuffer max width/height fields to drm_mode_config
Date:   Fri, 27 Sep 2019 18:28:50 -0700
Message-Id: <1569634131-13875-1-git-send-email-jsanka@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below two discussion threads will provide the context behind this patch.

https://www.spinics.net/lists/dri-devel/msg229070.html
https://lore.kernel.org/linux-arm-msm/db26145b-3f64-a334-f698-76f972332881@baylibre.com/T/

Seperating out the core framework patch from vendor implementation.

Jeykumar Sankaran (1):
  drm: add fb max width/height fields to drm_mode_config

 drivers/gpu/drm/drm_framebuffer.c | 17 +++++++++++++----
 include/drm/drm_mode_config.h     |  3 +++
 2 files changed, 16 insertions(+), 4 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

