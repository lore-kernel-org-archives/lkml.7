Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C06FC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424932175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g4/yUE4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390373AbfEXKKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:10:32 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:34883 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390106AbfEXKKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:10:32 -0400
Received: by mail-lf1-f46.google.com with SMTP id c17so6718394lfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 03:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=U7NqsxduTML6ThIFJ1X4Tao09DbCTx/kKKXM/580o5s=;
        b=g4/yUE4WonYVCbkWisUPSccD4AJiku3DsU0RiKPahQsT6OMSzbBpEj5OVfAT6vBFkn
         th6D2L8a965TkJ029h18S1Q47fEiVyKDuNSvAWldiw5q05urr60w4O5ELID8hVuqxWqI
         yJlLTMitbQPkOmv/gOkz6rN4f3jDvKdjU+GCBlyDNVPwdNm12F5NOoSr0fpeC2ybdJ2p
         m7/oO/5DYILVA7G0z3YcMDHHfzYHy3hC4/fgOONIvmgZfhLFfZXAaQgxUBd/gpTT6mNW
         GcDl+HNOloU1L+0U27+Fv1s0QD2Jr2ABykxVwMD2GHUhsGABkuXKeXvhqAKzZwnxTrZe
         7EPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U7NqsxduTML6ThIFJ1X4Tao09DbCTx/kKKXM/580o5s=;
        b=MMPf1sf/y/ushZhJYFv89l2pRG8ZG0b2jRosgvZxtNE2610dXzofvaBFn7PsOlaQdq
         jT7wutohle58xXkffuueygkDMxfBtbMwOaut+S3ijo8O9ck4PVyc91T4K2NoWqn3OyQU
         V503FJvMuMD3Wbl76iqmm/VmjcrIeDoF6NsiP2LA1CqtgQAMXqYHVKetHxtU0mkrjy5l
         /FEElQMQk9ckbcFj1VlIqOp61RrBgh915ll4I1g+8f3u/32hCr1CTfkYSrRLPF4qMT8c
         6jbpmFim/t2abGA6Uq3sfEQujKSgPD3SsACIW8Fy+60TuZ7zIKEqgE/SuI81GZHn6kW2
         Uzvw==
X-Gm-Message-State: APjAAAVqhOlA/p8I2mibgFjpG9pw5GOCPb3okNpsvZl/UTrGjC9H8CGN
        3+V++KCi/MDy3oiB1lJmz7XK4A==
X-Google-Smtp-Source: APXvYqxvf6E0mCnGnszFgr+tBQ1HPjaojk79rtWJhiZQ13Faw3GR3gBLcdPftYjpFym3Vk0p27RqOA==
X-Received: by 2002:ac2:510e:: with SMTP id q14mr9879286lfb.135.1558692630306;
        Fri, 24 May 2019 03:10:30 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id a10sm302945lfi.9.2019.05.24.03.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 03:10:29 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.2-rc2
Date:   Fri, 24 May 2019 12:10:28 +0200
Message-Id: <20190524101028.8158-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a few MMC fixes intended for v5.2-rc2. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 5ac94332248ee017964ba368cdda4ce647e3aba7:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2019-05-14 20:56:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.2-2

for you to fetch changes up to ec0970e0a1b2c807c908d459641a9f9a1be3e130:

  mmc: sdhci-iproc: Set NO_HISPD bit to fix HS50 data hold time problem (2019-05-15 13:52:05 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-iproc: Fix HS50 data hold time problem for a few variants

----------------------------------------------------------------
Trac Hoang (2):
      mmc: sdhci-iproc: cygnus: Set NO_HISPD bit to fix HS50 data hold time problem
      mmc: sdhci-iproc: Set NO_HISPD bit to fix HS50 data hold time problem

 drivers/mmc/host/sdhci-iproc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
