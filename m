Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98988C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645462084F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387580AbfB1ULj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:11:39 -0500
Received: from mga09.intel.com ([134.134.136.24]:9408 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfB1ULi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:11:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 12:11:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,424,1544515200"; 
   d="scan'208";a="150912947"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2019 12:11:37 -0800
Received: from [10.251.86.205] (abudanko-mobl.ccr.corp.intel.com [10.251.86.205])
        by linux.intel.com (Postfix) with ESMTP id 7683B58011C;
        Thu, 28 Feb 2019 12:11:35 -0800 (PST)
Subject: Re: [PATCH v4 01/10] feature: implement libzstd check, LIBZSTD_DIR
 and NO_LIBZSTD defines
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <bb018a36-5249-ca6a-8e16-6afac442bae5@linux.intel.com>
 <e729df84-1b0e-d402-c03e-c1729d4ec43d@linux.intel.com>
 <20190228184612.GF9508@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <33eb224d-3974-ebaa-20b7-9dbb66711839@linux.intel.com>
Date:   Thu, 28 Feb 2019 23:11:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190228184612.GF9508@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28.02.2019 21:46, Arnaldo Carvalho de Melo wrote:
> Em Thu, Feb 28, 2019 at 11:59:01AM +0300, Alexey Budankov escreveu:
>> +++ b/tools/build/Makefile.feature
>> @@ -66,7 +66,8 @@ FEATURE_TESTS_BASIC :=                  \
>>          sched_getcpu			\
>>          sdt				\
>>          setns				\
>> -        libaio
>> +        libaio				\
>> +        libzstd
> 
> Since you added this as a basic feature to test, add this when you
> resubmit, so that 'perf -vv' tells us that this basic feature is indeed
> present.

Yes, will do. Actually came to similar idea when 
observed your test report in pull requests:

# perf version --build-options
  perf version 5.0.rc5.gde667c
                   dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
      dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                   glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
                    gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
           syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                  libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                  libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
                 libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
  numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                 libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
                libslang: [ on  ]  # HAVE_SLANG_SUPPORT
               libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
               libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
      libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                    zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                    lzma: [ on  ]  # HAVE_LZMA_SUPPORT
               get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                     bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT

and it misses HAVE_ZSTD_SUPPORT define.

Thanks,
Alexey

> 
> 
> diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
> index 50df168be326..d41197fc8cef 100644
> --- a/tools/perf/builtin-version.c
> +++ b/tools/perf/builtin-version.c
> @@ -78,6 +78,7 @@ static void library_status(void)
>  	STATUS(HAVE_LZMA_SUPPORT, lzma);
>  	STATUS(HAVE_AUXTRACE_SUPPORT, get_cpuid);
>  	STATUS(HAVE_LIBBPF_SUPPORT, bpf);
> +	STATUS(HAVE_ZSTD_SUPPORT, bpf);
>  }
>  
>  int cmd_version(int argc, const char **argv)
> 
