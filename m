Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E61FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0215022CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="R3prp1MW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfH1Vhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 17:37:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44649 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfH1Vhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:37:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so386009pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 14:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Y5CgfqiMSShVcJIHPwChoaUI5jnbFihdLP9y/3LJuNE=;
        b=R3prp1MWTGHinnPidcl7VICFaEI8rvZssimKcVm5/NyNxNjrU8S48iPqPHOLyPTXvS
         5ORMOZw1CqRZKS8QMvSf/zU9dxga/BXHvfF49dBcQko6DZz5nu8ZdPLQqDAuFmlsdrfO
         pVPkXZSt+VQQW8jwhuA7J+J7ikakmI1kgWIQfyDcayYPgm6DtCDRXjptreKSscQP7eyS
         fwLNFZgxVp8zFccHJJkWKBZqPJRY160eNzNK5YsmSGeJzvRWHCrrGZr8dE4gAA/WWqQb
         g4Rl5HKQiylJQsMv/g/dwJPMbM7R/6cAQi2R4t+Ryp4BtYQu0o1obBoqCie8iI/wrmu6
         EIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Y5CgfqiMSShVcJIHPwChoaUI5jnbFihdLP9y/3LJuNE=;
        b=TB597ptMQyq8IpFm/HFP20AoyL4eMa/tI9XgEhSGzfWgcCYd7SapcZnwLSLT3vd9bj
         Ob/V3AJBDkODSkHKRADtYZT6NQ2uQnB4iRiQCVrr28Mgqim3hQiectIt5KzHOVaTVl1d
         Yw0TnGYZEc0P1z8nOHgJv2c6xLB6yb6EZ8gonz70ngGcwtOxeDfVDSdrEc3IuA4YdBQy
         w7MNv+Bwe0/14FI1sg/Ze7tOgcvsqw5rZPw7iF8dv7AgEMELcJJPrUoAdpQOOhU6RHUU
         ZyIIIJ7C+XuClCIDftsj4nSiolOs8ZRjiHDCjEL+oyE14kKY55P/+YoRPXgqrX85L3T0
         i0dQ==
X-Gm-Message-State: APjAAAUFDXyM/6hHRs+fsNXiViifKBH6Hd+zepnoFUzKP2wwqCcWjnfN
        mB2zbGMWGyoFmVt8jmRA0a7qmQ==
X-Google-Smtp-Source: APXvYqwjqk2RLXwbcIxDHoQOIkaEut6i7nG3Qo/gpY2k8JRUenwbpENdFGpse+imvvjq/h5Ig70C9A==
X-Received: by 2002:aa7:9edc:: with SMTP id r28mr6994148pfq.219.1567028254664;
        Wed, 28 Aug 2019 14:37:34 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id u24sm122218pgk.31.2019.08.28.14.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 14:37:33 -0700 (PDT)
Date:   Wed, 28 Aug 2019 14:37:33 -0700 (PDT)
X-Google-Original-Date: Wed, 28 Aug 2019 14:35:23 PDT (-0700)
Subject:     Re: [RFC PATCH 1/2] RISC-V: Mark existing SBI as legacy SBI.
In-Reply-To: <20190827083700.GF682@rapoport-lnx>
CC:     anup@brainfault.org, aou@eecs.berkeley.edu, alankao@andestech.com,
        alexios.zavras@intel.com, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        gary@garyguo.net, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, tglx@linutronix.de
From:   Palmer Dabbelt <palmer@sifive.com>
To:     rppt@linux.ibm.com
Message-ID: <mhng-fbf98ed7-3965-43d2-a816-ee1922bd4df1@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019 01:37:00 PDT (-0700), rppt@linux.ibm.com wrote:
> On Tue, Aug 27, 2019 at 01:58:03PM +0530, Anup Patel wrote:
>> On Tue, Aug 27, 2019 at 1:21 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>> >
>> > On Mon, Aug 26, 2019 at 04:32:55PM -0700, Atish Patra wrote:
>> > > As per the new SBI specification, current SBI implementation is
>> > > defined as legacy and will be removed/replaced in future.
>> > >
>> > > Rename existing implementation to reflect that. This patch is just
>> > > a preparatory patch for SBI v0.2 and doesn't introduce any functional
>> > > changes.
>> > >
>> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> > > ---
>> > >  arch/riscv/include/asm/sbi.h | 61 +++++++++++++++++++-----------------
>> > >  1 file changed, 33 insertions(+), 28 deletions(-)
>> > >
>> > > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
>> > > index 21134b3ef404..7f5ecaaaa0d7 100644
>> > > --- a/arch/riscv/include/asm/sbi.h
>> > > +++ b/arch/riscv/include/asm/sbi.h
>> > > @@ -8,17 +8,18 @@
>> > >
>> > >  #include <linux/types.h>
>> > >
>> > > -#define SBI_SET_TIMER 0
>> > > -#define SBI_CONSOLE_PUTCHAR 1
>> > > -#define SBI_CONSOLE_GETCHAR 2
>> > > -#define SBI_CLEAR_IPI 3
>> > > -#define SBI_SEND_IPI 4
>> > > -#define SBI_REMOTE_FENCE_I 5
>> > > -#define SBI_REMOTE_SFENCE_VMA 6
>> > > -#define SBI_REMOTE_SFENCE_VMA_ASID 7
>> > > -#define SBI_SHUTDOWN 8
>> > > -
>> > > -#define SBI_CALL(which, arg0, arg1, arg2, arg3) ({           \
>> > > +
>> > > +#define SBI_EXT_LEGACY_SET_TIMER 0x0
>> > > +#define SBI_EXT_LEGACY_CONSOLE_PUTCHAR 0x1
>> > > +#define SBI_EXT_LEGACY_CONSOLE_GETCHAR 0x2
>> > > +#define SBI_EXT_LEGACY_CLEAR_IPI 0x3
>> > > +#define SBI_EXT_LEGACY_SEND_IPI 0x4
>> > > +#define SBI_EXT_LEGACY_REMOTE_FENCE_I 0x5
>> > > +#define SBI_EXT_LEGACY_REMOTE_SFENCE_VMA 0x6
>> > > +#define SBI_EXT_LEGACY_REMOTE_SFENCE_VMA_ASID 0x7
>> > > +#define SBI_EXT_LEGACY_SHUTDOWN 0x8
>> >
>> > I can't say I'm closely following RISC-V development, but what will happen
>> > when SBI v0.3 will come out and will render v0.2 legacy?
>> > Won't we need another similar renaming then?
>>
>> Going forward with SBI v0.3 and higher, we won't see any calling
>> convention changes.
>>
>> The SBI spec will be maintained and improved by RISC-V UNIX
>> platform spec working group.
>>
>> My best guess is that, all future SBI releases (v0.3 or higher) will
>> include more optional SBI extensions (hart hotplug, power management, etc).
>
> Thanks for the clarification!

Specifically the issue is that 0.1 didn't include any mechanism for probing the 
existence of a function, but since that has been added in 0.2 it's possible to 
maintain compatible with future versions.

>
>> Regards,
>> Anup
>>
>> >
>> > > +#define SBI_CALL_LEGACY(which, arg0, arg1, arg2, arg3) ({             \
>> > >       register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);   \
>> > >       register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);   \
>> > >       register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);   \
>> > > @@ -32,58 +33,61 @@
>> > >  })
>> > >
>> > >  /* Lazy implementations until SBI is finalized */
>> > > -#define SBI_CALL_0(which) SBI_CALL(which, 0, 0, 0, 0)
>> > > -#define SBI_CALL_1(which, arg0) SBI_CALL(which, arg0, 0, 0, 0)
>> > > -#define SBI_CALL_2(which, arg0, arg1) SBI_CALL(which, arg0, arg1, 0, 0)
>> > > -#define SBI_CALL_3(which, arg0, arg1, arg2) \
>> > > -             SBI_CALL(which, arg0, arg1, arg2, 0)
>> > > -#define SBI_CALL_4(which, arg0, arg1, arg2, arg3) \
>> > > -             SBI_CALL(which, arg0, arg1, arg2, arg3)
>> > > +#define SBI_CALL_LEGACY_0(which) SBI_CALL_LEGACY(which, 0, 0, 0, 0)
>> > > +#define SBI_CALL_LEGACY_1(which, arg0) SBI_CALL_LEGACY(which, arg0, 0, 0, 0)
>> > > +#define SBI_CALL_LEGACY_2(which, arg0, arg1) \
>> > > +             SBI_CALL_LEGACY(which, arg0, arg1, 0, 0)
>> > > +#define SBI_CALL_LEGACY_3(which, arg0, arg1, arg2) \
>> > > +             SBI_CALL_LEGACY(which, arg0, arg1, arg2, 0)
>> > > +#define SBI_CALL_LEGACY_4(which, arg0, arg1, arg2, arg3) \
>> > > +             SBI_CALL_LEGACY(which, arg0, arg1, arg2, arg3)
>> > >
>> > >  static inline void sbi_console_putchar(int ch)
>> > >  {
>> > > -     SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
>> > > +     SBI_CALL_LEGACY_1(SBI_EXT_LEGACY_CONSOLE_PUTCHAR, ch);
>> > >  }
>> > >
>> > >  static inline int sbi_console_getchar(void)
>> > >  {
>> > > -     return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
>> > > +     return SBI_CALL_LEGACY_0(SBI_EXT_LEGACY_CONSOLE_GETCHAR);
>> > >  }
>> > >
>> > >  static inline void sbi_set_timer(uint64_t stime_value)
>> > >  {
>> > >  #if __riscv_xlen == 32
>> > > -     SBI_CALL_2(SBI_SET_TIMER, stime_value, stime_value >> 32);
>> > > +     SBI_CALL_LEGACY_2(SBI_EXT_LEGACY_SET_TIMER, stime_value,
>> > > +                       stime_value >> 32);
>> > >  #else
>> > > -     SBI_CALL_1(SBI_SET_TIMER, stime_value);
>> > > +     SBI_CALL_LEGACY_1(SBI_EXT_LEGACY_SET_TIMER, stime_value);
>> > >  #endif
>> > >  }
>> > >
>> > >  static inline void sbi_shutdown(void)
>> > >  {
>> > > -     SBI_CALL_0(SBI_SHUTDOWN);
>> > > +     SBI_CALL_LEGACY_0(SBI_EXT_LEGACY_SHUTDOWN);
>> > >  }
>> > >
>> > >  static inline void sbi_clear_ipi(void)
>> > >  {
>> > > -     SBI_CALL_0(SBI_CLEAR_IPI);
>> > > +     SBI_CALL_LEGACY_0(SBI_EXT_LEGACY_CLEAR_IPI);
>> > >  }
>> > >
>> > >  static inline void sbi_send_ipi(const unsigned long *hart_mask)
>> > >  {
>> > > -     SBI_CALL_1(SBI_SEND_IPI, hart_mask);
>> > > +     SBI_CALL_LEGACY_1(SBI_EXT_LEGACY_SEND_IPI, hart_mask);
>> > >  }
>> > >
>> > >  static inline void sbi_remote_fence_i(const unsigned long *hart_mask)
>> > >  {
>> > > -     SBI_CALL_1(SBI_REMOTE_FENCE_I, hart_mask);
>> > > +     SBI_CALL_LEGACY_1(SBI_EXT_LEGACY_REMOTE_FENCE_I, hart_mask);
>> > >  }
>> > >
>> > >  static inline void sbi_remote_sfence_vma(const unsigned long *hart_mask,
>> > >                                        unsigned long start,
>> > >                                        unsigned long size)
>> > >  {
>> > > -     SBI_CALL_3(SBI_REMOTE_SFENCE_VMA, hart_mask, start, size);
>> > > +     SBI_CALL_LEGACY_3(SBI_EXT_LEGACY_REMOTE_SFENCE_VMA, hart_mask,
>> > > +                       start, size);
>> > >  }
>> > >
>> > >  static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
>> > > @@ -91,7 +95,8 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
>> > >                                             unsigned long size,
>> > >                                             unsigned long asid)
>> > >  {
>> > > -     SBI_CALL_4(SBI_REMOTE_SFENCE_VMA_ASID, hart_mask, start, size, asid);
>> > > +     SBI_CALL_LEGACY_4(SBI_EXT_LEGACY_REMOTE_SFENCE_VMA_ASID, hart_mask,
>> > > +                       start, size, asid);
>> > >  }
>> > >
>> > >  #endif
>> > > --
>> > > 2.21.0
>> > >
>> > >
>> > > _______________________________________________
>> > > linux-riscv mailing list
>> > > linux-riscv@lists.infradead.org
>> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
>> > >
>> >
>> > --
>> > Sincerely yours,
>> > Mike.
>> >
>> >
>> > _______________________________________________
>> > linux-riscv mailing list
>> > linux-riscv@lists.infradead.org
>> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
