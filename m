Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DC6C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFD92089E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfEAUUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 16:20:07 -0400
Received: from mx2.yrkesakademin.fi ([85.134.45.195]:47720 "EHLO
        mx2.yrkesakademin.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfEAUUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 16:20:06 -0400
Subject: Re: perf build broken in 5.1-rc7
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     Song Liu <liu.song.a23@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
References: <560abacf-da1d-7f55-755c-2086096bdf2c@mageia.org>
 <fff8c124-505c-91b7-ff4b-cabca894b689@mageia.org>
 <CAPhsuW7dS9TXOAW--U2q9-zmsgS4_K+uZYLnbPra+r+2LjJKDQ@mail.gmail.com>
 <b773df70-58e6-69f8-d566-282b0f7ae579@mageia.org>
 <20190501130751.GB21436@kernel.org>
 <932c4e06-c4db-7bb8-769d-75651d092450@mageia.org>
 <20190501173158.GC21436@kernel.org>
From:   Thomas Backlund <tmb@mageia.org>
Message-ID: <f9439dd5-009b-8930-f233-6826c7e7c076@mageia.org>
Date:   Wed, 1 May 2019 23:20:02 +0300
MIME-Version: 1.0
In-Reply-To: <20190501173158.GC21436@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-WatchGuard-Spam-ID: str=0001.0A0C0209.5CC9FF75.001F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-WatchGuard-Spam-Score: 0, clean; 0, virus threat unknown
X-WatchGuard-Mail-Client-IP: 85.134.45.195
X-WatchGuard-Mail-From: tmb@mageia.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 01-05-2019 kl. 20:31, skrev Arnaldo Carvalho de Melo:
> Em Wed, May 01, 2019 at 05:09:59PM +0300, Thomas Backlund escreveu:
>> Den 01-05-2019 kl. 16:07, skrev Arnaldo Carvalho de Melo:
>>> Em Tue, Apr 30, 2019 at 04:31:14PM +0300, Thomas Backlund escreveu:
>>> Can you check the output for
>>> /tmp/build/perf/feature/test-disassembler-four-args.make.output in your
>>> system? And also check what is the prototype for the disassembler()
>>> routine on mageia7?
>> I guess this is what fails the test:
>   
>> cat /tmp/build/perf/feature/test-disassembler-four-args.make.output
>> /usr/bin/ld: /usr/lib64/libbfd.a(plugin.o): in function `try_load_plugin':
>> /home/iurt/rpmbuild/BUILD/binutils-2.32/objs/bfd/../../bfd/plugin.c:243:
>> undefined reference to `dlopen'
>> /usr/bin/ld:
>> /home/iurt/rpmbuild/BUILD/binutils-2.32/objs/bfd/../../bfd/plugin.c:271:
>> undefined reference to `dlsym'
>> /usr/bin/ld:
>> /home/iurt/rpmbuild/BUILD/binutils-2.32/objs/bfd/../../bfd/plugin.c:256:
>> undefined reference to `dlclose'
>> /usr/bin/ld:
>> /home/iurt/rpmbuild/BUILD/binutils-2.32/objs/bfd/../../bfd/plugin.c:246:
>> undefined reference to `dlerror'
>   
>> as we allow dynamic linking and loading
>   
>> And we use linker flags:
>   
>> rpm --eval %ldflags
>>   -Wl,--as-needed -Wl,--no-undefined -Wl,-z,relro -Wl,-O1 -Wl,--build-id
>> -Wl,--enable-new-dtags
> Would this help?
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index fe3f97e342fa..6d65874e16c3 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -227,7 +227,7 @@ FEATURE_CHECK_LDFLAGS-libpython-version := $(PYTHON_EMBED_LDOPTS)
>   
>   EATURE_CHECK_LDFLAGS-libaio = -lrt
>   
> -FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes
> +FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
>   
>   CFLAGS += -fno-omit-frame-pointer
>   CFLAGS += -ggdb3
>

Yeah, that fixes it

and /tmp/build/perf/feature/test-disassembler-four-args.make.output is now empty as wanted.


So I guess:

Reported-by: Thomas Backlund <tmb@mageia.org>

Tested-by: Thomas Backlund <tmb@mageia.org>



Thanks!


--

Thomas


