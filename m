Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96B0C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B7927D9D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfFCIef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:34:35 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:35594 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727255AbfFCIef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:34:35 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07457966|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.308558-0.00702582-0.684416;FP=0|0|0|0|0|-1|-1|-1;HT=e01l01425;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.EgonVnk_1559550871;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.EgonVnk_1559550871)
          by smtp.aliyun-inc.com(10.147.40.26);
          Mon, 03 Jun 2019 16:34:31 +0800
Date:   Mon, 3 Jun 2019 16:33:27 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-riscv@lists.infradead.org
Subject: Re: [PATCH V3 0/3] riscv: Add perf callchain support
Message-ID: <20190603083327.GA3101@vmh-VirtualBox>
References: <cover.1558081981.git.han_mao@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1558081981.git.han_mao@c-sky.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING?
On Fri, May 17, 2019 at 04:43:01PM +0800, Mao Han wrote:
> This patch set add perf callchain(FP/DWARF) support for RISC-V.
> It comes from the csky version callchain support with some
> slight modifications. The patchset base on Linux 5.1.
> 
> CC: Palmer Dabbelt <palmer@sifive.com>
> CC: linux-riscv <linux-riscv@lists.infradead.org>
> CC: Christoph Hellwig <hch@lst.de>
> CC: Guo Ren <guoren@kernel.org>
> 
> Changes since v2:
>   - fix inconsistent comment
>   - force to build kernel with -fno-omit-frame-pointer if perf
>     event is enabled
> 
> Changes since v1:
>   - simplify implementation and code convention
> 
> Mao Han (3):
>   riscv: Add perf callchain support
>   riscv: Add support for perf registers sampling
>   riscv: Add support for libdw
> 
>  arch/riscv/Kconfig                            |   2 +
>  arch/riscv/Makefile                           |   3 +
>  arch/riscv/include/uapi/asm/perf_regs.h       |  42 ++++++++++
>  arch/riscv/kernel/Makefile                    |   4 +-
>  arch/riscv/kernel/perf_callchain.c            | 113 ++++++++++++++++++++++++++
>  arch/riscv/kernel/perf_regs.c                 |  44 ++++++++++
>  tools/arch/riscv/include/uapi/asm/perf_regs.h |  42 ++++++++++
>  tools/perf/Makefile.config                    |   6 +-
>  tools/perf/arch/riscv/Build                   |   1 +
>  tools/perf/arch/riscv/Makefile                |   3 +
>  tools/perf/arch/riscv/include/perf_regs.h     |  96 ++++++++++++++++++++++
>  tools/perf/arch/riscv/util/Build              |   2 +
>  tools/perf/arch/riscv/util/dwarf-regs.c       |  72 ++++++++++++++++
>  tools/perf/arch/riscv/util/unwind-libdw.c     |  57 +++++++++++++
>  14 files changed, 485 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/include/uapi/asm/perf_regs.h
>  create mode 100644 arch/riscv/kernel/perf_callchain.c
>  create mode 100644 arch/riscv/kernel/perf_regs.c
>  create mode 100644 tools/arch/riscv/include/uapi/asm/perf_regs.h
>  create mode 100644 tools/perf/arch/riscv/Build
>  create mode 100644 tools/perf/arch/riscv/Makefile
>  create mode 100644 tools/perf/arch/riscv/include/perf_regs.h
>  create mode 100644 tools/perf/arch/riscv/util/Build
>  create mode 100644 tools/perf/arch/riscv/util/dwarf-regs.c
>  create mode 100644 tools/perf/arch/riscv/util/unwind-libdw.c
> 
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
