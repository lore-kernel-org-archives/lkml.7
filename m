Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691C9C4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 16:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365E2208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 16:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vB3Xtmqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407815AbfIUQ6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 12:58:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40807 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407792AbfIUQ6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 12:58:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so5572349pgj.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2019 09:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=q69Kv4s8NdbI7NNyGxPLpjBZIhyfFsGnwWZiB8RZWwo=;
        b=vB3Xtmqp22xIsej92uD7rfQHDIfaHKAMsoZqfQ2q8dyQnJHlAflnDdUXOMe+PsJbna
         okioIRakrgDGSOgub0SEh0r6noXIEehzdnXutxhOf4VsL986zIIck0RHIzYBRygb8ENq
         acj+KSB1oRU+QfUl7L2ZlhQ41gCURQzl4V0wiiWIbXJvBnFHxY9CdmnSLMcnW7IGLLgT
         yZDFVFE2iOYNVKDV/TS6L/9XWBKcBr7xqagUDNQNqzcAyP1nLAujv+Otlj13vfaHTX7g
         mdpDuaqVEODe77OebYibAFxdJBYR7SZcHBkllCnRriCZQuZgnpY884/+F5bJNO95ufo2
         C28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=q69Kv4s8NdbI7NNyGxPLpjBZIhyfFsGnwWZiB8RZWwo=;
        b=se4k85b61qeOHx1s+wz1iT/D/FVr/gni9bTuF+wx1GpIIqs1BULMHee+ex6UkmGUHd
         gBVj2BmMOg5T6CXn+SOwVwOM0kqsMQjniWCmvaG5NL8cz0W5jMKbgA4zSIwUGQG7GZt1
         Xx/tj3RS9FeqOPn2dDHSq0a347vTKNw5BhvMfl01Uk3sPSUB0GGYkRJ4gnzwlXfRq8yu
         EPfAgZ9doe3dPepKz4SX7pitmGpKwljzblg6Kf5ORyvKhDx1z+t37TKC1dcX1d7ifCrq
         7sAfXJXH5xQLwNadWXOqIBDu9r0qH24tdBenwPZ0LMWxA1K6G7KWfEEK0a2I99wM6yiT
         NKkA==
X-Gm-Message-State: APjAAAW5ml2bls3ChOOsVxIkcfdUNxoOUjL+TbMwkCM5vaC2qns5akqW
        3BDr8YhgThFgSZRA+i9J4lMnry1kUU0=
X-Google-Smtp-Source: APXvYqwQPsLb3MLTmsb026IX+IZkqAVLtMHNy+kmWtQQyb/2p/fmJ12W753iNAi9Oe8BIWe2G3xjeA==
X-Received: by 2002:a17:90a:5aa1:: with SMTP id n30mr10959977pji.82.1569085128882;
        Sat, 21 Sep 2019 09:58:48 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 16sm7362155pfn.35.2019.09.21.09.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 09:58:48 -0700 (PDT)
Date:   Sat, 21 Sep 2019 09:58:45 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>, Suman Anna <s-anna@ti.com>
Subject: [GIT PULL] remoteproc updates for v5.4
Message-ID: <20190921165845.GA6693@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I've finally moved my trees to kernel.org, please pull this and the
coming rpmsg request from their new location.

Regards,
Bjorn

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc tags/rproc-v5.4

for you to fetch changes up to 150997fac770c37b12459ec52fdf67a5dc1366f5:

  MAINTAINERS: remoteproc: update git tree location (2019-08-26 23:16:44 -0700)

----------------------------------------------------------------
remoteproc updates for v5.4

This exposes the remoteproc's name in sysfs, allows stm32 to enter
platform standby and provides bug fixes for stm32 and Qualcomm's modem
remoteproc drivers. Finally it updates MAINTAINERS to reflect the move
to kernel.org.

----------------------------------------------------------------
Bjorn Andersson (2):
      remoteproc: qcom: Move glink_ssr notification after stop
      MAINTAINERS: remoteproc: update git tree location

Fabien Dessenne (2):
      remoteproc: stm32: clear MCU PDDS at firmware start
      remoteproc: stm32: manage the get_irq probe defer case

Sibi Sankar (1):
      remoteproc: qcom: q6v5-mss: fixup q6v5_pds_enable error handling

Stephen Boyd (1):
      remoteproc: Remove dev_err() usage after platform_get_irq()

Suman Anna (1):
      remoteproc: Add a sysfs interface for name

 Documentation/ABI/testing/sysfs-class-remoteproc | 10 +++++++
 MAINTAINERS                                      |  2 +-
 drivers/remoteproc/da8xx_remoteproc.c            |  4 +--
 drivers/remoteproc/keystone_remoteproc.c         |  4 ---
 drivers/remoteproc/qcom_common.c                 |  4 +--
 drivers/remoteproc/qcom_q6v5.c                   | 35 ++++--------------------
 drivers/remoteproc/qcom_q6v5_mss.c               |  4 +--
 drivers/remoteproc/remoteproc_sysfs.c            | 11 ++++++++
 drivers/remoteproc/stm32_rproc.c                 | 14 ++++++++++
 9 files changed, 46 insertions(+), 42 deletions(-)
