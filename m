Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6836C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52198206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHKEYO7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbfDYRhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:37:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46459 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfDYRhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:37:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so174701pgg.13;
        Thu, 25 Apr 2019 10:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=raW0oogZ5EfoBzQqtBVYoEmvtzxY1VisvL2Lbh5qQDQ=;
        b=GHKEYO7Hfz3LD3x/OJtBtYafcNSP/eBGEq8b9UEohZ9A9EqBhU748ryEYgrRj1nPBx
         vavnGtoV21bO3swFep50I8HLbGnU5+U3B81339HhBERUhShBzIjMW/vuUJ78YrgnnM1n
         o3diHuAMm1etRfzo5V3W4ysJcEeQ1Vf953S5EWWqJQQ0a+IGl6ALKbqH7+OuANIvjKm1
         zzxsb5TTLJWFYIjADFbHOZsMdnWSy69x+xBHmXfcFE2gtRKisKjx3oU0IR5sNGlYwLc2
         BnACN1D7n757knfMqHlWoJNozKXC6/PZmo6sjS/NqY7zxcWMOm4pxzVK3FYjEwl4i42v
         fSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=raW0oogZ5EfoBzQqtBVYoEmvtzxY1VisvL2Lbh5qQDQ=;
        b=QSc8hcwqCBaZncv704Kry9lt5i95kGvubPHZG6dKPLaaKLALoPRdHNPFZoVxcShUIQ
         +hhhh0LbZprMbxuvBt41eWTirBt8TMpCnK2au5TDjuhIAO4MLYYE6yrK3HaUZf7iy8zZ
         oqr56DOyjkc/47C+2/0mUyiksMU2Brnyf9zdRisEqzG2B6Us18CPqNt1b39YDnOCj6g9
         Fy80D6muc2TMz2wKAE3E9t/mIu1fYkvLsCfVE4PuBPa9rXhENs35Re26RnU7Rhs8Inp6
         /PG8LA76oUNUbaAAfyo4b+qtA3ceG5m+U72Fd7d9IfUR+FvnTm6DHhCKNwYgdLNWRgfE
         Drtg==
X-Gm-Message-State: APjAAAUXto+PNyZCpbYjIMAYTv2o+kviAAggB+WpEPMM+9dnumNXQwD1
        ztW6TMg/78haVMmStsZCRT4=
X-Google-Smtp-Source: APXvYqxxCV+yXEWx+CQIRWWY23uYyNk79Hmhkp2bBTz26LTpZKzM5snNCcv7HqoRrFxgafIhMhGIew==
X-Received: by 2002:a62:e304:: with SMTP id g4mr17979717pfh.71.1556213859361;
        Thu, 25 Apr 2019 10:37:39 -0700 (PDT)
Received: from [10.2.189.129] ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id s9sm30512271pfe.183.2019.04.25.10.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 10:37:38 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH v4 03/23] x86/mm: Introduce temporary mm structs
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20190425162620.GA5199@zn.tnic>
Date:   Thu, 25 Apr 2019 10:37:35 -0700
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B7809434-CEBE-4664-ACE7-BA2412163CC4@gmail.com>
References: <20190422185805.1169-1-rick.p.edgecombe@intel.com>
 <20190422185805.1169-4-rick.p.edgecombe@intel.com>
 <20190425162620.GA5199@zn.tnic>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Apr 25, 2019, at 9:26 AM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> On Mon, Apr 22, 2019 at 11:57:45AM -0700, Rick Edgecombe wrote:
>> From: Andy Lutomirski <luto@kernel.org>
>>=20
>> Using a dedicated page-table for temporary PTEs prevents other cores
>> from using - even speculatively - these PTEs, thereby providing two
>> benefits:
>>=20
>> (1) Security hardening: an attacker that gains kernel memory writing
>> abilities cannot easily overwrite sensitive data.
>>=20
>> (2) Avoiding TLB shootdowns: the PTEs do not need to be flushed in
>> remote page-tables.
>>=20
>> To do so a temporary mm_struct can be used. Mappings which are =
private
>> for this mm can be set in the userspace part of the address-space.
>> During the whole time in which the temporary mm is loaded, interrupts
>> must be disabled.
>>=20
>> The first use-case for temporary mm struct, which will follow, is for
>> poking the kernel text.
>>=20
>> [ Commit message was written by Nadav Amit ]
>>=20
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Dave Hansen <dave.hansen@intel.com>
>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
>> Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>> ---
>> arch/x86/include/asm/mmu_context.h | 33 =
++++++++++++++++++++++++++++++
>> 1 file changed, 33 insertions(+)
>>=20
>> diff --git a/arch/x86/include/asm/mmu_context.h =
b/arch/x86/include/asm/mmu_context.h
>> index 19d18fae6ec6..d684b954f3c0 100644
>> --- a/arch/x86/include/asm/mmu_context.h
>> +++ b/arch/x86/include/asm/mmu_context.h
>> @@ -356,4 +356,37 @@ static inline unsigned long =
__get_current_cr3_fast(void)
>> 	return cr3;
>> }
>>=20
>> +typedef struct {
>> +	struct mm_struct *prev;
>> +} temp_mm_state_t;
>> +
>> +/*
>> + * Using a temporary mm allows to set temporary mappings that are =
not accessible
>> + * by other cores. Such mappings are needed to perform sensitive =
memory writes
>=20
> s/cores/CPUs/g
>=20
> Yeah, the concept of a thread of execution we call a CPU in the =
kernel,
> I'd say. No matter if it is one of the hyperthreads or a single thread
> in core.
>=20
>> + * that override the kernel memory protections (e.g., W^X), without =
exposing the
>> + * temporary page-table mappings that are required for these write =
operations to
>> + * other cores.
>=20
> Ditto.
>=20
>> Using temporary mm also allows to avoid TLB shootdowns when the
>=20
> Using a ..
>=20
>> + * mapping is torn down.
>> + *
>=20
> Nice commenting.
>=20
>> + * Context: The temporary mm needs to be used exclusively by a =
single core. To
>> + *          harden security IRQs must be disabled while the =
temporary mm is
> 			      ^
> 			      ,
>=20
>> + *          loaded, thereby preventing interrupt handler bugs from =
overriding
>> + *          the kernel memory protection.
>> + */
>> +static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
>> +{
>> +	temp_mm_state_t state;
>> +
>> +	lockdep_assert_irqs_disabled();
>> +	state.prev =3D this_cpu_read(cpu_tlbstate.loaded_mm);
>> +	switch_mm_irqs_off(NULL, mm, current);
>> +	return state;
>> +}
>> +
>> +static inline void unuse_temporary_mm(temp_mm_state_t prev)
>> +{
>> +	lockdep_assert_irqs_disabled();
>> +	switch_mm_irqs_off(NULL, prev.prev, current);
>=20
> I think this code would be more readable if you call that
> temp_mm_state_t variable "temp_state" and the mm_struct pointer "mm" =
and
> then you have:
>=20
> 	switch_mm_irqs_off(NULL, temp_state.mm, current);
>=20
> And above you'll have:
>=20
> 	temp_state.mm =3D ...

Andy, please let me know whether you are fine with this change and =
I=E2=80=99ll
incorporate it.=
