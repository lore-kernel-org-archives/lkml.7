Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F65C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0679C2186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfCTFJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:09:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34514 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfCTFJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 01:09:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id v64so1037793pfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 22:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zRNsdf+V/AK4P0Z2aSwS4lRRtyqJz6mWGX6inLxUzcw=;
        b=dXn3OpVA+JwYevRmwxKsasjxmmX1X1AYutU/a3mFKMF00ytKxwXgR+Z6P8vBeXfQpv
         fnt+JtyroNJby6Oj6TmbG2Fz7dtNDFnpx0x+m1Dm9Y/LbpUsysVv+fmB7pAxM3m2NPNR
         L42CQWzroAZI9Vlv2U1ZrW9HnYIMo0SgujnFsZiZmR1WPlWxB+ZYA/yvcZffcuCcMd1f
         Bts1hvyHTLXVOSunPM1/ecvA9lZDElarQlPYJv+Q5+0MWL1bnAbhbL+JSCSazLOJJz7L
         P6iTDqshb72vgZ0tuW5zVSk9DvGb49oXHPAGKehlBIc4gOL8OxsH5Gv/NRMynxzaUhGY
         ETkQ==
X-Gm-Message-State: APjAAAWgZDyl070ngCfBuq2kb3tGMN9qSM1YFmbmCRsN4Cmkpwle4f87
        8cJZd7lvwhXHzS6na6xunFZoO03kck0=
X-Google-Smtp-Source: APXvYqwPAI1uQcQkOu6TsbGPh4BpCrHfy7St/TgYZeLCzp0v/5kAh9lS3UJX6Bw722ElXp09XHgbpw==
X-Received: by 2002:a17:902:2bab:: with SMTP id l40mr5876361plb.273.1553058583841;
        Tue, 19 Mar 2019 22:09:43 -0700 (PDT)
Received: from localhost ([122.177.144.121])
        by smtp.gmail.com with ESMTPSA id p86sm1298564pfa.104.2019.03.19.22.09.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 22:09:42 -0700 (PDT)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will.deacon@arm.com>, Boris Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org
Subject: [PATCH v3 0/3] Append new variables to vmcoreinfo (PTRS_PER_PGD for arm64 and MAX_PHYSMEM_BITS for all archs)
Date:   Wed, 20 Mar 2019 10:39:31 +0530
Message-Id: <1553058574-18606-1-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
----------------
- v2 can be seen here:
  http://lists.infradead.org/pipermail/kexec/2019-March/022531.html
- Protected 'MAX_PHYSMEM_BITS' vmcoreinfo variable under CONFIG_SPARSEMEM
  ifdef sections, as suggested by Kazu.
- Updated vmcoreinfo documentation to add description about
  'MAX_PHYSMEM_BITS' variable (via [PATCH 3/3]).

Changes since v1:
----------------
- v1 was sent out as a single patch which can be seen here:
  http://lists.infradead.org/pipermail/kexec/2019-February/022411.html

- v2 breaks the single patch into two independent patches:
  [PATCH 1/2] appends 'PTRS_PER_PGD' to vmcoreinfo for arm64 arch, whereas
  [PATCH 2/2] appends 'MAX_PHYSMEM_BITS' to vmcoreinfo in core kernel code (all archs)

This patchset primarily fixes the regression reported in user-space
utilities like 'makedumpfile' and 'crash-utility' on arm64 architecture
with the availability of 52-bit address space feature in underlying
kernel. These regressions have been reported both on CPUs which don't
support ARMv8.2 extensions (i.e. LVA, LPA) and are running newer kernels
and also on prototype platforms (like ARMv8 FVP simulator model) which
support ARMv8.2 extensions and are running newer kernels.

The reason for these regressions is that right now user-space tools
have no direct access to these values (since these are not exported
from the kernel) and hence need to rely on a best-guess method of
determining value of 'PTRS_PER_PGD' and 'MAX_PHYSMEM_BITS' supported
by underlying kernel.

Exporting these values via vmcoreinfo will help user-land in such cases.
In addition, as per suggestion from makedumpfile maintainer (Kazu),
it makes more sense to append 'MAX_PHYSMEM_BITS' to
vmcoreinfo in the core code itself rather than in arm64 arch-specific
code, so that the user-space code for other archs can also benefit from
this addition to the vmcoreinfo and use it as a standard way of
determining 'SECTIONS_SHIFT' value in user-land.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Boris Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dave Anderson <anderson@redhat.com>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: x86@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org

Bhupesh Sharma (3):
  arm64, vmcoreinfo : Append 'PTRS_PER_PGD' to vmcoreinfo
  crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
  Documentation/vmcoreinfo: Add documentation for 'MAX_PHYSMEM_BITS'

 Documentation/kdump/vmcoreinfo.txt | 5 +++++
 arch/arm64/kernel/crash_core.c     | 1 +
 kernel/crash_core.c                | 1 +
 3 files changed, 7 insertions(+)

-- 
2.7.4

