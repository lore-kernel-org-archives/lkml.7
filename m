Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB09C2D0CE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 08:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4692C208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 08:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577694466;
	bh=9EMeHpw5evZdoe+AwHX3tiaQybGvCFpfAbbyvyTNN6g=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xZTGFGKRw3NPfRkNZRKZqt9ZA+w9GUEzLznNHvn/xTyvti11mK4UCIo+r1Kavx8QZ
	 GSmpgSDVBh2bZYeNHNZNj8I14hZovk3BW3fXsgtfhz44J3xPERd6q7yTJmljnVV9re
	 NANXxFuCpxDks5mM5VaZIX5UtUfkM+JuH0cczry8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfL3I1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 03:27:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:50894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbfL3I1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 03:27:45 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D00A620748;
        Mon, 30 Dec 2019 08:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577694464;
        bh=9EMeHpw5evZdoe+AwHX3tiaQybGvCFpfAbbyvyTNN6g=;
        h=From:To:Cc:Subject:Date:From;
        b=SlEl27wr7bAYPQ+O/tJdPsHjcnV8J61qdvqT5DSXCxmdub51A4W//ahl/C/OrzmSr
         Kk9usdHhNlNC3dsUzy3xLRmk2CZKCFEZjAg70Fz+xCECej8U0BteIE3vvVYm8JPi5j
         42877+aKfAUGr/TxSZ0wXwRPAKqxo7pm+Ju7f5y4=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 0/1] arm/arm64: add support for folded p4d page tables
Date:   Mon, 30 Dec 2019 10:27:33 +0200
Message-Id: <20191230082734.28954-1-rppt@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

This is a part of clean up of the page table manipulation code that aims to
remove asm-generic/5level-fixup.h and asm-generic/pgtable-nop4d-hack.h

There is a single patch for both arm and arm64 because doing the conversion
separately would mean breaking the shared mmu bits in virt/kvm/arm.

The patch is build tested and boot tested on qemu-system-{arm,aarch64}.

Mike Rapoport (1):
  arm/arm64: add support for folded p4d page tables

 arch/arm/include/asm/kvm_mmu.h          |   5 +-
 arch/arm/include/asm/pgtable.h          |   1 -
 arch/arm/include/asm/stage2_pgtable.h   |  15 +-
 arch/arm/lib/uaccess_with_memcpy.c      |   9 +-
 arch/arm/mach-sa1100/assabet.c          |   2 +-
 arch/arm/mm/dump.c                      |  29 +++-
 arch/arm/mm/fault-armv.c                |   7 +-
 arch/arm/mm/fault.c                     |  28 +++-
 arch/arm/mm/idmap.c                     |   3 +-
 arch/arm/mm/init.c                      |   2 +-
 arch/arm/mm/ioremap.c                   |  12 +-
 arch/arm/mm/mm.h                        |   2 +-
 arch/arm/mm/mmu.c                       |  35 +++-
 arch/arm/mm/pgd.c                       |  40 ++++-
 arch/arm64/include/asm/kvm_mmu.h        |  10 +-
 arch/arm64/include/asm/pgalloc.h        |  10 +-
 arch/arm64/include/asm/pgtable-types.h  |   5 +-
 arch/arm64/include/asm/pgtable.h        |  37 +++--
 arch/arm64/include/asm/stage2_pgtable.h |  48 ++++--
 arch/arm64/kernel/hibernate.c           |  46 +++++-
 arch/arm64/mm/dump.c                    |  29 +++-
 arch/arm64/mm/fault.c                   |   9 +-
 arch/arm64/mm/hugetlbpage.c             |  15 +-
 arch/arm64/mm/kasan_init.c              |  41 ++++-
 arch/arm64/mm/mmu.c                     |  52 ++++--
 arch/arm64/mm/pageattr.c                |   7 +-
 virt/kvm/arm/mmu.c                      | 209 ++++++++++++++++++++----
 27 files changed, 565 insertions(+), 143 deletions(-)

-- 
2.24.0

