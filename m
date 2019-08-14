Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A0CC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 21:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51612083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 21:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kea+s0+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfHNV30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 17:29:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32937 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfHNV30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 17:29:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so190335plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 14:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Q0GTf4SXd8ap/7eYvtbqWOyb5FQdhVMHgC+xfCGpXSQ=;
        b=kea+s0+EM0lH1QLqsZDsOn4sDOH41D3HRfCTW2cUvdWSICMhItatHtT/A6rHXo016S
         dCgfKALNbA888bZcw0h4uCtKVYxn8NHdwVsxi7iy8+79qiZQP3Q8ch5WvlR/i6L2rNZY
         sw8fYzM2F4Oby5/oXCn61+X+DqFP6g+PZ8jeCiPzmHzVxyK37+YvHxzJGSbVFpIILVJu
         ziqN7bbph16MtF6C+mDT0f5G8DI5VnpxilEiIvBPBFEPF+HJRQDwsg4JXnCcrcWRobhm
         SrxmxBgxMeoP6hfXkBI5tZ/YE+6BXtUTa3ZE8i4LjkqIDfqjv4/L8yLaLE66kGJtU1ez
         JrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Q0GTf4SXd8ap/7eYvtbqWOyb5FQdhVMHgC+xfCGpXSQ=;
        b=IYCU4sGMKavFtOByLInq/EpOHLkcxeU2Yz0Pz2crLqe8JeQntFkL422RZ72DaENVl6
         f6YvuQOq9C7JqcGGV54Bf4CSZgtz9dbmlXpA4EpsE+PZN8Nf4UQdDo7xybBNf2MNJ29Q
         ST5iDNnt3Q7F/kupjeI0GlaQzK8nu6YoWc4XDgqygHRTY+rop4GezE/QYcGDx2GMXCOs
         NELJL4g09Vb2UI7ZeeIxXMgWIk9laQ7h3YvxLOQBtbnq8sfThXMvY5Abj0xsp2G86mE3
         HQNXQj68/6XMYjHGg/sxDpmctWEZqwTysyaOxGmew7lDthqejM3biWcOb+qDoXqksxjL
         /Kpg==
X-Gm-Message-State: APjAAAV8ESdu9wMQYnmp+gXI2y4L+d7WvrD8dREaoalpJHkxTvIWuv7s
        JqNbSRYSvEf/uFNrxG3EuPPcIQ==
X-Google-Smtp-Source: APXvYqxeC6mQSHmSjfMvx2i1IeIw2IejFV3LJk1NJqcnb3GlKQMqyAZrrRNMCWBC5CwMBN6KMTvnQQ==
X-Received: by 2002:a17:902:9a8d:: with SMTP id w13mr1279338plp.157.1565818165383;
        Wed, 14 Aug 2019 14:29:25 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id k5sm709566pjl.32.2019.08.14.14.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 14:29:24 -0700 (PDT)
Date:   Wed, 14 Aug 2019 14:29:24 -0700 (PDT)
X-Google-Original-Date: Wed, 14 Aug 2019 14:15:32 PDT (-0700)
Subject:     Re: [PATCH v2 2/2] riscv: Make __fstate_clean() work correctly.
In-Reply-To: <alpine.DEB.2.21.9999.1908141328440.18249@viisi.sifive.com>
CC:     vincent.chen@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <mhng-4eded486-d381-4822-abc5-4023bf7ba591@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019 13:32:50 PDT (-0700), Paul Walmsley wrote:
> On Wed, 14 Aug 2019, Vincent Chen wrote:
>
>> Make the __fstate_clean() function correctly set the
>> state of sstatus.FS in pt_regs to SR_FS_CLEAN.
>>
>> Fixes: 7db91e5 ("RISC-V: Task implementation")
>> Cc: linux-stable <stable@vger.kernel.org>
>> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
>> Reviewed-by: Anup Patel <anup@brainfault.org>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Thanks, I extended the "Fixes" commit ID to 12 digits, as is the usual
> practice here, and have queued the following for v5.3-rc.

For reference, something like "git config core.abbrev=12" (or whatever you 
write to get this in your .gitconfig)

    https://github.com/palmer-dabbelt/home/blob/master/.gitconfig.in#L23

causes git to do the right thing.

> - Paul
>
> From: Vincent Chen <vincent.chen@sifive.com>
> Date: Wed, 14 Aug 2019 16:23:53 +0800
> Subject: [PATCH] riscv: Make __fstate_clean() work correctly.
>
> Make the __fstate_clean() function correctly set the
> state of sstatus.FS in pt_regs to SR_FS_CLEAN.
>
> Fixes: 7db91e57a0acd ("RISC-V: Task implementation")
> Cc: linux-stable <stable@vger.kernel.org>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> [paul.walmsley@sifive.com: expanded "Fixes" commit ID]
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> ---
>  arch/riscv/include/asm/switch_to.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> index 949d9cd91dec..f0227bdce0f0 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -16,7 +16,7 @@ extern void __fstate_restore(struct task_struct *restore_from);
>
>  static inline void __fstate_clean(struct pt_regs *regs)
>  {
> -	regs->sstatus |= (regs->sstatus & ~(SR_FS)) | SR_FS_CLEAN;
> +	regs->sstatus = (regs->sstatus & ~SR_FS) | SR_FS_CLEAN;
>  }
>
>  static inline void fstate_off(struct task_struct *task,
