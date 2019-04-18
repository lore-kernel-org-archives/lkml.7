Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D42C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B14520675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="kLAKcwSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389098AbfDROO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:14:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38022 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388097AbfDROO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:14:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so1180902pfo.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 07:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6H1zDqGt/b6GJ482WgvFnq2ERnpwm9EfBRigbBTlPR0=;
        b=kLAKcwSAYSohAk3AmSls1kWVTtK5mFQNtiQBrnhPwokjCesCfrD1dty5fZMvMCqNcI
         TsIjkwQmUhYJZfawrpC+5duwzbCJz2zLE3c56LdGh8aiHxb4sbiDEGh3kJiDmoB++tgF
         00bzAMXoI/CH2dkivAWAs3IIyduNfPcBRRXDmGe+jvdLuMjlPRe11nGzauqIAV9qzwv1
         pGyfyfZV1FS17CcylazgO5LgXdRuS+S/vfvp9LWT2Sb7gYpPU8VssFAqmpI4DxE/HBxX
         /e+OAx7fwj2v1e092GFRLRcoEFZ+KUHQHOeNNP8ap7GwezwACvrBtCoSdXwUuWBHnobU
         xpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6H1zDqGt/b6GJ482WgvFnq2ERnpwm9EfBRigbBTlPR0=;
        b=sKuJK+eOxGCZw2awYZessdqhKqJPWxb4qFhD+/WDJD5Np4H2RXqtNU4p8wtGNj/Gxd
         VEXBqYx33Km4NsXBjIXzUo2dDJd/1kG9XdYMFUxW1xx92n/mp5ITxI0hVCr8RG50kpOJ
         M0tiHiAxbYX5J+ILwUUxoULXjZqpusefsz7oAHHTtuFYCWW+NodynXHehFhFgzDrUqRy
         yv1/rSp78Jgi3VHgVXbQpkG4NsyA+3/76u3wwo+coD54w0XIlOJNrHiU/mYZwu3jWdLl
         /HYP4MrtVnhlRJVG6MoiVmpId+OigTtXACQA5Mh61UsyUYtHtWXW6U0Fd9mAvvv/Oem8
         0yBQ==
X-Gm-Message-State: APjAAAVRkgsS9OoN4D78voNFMEy+AZcEF5dlNCeGSg2wx0yHGUuWfa03
        F7iAsdhD/dYK+webzUbXcmRctQ==
X-Google-Smtp-Source: APXvYqzlzMSXutx1EA9sYkcXLNM53oX/XQphzAkqs7maxBQTfheK9W064TN1tbI1vTrSn5wT3BJj8Q==
X-Received: by 2002:a65:4105:: with SMTP id w5mr56464036pgp.222.1555596897274;
        Thu, 18 Apr 2019 07:14:57 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:5c7f:f75f:f8ec:24c5? ([2601:646:c200:1ef2:5c7f:f75f:f8ec:24c5])
        by smtp.gmail.com with ESMTPSA id 17sm3964921pfw.65.2019.04.18.07.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 07:14:55 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86_64: Disabling read-implies-exec when the stack is executable
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <alpine.DEB.2.21.1904181015270.3174@nanos.tec.linutronix.de>
Date:   Thu, 18 Apr 2019 07:14:54 -0700
Cc:     Kees Cook <keescook@chromium.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Huaitong Han <huaitong.han@intel.com>,
        Ismael Ripoll Ripoll <iripoll@upv.es>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <74755222-0B16-4A81-85F6-D2803E4C0334@amacapital.net>
References: <1462963502-11636-1-git-send-email-hecmargi@upv.es> <CAGXu5jLZ-DgTfokLTqUHOUphO4C1FwHgYDLTA1oB9HBHnH-a1Q@mail.gmail.com> <alpine.DEB.2.21.1904181015270.3174@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Apr 18, 2019, at 1:17 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
>> On Thu, 18 Apr 2019, Kees Cook wrote:
>> On Wed, May 11, 2016 at 5:45 AM Hector Marco-Gisbert <hecmargi@upv.es> wr=
ote:
>> *thread necromancy*
>>=20
>> I'd still like to see this get landed. READ_IMPLIES_EXEC is way too
>> powerful (it impacts, for example, mmap() regions of device driver
>> memory, forcing drivers to not be able to disallow VM_EXEC[1]).
>>=20
>> The only case it could break is on an AMD K8 (Athlon only, I assume?),
>> which seems unlikely to have a modern kernel run on it. If there is
>> still concern, then we could just test against the NX CPU feature:
>>=20
>> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
>> index 69c0f892e310..367cd36259a4 100644
>> --- a/arch/x86/include/asm/elf.h
>> +++ b/arch/x86/include/asm/elf.h
>> @@ -280,10 +280,12 @@ extern u32 elf_hwcap2;
>>=20
>> /*
>>  * An executable for which elf_read_implies_exec() returns TRUE will
>> - * have the READ_IMPLIES_EXEC personality flag set automatically.
>> + * have the READ_IMPLIES_EXEC personality flag set automatically when
>> + * a CPU did not support NX or is using a 32-bit memory layout.
>>  */
>> -#define elf_read_implies_exec(ex, executable_stack)    \
>> -       (executable_stack !=3D EXSTACK_DISABLE_X)
>> +#define elf_read_implies_exec(ex, executable_stack)            \
>> +       (mmap_is_ia32() || !(__supported_pte_mask & _PAGE_NX) ? \
>=20
> What's special about ia32? All what matters is whether PAGE_NX is supporte=
d
> or not. That has nothing to do with 32/64bit unless I'm missing something
> (as usual).
>=20
>=20

I have the opposite question: who cares if we have NX?  On a CPU without NX,=
 read implies exec, full stop. Why should nasty personality stuff matter at a=
ll?  The personality stuff is about supporting old crufty binaries.

So: are there old 64-bit binaries that have their stacks marked RX that expe=
ct mmap to automatically return X memory?  If so, then the patch is a proble=
m. If not, then maybe the patch is okay.

All that being said, the comment in the patch seems to be highly misleading.=
  If the patch is to be applied, the comment needs serious work.=
