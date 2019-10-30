Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2402CCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62CB2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oo64KFyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfJ3PPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:15:00 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:44914 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfJ3PO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:14:58 -0400
Received: by mail-qt1-f201.google.com with SMTP id t16so2719182qtp.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 08:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/HqRs/4PEWSPeszy+1YAHTc+STOVRE/b7E+6UiQa8wQ=;
        b=oo64KFyI1zU+6X7Sie0S+Sy7aSaSGxL7Tik7Cn0/91ADmtEtara4n2Kolm9EI/foMZ
         mMaXKwG2iRl49s58iHNzgcLkgOXpgLWGSX40jUMYE9262H0RIHW0S3Hkr2sujoy6tH44
         mEMlhlDHiCKu+gWH6PGC+9vYJsjG61qELT/EmN6fB3RYlvTl/HDwc3LM0YEj4ouPPuy+
         ZkchuwEYvkaS9CPkLrmtWJC3ANGiOgRPEVkMr++md+C1CCgxGvBjVPLDVqizXb7DgDLA
         aiBks5l4eKewM2nfcIBvEsCG3EQSMcePE9vCbYaG53HY/QwQwAKFRzm7l6iiJjnlg90C
         hVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/HqRs/4PEWSPeszy+1YAHTc+STOVRE/b7E+6UiQa8wQ=;
        b=AZn9O2H0DHOgNP8OT+utSGiPj9SsVrVyJMalfLA2j+Alk9h4UXIs8ka5jfTvQxJnGu
         MHOL9NwGzHkZpztnU9hzIECf90IF2ExQE9oX5oBLGfQej/rRK5xSwK6mmtmZF8slANti
         oFZ6bNHXivWIzNnQzqjR3N0RKDXVRPt3lqLAkFkbWfEzXK8oZvmlgfCPpUseyyKq2PPN
         xdmFOMz5npmNtdCaFu2giuoGcw8/lI0z1SCO8wpK3HO/mWjHp37yRG3Ahg8mr4XgsOov
         XVzsTnqx3aSJKo26NjDWhnzZUHIUv9d0HTSAJCGyY0jw7pt1SMNhUeK3AJ6o+qeWpzy3
         StGw==
X-Gm-Message-State: APjAAAVMUR4mu1WQJ3qzIyxaKWNxWqVLp/vqaXm2702LI0yZ1tsvVPjA
        PBcTuUhvUxD2AjqyLzlnnu+AT0bjDH0t
X-Google-Smtp-Source: APXvYqysQ0+1S2Zh68bWrMa9cSXOxT8i2A4L1slKcj2AH6+yidC45+MzAoc80DTMdNvuNN35jEPpF8qIecZJ
X-Received: by 2002:ac8:244e:: with SMTP id d14mr547186qtd.388.1572448497275;
 Wed, 30 Oct 2019 08:14:57 -0700 (PDT)
Date:   Wed, 30 Oct 2019 15:14:48 +0000
In-Reply-To: <20191030151451.7961-1-qperret@google.com>
Message-Id: <20191030151451.7961-2-qperret@google.com>
Mime-Version: 1.0
References: <20191030151451.7961-1-qperret@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v9 1/4] arm64: defconfig: Enable CONFIG_ENERGY_MODEL
From:   Quentin Perret <qperret@google.com>
To:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, daniel.lezcano@linaro.org
Cc:     dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recently introduced Energy Model (EM) framework manages power cost
tables for the CPUs of the system. Its only user right now is the
scheduler, in the context of Energy Aware Scheduling (EAS).

However, the EM framework also offers a generic infrastructure that
could replace subsystem-specific implementations of the same concepts,
as this is the case in the thermal framework.

So, in order to prepare the migration of the thermal subsystem to use
the EM framework, enable it in the default arm64 defconfig, which is the
most commonly used architecture for IPA. This will also compile-in all
of the EAS code, although it won't be enabled by default -- EAS requires
to use the 'schedutil' CPUFreq governor while arm64 defaults to
'performance'.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c9a867ac32d4..89b4feced426 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -71,6 +71,7 @@ CONFIG_COMPAT=y
 CONFIG_RANDOMIZE_BASE=y
 CONFIG_HIBERNATION=y
 CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
+CONFIG_ENERGY_MODEL=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_ARM_PSCI_CPUIDLE=y
 CONFIG_CPU_FREQ=y
-- 
2.24.0.rc0.303.g954a862665-goog

