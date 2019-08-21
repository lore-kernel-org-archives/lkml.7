Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B816C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EF6233FE
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dQsp2Dw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfHUJIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 05:08:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44985 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfHUJIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:08:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id c81so1002456pfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 02:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=EpNyefDvziRpVKagmeTe6/DY7qk9smhH+f//3Sqbad0=;
        b=dQsp2Dw2bertAm4zumWxD9PMW6WBKigYQx9sgBL6jxtTVSIeEX98WKxQ4hPjNdkb2N
         CbtwwheE9joXr/a2e/xg0CdTt5ZlfsecT3J+FeeXP2a6QonRnp4J1RMPMrjm8ZSPLeHh
         nYeuIctAUIbJEK3C1IXTrvE+IyNiEAiY0AjVPHcIWeSpUKLfCv2NlRGsdRLxl3myZHeu
         qT65RPXcM+C+1ne4IF0+faAgxnpLc4zVbjnlvsQOSlY99IiFSSYFwbJjnelaFdISbU8s
         gzaIljkMD/hnJGPTEuJouI835NBnLV+7WXsfuNgZAPd8OFpJILPEVTCiQLazw19YNpPB
         S49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=EpNyefDvziRpVKagmeTe6/DY7qk9smhH+f//3Sqbad0=;
        b=TaucuSanhx1PgtqBGveGRygpbk0klkkBMRdqqQibcpFWvb/S6RcFFk9q2W1UF8U8QE
         S6gfshJAIhmvQu2k8nPF/v4OfMC5l+UJa5lvVtrX/zysSdOFj7LqPpZJfgJUTE/+FQ4I
         yFiboTKVoIJkXbJ9C83Glku4Oqgv7l5XNACPzxmgGEYGonWz42w8maB0HSFUrhPs31y5
         mci4r7whfb1CFoOjzLXLYGxJAKWcjMHblFP29pFKkfM82mThIcpq3imbcJdnpoPvVKOq
         +Ag9wgVO00+snenqJbBWCW6gC6RpG6cLzMdAQ7kyFJeWnsSp6Gzu2dyaFCKO2K5cQI4A
         p7/w==
X-Gm-Message-State: APjAAAVFpNBiUcRZvHX2fhhA3WtMJFMxeNocN2vFQ9IAQW6C6DPYFTzL
        xKoAeKkwnU6D04ebpr+M9BLA2gVSwocShg==
X-Google-Smtp-Source: APXvYqyKArjR2xo71GWtZw1TUowFuYt0l6yVGhFp4LeYfdoCxutYVSWM6jVKK2L6RPGuOF5l6U4+1g==
X-Received: by 2002:aa7:8602:: with SMTP id p2mr34278306pfn.138.1566378518653;
        Wed, 21 Aug 2019 02:08:38 -0700 (PDT)
Received: from localhost ([114.143.126.83])
        by smtp.gmail.com with ESMTPSA id x128sm39525090pfd.52.2019.08.21.02.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 02:08:37 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add Amit Kucheria as reviewer for thermal
Date:   Wed, 21 Aug 2019 14:38:31 +0530
Message-Id: <dc11c8ac0892ac14f4fe66ed5336bf32d26e27c9.1566377984.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566377984.git.amit.kucheria@linaro.org>
References: <cover.1566377984.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Amit Kucheria as the reviewer for thermal as he would like to
participate in the review process effort for the thermal framework.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
Hi thermal maintainers, I'd like to help out with reviewing patches to the
thermal framework. I respectfully submit this patch for you to consider
adding me to the MAINTAINERS file as a reviewer so I get cc'ed on the
patches.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e81e60bd7c26..75c510270eb2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15896,6 +15896,7 @@ THERMAL
 M:	Zhang Rui <rui.zhang@intel.com>
 M:	Eduardo Valentin <edubezval@gmail.com>
 R:	Daniel Lezcano <daniel.lezcano@linaro.org>
+R:	Amit Kucheria <amit.kucheria@verdurent.com>
 L:	linux-pm@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
-- 
2.17.1

