Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C38CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 20:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4BA20717
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 20:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CL8/8ne2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbfKDU7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 15:59:48 -0500
Received: from mout.gmx.net ([212.227.15.15]:33067 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728559AbfKDU7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 15:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572901112;
        bh=o9zHlgAY77TGflpzTqEN0LG4kSpDdTWJLg2wRgivjGU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CL8/8ne27xu6Ld5/yV8OWVc7UVDl40OSIUKAO/aLAKqDfuVfja+UfCu/mD23/lmZg
         UFl6IxezEkKV7CDuPHC6pgUa54zfe+Y8MPh2Eyqnl+jfy4qJu4lB7yBF5zpXLNI6fj
         dtXGXLGr9vzkvsTaLMEEeWHvcU78qtGmH5GzLRn8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.167.207]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7sDg-1iWfNK224Y-0051am; Mon, 04
 Nov 2019 21:58:32 +0100
Subject: Re: [PATCHv2 2/8] module/ftrace: handle patchable-function-entry
To:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, Jessica Yu <jeyu@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@arm.com,
        catalin.marinas@arm.com, duwe@suse.de, james.morse@arm.com,
        jpoimboe@redhat.com, jthierry@redhat.com,
        linux-parisc@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org, svens@stackframe.org,
        takahiro.akashi@linaro.org, will@kernel.org
References: <20191029165832.33606-1-mark.rutland@arm.com>
 <20191029165832.33606-3-mark.rutland@arm.com>
 <20191104155132.GA1643@lakrids.cambridge.arm.com>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 oiAieEtb6a/7+jPKZnRFTw==
Message-ID: <ac753055-1542-1636-b95a-bac5c3014643@gmx.de>
Date:   Mon, 4 Nov 2019 21:58:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191104155132.GA1643@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Nq7uHo8vLJ9av4lm198qsWtZq+Kbr0zXPbi0OBky+J98bDf8Zd7
 5z5YL1z1AbfVhT7l2S9j/xKwr8s4VPhf6U0+toQIPd33u6DjlLsAS7xNY6u2T21wC864c3p
 wNNXlUaXhHGIIwTDiq11n7kUTmIFkX9P8zV9cXESaGLXFsHfTEuna0lHXhccKphDhXPxfmu
 q1+2gwMCrM9an1OfV9laQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HM76uRE6QC8=:qFrjSQ6VveTIJaNERAly2t
 +7BW9qHdV3ZLGV5VE/MmzyYphyZjZRidEas+D3YjmznC7F0v6HcVk3RIX7o15x0QlzMb9lwP2
 t2eqAu8loKhdOc/D1Jmo1D4pwY1x54jytpQAB0wVXpfJlgBMPbj5DmmFBfIY3aKGlqeA3jsQ4
 jo14QnbBzj2bbtyh5WjcTNL1XaX2yf30AFc4j/vKgaR+6xLjHczkjqHMTU8G2sqbKQ1870bl+
 x3YddN8KOBhQQmEEAUb7wAVEGBnwSWQqTFsiYgKkg7AUKzIh2afaN7Api5+0YOzSPU3pWXusl
 xzmOp4l0V3TDmNPXxsJ+62nug1n/qqmbZTS6GkeN6L/WiioieNIxmFwHOG8O76Wr3jsEJTGJ5
 9GScrQCGBxjK9Q9fUbZdcWAnyKgn0pZj0rwNLaBJMahBSYchgFgpmXwAvRnrS7Qu67LBDA1yn
 KeP3NzN54eDwtBZj+vKIucTP1R23CpUI59WJ0q/f6rXBY3plhsVFZFVxYaRVSB4rj53RZZH04
 iYKmjo+NAdbB0PZNo5u/M9Y2/5dcpw/myi+56EdlTVjyah1vgqlc22DhhNSXrp25sL5WJyvkY
 0QEMPhBaP4+/tRpw/yPLA8kDXE33+AZj/7hIQZ4+oP/Cm+W0tsE29eN1UpLL9Gq2UdodrY3ca
 9uT/MbipfGL1rvd0+tmoUdSXd0Z+rEM2tW/NRRXUd2lxJ6DOW+uYCklqIPZE9ZK/vaBYqhRsR
 hTFzpq566pp08/hN+35c9MlaaksPSZWFBWNbQ7FegM3nLabx0fmEoTqN76HM5C0JcISXCQXE/
 0RNYoEevnZIzu7rwHjpBmWjapM0ZjZHjb9yXzrG0UhLumGd8hLMoejaA2u3WTbbPJtbnW/dm0
 tE+hHTR8gghI9K0v/Jb0/GLPQmXGMWDpj/U/lyIfDZoAl+alnq/c3JPt341TLA5QIH39OMsiX
 asuz2IfLa1/i+auAsA9GexmW1a1NNzozMEB+H8daPsBcYdWakRaxYT7hdYs3sPhun/70+/dV1
 xIxRzRfcBBV1aVabLdC7sEftbGHNTOJ/ZTmIqvyA0CLU3oNeZA0evBfcoaJYgVeI9OUkWALeo
 IiIc5bnsYtD5q2LNYefZTNDlHM8xMxttkc4x5dmqiVN8UonVcO0X28FgUIUQdyABbChwmJBq6
 0858Xt6zpR/96QIkh526SahE98ADlXG42vSNrQZyDHNicIWNWsRdJHUZ/5ftmqp8QyiG7lB7e
 Da8LUOSO1SjNK/w+/DfEosnU3m752y6EqrsZrpA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 04.11.19 16:51, Mark Rutland wrote:
> Hi Jessica, Helge,
>
> Are you ok with the module and parisc changes, repectively?

Sure, please add my:
Acked-by: Helge Deller <deller@gmx.de>

Helge

> The kbuild test robot is happy building this for multiple architectures,
> Sven has tested that this works correctly on parisc, and others have
> tested other architectures.
>
> I'd like to queue this in the arm64 tree soon if possible.
>
> Thanks,
> Mark.
>
> On Tue, Oct 29, 2019 at 04:58:26PM +0000, Mark Rutland wrote:
>> When using patchable-function-entry, the compiler will record the
>> callsites into a section named "__patchable_function_entries" rather
>> than "__mcount_loc". Let's abstract this difference behind a new
>> FTRACE_CALLSITE_SECTION, so that architectures don't have to handle thi=
s
>> explicitly (e.g. with custom module linker scripts).
>>
>> As parisc currently handles this explicitly, it is fixed up accordingly=
,
>> with its custom linker script removed. Since FTRACE_CALLSITE_SECTION is
>> only defined when DYNAMIC_FTRACE is selected, the parisc module loading
>> code is updated to only use the definition in that case. When
>> DYNAMIC_FTRACE is not selected, modules shouldn't have this section, so
>> this removes some redundant work in that case.
>>
>> I built parisc generic-{32,64}bit_defconfig with DYNAMIC_FTRACE enabled=
,
>> and verified that the section made it into the .ko files for modules.
>>
>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: Helge Deller <deller@gmx.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
>> Cc: Jessica Yu <jeyu@kernel.org>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Sven Schnelle <svens@stackframe.org>
>> Cc: linux-parisc@vger.kernel.org
>> ---
>>  arch/parisc/Makefile          |  1 -
>>  arch/parisc/kernel/module.c   | 10 +++++++---
>>  arch/parisc/kernel/module.lds |  7 -------
>>  include/linux/ftrace.h        |  5 +++++
>>  kernel/module.c               |  2 +-
>>  5 files changed, 13 insertions(+), 12 deletions(-)
>>  delete mode 100644 arch/parisc/kernel/module.lds
>>
>> diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
>> index 36b834f1c933..dca8f2de8cf5 100644
>> --- a/arch/parisc/Makefile
>> +++ b/arch/parisc/Makefile
>> @@ -60,7 +60,6 @@ KBUILD_CFLAGS +=3D -DCC_USING_PATCHABLE_FUNCTION_ENTR=
Y=3D1 \
>>  		 -DFTRACE_PATCHABLE_FUNCTION_SIZE=3D$(NOP_COUNT)
>>
>>  CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D$(NOP_COUNT),$(shell=
 echo $$(($(NOP_COUNT)-1)))
>> -KBUILD_LDS_MODULE +=3D $(srctree)/arch/parisc/kernel/module.lds
>>  endif
>>
>>  OBJCOPY_FLAGS =3D-O binary -R .note -R .comment -S
>> diff --git a/arch/parisc/kernel/module.c b/arch/parisc/kernel/module.c
>> index ac5f34993b53..1c50093e2ebe 100644
>> --- a/arch/parisc/kernel/module.c
>> +++ b/arch/parisc/kernel/module.c
>> @@ -43,6 +43,7 @@
>>  #include <linux/elf.h>
>>  #include <linux/vmalloc.h>
>>  #include <linux/fs.h>
>> +#include <linux/ftrace.h>
>>  #include <linux/string.h>
>>  #include <linux/kernel.h>
>>  #include <linux/bug.h>
>> @@ -862,7 +863,7 @@ int module_finalize(const Elf_Ehdr *hdr,
>>  	const char *strtab =3D NULL;
>>  	const Elf_Shdr *s;
>>  	char *secstrings;
>> -	int err, symindex =3D -1;
>> +	int symindex =3D -1;
>>  	Elf_Sym *newptr, *oldptr;
>>  	Elf_Shdr *symhdr =3D NULL;
>>  #ifdef DEBUG
>> @@ -946,11 +947,13 @@ int module_finalize(const Elf_Ehdr *hdr,
>>  			/* patch .altinstructions */
>>  			apply_alternatives(aseg, aseg + s->sh_size, me->name);
>>
>> +#ifdef CONFIG_DYNAMIC_FTRACE
>>  		/* For 32 bit kernels we're compiling modules with
>>  		 * -ffunction-sections so we must relocate the addresses in the
>> -		 *__mcount_loc section.
>> +		 *  ftrace callsite section.
>>  		 */
>> -		if (symindex !=3D -1 && !strcmp(secname, "__mcount_loc")) {
>> +		if (symindex !=3D -1 && !strcmp(secname, FTRACE_CALLSITE_SECTION)) {
>> +			int err;
>>  			if (s->sh_type =3D=3D SHT_REL)
>>  				err =3D apply_relocate((Elf_Shdr *)sechdrs,
>>  							strtab, symindex,
>> @@ -962,6 +965,7 @@ int module_finalize(const Elf_Ehdr *hdr,
>>  			if (err)
>>  				return err;
>>  		}
>> +#endif
>>  	}
>>  	return 0;
>>  }
>> diff --git a/arch/parisc/kernel/module.lds b/arch/parisc/kernel/module.=
lds
>> deleted file mode 100644
>> index 1a9a92aca5c8..000000000000
>> --- a/arch/parisc/kernel/module.lds
>> +++ /dev/null
>> @@ -1,7 +0,0 @@
>> -/* SPDX-License-Identifier: GPL-2.0 */
>> -
>> -SECTIONS {
>> -	__mcount_loc : {
>> -		*(__patchable_function_entries)
>> -	}
>> -}
>> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
>> index 9867d90d635e..9141f2263286 100644
>> --- a/include/linux/ftrace.h
>> +++ b/include/linux/ftrace.h
>> @@ -738,6 +738,11 @@ static inline unsigned long get_lock_parent_ip(voi=
d)
>>
>>  #ifdef CONFIG_FTRACE_MCOUNT_RECORD
>>  extern void ftrace_init(void);
>> +#ifdef CC_USING_PATCHABLE_FUNCTION_ENTRY
>> +#define FTRACE_CALLSITE_SECTION	"__patchable_function_entries"
>> +#else
>> +#define FTRACE_CALLSITE_SECTION	"__mcount_loc"
>> +#endif
>>  #else
>>  static inline void ftrace_init(void) { }
>>  #endif
>> diff --git a/kernel/module.c b/kernel/module.c
>> index ff2d7359a418..acf7962936c4 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -3222,7 +3222,7 @@ static int find_module_sections(struct module *mo=
d, struct load_info *info)
>>  #endif
>>  #ifdef CONFIG_FTRACE_MCOUNT_RECORD
>>  	/* sechdrs[0].sh_size is always zero */
>> -	mod->ftrace_callsites =3D section_objs(info, "__mcount_loc",
>> +	mod->ftrace_callsites =3D section_objs(info, FTRACE_CALLSITE_SECTION,
>>  					     sizeof(*mod->ftrace_callsites),
>>  					     &mod->num_ftrace_callsites);
>>  #endif
>> --
>> 2.11.0
>>

