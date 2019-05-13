Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03869C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36CE20873
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfEMV17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 17:27:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:37697 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfEMV17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 17:27:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 14:27:58 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 13 May 2019 14:27:58 -0700
Received: from [10.251.13.252] (kliang2-mobl.ccr.corp.intel.com [10.251.13.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 99F98580416;
        Mon, 13 May 2019 14:27:57 -0700 (PDT)
Subject: Re: [RESEND PATCH 1/3] perf, tools: Add support for recording and
 printing XMM registers
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Kan Liang <kan.liang@intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        ak@ghostprotocols.net
References: <20190513182541.GC8003@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <d5363c4c-c8ad-1766-132d-4e97d339d999@linux.intel.com>
Date:   Mon, 13 May 2019 17:27:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513182541.GC8003@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/2019 2:37 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, May 13, 2019 at 01:37:16PM -0400, Arnaldo Carvalho de Melo escreveu:
>> Em Mon, May 06, 2019 at 07:19:24AM -0700, kan.liang@linux.intel.com escreveu:
>>> From: Andi Kleen <ak@linux.intel.com>
>>>
>>> Icelake and later platforms support collecting XMM registers with PEBS
>>> event.
>>> Add support for perf script to dump them, and support
>>> for the register parser in perf record -I ... to configure them.
>>> For now they are just printed in hex, could potentially add
>>> other formats too.
>>
>> So I noticed the sync warning about
>> tools/arch/x86/include/uapi/asm/perf_regs.h abd added a separate patch
>> for that, removing this part from this patch, applying it afterward.
> 
> Also, when using 'perf record -I foobar' it should record all registers,
> which I think includes the xmm registers in capable platforms, from your
> 'Add perf script support to dump them', so I tried running it here on a
> skylake notebook, i.e. where it fails when I ask for a specific xmm
> register:
> 
>    # perf record -Isi,di,xmm0 sleep 1
>    Error:
>    The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cycles).
>    /bin/dmesg | grep -i perf may provide additional information.
> 
>    # perf record -I?
>    available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 XMM9 XMM10 XMM11 XMM12 XMM13 XMM14 XMM15
> 
>     Usage: perf record [<options>] [<command>]
>        or: perf record [<options>] -- <command> [<options>]
> 
>        -I, --intr-regs[=<any register>]
>                              sample selected machine registers on interrupt, use -I ? to list register names
>      #
> 
> But when I try asking for all those "available" registers, it doesn't
> seem to ask for the xmm registers, i.e. it works:
> 
> [root@quaco ~]# perf record -I
> ^C[ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 1.812 MB perf.data (2036 samples) ]
> 
>    # perf evlist -v
>    cycles: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD|REGS_INTR, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, sample_regs_intr: 0xff0fff
>    #
> 
>    # perf script -F uregs
>    Samples for 'cycles' event do not have UREGS attribute set. Cannot print 'uregs' field.
>    # perf script -F iregs | head -1
>     ABI:2    AX:0xf    BX:0xffff9edc4620f3a0    CX:0x38f    DX:0x7    SI:0xf    DI:0x38f    BP:0x0    SP:0xffff9edc46203f68    IP:0xffffffffae069894 FLAGS:0xa    CS:0x10    SS:0x18    R8:0x0    R9:0x207c0   R10:0x7968cfe8776   R11:0x5   R12:0x0   R13:0xffffbaec16fb7d20   R14:0xffff9edc2b5ab000   R15:0x0
>    #
> 
> So, can you please check all this and please consider sending a fix that
> comes with output for the steps used to test it, like above.
> 
> I'm applying this now because it adds a ability that, used with the
> above caveats in mind, is useful, but please help improving the output
> so that users don't get confused.
> 
> For instance, the 'perf record -I?' code should probe for the existence
> of these registers in the combo kernel+hardware, by creating an event,
> asking the kernel to record those registers and checking if the kernel
> supports this and the hardware has such registers.
>

Thanks for the test. I will send a fix for the issue.

Thanks,
Kan


> Thanks,
> 
> - Arnaldo
>   
>> - Arnaldo
>>   
>>> Signed-off-by: Andi Kleen <ak@linux.intel.com>
>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>> ---
>>>   tools/arch/x86/include/uapi/asm/perf_regs.h | 23 ++++++++++++++++++-
>>>   tools/perf/arch/x86/include/perf_regs.h     | 25 +++++++++++++++++++--
>>>   tools/perf/arch/x86/util/perf_regs.c        | 16 +++++++++++++
>>>   tools/perf/util/perf_regs.h                 |  1 +
>>>   4 files changed, 62 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/x86/include/uapi/asm/perf_regs.h
>>> index f3329cabce5c..ac67bbea10ca 100644
>>> --- a/tools/arch/x86/include/uapi/asm/perf_regs.h
>>> +++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
>>> @@ -27,8 +27,29 @@ enum perf_event_x86_regs {
>>>   	PERF_REG_X86_R13,
>>>   	PERF_REG_X86_R14,
>>>   	PERF_REG_X86_R15,
>>> -
>>> +	/* These are the limits for the GPRs. */
>>>   	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
>>>   	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
>>> +
>>> +	/* These all need two bits set because they are 128bit */
>>> +	PERF_REG_X86_XMM0  = 32,
>>> +	PERF_REG_X86_XMM1  = 34,
>>> +	PERF_REG_X86_XMM2  = 36,
>>> +	PERF_REG_X86_XMM3  = 38,
>>> +	PERF_REG_X86_XMM4  = 40,
>>> +	PERF_REG_X86_XMM5  = 42,
>>> +	PERF_REG_X86_XMM6  = 44,
>>> +	PERF_REG_X86_XMM7  = 46,
>>> +	PERF_REG_X86_XMM8  = 48,
>>> +	PERF_REG_X86_XMM9  = 50,
>>> +	PERF_REG_X86_XMM10 = 52,
>>> +	PERF_REG_X86_XMM11 = 54,
>>> +	PERF_REG_X86_XMM12 = 56,
>>> +	PERF_REG_X86_XMM13 = 58,
>>> +	PERF_REG_X86_XMM14 = 60,
>>> +	PERF_REG_X86_XMM15 = 62,
>>> +
>>> +	/* These include both GPRs and XMMX registers */
>>> +	PERF_REG_X86_XMM_MAX = PERF_REG_X86_XMM15 + 2,
>>>   };
>>>   #endif /* _ASM_X86_PERF_REGS_H */
>>> diff --git a/tools/perf/arch/x86/include/perf_regs.h b/tools/perf/arch/x86/include/perf_regs.h
>>> index 7f6d538f8a89..b7321337d100 100644
>>> --- a/tools/perf/arch/x86/include/perf_regs.h
>>> +++ b/tools/perf/arch/x86/include/perf_regs.h
>>> @@ -8,9 +8,9 @@
>>>   
>>>   void perf_regs_load(u64 *regs);
>>>   
>>> +#define PERF_REGS_MAX PERF_REG_X86_XMM_MAX
>>>   #ifndef HAVE_ARCH_X86_64_SUPPORT
>>>   #define PERF_REGS_MASK ((1ULL << PERF_REG_X86_32_MAX) - 1)
>>> -#define PERF_REGS_MAX PERF_REG_X86_32_MAX
>>>   #define PERF_SAMPLE_REGS_ABI PERF_SAMPLE_REGS_ABI_32
>>>   #else
>>>   #define REG_NOSUPPORT ((1ULL << PERF_REG_X86_DS) | \
>>> @@ -18,7 +18,6 @@ void perf_regs_load(u64 *regs);
>>>   		       (1ULL << PERF_REG_X86_FS) | \
>>>   		       (1ULL << PERF_REG_X86_GS))
>>>   #define PERF_REGS_MASK (((1ULL << PERF_REG_X86_64_MAX) - 1) & ~REG_NOSUPPORT)
>>> -#define PERF_REGS_MAX PERF_REG_X86_64_MAX
>>>   #define PERF_SAMPLE_REGS_ABI PERF_SAMPLE_REGS_ABI_64
>>>   #endif
>>>   #define PERF_REG_IP PERF_REG_X86_IP
>>> @@ -77,6 +76,28 @@ static inline const char *perf_reg_name(int id)
>>>   	case PERF_REG_X86_R15:
>>>   		return "R15";
>>>   #endif /* HAVE_ARCH_X86_64_SUPPORT */
>>> +
>>> +#define XMM(x) \
>>> +	case PERF_REG_X86_XMM ## x:	\
>>> +	case PERF_REG_X86_XMM ## x + 1:	\
>>> +		return "XMM" #x;
>>> +	XMM(0)
>>> +	XMM(1)
>>> +	XMM(2)
>>> +	XMM(3)
>>> +	XMM(4)
>>> +	XMM(5)
>>> +	XMM(6)
>>> +	XMM(7)
>>> +	XMM(8)
>>> +	XMM(9)
>>> +	XMM(10)
>>> +	XMM(11)
>>> +	XMM(12)
>>> +	XMM(13)
>>> +	XMM(14)
>>> +	XMM(15)
>>> +#undef XMM
>>>   	default:
>>>   		return NULL;
>>>   	}
>>> diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
>>> index fead6b3b4206..71d7604dbf0b 100644
>>> --- a/tools/perf/arch/x86/util/perf_regs.c
>>> +++ b/tools/perf/arch/x86/util/perf_regs.c
>>> @@ -31,6 +31,22 @@ const struct sample_reg sample_reg_masks[] = {
>>>   	SMPL_REG(R14, PERF_REG_X86_R14),
>>>   	SMPL_REG(R15, PERF_REG_X86_R15),
>>>   #endif
>>> +	SMPL_REG2(XMM0, PERF_REG_X86_XMM0),
>>> +	SMPL_REG2(XMM1, PERF_REG_X86_XMM1),
>>> +	SMPL_REG2(XMM2, PERF_REG_X86_XMM2),
>>> +	SMPL_REG2(XMM3, PERF_REG_X86_XMM3),
>>> +	SMPL_REG2(XMM4, PERF_REG_X86_XMM4),
>>> +	SMPL_REG2(XMM5, PERF_REG_X86_XMM5),
>>> +	SMPL_REG2(XMM6, PERF_REG_X86_XMM6),
>>> +	SMPL_REG2(XMM7, PERF_REG_X86_XMM7),
>>> +	SMPL_REG2(XMM8, PERF_REG_X86_XMM8),
>>> +	SMPL_REG2(XMM9, PERF_REG_X86_XMM9),
>>> +	SMPL_REG2(XMM10, PERF_REG_X86_XMM10),
>>> +	SMPL_REG2(XMM11, PERF_REG_X86_XMM11),
>>> +	SMPL_REG2(XMM12, PERF_REG_X86_XMM12),
>>> +	SMPL_REG2(XMM13, PERF_REG_X86_XMM13),
>>> +	SMPL_REG2(XMM14, PERF_REG_X86_XMM14),
>>> +	SMPL_REG2(XMM15, PERF_REG_X86_XMM15),
>>>   	SMPL_REG_END
>>>   };
>>>   
>>> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
>>> index c9319f8d17a6..1a15a4bfc28d 100644
>>> --- a/tools/perf/util/perf_regs.h
>>> +++ b/tools/perf/util/perf_regs.h
>>> @@ -12,6 +12,7 @@ struct sample_reg {
>>>   	uint64_t mask;
>>>   };
>>>   #define SMPL_REG(n, b) { .name = #n, .mask = 1ULL << (b) }
>>> +#define SMPL_REG2(n, b) { .name = #n, .mask = 3ULL << (b) }
>>>   #define SMPL_REG_END { .name = NULL }
>>>   
>>>   extern const struct sample_reg sample_reg_masks[];
>>> -- 
>>> 2.17.1
>>
>> -- 
>>
>> - Arnaldo
> 
