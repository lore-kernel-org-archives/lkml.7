Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3AFC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 20:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFEB20857
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 20:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MQVqqRNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfDUUHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 16:07:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50845 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfDUUHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 16:07:31 -0400
Received: from [IPv6:2601:646:8680:2bb1:844c:2e29:7c13:f0bc] ([IPv6:2601:646:8680:2bb1:844c:2e29:7c13:f0bc])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x3LK7Fbp1319142
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 21 Apr 2019 13:07:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x3LK7Fbp1319142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555877238;
        bh=eS8uCVOKbnfxvVl834Q+CPSo+ymVh5DSXFEAW80LHvc=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=MQVqqRNKowPh63ENRvHwkvUFflAYXabgNHPDKCykeG9ylqBKeVmlhPGVJbcV9C1nc
         9nUI9qG8sYBapif62ZrY5OTbwrgyGqhpHQpfHayUPqhkkWsicRVJ2UllA2t3oj7Jxc
         WL4h3NLk/COzjapi5kHXCcf4Nxz4o0BGroEUBKOSEWIFv1POtCaB3UmOXni6M5WLMN
         kN0oLBS86S39sqZPK6Ipm/u0y1orjCzZB2sefOkXrrHdEme2JNM/8BbnkMXc3UsAbH
         2Rp6zoAA1jg7PM27d4kFrySkC2AzmUk1b8OZlWWp9OkDveOP0cs6ejobI8Nc5e+IWo
         vVK9tdKSfTDbg==
Date:   Sun, 21 Apr 2019 13:07:08 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20190421182842.GD35603@gmail.com>
References: <20190421160600.GA31092@avx2> <20190421182842.GD35603@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] x86_64: uninline TASK_SIZE
To:     Ingo Molnar <mingo@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
CC:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        linux-kernel@vger.kernel.org, x86@kernel.org
From:   hpa@zytor.com
Message-ID: <8B42CD57-9343-4234-A96D-80337BFFDF0E@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 21, 2019 11:28:42 AM PDT, Ingo Molnar <mingo@kernel=2Eorg> wrote:
>
>* Alexey Dobriyan <adobriyan@gmail=2Ecom> wrote:
>
>> TASK_SIZE macro is quite deceptive: it looks like a constant but in
>fact
>> compiles to 50+ bytes=2E
>>=20
>> Space savings on x86_64 defconfig:
>>=20
>> add/remove: 1/0 grow/shrink: 3/24 up/down: 77/-2247 (-2170)
>> Function                                     old     new   delta
>> _task_size                                     -      52     +52
>> mpol_shared_policy_init                      344     363     +19
>> shmem_get_unmapped_area                       92      97      +5
>> __rseq_handle_notify_resume=2Ecold              34      35      +1
>> copy_from_user_nmi                           123     113     -10
>> mmap_address_hint_valid                       92      56     -36
>> arch_get_unmapped_area_topdown               471     435     -36
>> tlb_gather_mmu                               164     126     -38
>> hugetlb_get_unmapped_area                    774     736     -38
>> __create_xol_area                            497     458     -39
>> arch_tlb_gather_mmu                          160     120     -40
>> setup_new_exec                               380     336     -44
>> __x64_sys_mlockall                           378     333     -45
>> __ia32_sys_mlockall                          378     333     -45
>> tlb_flush_mmu                                235     189     -46
>> unmap_page_range                            2098    2048     -50
>> copy_mount_options                           518     465     -53
>> __get_user_pages                            1737    1675     -62
>> get_unmapped_area                            270     204     -66
>> perf_prepare_sample                         1176    1098     -78
>> perf_callchain_user                          549     469     -80
>> mremap_to=2Eisra                               545     457     -88
>> arch_tlb_finish_mmu                          394     305     -89
>> __do_munmap                                 1039     927    -112
>> elf_map                                      527     409    -118
>> prctl_set_mm                                1509    1335    -174
>> __rseq_handle_notify_resume                 1116     906    -210
>> load_elf_binary                            11761   11111    -650
>> Total: Before=3D14121337, After=3D14119167, chg -0=2E02%
>>=20
>> Signed-off-by: Alexey Dobriyan <adobriyan@gmail=2Ecom>
>> ---
>>=20
>>  arch/x86/include/asm/processor=2Eh |    4 ++--
>>  arch/x86/kernel/Makefile         |    1 +
>>  arch/x86/kernel/task_size_64=2Ec   |    9 +++++++++
>>  3 files changed, 12 insertions(+), 2 deletions(-)
>>=20
>> --- a/arch/x86/include/asm/processor=2Eh
>> +++ b/arch/x86/include/asm/processor=2Eh
>> @@ -887,8 +887,8 @@ static inline void spin_lock_prefetch(const void
>*x)
>> =20
>>  #define TASK_SIZE_LOW		(test_thread_flag(TIF_ADDR32) ? \
>>  					IA32_PAGE_OFFSET : DEFAULT_MAP_WINDOW)
>> -#define TASK_SIZE		(test_thread_flag(TIF_ADDR32) ? \
>> -					IA32_PAGE_OFFSET : TASK_SIZE_MAX)
>> +unsigned long _task_size(void);
>> +#define TASK_SIZE		_task_size()
>>  #define TASK_SIZE_OF(child)	((test_tsk_thread_flag(child,
>TIF_ADDR32)) ? \
>>  					IA32_PAGE_OFFSET : TASK_SIZE_MAX)
>> =20
>> --- a/arch/x86/kernel/Makefile
>> +++ b/arch/x86/kernel/Makefile
>> @@ -46,6 +46,7 @@ CFLAGS_irq=2Eo :=3D -I$(src)/=2E=2E/include/asm/trace
>> =20
>>  obj-y			:=3D process_$(BITS)=2Eo signal=2Eo
>>  obj-$(CONFIG_COMPAT)	+=3D signal_compat=2Eo
>> +obj-$(CONFIG_X86_64)	+=3D task_size_64=2Eo
>>  obj-y			+=3D traps=2Eo idt=2Eo irq=2Eo irq_$(BITS)=2Eo dumpstack_$(BIT=
S)=2Eo
>>  obj-y			+=3D time=2Eo ioport=2Eo dumpstack=2Eo nmi=2Eo
>>  obj-$(CONFIG_MODIFY_LDT_SYSCALL)	+=3D ldt=2Eo
>> new file mode 100644
>> --- /dev/null
>> +++ b/arch/x86/kernel/task_size_64=2Ec
>> @@ -0,0 +1,9 @@
>> +#include <linux/export=2Eh>
>> +#include <linux/sched=2Eh>
>> +#include <linux/thread_info=2Eh>
>> +
>> +unsigned long _task_size(void)
>> +{
>> +	return test_thread_flag(TIF_ADDR32) ? IA32_PAGE_OFFSET :
>TASK_SIZE_MAX;
>> +}
>> +EXPORT_SYMBOL(_task_size);
>
>Good idea - but instead of adding yet another compilation unit, why not
>
>stick _task_size() into arch/x86/kernel/process_64=2Ec, which is the=20
>canonical place for process management related arch functions?
>
>Thanks,
>
>	Ingo

Better yet=2E=2E=2E since TIF_ADDR32 isn't something that changes randomly=
, perhaps this should be a separate variable?
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
