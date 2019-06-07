Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11809C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEA8207E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbfFGWMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:12:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38359 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729456AbfFGWMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:12:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id f97so1323942plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=jmPOqHVXXc8BsUqtRJfurbZZiUJ7eEKFAc+yR316dGU=;
        b=S+JIfgqMNuHp+z/SW60OUgNuZJFcnFNMreXNImfTh599dkW4Gxekch3udzzJsY4AuO
         kcfH7Ux36+HWw6iX7cOSu9JyJArZ1e94gMy8BBHCxcgOR7QvVuoea1okqbqbbFUlUJ5Z
         5mS7SBa+JzBayGekbP73iASRDIJ1U/KEsenA0z61nRH/ZfQe5MRojraxQOYFbxVKIWPp
         STa4Q6JXaSRSrLno4qeVZeLZjtd+2xKeURWaqZIkD92C+6DpEwRs45UaT+eNFrkqCN/j
         CQ8fYJ+ti02/il5PxlBILca3QX2WnO6ontkf4sHLAJezFNqa1dpQsSRGPi8HVDc8JNs8
         v+gQ==
X-Gm-Message-State: APjAAAXsWXJo3HcVLIUhlWC+RY2J4jmqhhiBECnfPz3pnTlQkVm9GJ1U
        dEAdPevy7fzTM5Teuhea1wqJLQ==
X-Google-Smtp-Source: APXvYqz8OpliHXJJwtu5JxWix99Vw57S+eyKvSu4i62/JdX5hwf+WiB2lih0L3JKi8BXO4s9PFJ4CA==
X-Received: by 2002:a17:902:8f8e:: with SMTP id z14mr16618264plo.1.1559945563443;
        Fri, 07 Jun 2019 15:12:43 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id y13sm3407673pfb.143.2019.06.07.15.12.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 15:12:42 -0700 (PDT)
Date:   Fri, 07 Jun 2019 15:12:42 -0700 (PDT)
X-Google-Original-Date: Fri, 07 Jun 2019 15:12:41 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Break load reservations during switch_to
In-Reply-To: <87ftom4ij2.fsf@igel.home>
CC:     Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, marco@decred.org,
        me@carlosedp.com, joel@sing.id.au, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     schwab@linux-m68k.org
Message-ID: <mhng-a0345343-89b4-43e0-94dd-fb4f2cc851e0@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jun 2019 12:32:01 PDT (-0700), schwab@linux-m68k.org wrote:
> On Jun 06 2019, Christoph Hellwig <hch@infradead.org> wrote:
>
>> On Wed, Jun 05, 2019 at 04:17:35PM -0700, Palmer Dabbelt wrote:
>>>  	REG_S ra,  TASK_THREAD_RA_RA(a3)
>>> +	/*
>>> +	 * The Linux ABI allows programs to depend on load reservations being
>>> +	 * broken on context switches, but the ISA doesn't require that the
>>> +	 * hardware ever breaks a load reservation.  The only way to break a
>>> +	 * load reservation is with a store conditional, so we emit one here.
>>> +	 * Since nothing ever takes a load reservation on TASK_THREAD_RA_RA we
>>> +	 * know this will always fail, but just to be on the safe side this
>>> +	 * writes the same value that was unconditionally written by the
>>> +	 * previous instruction.
>>> +	 */
>>> +#if (TASK_THREAD_RA_RA != 0)
>>
>> I don't think this check works as intended.  TASK_THREAD_RA_RA is a
>> parameterized macro,
>
> Is it?  Just because it is used before an open paren doesn't mean that
> the macro takes a parameter.

Yes, you're right -- the parens there aren't a macro parameter, they're the
assembly syntax for constant-offset loads.  I guess I'd just assumed Christoph
was referring to some magic in how asm-offsets gets generated, as I've never
actually looked inside that stuff.  I went ahead and just tested this

    $ git diff | cat
    diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
    index 578bb5efc085..e3f06495dbf8 100644
    --- a/arch/riscv/kernel/asm-offsets.c
    +++ b/arch/riscv/kernel/asm-offsets.c
    @@ -125,6 +125,7 @@ void asm_offsets(void)
            DEFINE(TASK_THREAD_RA_RA,
                      offsetof(struct task_struct, thread.ra)
                    - offsetof(struct task_struct, thread.ra)
    +               + 1
            );
            DEFINE(TASK_THREAD_SP_RA,
                      offsetof(struct task_struct, thread.sp)

and it causes the expected failure

     $ make.cross ARCH=riscv -j1
    make CROSS_COMPILE=/home/palmer/.local/opt/gcc-8.1.0-nolibc/riscv64-linux/bin/riscv64-linux- ARCH=riscv -j1
      CALL    scripts/checksyscalls.sh
      CALL    scripts/atomic/check-atomics.sh
      CHK     include/generated/compile.h
      AS      arch/riscv/kernel/entry.o
    arch/riscv/kernel/entry.S:344:3: error: #error "The offset between ra and ra is non-zero"
     # error "The offset between ra and ra is non-zero"
       ^~~~~
    make[1]: *** [scripts/Makefile.build:369: arch/riscv/kernel/entry.o] Error 1
    make: *** [Makefile:1071: arch/riscv/kernel] Error 2

so I'm going to leave it alone.  I'll submit a v2 with a better error message
and a cleaner sc.w/sc.d.
