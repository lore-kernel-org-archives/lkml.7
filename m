Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90747C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602F720883
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCLLUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:20:31 -0400
Received: from www62.your-server.de ([213.133.104.62]:38348 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfCLLUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:20:31 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h3fSM-0004gC-KT; Tue, 12 Mar 2019 12:20:26 +0100
Received: from [178.197.248.21] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h3fSM-0000CI-AF; Tue, 12 Mar 2019 12:20:26 +0100
Subject: Re: [PATCH v7 perf,bpf 02/15] bpf: libbpf: introduce
 bpf_program__get_prog_info_linear()
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, kernel-team@fb.com, peterz@infradead.org,
        acme@redhat.com, jolsa@kernel.org, namhyung@kernel.org
References: <20190307175810.249857-1-songliubraving@fb.com>
 <20190307175810.249857-3-songliubraving@fb.com>
 <20190311182631.GX10690@kernel.org>
 <b6fb25aa-5bfc-cf97-f960-5966154e5ef5@iogearbox.net>
 <20190311205720.GD10690@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ce92c091-e80d-a0c1-4aa0-987706c42b20@iogearbox.net>
Date:   Tue, 12 Mar 2019 12:20:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190311205720.GD10690@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25386/Tue Mar 12 09:15:09 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2019 09:57 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Mar 11, 2019 at 09:45:49PM +0100, Daniel Borkmann escreveu:
>> On 03/11/2019 07:26 PM, Arnaldo Carvalho de Melo wrote:
>>> Em Thu, Mar 07, 2019 at 09:57:57AM -0800, Song Liu escreveu:
>>>> Currently, bpf_prog_info includes 9 arrays. The user has the option to
>>>> fetch any combination of these arrays. However, this requires a lot of
>>>> handling of these arrays. This work becomes more tricky when we need to
>>>> store bpf_prog_info to a file, because these arrays are allocated
>>>> independently.
>>>>
>>>> This patch introduces struct bpf_prog_info_linear, which stores arrays
>>>> of bpf_prog_info in continues memory. Helper functions are introduced
>>>> to unify the work to get different information of bpf_prog_info.
>>>> Specifically, bpf_program__get_prog_info_linear() allows the user to
>>>> select which arrays to fetch, and handles details for the user.
>>>>
>>>> Plesae see the comments before enum bpf_prog_info_array for more details
>>>> and examples.
>>>>
>>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>>>> Cc: Alexei Starovoitov <ast@kernel.org>
>>>
>>> Daniel, are you ok with these changes to libbpf and bpftool? Perhaps
>>> those should be detached from this patchkit and submitted sooner,
>>> eroding the size of this kit.
>>>
>>> Alternatively, if you're ok with it, please provide your Acked-by and
>>> I'll process as soon as I get back to it after Jiri is done reviewing.
>>
>> Overall looks okay. Are you planning to get these in for 5.1 window? If
> 
> I hope so.
> 
>> yes, that would be great, otherwise we might need to cherry-pick the libbpf
> 
> So I'll try and grab those for my next pull req to Ingo, this week,
> will add your Acked-by, ok?

Please do, thanks.

>> and bpftool ones from your tree into bpf-next as well since there's just
>> too much going on in this area where we'd potentially run into complex
>> merge conflicts. In the latter case, libbpf.map would need to be fixed up
>> to LIBBPF_0.0.3 as convention is that this is in line with kernel release.
> 
> BTW, while running my build tests I had to add this to today's batch,
> should be trivial when merging, I think, ok?

That's fine as well, ack, lets shoot for getting it in during merge window
such that we don't need to duplicate these dependencies in bpf trees.

> commit dfcbc2f2994b8a3af3605a26dc29c07ad7378bf4
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Mon Mar 11 17:07:52 2019 -0300
> 
>     tools lib bpf: Fix the build by adding a missing stdarg.h include
>     
>     The libbpf_print_fn_t typedef uses va_list without including the header
>     where that type is defined, stdarg.h, breaking in places where we're
>     unlucky for that type not to be already defined by some previously
>     included header.
>     
>     Noticed while building on fedora 24 cross building tools/perf to the ARC
>     architecture using the uClibc C library:
>     
>       28 fedora:24-x-ARC-uClibc   : FAIL arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
>     
>         CC       /tmp/build/perf/tests/llvm.o
>       In file included from tests/llvm.c:3:0:
>       /git/linux/tools/lib/bpf/libbpf.h:57:20: error: unknown type name 'va_list'
>             const char *, va_list ap);
>                           ^~~~~~~
>       /git/linux/tools/lib/bpf/libbpf.h:59:34: error: unknown type name 'libbpf_print_fn_t'
>        LIBBPF_API void libbpf_set_print(libbpf_print_fn_t fn);
>                                         ^~~~~~~~~~~~~~~~~
>       mv: cannot stat '/tmp/build/perf/tests/.llvm.o.tmp': No such file or directory
>     
>     Cc: Alexei Starovoitov <ast@kernel.org>
>     Cc: Daniel Borkmann <daniel@iogearbox.net>
>     Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Quentin Monnet <quentin.monnet@netronome.com>
>     Cc: Stanislav Fomichev <sdf@google.com>
>     Cc: Yonghong Song <yhs@fb.com>
>     Fixes: a8a1f7d09cfc ("libbpf: fix libbpf_print")
>     Link: https://lkml.kernel.org/n/tip-5270n2quu2gqz22o7itfdx00@git.kernel.org
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b4652aa1a58a..aa1521a51687 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -10,6 +10,7 @@
>  #ifndef __LIBBPF_LIBBPF_H
>  #define __LIBBPF_LIBBPF_H
>  
> +#include <stdarg.h>
>  #include <stdio.h>
>  #include <stdint.h>
>  #include <stdbool.h>
> 

Thanks,
Daniel
