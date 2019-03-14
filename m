Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F45C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456AD2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="choj6QuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfCNGnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:43:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45028 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfCNGnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:43:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id a3so3167368pff.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 23:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5+5Cw5z33DIg1su6ZAUGhXXSsFuNvEeeUI9Xv45/m58=;
        b=choj6QuSgZ7wxLK9NEnm1WuZw7X2kxDkrYlJTBwSkSyerLOzHHGhZKWFF1Ez6zPiaO
         3vW5/4Gtsw5rjr1ngc6bh8kPsQj+kjV5FKIVq7nBoptGdKup7FvvfK4cwX+vmqLVZ7BL
         GJW6UKZQCJuz4Pd7qPkyXFwDxsX9x0dp06tJamwEJ329GxZsfT5/l5d3v5aJJW09Jn1r
         D+p4YEQldkh4P70N0PICTYqp3tiiRBWCrY1bz7J031Ni9wclcUSD63V05n2rAn2jwQ7m
         juiAMIFNKk28O8ng9FCGC0aqic5RCA6LOuvVZ7QyrmgdUgem4OzQWvVRf4AidiNPkePa
         i8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5+5Cw5z33DIg1su6ZAUGhXXSsFuNvEeeUI9Xv45/m58=;
        b=BPADuqK0Jr/9alF9hf89E6LTg3Cw2/744X6LQqyhLY5JUQXLOZ99CO5kiP6ByNs1XT
         TFqIvAnGnlCLODOQ/mXxRnPUmxsc/drilMNdYjiHXqTf07VKyZe5kuaer6VkqQXvlW9d
         Q/XsVz334iOLQwF3QIxcwB4HrD1Eblq6lIbFDTDyfdycmfzAz7KWWDoYr7eWbzbvbE4/
         1HvI4eary3LwE4KGbXqNPVBLmwoA2EoU82p5GIVp7FNrDjuYWiZUWeR0CymHihy/gan5
         c4qUJeWKYizTZTdbHseocojeg1xal7iQQyDtM09tXKsinCo1DuWtadIurOULKpoWNVD0
         C6fw==
X-Gm-Message-State: APjAAAVNICVFzlci1IDH2CYW7bqJOBTtrizLPVPRXW0vzJoNMDhLmp87
        k/o2CmGxMQLdUNH4ASwQ7ACf/w==
X-Google-Smtp-Source: APXvYqzfZPOAXR4qUxqYyIY63Y/rMYs8i72UfcADk39hoDbPZX9Wfa/ze1+OALWIksGswXiJeQJpgQ==
X-Received: by 2002:aa7:8a95:: with SMTP id a21mr925115pfc.14.1552545796399;
        Wed, 13 Mar 2019 23:43:16 -0700 (PDT)
Received: from localhost ([122.166.134.37])
        by smtp.gmail.com with ESMTPSA id h63sm46530100pfd.148.2019.03.13.23.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 23:43:15 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 0/7] cpufreq: Call transition notifier only once for each policy
Date:   Thu, 14 Mar 2019 12:12:46 +0530
Message-Id: <cover.1552545525.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we call the cpufreq transition notifiers once for each CPU of
the policy->cpus cpumask, which isn't that efficient. This patchset
tries to simplify that by adding another field in struct cpufreq_freqs,
cpus, so the callback has all the information available with a single
call for each policy.

I have tested this on arm64 platform and is compile tested for other
platforms. This has gone through 0-day testing as well, I have pushed my
branch over a week back to the public tree which gets tested by 0-day
bot.

FWIW, it maybe possible to make the callback implementation more
efficient now that they are called only once for each policy, but this
patchset only did the minimum amount of changes to make sure we don't
end up breaking otherwise working code.

--
viresh

Viresh Kumar (7):
  cpufreq: Pass policy->related_cpus to transition notifiers
  ARM: smp: Update cpufreq transition notifier to handle multiple CPUs
  ARM: twd: Update cpufreq transition notifier to handle multiple CPUs
  sparc64: Update cpufreq transition notifier to handle multiple CPUs
  x86/tsc: Update cpufreq transition notifier to handle multiple CPUs
  KVM: x86: Update cpufreq transition notifier to handle multiple CPUs
  cpufreq: Call transition notifiers only once for each policy

 arch/arm/kernel/smp.c       | 23 ++++++++++++++---------
 arch/arm/kernel/smp_twd.c   |  9 ++++++---
 arch/sparc/kernel/time_64.c | 28 ++++++++++++++++------------
 arch/x86/kernel/tsc.c       | 31 ++++++++++++++++++++-----------
 arch/x86/kvm/x86.c          | 31 ++++++++++++++++++++-----------
 drivers/cpufreq/cpufreq.c   | 19 ++++++++++---------
 include/linux/cpufreq.h     |  2 +-
 7 files changed, 87 insertions(+), 56 deletions(-)

-- 
2.21.0.rc0.269.g1a574e7a288b

