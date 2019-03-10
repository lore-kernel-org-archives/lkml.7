Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34012C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 10:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CBC207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 10:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfCJKEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 06:04:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34625 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfCJKEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 06:04:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id u65so1722371pgc.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 03:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LV3A1K28ZzdlaXBJ+m4jDlY+1loO1xTntknB7j9GNVc=;
        b=WtJdzWeexTPysHsyx3COQdBqDtjyPGdHvrVGHOY/9d3vWxGk6CwqlMzy+XIj+N4XUq
         6dWLvQMWvB4ZqEg4dk4uSmoLuTXHei8F1Y7g8a2zGpf8f/kkNKbla0KkonuA/DMmZ2c7
         VkETKqecY7ZCZXWxHVmthjfl7rdB479uB5yGr48UutPJaLXVTT2P63U9XGjMIeqWSQdv
         2UkefIWLc6olrIPSZh6TZKx4Gg01oqL2/y8LhZVkJyTKKl1yRfressSF/qm2NXZTKS6X
         g7jdSNFvR07Pd7n4/qYi+IPGxN0MoHtYnEMT6fiWf9TywEXzXS0tWwYhE7ZCMspHAYAb
         HmmA==
X-Gm-Message-State: APjAAAUZxSm4W9+58ADSJGm/X+h34tpmADISFDyEecgMr+3a0SY3VYnf
        EDYO/DEKCw24rqX8IZ3PkPmvEBJu6c8=
X-Google-Smtp-Source: APXvYqwvqV+s+YSa4RrgVVU1zmYLlcj68VnkbN9gYn1E1+qoEavuXS/+Gku4N9ALNKZJO+0AiddaFQ==
X-Received: by 2002:a63:ed45:: with SMTP id m5mr3439137pgk.265.1552212292391;
        Sun, 10 Mar 2019 03:04:52 -0700 (PDT)
Received: from localhost ([106.215.118.61])
        by smtp.gmail.com with ESMTPSA id o2sm7496739pgq.29.2019.03.10.03.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 03:04:51 -0700 (PDT)
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
Subject: [PATCH v2 0/2] Append new variables to vmcoreinfo (PTRS_PER_PGD for arm64 and MAX_PHYSMEM_BITS for all archs)
Date:   Sun, 10 Mar 2019 15:34:00 +0530
Message-Id: <1552212242-9479-1-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
In addition, as per suggestion from makedumpfile maintainer (Kazu)
during v1 review, it makes more sense to append 'MAX_PHYSMEM_BITS' to
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

Bhupesh Sharma (2):
  arm64, vmcoreinfo : Append 'PTRS_PER_PGD' to vmcoreinfo
  crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo

 arch/arm64/kernel/crash_core.c | 1 +
 kernel/crash_core.c            | 1 +
 2 files changed, 2 insertions(+)

-- 
2.7.4

