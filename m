Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC080C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C3E2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u0DPpaMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfDLMC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:02:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37094 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfDLMC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:02:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id v13so8630722ljk.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 05:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=12VMu59lJ1sUl6kgJT2+jOCBU1bkwPvTr+0cClVY4oQ=;
        b=u0DPpaMDExB3qhxXWbZWGNOIt418aF+tuA1SKEvxSiiQIeAW0Yu/XQ6zwxeyrd2zHE
         IJ1y+Z91xCL1iN/jCVXr/bCweB/QKcZ8hUxuccrNQ9wXLEGK1IMeKeLdOOSQFxb+2AvU
         ulNDJbf1Qpcz7Bs8HT48hOlGg5X3Xt722P+BUK7kbKNgstcMeR2uII25LtndSLbkdsfa
         OMqqP11rDfWo0ifRQNDs6ds8ZX5ttf/DRXlC+GslxZz6bPke5rPW31xAbs7HZ2fL5UrA
         unUPPPaz/2korKCBGNJmODHcsjdsR5jdIe0+RD2pkGjniiqWWuesmfGpq43qaLtuOZeR
         Eh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=12VMu59lJ1sUl6kgJT2+jOCBU1bkwPvTr+0cClVY4oQ=;
        b=ie2e2ue15xK+OS/dO3SH4qZKMSGUYkDv5smYp7wd7TC9x94bw+7slHkKfFaWiRClh+
         /yIshfrepYrdFKSNEu4ryInhzuAEoLqaCMJWkx6QKL18LdTx4LclygHCmIlFwihnjl3F
         REtmzrUpQC103BSjj8YNheJ+ChfYk+jHk839Jqy1GYtOZ+t2qnHiOFG7jbI7KL6S72C4
         ohxlvHuycMbUpwYWbSpy9w27eUSAyvYismGD3XIntnPw1Yfa8H0KwTZBCqBDjPkaScEH
         btfBuiM6Tr3aW0NcukP3+wkHlm0ZyxaJH/YLMvqYqmXP9VFICKqdoOnBoAJmMBnkthBo
         hRkQ==
X-Gm-Message-State: APjAAAWtM67jVgJVHEHvnTnQftaOiM6uw6Jzu8CBO9mXJGkRkq/euviP
        g+9pmEHTU3Mk59Unl9i1e5uShDITj6s=
X-Google-Smtp-Source: APXvYqy8REyC/82YB5OVQTrr4HXvhyThCFYWtVRsy9IFGwVgpEmEZXsAFX3JjPY2wcpj4sasOS+2bQ==
X-Received: by 2002:a2e:8693:: with SMTP id l19mr29647321lji.47.1555070574041;
        Fri, 12 Apr 2019 05:02:54 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id f25sm7549807lfk.69.2019.04.12.05.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 05:02:53 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.1-rc5
Date:   Fri, 12 Apr 2019 14:02:52 +0200
Message-Id: <20190412120252.3704-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.1-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.1-rc2

for you to fetch changes up to 5c41ea6d52003b5bc77c2a82fd5ca7d480237d89:

  mmc: sdhci-omap: Don't finish_mrq() on a command error during tuning (2019-04-11 12:40:32 +0200)

----------------------------------------------------------------
MMC host:
 - alcor: Stabilize data write requests
 - sdhci-omap: Fix command error path during tuning

----------------------------------------------------------------
Daniel Drake (1):
      mmc: alcor: don't write data before command has completed

Faiz Abbas (1):
      mmc: sdhci-omap: Don't finish_mrq() on a command error during tuning

 drivers/mmc/host/alcor.c      | 34 +++++++++++++---------------------
 drivers/mmc/host/sdhci-omap.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 21 deletions(-)
