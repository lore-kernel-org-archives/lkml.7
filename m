Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC6BC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5808B2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="X8gnSbGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfHNUcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 16:32:53 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42488 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfHNUcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:32:52 -0400
Received: by mail-ot1-f68.google.com with SMTP id j7so1062960ota.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 13:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=RHKwFMVKNYQMd4/tP+2CUffs2l2JEgbMZRapdlVGZIY=;
        b=X8gnSbGM+nulr5SiQfFmuO8kXPv4djlLrxG+SvnL74ayuUiMcFyraCcB3zu9z9WVcD
         dLtEkzyJddzpCVaR98s8ld3acAVetijvZstNygcyJBdxp5/eJHhb+CSxCxdpjRPLmmwr
         lkJ19kDC/FwDT0H5YYfeS5NBV3aWJZv41DVhGpaqZAqPbcc9+jBetJ47bi+R2EdQ2E+2
         bhTl66ia4TiwQksnq1HQaS3wMMj2G7+wK1XcbvTM4ftyVViPEZFLSeJEuO0MTok2XuFJ
         SaVhE2AsBgWc5tr5XryVURfapEH2kC+4fJr4voK7h5x2cGjpHf9kHq8qpqh1kLEhvxKZ
         Y2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=RHKwFMVKNYQMd4/tP+2CUffs2l2JEgbMZRapdlVGZIY=;
        b=dJwlnogR5MH9uo1fgDziwReKk8Q8QSUHEtbwv2fAphXJaIxe28vsSrHXwm0ie2wmp8
         FsHQdOM0BaGDozCtKiDWZieCyssDi3KTI1cLpohLOJr+1yFULqfXBIbqLA2PluohOX8p
         IZzs2jjSIQsj1E3qcuBmvDX9q8xo9TI7Kgu1N2AfYMYxxGg9IQJxkhRinyOOfh09VOiY
         4zWOPUK+l9k05R8nM/AXOUcLQ4Hmgr8GlutIKKhlkjCYubVpcURXQMh0wTxnncBx0h+G
         Zdt9CR/XbWX9btEEtA/FWCJIN78aFPfgypb26Q3GBMyCx8SSNqhq3dKzqb/fmhppZdli
         k1hQ==
X-Gm-Message-State: APjAAAX6EEEaK3aZ9mg7NmCk3MFdKaOJuiPnk1u8LZqRZX5bHXn0I5po
        RqtPDiPve/LFxMswQRUkowFaOw==
X-Google-Smtp-Source: APXvYqwKfp7tkmyc33gvbJiRyfZ67DOF2YTIbJn9ktqULef9SjFw8W2PQ8JakgfdW6Ws3cQonPyqLg==
X-Received: by 2002:a6b:4101:: with SMTP id n1mr1928939ioa.138.1565814771712;
        Wed, 14 Aug 2019 13:32:51 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id j16sm1106209iok.34.2019.08.14.13.32.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 13:32:51 -0700 (PDT)
Date:   Wed, 14 Aug 2019 13:32:50 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Vincent Chen <vincent.chen@sifive.com>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] riscv: Make __fstate_clean() work correctly.
In-Reply-To: <1565771033-1831-3-git-send-email-vincent.chen@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1908141328440.18249@viisi.sifive.com>
References: <1565771033-1831-1-git-send-email-vincent.chen@sifive.com> <1565771033-1831-3-git-send-email-vincent.chen@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019, Vincent Chen wrote:

> Make the __fstate_clean() function correctly set the
> state of sstatus.FS in pt_regs to SR_FS_CLEAN.
> 
> Fixes: 7db91e5 ("RISC-V: Task implementation")
> Cc: linux-stable <stable@vger.kernel.org>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks, I extended the "Fixes" commit ID to 12 digits, as is the usual 
practice here, and have queued the following for v5.3-rc.


- Paul

From: Vincent Chen <vincent.chen@sifive.com>
Date: Wed, 14 Aug 2019 16:23:53 +0800
Subject: [PATCH] riscv: Make __fstate_clean() work correctly.

Make the __fstate_clean() function correctly set the
state of sstatus.FS in pt_regs to SR_FS_CLEAN.

Fixes: 7db91e57a0acd ("RISC-V: Task implementation")
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
[paul.walmsley@sifive.com: expanded "Fixes" commit ID]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/include/asm/switch_to.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 949d9cd91dec..f0227bdce0f0 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -16,7 +16,7 @@ extern void __fstate_restore(struct task_struct *restore_from);
 
 static inline void __fstate_clean(struct pt_regs *regs)
 {
-	regs->sstatus |= (regs->sstatus & ~(SR_FS)) | SR_FS_CLEAN;
+	regs->sstatus = (regs->sstatus & ~SR_FS) | SR_FS_CLEAN;
 }
 
 static inline void fstate_off(struct task_struct *task,
-- 
2.23.0.rc1

