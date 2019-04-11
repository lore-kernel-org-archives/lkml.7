Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674B0C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D94217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m25urrAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfDKDfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:35:04 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38564 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDKDfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:35:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id f36so2670584plb.5;
        Wed, 10 Apr 2019 20:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mfPce7oGCKplZgC5wXkTyuZmmh+XEXF/RZVOfDV3eos=;
        b=m25urrAi+4xkiJ1CsLzM2apRGya51y7qwjJc5REkCjz4D+TyX1l1LYGQKvtosh77RZ
         sq94kLAAMjlYnNTTPTYouQxeUQuXn7z/o9b5erowiqk6PWtnt8RjhNXSgL0t1bLCIWOM
         5KlWXorybfGXnxz1Z3NpdB32Wpwf0zxBU0QFfGU8O9brs67wY1T3OfhWRWoY2TRssr0n
         Ov6gQJgxWw23Cde35hvR12HiX4aWT1q9gynTOOgljdVREIdSctJVuz4/3fcxo3y41NWC
         09ZNZHtDRDfj9008TgUDSy4p/WXItsW0aeIH4VJIOE76ILtkij16gkNamBkeCcL7O54/
         ll0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mfPce7oGCKplZgC5wXkTyuZmmh+XEXF/RZVOfDV3eos=;
        b=V3v5NRSP/HpQmGiie8TEXy9+rk9d+vUgbtAadJU1pqbGE7OaNon3UYCgmHWcxZ8iNg
         0lW3737YfilW3Et1JSE9DHE4pd5TulXMJjpmAiEKHDqZGCdiJVbUxweoTVtouHGmARA2
         xvNZHipWxJwAY3lB6rQwKcX6CGP6hDVzPhWht5IbRXZEAbaq3MpVofHT2AamA/Np1ass
         i0a6FcIaADiLHqWcoLZMatwHjqY/X/tt2arhfz2QAy1JuAt7yxxWaOaIAazCrKR4Xf7+
         hIfYHbUiWKyAyIpSaTgUiI/fPeD4LbUrIQ1jKaBQEFxQxTj5NN9mF/T53Ww0uFcTn4/1
         0OQw==
X-Gm-Message-State: APjAAAU9tHBbo5sOOuc0YsEc0Q5EIX5Nwdc6n6xO1ylwifwMSvBqO3wF
        N3n/bOkfpStZneYJZM/LCmw=
X-Google-Smtp-Source: APXvYqyICp4HbALhnA3SbAwWILmej0/qeGjvG1lnDwsLQ7HXwWDLdgTW/8U6whyjVhne8GwPzireTg==
X-Received: by 2002:a17:902:bd0c:: with SMTP id p12mr21998494pls.50.1554953702774;
        Wed, 10 Apr 2019 20:35:02 -0700 (PDT)
Received: from bobo.local0.net ([203.63.188.231])
        by smtp.gmail.com with ESMTPSA id b9sm37231416pfd.32.2019.04.10.20.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 20:35:01 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/5] Allow CPU0 to be nohz full
Date:   Thu, 11 Apr 2019 13:34:43 +1000
Message-Id: <20190411033448.20842-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since last time, I added a compile time option to opt-out of this
if the platform does not support suspend on non-zero, and tried to
improve legibility of changelogs and explain the justification
better.

I have been testing this on powerpc/pseries and it seems to work
fine (the firmware call to suspend can be called on any CPU and
resumes where it left off), but not included here because the
code has some bitrot unrelated to this series which I hacked to
fix. I will discuss it and either send an acked patch to go with
this series if it is small, or fix it in powerpc tree.

Thanks,
Nick

Nicholas Piggin (5):
  sched/core: allow the remote scheduler tick to be started on CPU0
  PM / suspend: add function to disable secondaries for suspend
  kernel/cpu: Allow non-zero CPU to be primary for suspend / kexec
    freeze
  kernel/sched/isolation: require a present CPU in housekeeping mask
  nohz_full: Allow the boot CPU to be nohz_full

 include/linux/cpu.h       | 15 ++++++++++++
 kernel/cpu.c              | 10 +++++++-
 kernel/kexec_core.c       |  4 ++--
 kernel/power/Kconfig      |  9 +++++++
 kernel/power/hibernate.c  | 12 +++++-----
 kernel/power/suspend.c    |  4 ++--
 kernel/sched/core.c       |  2 +-
 kernel/sched/isolation.c  | 18 ++++++++++----
 kernel/time/tick-common.c | 50 +++++++++++++++++++++++++++++++++++----
 kernel/time/tick-sched.c  | 34 ++++++++++++++++++--------
 11 files changed, 131 insertions(+), 31 deletions(-)

-- 
2.20.1

