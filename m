Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BE5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5512F20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SNRrPeiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfCDTGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:06:43 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33903 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfCDTGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:06:40 -0500
Received: by mail-pf1-f193.google.com with SMTP id u9so3687089pfn.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 11:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=fsyumd3cYkUPXCx3sxWWz65F7VdbF/BpDrgSmoCGI7E=;
        b=SNRrPeiPmCZ40ZCzXnA5d+cPrKqQUjOSDWFH7Ft8rbQh9PqVBJFNLOvMLKBxfm9ho2
         HrEg/VRhgzZ89iNdAToXKZpM/WI/EmRjYuHtzr5YG1OSN2kaIINfe85IZSysD3ntI29l
         ja2BV/ouYIFt6NIXPA2QLXswoJIqaNR2Wpoby/IpkDF4yMpQG3h2J9HIrndu5xi0TkEX
         tNsdPf9f+eUiUaabj6o0pWfP70yKEDyaRGQWxiqKlSu0ic+8FMqEXw6kSS/dBRlmQ1LI
         4DkYzgQfJIp6lY0PCsejNqNDFFLzF/yQf5lIQZju1Siirn3pjDyzeh6XAI5jIJGTvzJK
         P2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=fsyumd3cYkUPXCx3sxWWz65F7VdbF/BpDrgSmoCGI7E=;
        b=hRLrNJEp7jqnsm88520Oe6W5Yk2MEDbF6Om1ZFAi9pUpRlA+SSyM1oJOy6bm1T4ErH
         RTjKTWA3aX2Foaj+64wbaZI3DNrjnXuHbU1QKXkhmQ8JBSeHW0jglUXO9nuryFgitpwJ
         y7DB840gWoWiLDXsQPGMBTMlY0oE9YShwAa63i+JWMH0sds9cArpgg+sFJVj04m5TCva
         FfvW5qoTE+ZS10Wjr0loa0YwZtEnOA7RdkdJkO67oOfhN0dGwNqsjmfBM9nxEkTbhvL3
         /3JltvFFmWreJvC9dVIFrTGPq2Ezr+IxAovFc+nt6dCnfiOySGZTV0PwdKvgcaFaycM+
         saxw==
X-Gm-Message-State: AHQUAuacPPS06ZJPpKa6TUo8i6YMNvGt3qVIo1wUbhsui/rGPRbja+xr
        BGyDBKDDZ/HZ5r6xJTZAMAhm9DJr8E8=
X-Google-Smtp-Source: APXvYqzDN0bfW6vhe7meCYC2JknpYdrSeoicnS++/YC8bLC0ijRS28CggA6IBNYpeqmXV0m5Q7v5FQ==
X-Received: by 2002:a62:6453:: with SMTP id y80mr21207844pfb.203.1551726398577;
        Mon, 04 Mar 2019 11:06:38 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id f192sm12087077pfc.180.2019.03.04.11.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 11:06:37 -0800 (PST)
Date:   Mon, 04 Mar 2019 11:06:37 -0800 (PST)
X-Google-Original-Date: Mon, 04 Mar 2019 11:06:35 PST (-0800)
Subject:     Re: [v6 PATCH 0/6] Various SMP related fixes
In-Reply-To: <1550864500-13652-1-git-send-email-atish.patra@wdc.com>
CC:     linux-riscv@lists.infradead.org, atish.patra@wdc.com,
        alankao@andestech.com, aou@eecs.berkeley.edu, schwab@suse.de,
        anup@brainfault.org, dmitriy@oss-tech.org, johan@kernel.org,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, tglx@linutronix.de
From:   Palmer Dabbelt <palmer@sifive.com>
To:     atish.patra@wdc.com
Message-ID: <mhng-0e06d7b7-e7f4-4ca0-a8cc-1b06c43701d2@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 11:41:34 PST (-0800), atish.patra@wdc.com wrote:
> The existing upstream kernel doesn't boot for non-smp configuration.
> This patch series address various issues with non-smp configurations.
>
> The patch series is based on 5.0-rc7 + Johan's below mentioned patch
> series. Tested on both QEMU and HiFive Unleashed board using both
> OpenSBI & BBL.
>
> https://lore.kernel.org/lkml/20190118140308.9599-1-johan@kernel.org/
>
> Changes from v5->v6
> 1. Dropped driver patches as they have been accepted via drivers tree.
>
> Changes from v4->v5
> 1. Continue processing other harts even if isa string is incorrect for
>    a single hart during HWCAP processing.
>
> Changes from v3->v4
> 1. Fixed commit text length issues.
> 2. Updated hwcap patch to use common capabilities of all harts.
> 3. Rebased on Johan's patch series.
>
> Changes from v2->v3
>
> 1. Fixed spurious white space.
> 2. Added lockdep for smpboot completion variable.
> 2. Added a sanity check for hwcap.
>
> Changes from v1->v2
>
> 1. Move the cpuid to hartid map to smp.c from setup.c
> 2. Split 3rd patch into several small patches based on
>    logical grouping.
> 3. Added a new patch that fixes an issue in hwcap query.
> 4. Changed the title of the patch series.
>
> Atish Patra (6):
> RISC-V: Do not wait indefinitely in __cpu_up
> RISC-V: Move cpuid to hartid mapping to SMP.
> RISC-V: Remove NR_CPUs check during hartid search from DT
> RISC-V: Allow hartid-to-cpuid function to fail.
> RISC-V: Compare cpuid with NR_CPUS before mapping.
> RISC-V: Assign hwcap as per comman capabilities.
>
> arch/riscv/include/asm/smp.h   | 18 +++++++++++++-----
> arch/riscv/kernel/cpu.c        |  4 ----
> arch/riscv/kernel/cpufeature.c | 41 ++++++++++++++++++++++-------------------
> arch/riscv/kernel/setup.c      |  9 ---------
> arch/riscv/kernel/smp.c        | 10 +++++++++-
> arch/riscv/kernel/smpboot.c    | 20 +++++++++++++++++---
> 6 files changed, 61 insertions(+), 41 deletions(-)

I've taken this v6 into for-next, thanks!
