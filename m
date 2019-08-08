Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54E5C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC9E217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="c5eSw44b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389949AbfHHKRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 06:17:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53302 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389907AbfHHKRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:17:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id 10so1824594wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 03:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A67o93psY5B4eG+Z4gU8la/fXN6tQo4s6p40YcJCO2U=;
        b=c5eSw44burssOoFTN87qDDMEdKZYrxwitEzxmyGA+TClM4eL4j+U2vXkjSTWDg78k1
         4kO3ET7xFc8yUFVM7rZOGGN+EW6e4ck/BVDqAy2QpDcxx6oeLpxjy6cbgbj0MGp2SY64
         +2NaQQlnir4wPwxR7Za2cb2f1wUXEU1lWS1F4Eb7TAMevbAPuLLbjR43OaeMq/nu2xqY
         aQmFBVEEUtW8leJ3J5gDUHXxCUQMiJu1q9KzyZZHxE+xD4UmHGjLlsRn+J5IPaIsa+qZ
         OjcyMc8M6S76QLrpSsUg7Qa/rZCiVdgE8kuYxBeboEovW8RDtrByc9ttnnVluXFwltuq
         B8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A67o93psY5B4eG+Z4gU8la/fXN6tQo4s6p40YcJCO2U=;
        b=KLABPsnyT63fOL3m4PIcRGOIbtkTWquNGzesDQlhgEMzFAf51uISYou4rm800H+w1o
         /jqQvL1lA2aMT/x3kwNdihbM4G+WGyymsOBgHcyIUWvsqMuSZ/Ks5CUZHV9srvV/sjrN
         eKJB43x9Czw8PmyHklSxTIQFQjxQo+aYZFG//fUDgjWPCPKVqlqX73+GbT04kUUwtvKy
         RDKZcHiNmz9qzWEf60c91bj9hR119N4BI/OO4SP+YwZPf2Q8RnuzYF1tJvESZJxHBTFy
         clOjbvX9gTPafYAuF0glx1iRlXg/38xfH/FxF1UcZhx4oo9NVEqCl1WfZz3ihHKirovk
         Qpsg==
X-Gm-Message-State: APjAAAXWt85rJ1PPJgi/eoCtEl6Ha6d+k3SIwWQJJZd/StqMcjTKe6jp
        aSq3GK0BrYTbW8ktgJEDg99eYNrNj4EWQVqAtQL5tw==
X-Google-Smtp-Source: APXvYqz7BKIweTGD0pA249jlnSDGofQc14qRXCJ79xu+fAryKh6X3PjA3bV6mjRS8i9LvDRdKCRm8/Adrr477M76s7k=
X-Received: by 2002:a1c:3d89:: with SMTP id k131mr3238609wma.24.1565259458889;
 Thu, 08 Aug 2019 03:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <1565251121-28490-1-git-send-email-vincent.chen@sifive.com> <1565251121-28490-3-git-send-email-vincent.chen@sifive.com>
In-Reply-To: <1565251121-28490-3-git-send-email-vincent.chen@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 8 Aug 2019 15:47:26 +0530
Message-ID: <CAAhSdy0+FeZecT0Xppwq+fGu-BV7dp+zY141R73=0O=khKdOKQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Make __fstate_clean() can work correctly.
To:     Vincent Chen <vincent.chen@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 1:30 PM Vincent Chen <vincent.chen@sifive.com> wrote:
>
> Make the __fstate_clean() function can correctly set the
> state of sstatus.FS in pt_regs to SR_FS_CLEAN.
>
> Tested on both QEMU and HiFive Unleashed using BBL + Linux.
>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> ---
>  arch/riscv/include/asm/switch_to.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> index d5fe573..544f99a 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -16,7 +16,7 @@ extern void __fstate_restore(struct task_struct *restore_from);
>
>  static inline void __fstate_clean(struct pt_regs *regs)
>  {
> -       regs->sstatus |= (regs->sstatus & ~(SR_FS)) | SR_FS_CLEAN;
> +       regs->sstatus = (regs->sstatus & ~(SR_FS)) | SR_FS_CLEAN;
>  }
>
>  static inline void fstate_off(struct task_struct *task,
> --
> 2.7.4
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

This should be a RC fix.

Please add "Fixes:" in your commit description and
CC stable kernel.

Regards,
Anup
