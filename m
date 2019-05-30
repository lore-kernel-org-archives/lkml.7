Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1C3C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA22250ED
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfE3EJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:09:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38809 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfE3EJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 00:09:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id f97so1979322plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 21:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=pgMA0Wfc76ibrLZDaqEAp0iESFpifKaHVOBOP4rz25s=;
        b=GZXUQS6xnZMeSgYPU7yTlk08Z4KF1uhmo/2RKiQPBb2Fz7KiuPt1XmN/71KsZqygdr
         7fOiTjrOOz9A2eN462PpqW55OX12N3UsLiZDKBWuU4lFjuinbzlBlVz87QrROT8EKvQO
         NzlC3WnnlmR/FAWbCUvyqgeyQpk7Vx4yvMNb50Jduber6Mrc27YEhHJyz/3+cuUjhUpQ
         y6WFe7RWuEa65bA4ywcvCd+SSAJR3WORR8UFWkb3mv8F6RNsCGaCAYIvfy+HznkRIdQE
         ck86PSwm/comkAqjPua6vmyCj9dXEIVsFqdhJcfXLbE28hqM5XAowlcuBHK7yGiZsV+8
         QNEg==
X-Gm-Message-State: APjAAAVShlRHlAzJ5vNwPNKdxXi/HtL9bPh5+9YuMatqOYAUeHSPWwQ2
        mady2IXSNrch74Hu6/XEcgqtyjbg6IV6jw==
X-Google-Smtp-Source: APXvYqynAVNJiWMosj39mGO5m4j4CaYHyiDZKp97BOYFMAtBAQuLZMgN27bxN/yqwZ4YwNPWI+pRWQ==
X-Received: by 2002:a17:902:a405:: with SMTP id p5mr1741551plq.51.1559189359758;
        Wed, 29 May 2019 21:09:19 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id s80sm1464910pfs.117.2019.05.29.21.09.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 21:09:19 -0700 (PDT)
Date:   Wed, 29 May 2019 21:09:19 -0700 (PDT)
X-Google-Original-Date: Wed, 29 May 2019 20:53:09 PDT (-0700)
Subject:     Re: [PATCH RESEND 5/7] RISC-V: entry: Remove unneeded need_resched() loop
In-Reply-To: <20190528104848.13160-6-valentin.schneider@arm.com>
CC:     linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     valentin.schneider@arm.com
Message-ID: <mhng-066fe6a6-4d0a-4286-bc01-faaf21ff2698@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019 03:48:46 PDT (-0700), valentin.schneider@arm.com wrote:
> Since the enabling and disabling of IRQs within preempt_schedule_irq()
> is contained in a need_resched() loop, we don't need the outer arch
> code loop.
>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> ---
>  arch/riscv/kernel/entry.S | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 1c1ecc238cfa..d0b1b9660283 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -258,12 +258,11 @@ restore_all:
>  resume_kernel:
>  	REG_L s0, TASK_TI_PREEMPT_COUNT(tp)
>  	bnez s0, restore_all
> -need_resched:
>  	REG_L s0, TASK_TI_FLAGS(tp)
>  	andi s0, s0, _TIF_NEED_RESCHED
>  	beqz s0, restore_all
>  	call preempt_schedule_irq
> -	j need_resched
> +	j restore_all
>  #endif
>
>  work_pending:

Sorry I missed this the first time around.

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Do you want this through the RISC-V tree, or are you going to take it?
