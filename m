Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59888CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D7E2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gh+uQ97D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392519AbfJXNCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:02:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33325 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbfJXNCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:02:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id u23so3532359pgo.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 06:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/b8upsYxAHV50/pkYFWToTEqmLmbge4Vw0LfKFTH7Xc=;
        b=gh+uQ97D7GUTUYtFAtlwK+hH5zRunx9fI4Ek+HyI0OlT8NFkPuO1fgvlRsmfy8w/wt
         RxCgPw6PfrEShBToO7EkCCka343tZcykL31Hh9dzBidAgrEyz/hOhWSgCWzSuzKRPKab
         oFdqDliGvQbfLzX7nSn7Beem/4PFjw9KTMFUG+2xbPf2mmWJzRVAubf+YseM0uzUyipP
         9gcGdMAQNAwH9/2ZpDOzPwJ4vrHfkB2PPYeV2db/DF9yXmXxrqq6R9eteN3CXMwEuoVc
         6pul558jRX4p3IvblZzFZXzG2b9/fQ6q7fuTSoa+/7QUZFS+1BLGFNKNhmqavTVQyzna
         8FIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/b8upsYxAHV50/pkYFWToTEqmLmbge4Vw0LfKFTH7Xc=;
        b=pPbLLE841BIKwbPd7OuDbBsz4eSjXG5fXbvk3Su6ZsFmhhGLDqZX1ZfX/CmlS/hPwJ
         OpzFSyFuE71BGVard3lqY5dxF818Hz6JGie32IUFh3QuO6/Ou3yN7gHC5Qd06owgv7Kl
         6oLxExcO+xOiCuypmCK9qKuHGd4WINX1Gnh7mgNHuZUdBu6BZLutLy0nDxd5JStzg+Qt
         pIy7G/klwjZa08PKoV/3BLw/NctBTlDV2zxnjGGKwjV4UHsVddrbzPm1ifx0jKyx400G
         XLqnlZ+zGcHDhMsQQQtkeM0dHT70FVzPrhNMKmQ6/XvuHd7WzsP3wiu2dN2Sx07RJRVx
         FFOA==
X-Gm-Message-State: APjAAAWUkVmZPgF8ENqa2vQDrpxwklSd3cAd7Q7O8dKglSZ9r9z1jYNr
        rOikNWNzI2Cac/86SPfEz1zNnqhYjAuofQ==
X-Google-Smtp-Source: APXvYqyTc7x7OPqtZa9Jfa8hnggbtw9Uaf08mi1nImO078RVxE7CDqjXQA5ApLB14/lp4ichMdgA1g==
X-Received: by 2002:a63:4553:: with SMTP id u19mr16191277pgk.436.1571922162455;
        Thu, 24 Oct 2019 06:02:42 -0700 (PDT)
Received: from gamma07.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id z4sm2308775pjt.17.2019.10.24.06.02.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Oct 2019 06:02:41 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        paul.walmsley@sifive.com, palmer@sifive.com, steven.price@arm.com
Cc:     Zong Li <zong.li@sifive.com>
Subject: [RFC PATCH 0/1] RISC-V page table dumper
Date:   Thu, 24 Oct 2019 06:02:17 -0700
Message-Id: <cover.1571920862.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the support for dumping the page tables, and it's implemented on top of the generic page table dumper patch set. The generic page table dumper patch set is submmited to version 12, it looks good and only a little bit different from previous version. I'll post the formal patch after it be merged.

The patch set of gerneric page table dumper.
https://lore.kernel.org/lkml/20191018101248.33727-1-steven.price@arm.com/


Zong Li (1):
  riscv: Add support to dump the kernel page tables

 arch/riscv/Kconfig               |   1 +
 arch/riscv/include/asm/pgtable.h |  10 ++
 arch/riscv/include/asm/ptdump.h  |  19 +++
 arch/riscv/mm/Makefile           |   1 +
 arch/riscv/mm/ptdump.c           | 309 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 340 insertions(+)
 create mode 100644 arch/riscv/include/asm/ptdump.h
 create mode 100644 arch/riscv/mm/ptdump.c

-- 
2.7.4

