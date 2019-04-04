Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9B3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BED52082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7nOtkP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfDDMHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:07:16 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33309 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDDMHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:07:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id t16so1095936plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 05:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vZDhAtn11Fi2Pzw8YgGMWRZy9SdkPO12VztgbovlY+Y=;
        b=F7nOtkP33Bm6ESrxx0ikfgr7ZeeB/Q5vPXIPSHzNcxilivqBd7IrfXwNw9mUTDXnvc
         PKKzERQMRDejquVPoZ8kR3/YeuJDtkRAImZZF5Zy7BiS/EH1uxmfo3oaP5Wt9L3tWGsV
         MyEVMDI5oX65kqhy/64BPgHDaYeieWHQA67GPA9MwJ8lQXv2UELng9jV+f/Sb3wWGdPm
         ah4q7OcZawZfb/h1SctsBdfLdhFeE0jI0ZZVtZBz0maNoS24BqqTQGhEY0v5ga3T2mLa
         sryzy+jElZY0bYRcVq8dpfPWUIaGQQg3fXhLatZ8RIgaV26Ykuxl50i4RIjLvaQVoVGH
         2bLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vZDhAtn11Fi2Pzw8YgGMWRZy9SdkPO12VztgbovlY+Y=;
        b=BW/EOcLdjv0IHAJFoV2ODNLbsbgbmRWkX+TtmuleoU9FxTLUy7lguJA4Sv+ORt1Z91
         Nulkmv1Mz+sOxTPAk/MosPYLnqjzZX7n6Eu/djJjeVh0KIBUmCI+NHCzEqXcUQ0coNe4
         1D3yqcK06c5QPiJTQnJZA8AhPsOQaMNyMiurExNot7qGTKrEdrpdsiDdW1TBVloYxS8g
         Jyd9tWTyiD0KtPVr+rEfvaSC9VVSjxOrLifgKzL/3jKBJ88uhReJi6uy8iHTBfBc+jxo
         z+gCticxUCneqtaV8ZikH33/NQmh5klRNi5IZu5YI3/2DykQCqS6ej6kVnCc7ESjAHfM
         N3Wg==
X-Gm-Message-State: APjAAAVm3sThAordh6nzN+tawrxYSmLGeCWMmoRPDzYt5SX0bQ/2Mde3
        X/ASeCQV26ulsikiqnATXn0=
X-Google-Smtp-Source: APXvYqypjLMsaZuA+tg6HIMAAxkPuDZfC069CCddbq+xd042RX6siImqqjQhf+KN5JdwZUJzONy0Fw==
X-Received: by 2002:a17:902:15a8:: with SMTP id m37mr6035488pla.178.1554379635198;
        Thu, 04 Apr 2019 05:07:15 -0700 (PDT)
Received: from bobo.local0.net (193-116-89-42.tpgi.com.au. [193.116.89.42])
        by smtp.gmail.com with ESMTPSA id j22sm24720668pfn.129.2019.04.04.05.07.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 05:07:14 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Allow CPU0 to be nohz full
Date:   Thu,  4 Apr 2019 22:07:00 +1000
Message-Id: <20190404120704.18479-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been looking at ways to fix suspend breakage with CPU0 as a
nohz CPU. I started looking at various things like allowing CPU0
to take over do_timer again temporarily or allowing nohz full
to be stopped at runtime (that is quite a significant change for
little real benefit). The problem then was having the housekeeping
CPU go offline.

So I decided to try just allowing the freeze to occur on non-zero
CPU. This seems to be a lot simpler to get working, but I guess
some archs won't be able to deal with this? Would it be okay to
make it opt-in per arch?

Thanks,
Nick

Nicholas Piggin (4):
  sched/core: allow the remote scheduler tick to be started on CPU0
  kernel/cpu: Allow non-zero CPU to be primary for suspend / kexec
    freeze
  kernel/sched/isolation: require a present CPU in housekeeping mask
  nohz_full: Allow the boot CPU to be full nohz

 include/linux/cpu.h       |  2 +-
 kernel/cpu.c              | 10 +++++++-
 kernel/sched/core.c       |  2 +-
 kernel/sched/isolation.c  | 18 ++++++++++----
 kernel/time/tick-common.c | 50 +++++++++++++++++++++++++++++++++++----
 kernel/time/tick-sched.c  | 27 +++++++++++----------
 6 files changed, 84 insertions(+), 25 deletions(-)

-- 
2.20.1

