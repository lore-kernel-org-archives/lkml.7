Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363E5C73C56
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28862073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbfGIT1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 15:27:36 -0400
Received: from www62.your-server.de ([213.133.104.62]:40730 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbfGIT1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 15:27:36 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hkvlT-0001La-9D; Tue, 09 Jul 2019 21:26:59 +0200
Received: from [178.193.45.231] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hkvlT-0002W3-3L; Tue, 09 Jul 2019 21:26:59 +0200
Subject: Re: [tip:x86/urgent] bpf: Fix ORC unwinding in non-JIT BPF code
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kairui Song <kasong@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <20190707013206.don22x3tfldec4zm@treble>
 <20190707055209.xqyopsnxfurhrkxw@treble>
 <CAADnVQJqT8o=_6P6xHjwxrXqX9ToSb0cTfoOcm2Xcha3KRNNSw@mail.gmail.com>
 <20190708223834.zx7u45a4uuu2yyol@treble>
 <CAADnVQKWDvzsvyjGoFvSQV7VGr2hF2zzCsC9vnpncWMxOJWYdw@mail.gmail.com>
 <20190708225359.ewk44pvrv6a4oao7@treble>
 <20190708230201.mol27wzansuy3n2v@treble>
 <CAADnVQ+imsK-reGBiSzY02e+KdyGYZxm1su7T1bWvti=YmSV-Q@mail.gmail.com>
 <20190709174744.dtbjm72cbu5fepar@treble>
 <CAADnVQJ+iCZ8g38XJkOiawS=p1mZU5XBqaBWc8_zCKVe8hMxTQ@mail.gmail.com>
 <20190709191751.24eq5zx2c7hoqot6@treble>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <47fc592d-08a0-a69a-89d0-603d47893656@iogearbox.net>
Date:   Tue, 9 Jul 2019 21:26:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190709191751.24eq5zx2c7hoqot6@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25505/Tue Jul  9 10:07:53 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2019 09:17 PM, Josh Poimboeuf wrote:
> On Tue, Jul 09, 2019 at 11:02:40AM -0700, Alexei Starovoitov wrote:
>> On Tue, Jul 9, 2019 at 10:48 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>>>
>>> On Mon, Jul 08, 2019 at 04:16:25PM -0700, Alexei Starovoitov wrote:
>>>> total time is hard to compare.
>>>> Could you compare few tests?
>>>> like two that are called "tcpdump *"
>>>>
>>>> I think small regression is ok.
>>>> Folks that care about performance should be using JIT.
>>>
>>> I did each test 20 times and computed the averages:
>>>
>>> "tcpdump port 22":
>>>  default:       0.00743175s
>>>  -fno-gcse:     0.00709920s (~4.5% speedup)
>>>
>>> "tcpdump complex":
>>>  default:       0.00876715s
>>>  -fno-gcse:     0.00854895s (~2.5% speedup)
>>>
>>> So there does seem to be a small performance gain by disabling this
>>> optimization.
>>
>> great. thanks for checking.
>>
>>> We could change it for the whole file, by adjusting CFLAGS_core.o in the
>>> BPF makefile, or we could change it for the function only with something
>>> like the below patch.
>>>
>>> Thoughts?
>>>
>>> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
>>> index e8579412ad21..d7ee4c6bad48 100644
>>> --- a/include/linux/compiler-gcc.h
>>> +++ b/include/linux/compiler-gcc.h
>>> @@ -170,3 +170,5 @@
>>>  #else
>>>  #define __diag_GCC_8(s)
>>>  #endif
>>> +
>>> +#define __no_fgcse __attribute__((optimize("-fno-gcse")))
>>> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
>>> index 095d55c3834d..599c27b56c29 100644
>>> --- a/include/linux/compiler_types.h
>>> +++ b/include/linux/compiler_types.h
>>> @@ -189,6 +189,10 @@ struct ftrace_likely_data {
>>>  #define asm_volatile_goto(x...) asm goto(x)
>>>  #endif
>>>
>>> +#ifndef __no_fgcse
>>> +# define __no_fgcse
>>> +#endif
>>> +
>>>  /* Are two types/vars the same type (ignoring qualifiers)? */
>>>  #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>>>
>>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>>> index 7e98f36a14e2..8191a7db2777 100644
>>> --- a/kernel/bpf/core.c
>>> +++ b/kernel/bpf/core.c
>>> @@ -1295,7 +1295,7 @@ bool bpf_opcode_in_insntable(u8 code)
>>>   *
>>>   * Decode and execute eBPF instructions.
>>>   */
>>> -static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
>>> +static u64 __no_fgcse ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
>>
>> I prefer per-function flag.

Same preference from my side.

>> If you want to route it via tip:
>> Acked-by: Alexei Starovoitov <ast@kerrnel.org>
>>
>> or Daniel can take it into bpf tree while I'm traveling.
> 
> Thanks!  I''ll probably send it through the tip tree, along with an
> objtool fix for the other optimization.

Ok, sounds good, thanks!
