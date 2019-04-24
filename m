Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A19FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E2A21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osxIzQcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfDXXPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:15:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37841 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbfDXXPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:15:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id v13so5903218ljk.4;
        Wed, 24 Apr 2019 16:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mjGcbPS9GbZBCmmz8x+BiFOIrBo2dU/k3TmS0p8J6hA=;
        b=osxIzQcKOcnA1jszkl/XbrHO+ZTyDRhO7PXwLyfVJe9KXcmEvfBJzzF1D5INu9Ap8l
         Oy8hrGKd+hCahKHb2Gz/7xDKNVSiv1sDUJ7fBXx+LJQwV3Jpmk3CaMByt7vBtKrU2NBQ
         34RPiFsddzjFTTWpvMz0ojjZjBBVYgjIXi2qwzSCBhJn4YchZi+bV++UcDhCGe8ubTxR
         PLqmm80lTXuZ80Ryuipknvl/HDzW2MdlzJ1gU8mtXL/HHsQlkTjEfBbGxmq+2rMHHElS
         ErThbrBD5QlJ2/Rkki8VDRmg6ZtqEMDHRKycz/jaKxZfpfJxpCV0hrekM+ywdPw55Oij
         FWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mjGcbPS9GbZBCmmz8x+BiFOIrBo2dU/k3TmS0p8J6hA=;
        b=YIZUzmDMZ375uYgXe7GqNGRrzey2olDNvSlr3r5S422Ih4HqkVfTAnq9JKa6KB9jw4
         lIKpxS+xWAMTw5SlvlV9JrTZhWCcyEno6ItUTHccHVgDIldv9ni1ego2t0QQQtfyjTii
         nRE9RKgxo6Z+CwI/SSI/FJkbc0/DoWxQvSzOkNNLde1dH78kMPS/Fm+5Q+l1qgJfRsg/
         x1C90ptLigt5jyCDB9+4L+tswVwk8cgUGD7/wPgixfEaF4bxtBPUT1ncjvtSJYQAne1i
         yPWZgQDa4+BTWUdlOwhrw3gjeKNvpt2HlR68jdWQApCag80ao9VCu8EaYoB1PlHmdo2h
         0YyQ==
X-Gm-Message-State: APjAAAWAu3rW6q1ANb6S47Ey7Oyz3z1doJc+NRE3cFZelusMX8/4CoNA
        ynzmFjsqeyXFlYRAdhmLOig=
X-Google-Smtp-Source: APXvYqzVsurkeVg6PSf8QSINv3e9cDiR1CwnVXqvA72A71sQzQbmZoDINpRhdPvNYVS+LlLBAEak8g==
X-Received: by 2002:a2e:a0c4:: with SMTP id f4mr1225684ljm.100.1556147710278;
        Wed, 24 Apr 2019 16:15:10 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id j13sm830192lfb.34.2019.04.24.16.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:15:09 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/7] clocksource/drivers/tegra: Reset hardware state on init
Date:   Thu, 25 Apr 2019 02:14:40 +0300
Message-Id: <20190424231444.20876-4-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424231444.20876-1-digetx@gmail.com>
References: <20190424231444.20876-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset timer's hardware state to ensure that initially it is in a
predictable state.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra20.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index 508ca4cdbc60..01d713f20a85 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -145,6 +145,9 @@ static int tegra_timer_setup(unsigned int cpu)
 {
 	struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
 
+	writel(0, timer_of_base(to) + TIMER_PTV);
+	writel(TIMER_PCR_INTR_CLR, timer_of_base(to) + TIMER_PCR);
+
 	irq_force_affinity(to->clkevt.irq, cpumask_of(cpu));
 	enable_irq(to->clkevt.irq);
 
-- 
2.21.0

