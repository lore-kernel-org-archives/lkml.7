Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F27C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 01:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1560520869
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 01:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZgJNyfhI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SYpMtrN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfI1Bbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 21:31:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46006 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfI1Bbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 21:31:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D6FC16122D; Sat, 28 Sep 2019 01:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569634300;
        bh=kbPZarCkYnlJWtdPyEyjjRJbhqhbOcPRYQvgulMnMvY=;
        h=From:To:Cc:Subject:Date:From;
        b=ZgJNyfhIufwD3ROwcVCGbYxttuM5nM6lIoZe9MncugIXtcVz04XorYzet1E9Em4+A
         mtZSqV8zY3KhwkJfIOiI/SNuqW0+2vj5jj9uPRxHHjXQZPtvxAwh5tsYC2RpPBH2z9
         8nm36lFaoSbgtRP5iESRK3Sy3fPCONXVir69uRnw=
Received: from jeykumar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jsanka@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 24380611CE;
        Sat, 28 Sep 2019 01:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569634298;
        bh=kbPZarCkYnlJWtdPyEyjjRJbhqhbOcPRYQvgulMnMvY=;
        h=From:To:Cc:Subject:Date:From;
        b=SYpMtrN3M8ycqPoCelDO5aK2Q6TAcF5bObmiS0aMtEXE+Sv//8nX6DwCBY2W9WXSi
         ndSDxBHXZx1Rw+njpIVpwQWbFUB7ta8mrPmFlomSJhNizLLYt2Fi2liS6KdE95MtCP
         dPYQAEtZG/zAwSbtRENgFDo4/OrOU2f7St0XqpJE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24380611CE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jsanka@codeaurora.org
From:   Jeykumar Sankaran <jsanka@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Jeykumar Sankaran <jsanka@codeaurora.org>, narmstrong@baylibre.com,
        seanpaul@chromium.org, robdclark@gmail.com, jcrouse@codeaurora.org
Subject: [PATCH] Add framebuffer max width/height fields to drm_mode_config
Date:   Fri, 27 Sep 2019 18:31:23 -0700
Message-Id: <1569634284-14147-1-git-send-email-jsanka@codeaurora.org>
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

