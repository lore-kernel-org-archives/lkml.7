Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADD4C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F392147A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfFMTYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 15:24:44 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35391 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfFMTYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 15:24:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id d23so23935327qto.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 12:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=++Nt/1Xw2R+gW/nVhkKRGoAnkZFTEez7LtK1ZaA4MrY=;
        b=azN1DNIr72mRfFf9vdWI94AqBlGOF28UnKPZBrQDNEGOb6ooLoLgRXB2eRraia2Uq0
         NbVHK5bWKxVhNSDsogxkoRvrMJP43NgAeM/Gu4NnfHHeFwNWSPbtRqpmanxHMuYzI+Li
         vGa+aMLLh7KmSOZoATAAffPKptRCStU+Js25bNoT/Al7m8+ouVgSDQlKuqgWMLKTZKrA
         3Kmi/8nICBiReA5xUNK+4LVv5UgWp0ZgAtrmRFVBK3YFL0LqZQxYpg5nIuok2J5UGJcB
         5yEJtZEELF3JC6zxbnhnt2DJ1B3P3IUw63Q+GUXGe02xrSXz8Ng/KSo2ztnjR92fOfMp
         khUA==
X-Gm-Message-State: APjAAAW1H4UGtdEhmYysY+vuvs58tuUY2JpfwvnWlfrXwD6VWXsPnHKb
        /tgOOqcfVMEb7p8kgS20cBbEY8j94XY=
X-Google-Smtp-Source: APXvYqw0W2FRG54tq+cLHL0UkmL22qusrLFzFd/JKAwioNBShe5fKfzlCcmTK23cb2DHg4kVX/8BUQ==
X-Received: by 2002:ac8:3f32:: with SMTP id c47mr76519394qtk.342.1560453882738;
        Thu, 13 Jun 2019 12:24:42 -0700 (PDT)
Received: from [192.168.1.152] (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id s44sm440437qtc.8.2019.06.13.12.24.41
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 12:24:41 -0700 (PDT)
Subject: Re: perf build failure with newer glibc headers
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4c0a4264-7142-2e6d-540d-aa354700e0bb@redhat.com>
 <20190612205611.GA2149@redhat.com> <20190613151925.GA2834@redhat.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <a3ac5f0b-9255-155c-5151-d234890f4562@redhat.com>
Date:   Thu, 13 Jun 2019 15:24:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190613151925.GA2834@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/19 11:19 AM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jun 12, 2019 at 05:56:11PM -0300, Arnaldo Carvalho de Melo escreveu:
>> So, we'll have to have a feature test, that defines some HAVE_GETTID
>> that then ifdefs out our inline copy, working on it.
> 
> This should take care of it, please check, perhaps providing a
> Tested-by: to add to this,
> 

built okay on the tree that previously failed

Tested-by: Laura Abbott <labbott@redhat.com>

> Thanks,
> 
> - Arnaldo
> 
> commit a04ef2eb0a66d9479e75e536d919c8c9cd618ee3
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Thu Jun 13 12:04:19 2019 -0300
> 
>      tools build: Check if gettid() is available before providing helper
>      
>      Laura reported that the perf build failed in fedora when we got a glibc
>      that provides gettid(), which I reproduced using fedora rawhide with the
>      glibc-devel-2.29.9000-26.fc31.x86_64 package.
>      
>      Add a feature check to avoid providing a gettid() helper in such
>      systems.
>      
>      On a fedora rawhide system with this patch applied we now get:
>      
>        [root@7a5f55352234 perf]# grep gettid /tmp/build/perf/FEATURE-DUMP
>        feature-gettid=1
>        [root@7a5f55352234 perf]# cat /tmp/build/perf/feature/test-gettid.make.output
>        [root@7a5f55352234 perf]# ldd /tmp/build/perf/feature/test-gettid.bin
>                linux-vdso.so.1 (0x00007ffc6b1f6000)
>                libc.so.6 => /lib64/libc.so.6 (0x00007f04e0a74000)
>                /lib64/ld-linux-x86-64.so.2 (0x00007f04e0c47000)
>        [root@7a5f55352234 perf]# nm /tmp/build/perf/feature/test-gettid.bin | grep -w gettid
>                         U gettid@@GLIBC_2.30
>        [root@7a5f55352234 perf]#
>      
>      While on a fedora:29 system:
>      
>        [acme@quaco perf]$ grep gettid /tmp/build/perf/FEATURE-DUMP
>        feature-gettid=0
>        [acme@quaco perf]$ cat /tmp/build/perf/feature/test-gettid.make.output
>        test-gettid.c: In function ‘main’:
>        test-gettid.c:8:9: error: implicit declaration of function ‘gettid’; did you mean ‘getgid’? [-Werror=implicit-function-declaration]
>          return gettid();
>                 ^~~~~~
>                 getgid
>        cc1: all warnings being treated as errors
>        [acme@quaco perf]$
>      
>      Reported-by: Laura Abbott <labbott@redhat.com>
>      Cc: Adrian Hunter <adrian.hunter@intel.com>
>      Cc: Florian Weimer <fweimer@redhat.com>
>      Cc: Jiri Olsa <jolsa@kernel.org>
>      Cc: Namhyung Kim <namhyung@kernel.org>
>      Cc: Stephane Eranian <eranian@google.com>
>      Link: https://lkml.kernel.org/n/tip-yfy3ch53agmklwu9o7rlgf9c@git.kernel.org
>      Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 3b24231c58a2..50377cc2f5f9 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -36,6 +36,7 @@ FEATURE_TESTS_BASIC :=                  \
>           fortify-source                  \
>           sync-compare-and-swap           \
>           get_current_dir_name            \
> +        gettid				\
>           glibc                           \
>           gtk2                            \
>           gtk2-infobar                    \
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 4b8244ee65ce..523ee42db0c8 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -54,6 +54,7 @@ FILES=                                          \
>            test-get_cpuid.bin                     \
>            test-sdt.bin                           \
>            test-cxx.bin                           \
> +         test-gettid.bin			\
>            test-jvmti.bin				\
>            test-jvmti-cmlr.bin			\
>            test-sched_getcpu.bin			\
> @@ -267,6 +268,9 @@ $(OUTPUT)test-sdt.bin:
>   $(OUTPUT)test-cxx.bin:
>   	$(BUILDXX) -std=gnu++11
>   
> +$(OUTPUT)test-gettid.bin:
> +	$(BUILD)
> +
>   $(OUTPUT)test-jvmti.bin:
>   	$(BUILD)
>   
> diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
> index a59c53705093..3b3d5d72124a 100644
> --- a/tools/build/feature/test-all.c
> +++ b/tools/build/feature/test-all.c
> @@ -38,6 +38,10 @@
>   # include "test-get_current_dir_name.c"
>   #undef main
>   
> +#define main main_test_gettid
> +# include "test-gettid.c"
> +#undef main
> +
>   #define main main_test_glibc
>   # include "test-glibc.c"
>   #undef main
> @@ -195,6 +199,7 @@ int main(int argc, char *argv[])
>   	main_test_libelf();
>   	main_test_libelf_mmap();
>   	main_test_get_current_dir_name();
> +	main_test_gettid();
>   	main_test_glibc();
>   	main_test_dwarf();
>   	main_test_dwarf_getlocations();
> diff --git a/tools/build/feature/test-gettid.c b/tools/build/feature/test-gettid.c
> new file mode 100644
> index 000000000000..ef24e42d3f1b
> --- /dev/null
> +++ b/tools/build/feature/test-gettid.c
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2019, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
> +#define _GNU_SOURCE
> +#include <unistd.h>
> +
> +int main(void)
> +{
> +	return gettid();
> +}
> +
> +#undef _GNU_SOURCE
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 51dd00f65709..5f16a20cae86 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -332,6 +332,10 @@ ifeq ($(feature-get_current_dir_name), 1)
>     CFLAGS += -DHAVE_GET_CURRENT_DIR_NAME
>   endif
>   
> +ifeq ($(feature-gettid), 1)
> +  CFLAGS += -DHAVE_GETTID
> +endif
> +
>   ifdef NO_LIBELF
>     NO_DWARF := 1
>     NO_DEMANGLE := 1
> diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
> index f7eb63cbbc65..88108598d6e9 100644
> --- a/tools/perf/jvmti/jvmti_agent.c
> +++ b/tools/perf/jvmti/jvmti_agent.c
> @@ -45,10 +45,12 @@
>   static char jit_path[PATH_MAX];
>   static void *marker_addr;
>   
> +#ifndef HAVE_GETTID
>   static inline pid_t gettid(void)
>   {
>   	return (pid_t)syscall(__NR_gettid);
>   }
> +#endif
>   
>   static int get_e_machine(struct jitheader *hdr)
>   {
> 


