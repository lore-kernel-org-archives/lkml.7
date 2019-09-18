Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CF6C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B623205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x9PsKe2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfIRLFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 07:05:25 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:47058 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbfIRLFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 07:05:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id e17so6705900ljf.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 04:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JNIOOCl1FIlLK8OEQrCWm+4MRTLInoFaM8HwgPYRrSI=;
        b=x9PsKe2lWSxm5YFoGrE7b1TTrtwP4ymR5aHH9sHEKViQA3aCR2IMzJ2aBGzYvIdJ17
         OtiILmKAN0rwR0GwJFAJy5PwRZwXAemG0uob3Zz1kWZLO8HzXikGDYheeGh9XwMxZS/d
         1zxWeZ4SDo0Y2AqIc/XMLu1xhSXcxP0qU0RdRalMXVHAiRHTuoqsaB4EXKrhfagz9qyc
         6yeAvnu4eEoRjkGR1NbBOc+2f31Lbpk3CrBYvLHmDs9uFCPkcSXTh/ZzzcNQ3BXng9gA
         GaCTr+J1gFHg2F27Zy0MkLOEU7YoJ3XFLbNPSeyu15FWT50wATdLXZbv7LCG/gCEx7Dv
         AAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=JNIOOCl1FIlLK8OEQrCWm+4MRTLInoFaM8HwgPYRrSI=;
        b=lsLYNB6qd51rceNG5jGW/IYahBQonNmmjh0U0B1BHLdX9M6JwvmQWcxYYmBPHaLd+x
         s2N4REGXNL4ugO83RWWOHLyq5hroCYUKdzjF+TVGQXJvmtBJFsbyKH9wX8moSVzDUPJI
         zKqWwJhxGRzSD4JFPGk5AOlIP3X7j868oAwl+kW+gR/Jxi7eDHIUr9CBmBw3RINw4a+Q
         +CbSP6kci5hgB/ezgzXg3SSunf4usT9cz0j+TbpKTmiTfzV001vK2phR+5P1aHLNRcgU
         w5/57083nZtw7SzjB6H9b62cY19twmRzIAvaCh/jnwR64RNdl/pLHAMAR6fYxatx5Oz0
         tGvQ==
X-Gm-Message-State: APjAAAVZTxBVSZm+vH63sYDRnYWNzDHxckaFUgmOjDvABgSYXi0TakAB
        AiQx2qG9+gNidN9KVro4XgT6QA==
X-Google-Smtp-Source: APXvYqwhzGaNYWRfqqbacjV8ivacocjE8Zel8keZadSmB9WJFdU54IEBfsuyRvZlrIEaM1mB7lZcrg==
X-Received: by 2002:a2e:9ac4:: with SMTP id p4mr1793545ljj.206.1568804721863;
        Wed, 18 Sep 2019 04:05:21 -0700 (PDT)
Received: from khorivan (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id s7sm959288ljs.16.2019.09.18.04.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Sep 2019 04:05:20 -0700 (PDT)
Date:   Wed, 18 Sep 2019 14:05:18 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH v3 bpf-next 11/14] libbpf: makefile: add C/CXX/LDFLAGS to
 libbpf.so and test_libpf targets
Message-ID: <20190918110517.GD2908@khorivan>
Mail-Followup-To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        sergei.shtylyov@cogentembedded.com
References: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
 <20190916105433.11404-12-ivan.khoronzhuk@linaro.org>
 <CAEf4BzZXNN_dhs=jUjtfCqtuV1bk9H=q5b07kVDQQsysjhF4cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAEf4BzZXNN_dhs=jUjtfCqtuV1bk9H=q5b07kVDQQsysjhF4cQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 10:19:22PM -0700, Andrii Nakryiko wrote:
>On Mon, Sep 16, 2019 at 4:00 AM Ivan Khoronzhuk
><ivan.khoronzhuk@linaro.org> wrote:
>>
>> In case of LDFLAGS and EXTRA_CC/CXX flags there is no way to pass them
>> correctly to build command, for instance when --sysroot is used or
>> external libraries are used, like -lelf, wich can be absent in
>> toolchain. This can be used for samples/bpf cross-compiling allowing
>> to get elf lib from sysroot.
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> ---
>>  tools/lib/bpf/Makefile | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
>> index c6f94cffe06e..bccfa556ef4e 100644
>> --- a/tools/lib/bpf/Makefile
>> +++ b/tools/lib/bpf/Makefile
>> @@ -94,6 +94,10 @@ else
>>    CFLAGS := -g -Wall
>>  endif
>>
>> +ifdef EXTRA_CXXFLAGS
>> +  CXXFLAGS := $(EXTRA_CXXFLAGS)
>> +endif
>> +
>>  ifeq ($(feature-libelf-mmap), 1)
>>    override CFLAGS += -DHAVE_LIBELF_MMAP_SUPPORT
>>  endif
>> @@ -176,8 +180,9 @@ $(BPF_IN): force elfdep bpfdep
>>  $(OUTPUT)libbpf.so: $(OUTPUT)libbpf.so.$(LIBBPF_VERSION)
>>
>>  $(OUTPUT)libbpf.so.$(LIBBPF_VERSION): $(BPF_IN)
>> -       $(QUIET_LINK)$(CC) --shared -Wl,-soname,libbpf.so.$(LIBBPF_MAJOR_VERSION) \
>> -                                   -Wl,--version-script=$(VERSION_SCRIPT) $^ -lelf -o $@
>> +       $(QUIET_LINK)$(CC) $(LDFLAGS) \
>> +               --shared -Wl,-soname,libbpf.so.$(LIBBPF_MAJOR_VERSION) \
>> +               -Wl,--version-script=$(VERSION_SCRIPT) $^ -lelf -o $@
>>         @ln -sf $(@F) $(OUTPUT)libbpf.so
>>         @ln -sf $(@F) $(OUTPUT)libbpf.so.$(LIBBPF_MAJOR_VERSION)
>>
>> @@ -185,7 +190,7 @@ $(OUTPUT)libbpf.a: $(BPF_IN)
>>         $(QUIET_LINK)$(RM) $@; $(AR) rcs $@ $^
>>
>>  $(OUTPUT)test_libbpf: test_libbpf.cpp $(OUTPUT)libbpf.a
>> -       $(QUIET_LINK)$(CXX) $(INCLUDES) $^ -lelf -o $@
>> +       $(QUIET_LINK)$(CXX) $(CXXFLAGS) $(LDFLAGS) $(INCLUDES) $^ -lelf -o $@
>
>Instead of doing ifdef EXTRA_CXXFLAGS bit above, you can just include
>both $(CXXFLAGS) and $(EXTRA_CXXFLAGS), which will do the right thing
>(and is actually recommended my make documentation way to do this).
It's good practice to follow existent style, I've done similar way as for
CFLAGS + EXTRACFLAGS here, didn't want to verify it can impact on
smth else. And my goal is not to correct everything but embed my
functionality, series tool large w/o it.

>
>But actually, there is no need to use C++ compiler here,
>test_libbpf.cpp can just be plain C. Do you mind renaming it to .c and
>using C compiler instead?
Seems like, will try in next v.

>
>>
>>  $(OUTPUT)libbpf.pc:
>>         $(QUIET_GEN)sed -e "s|@PREFIX@|$(prefix)|" \
>> --
>> 2.17.1
>>

-- 
Regards,
Ivan Khoronzhuk
