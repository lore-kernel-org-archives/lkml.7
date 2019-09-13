Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE276C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA3E20693
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yWIvAi71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403934AbfIMWPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:15:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35469 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390255AbfIMWPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 18:15:00 -0400
Received: by mail-lj1-f193.google.com with SMTP id q22so23910486ljj.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 15:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Aws4qLTU0wWFl3XhWF/GSUsHrXBVOSQQwQxzuiN2xN0=;
        b=yWIvAi71EhlHzCIVwDfDDbPfCTzA3GqRJL4xVjp+4yE3LIJT4p9CeK76GSeSnFgn61
         8ZxhkeHuWFqiKYjWJGaDOBOxfHgjQcvDCVbx3V9DbEuLBvZ2XI2FUMVmW04FvxOwVEZ5
         aMg/9h9g9acJ0eSgOSpKg8+26ULeOyMbe6xYDa4+zXK1KotBl9WXbEkOYgaYMhhwHdQn
         XAx7jn9seCLMHjGGywKuEPCGqoC8U8gG+wSXZWJgumcdffpaFX32soDlRa2lvh+VLjXQ
         S8HLuTKqYa5hM7AMsI43M3KfqO2IJySOxGyjgfr2DTf8vuYsHCNSz/JeU24eIG67v/jx
         T95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Aws4qLTU0wWFl3XhWF/GSUsHrXBVOSQQwQxzuiN2xN0=;
        b=pDb66o9cJqJg3gi4yMYAvQWqUyftvVywG+4Lg3mwWIr3sBS77Ju0Ush5QyL+sq8xcC
         udsnSu4x2jzQcd1LUfM9pzehDGviHSPfyZ7R4UjPPjUyzXONEAcnJ4ySqTdXli/XuDQH
         iaW2/hSHBsLdZbFfopOFT3c5wQ7UPwxT/GddBDEv9Gxfpdj2x6H/xFD8SQDQ1onqpJIr
         nucwD1mTdTKYgFWWpIg5g4cwa40AOqjznWVxFVTaDlTeOwU3VglrEp7SGCPXvFQca6FT
         Vh2yoQSDX3kHYxzv+Q5D8fgLAYB7UmCARk0B3T4EniKJdmOQEaVt2hPXO/bEaDWMjACH
         e6PA==
X-Gm-Message-State: APjAAAVgut9u7rosiBuJNa3Aj0ZAPkXFuoFTNYHzHkwTafCuORadULjV
        hhDOI30zDgJEfiujWSdagQloeQ==
X-Google-Smtp-Source: APXvYqwlnHCevB0S7cA0qpBG5jlZDBao84E1GD8LnJh21I2z6KDrBVlkh/b4zGUa95Y8PdeNBSN+Pg==
X-Received: by 2002:a2e:3618:: with SMTP id d24mr30461361lja.179.1568412897370;
        Fri, 13 Sep 2019 15:14:57 -0700 (PDT)
Received: from khorivan (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id w13sm666947lfk.47.2019.09.13.15.14.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Sep 2019 15:14:56 -0700 (PDT)
Date:   Sat, 14 Sep 2019 01:14:54 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH bpf-next 07/11] samples: bpf: add makefile.prog for
 separate CC build
Message-ID: <20190913221453.GD26724@khorivan>
Mail-Followup-To: Yonghong Song <yhs@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" <clang-built-linux@googlegroups.com>
References: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
 <20190910103830.20794-8-ivan.khoronzhuk@linaro.org>
 <1720c5a5-5c64-46a3-be2f-56b59614f82a@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1720c5a5-5c64-46a3-be2f-56b59614f82a@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 09:33:58PM +0000, Yonghong Song wrote:
>
>
>On 9/10/19 11:38 AM, Ivan Khoronzhuk wrote:
>> The makefile.prog is added only, will be used in sample/bpf/Makefile
>> later in order to switch cross-compiling on CC from HOSTCC.
>>
>> The HOSTCC is supposed to build binaries and tools running on the host
>> afterwards, in order to simplify build or so, like "fixdep" or else.
>> In case of cross compiling "fixdep" is executed on host when the rest
>> samples should run on target arch. In order to build binaries for
>> target arch with CC and tools running on host with HOSTCC, lets add
>> Makefile.prog for simplicity, having definition and routines similar
>> to ones, used in script/Makefile.host. This allows later add
>> cross-compilation to samples/bpf with minimum changes.
>
>So this is really Makefile.host or Makefile.user, right?
It's cut and modified version of Makefile.host

>In BPF, 'prog' can refers to user prog or bpf prog.
>To avoid ambiguity, maybe Makefile.host?
Makefile.target? as target = host not always.
Makefile.user also looks ok, but doesn't contain target,
maybe "targetuser", but bpf is also target...
Initially I was thinking about Makefile.targetprog, but it looks too long.

>
>>
>> Makefile.prog contains only stuff needed for samples/bpf, potentially
>> can be reused and extended for other prog sets later and now needed
>
>What do you mean 'extended for other prog sets'? I am wondering whether
Another kind of samples...with c++ for instance.

>we could just include 'scripts/Makefile.host'? How hard it is?
It's bound to HOSTCC and it's environment. It is included by default and
was used before this patchset, blocking cross complication.

>
>> only for unblocking tricky samples/bpf cross compilation.
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> ---
>>   samples/bpf/Makefile.prog | 77 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 77 insertions(+)
>>   create mode 100644 samples/bpf/Makefile.prog
>>
>> diff --git a/samples/bpf/Makefile.prog b/samples/bpf/Makefile.prog
>> new file mode 100644
>> index 000000000000..3781999b9193
>> --- /dev/null
>> +++ b/samples/bpf/Makefile.prog
>> @@ -0,0 +1,77 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# ==========================================================================
>> +# Building binaries on the host system
>> +# Binaries are not used during the compilation of the kernel, and intendent
>> +# to be build for target board, target board can be host ofc. Added to build
>> +# binaries to run not on host system.
>> +#
>> +# Only C is supported, but can be extended for C++.
>
>The above comment is not needed.
will drop it.

>samples/bpf/ only have C now. I am wondering whether your below scripts
>can be simplified, e.g., removing cxxobjs.
I think yes, will try

>
>> +#
>> +# Sample syntax (see Documentation/kbuild/makefiles.rst for reference)
>> +# progs-y := xsk_example
>> +# Will compile xdpsock_example.c and create an executable named xsk_example
>> +#
>> +# progs-y    := xdpsock
>> +# xdpsock-objs := xdpsock_1.o xdpsock_2.o
>> +# Will compile xdpsock_1.c and xdpsock_2.c, and then link the executable
>> +# xdpsock, based on xdpsock_1.o and xdpsock_2.o
>> +#
>> +# Inherited from scripts/Makefile.host
>> +#
>> +__progs := $(sort $(progs-y))
>> +
>> +# C code
>> +# Executables compiled from a single .c file
>> +prog-csingle	:= $(foreach m,$(__progs), \
>> +			$(if $($(m)-objs)$($(m)-cxxobjs),,$(m)))
>> +
>> +# C executables linked based on several .o files
>> +prog-cmulti	:= $(foreach m,$(__progs),\
>> +		   $(if $($(m)-cxxobjs),,$(if $($(m)-objs),$(m))))
>> +
>> +# Object (.o) files compiled from .c files
>> +prog-cobjs	:= $(sort $(foreach m,$(__progs),$($(m)-objs)))
>> +
>> +prog-csingle	:= $(addprefix $(obj)/,$(prog-csingle))
>> +prog-cmulti	:= $(addprefix $(obj)/,$(prog-cmulti))
>> +prog-cobjs	:= $(addprefix $(obj)/,$(prog-cobjs))
>> +
>> +#####
>> +# Handle options to gcc. Support building with separate output directory
>> +
>> +_progc_flags   = $(PROGS_CFLAGS) \
>> +                 $(PROGCFLAGS_$(basetarget).o)
>> +
>> +# $(objtree)/$(obj) for including generated headers from checkin source files
>> +ifeq ($(KBUILD_EXTMOD),)
>> +ifdef building_out_of_srctree
>> +_progc_flags   += -I $(objtree)/$(obj)
>> +endif
>> +endif
>> +
>> +progc_flags    = -Wp,-MD,$(depfile) $(_progc_flags)
>> +
>> +# Create executable from a single .c file
>> +# prog-csingle -> Executable
>> +quiet_cmd_prog-csingle 	= CC  $@
>> +      cmd_prog-csingle	= $(CC) $(progc_flags) $(PROGS_LDFLAGS) -o $@ $< \
>> +		$(PROGS_LDLIBS) $(PROGLDLIBS_$(@F))
>> +$(prog-csingle): $(obj)/%: $(src)/%.c FORCE
>> +	$(call if_changed_dep,prog-csingle)
>> +
>> +# Link an executable based on list of .o files, all plain c
>> +# prog-cmulti -> executable
>> +quiet_cmd_prog-cmulti	= LD  $@
>> +      cmd_prog-cmulti	= $(CC) $(progc_flags) $(PROGS_LDFLAGS) -o $@ \
>> +			  $(addprefix $(obj)/,$($(@F)-objs)) \
>> +			  $(PROGS_LDLIBS) $(PROGLDLIBS_$(@F))
>> +$(prog-cmulti): $(prog-cobjs) FORCE
>> +	$(call if_changed,prog-cmulti)
>> +$(call multi_depend, $(prog-cmulti), , -objs)
>> +
>> +# Create .o file from a single .c file
>> +# prog-cobjs -> .o
>> +quiet_cmd_prog-cobjs	= CC  $@
>> +      cmd_prog-cobjs	= $(CC) $(progc_flags) -c -o $@ $<
>> +$(prog-cobjs): $(obj)/%.o: $(src)/%.c FORCE
>> +	$(call if_changed_dep,prog-cobjs)
>>

-- 
Regards,
Ivan Khoronzhuk
