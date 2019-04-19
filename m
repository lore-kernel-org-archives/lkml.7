Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702E6C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E00420449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698818;
	bh=Urs8rXEo61oN+xN5Rmqmzbm8bzHqq92eoubxRXJFsjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zDvRMoDFdhoZrRLMLQPEwTOCP7mTteR5T6UmU2QjECBQ5hXEhlVSHAXbu128EACgt
	 VefDMBIImud7std0Jhggk8SYCzw6d+uaEPw2vpyhLd/AtEujHCvYFv4VzdkyicdH59
	 Yd9x4KU+IjwuDm2+n5dcfp5IzqfYgAAVJKZsqKWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbfDSSdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:33:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbfDSS3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:16 -0400
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50D4B21917;
        Fri, 19 Apr 2019 11:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555672963;
        bh=Urs8rXEo61oN+xN5Rmqmzbm8bzHqq92eoubxRXJFsjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p4PglF2bvX2OUC4TAfvXZhlpeboc/DwGaT1oaY3WdzsS6TlqMEnXsEkZqdtPySplu
         WfE6koUMhhD1YLGOng/q0n3fH1kxxlsCBTJBIllevAH7wWSQRNlSAOj897148wdfmk
         Zz+ibgrlpQxWatgge5ffDz0mrMZsnvAxn/npQHY4=
Date:   Fri, 19 Apr 2019 19:22:37 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Mao Han <han_mao@c-sky.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 0/2] csky: perf callchain dwarf support
Message-ID: <20190419112237.GB20554@guoren-Inspiron-7460>
References: <cover.1555319439.git.han_mao@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555319439.git.han_mao@c-sky.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nice Job, Maomao

Signed-off: Guo Ren <ren_guo@c-sky.com>

On Mon, Apr 15, 2019 at 05:17:28PM +0800, Mao Han wrote:
> This patch set add perf DWARF unwinding support for C-SKY.
> Including user registers/stack dump API, and libdw support.
> 
> CC: Guo Ren <guoren@kernel.org>
> 
> Changes since v4:
>   - remove some of the dwarf regs definition
> 
> Changes since v3:
>   - update with patch from Arnaldo
>     replace other hweight_long with hweight64
> 
> Changes since v2:
>   - use same registers name as struct pt_regs
>   - code convention
> 
> Changes since v1:
>   - seperate the callchain support using frame pointer
> Mao Han (2):
>   csky: Add support for perf registers sampling
>   csky: Add support for libdw
> 
>  arch/csky/Kconfig                            |   2 +
>  arch/csky/include/uapi/asm/perf_regs.h       |  51 ++++++++++++++
>  arch/csky/kernel/Makefile                    |   1 +
>  arch/csky/kernel/perf_regs.c                 |  40 +++++++++++
>  tools/arch/csky/include/uapi/asm/perf_regs.h |  51 ++++++++++++++
>  tools/perf/Makefile.config                   |   6 +-
>  tools/perf/arch/csky/Build                   |   1 +
>  tools/perf/arch/csky/Makefile                |   3 +
>  tools/perf/arch/csky/include/perf_regs.h     | 100 +++++++++++++++++++++++++++
>  tools/perf/arch/csky/util/Build              |   2 +
>  tools/perf/arch/csky/util/dwarf-regs.c       |  49 +++++++++++++
>  tools/perf/arch/csky/util/unwind-libdw.c     |  77 +++++++++++++++++++++
>  12 files changed, 382 insertions(+), 1 deletion(-)
>  create mode 100644 arch/csky/include/uapi/asm/perf_regs.h
>  create mode 100644 arch/csky/kernel/perf_regs.c
>  create mode 100644 tools/arch/csky/include/uapi/asm/perf_regs.h
>  create mode 100644 tools/perf/arch/csky/Build
>  create mode 100644 tools/perf/arch/csky/Makefile
>  create mode 100644 tools/perf/arch/csky/include/perf_regs.h
>  create mode 100644 tools/perf/arch/csky/util/Build
>  create mode 100644 tools/perf/arch/csky/util/dwarf-regs.c
>  create mode 100644 tools/perf/arch/csky/util/unwind-libdw.c
> 
> -- 
> 2.7.4
> 
