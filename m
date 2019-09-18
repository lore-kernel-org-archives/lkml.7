Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8994AC4CECE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 10:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BAD21906
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 10:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y5GBajLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfIRKXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 06:23:09 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46308 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbfIRKXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 06:23:08 -0400
Received: by mail-lf1-f66.google.com with SMTP id t8so5225944lfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 03:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fVR7WsKZT5heVux6OOhTNN5qN9Wk5lAWV1vo95u5Gr0=;
        b=Y5GBajLiMRbH/tuOHEBJvgYOb5SWPminhxoMUY69MsCfGM5r0xIm6Ikqje9sxOendn
         tdPVPYzb9qFisuw1tsor9oEfooOu33xZjMzzTjqw5xlPejP8lTovz/Y9QgvDAGiXbD5g
         LUamOcDj0jAoSLteYIE+uEzSJPyUazE+b8FlFAjwivlQFnBzUf3h6/sM2MEMZiqj5in6
         lKTphQZcEWAnzjawl6Aj9zY4GZUT5YQaYGSWT+quiiskZS/xx4dbZgRw4uDeN1kpJwfE
         WD1C1bCk+z/2QU5cWDBUTNLovP0E0/w/HlsZwYjfRLedw80G+Ue9YebLZxOTQ3hvmeiA
         Vcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=fVR7WsKZT5heVux6OOhTNN5qN9Wk5lAWV1vo95u5Gr0=;
        b=Vgv0KgfzgeiCSdX8hlhBJQG0OWcYeeTFj5ZnEHSXkdM4ngvjyQ/CueSQg+72nSmWAz
         g9CJwZ6SAAzsVfWELmaSl3diQuLQhpANzglqsL0T+VQjuBqeQwEjNkAVPJtIQqx8ENBN
         w3Au8fk2YbfK/W10EyhZz537gZjr8h562qShAcIKs660HWsJLa0SGwyY1ukT2c2QxQqQ
         7unKygCROUpQ1s/jYX5fZrMH8mdmrgXZpTqmeQBPuvPd52/3CPcvntsJeBfL5++srULr
         f3CBJyDD6aehuZsJF9lEB44aK8ZSEnUhrHB0hT1A8OMkYuNZFJc4mZ4QbMUuPIkHYPEF
         LU/g==
X-Gm-Message-State: APjAAAWS2p8HCHYGdDYeA55kqpugwQdMQLTXzV+ErYm56/lHvfnN+Ylv
        +2D4FNQ/2tMdWk+7JA7Ey9WAOw==
X-Google-Smtp-Source: APXvYqz4gDimKURT0PWwEBQXLEtgkrosCtJcqwr5kRYavpJm1msXefaCnraptiyROoAqurD5dtoidA==
X-Received: by 2002:a19:7d55:: with SMTP id y82mr1737621lfc.106.1568802186400;
        Wed, 18 Sep 2019 03:23:06 -0700 (PDT)
Received: from khorivan (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id y22sm936629lfb.75.2019.09.18.03.23.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Sep 2019 03:23:05 -0700 (PDT)
Date:   Wed, 18 Sep 2019 13:23:03 +0300
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
Subject: Re: [PATCH v3 bpf-next 08/14] samples: bpf: makefile: base target
 programs rules on Makefile.target
Message-ID: <20190918102301.GB2908@khorivan>
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
 <20190916105433.11404-9-ivan.khoronzhuk@linaro.org>
 <CAEf4BzYFoJJk+WM51YT7NwCxQpy117DAMmgiJ1YbqaW9UUWpEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAEf4BzYFoJJk+WM51YT7NwCxQpy117DAMmgiJ1YbqaW9UUWpEg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 04:28:01PM -0700, Andrii Nakryiko wrote:
>On Mon, Sep 16, 2019 at 3:58 AM Ivan Khoronzhuk
><ivan.khoronzhuk@linaro.org> wrote:
>>
>
>Please don't prepend "samples: bpf: makefile:" to patches,
>"samples/bpf: " is a typical we've used for BPF samples changes.
Ok.

>
>
>> The main reason for that - HOSTCC and CC have different aims.
>> HOSTCC is used to build programs running on host, that can
>> cross-comple target programs with CC. It was tested for arm and arm64
>> cross compilation, based on linaro toolchain, but should work for
>> others.
>>
>> So, in order to split cross compilation (CC) with host build (HOSTCC),
>> lets base samples on Makefile.target. It allows to cross-compile
>> samples/bpf programs with CC while auxialry tools running on host
>> built with HOSTCC.
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> ---
>>  samples/bpf/Makefile | 135 ++++++++++++++++++++++---------------------
>>  1 file changed, 69 insertions(+), 66 deletions(-)
>>
>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>> index 9d923546e087..1579cc16a1c2 100644
>> --- a/samples/bpf/Makefile
>> +++ b/samples/bpf/Makefile
>> @@ -4,55 +4,53 @@ BPF_SAMPLES_PATH ?= $(abspath $(srctree)/$(src))
>>  TOOLS_PATH := $(BPF_SAMPLES_PATH)/../../tools
>>
>>  # List of programs to build
>> -hostprogs-y := test_lru_dist
[...]
>> -KBUILD_HOSTCFLAGS := $(ARM_ARCH_SELECTOR)
>> +TPROGS_CFLAGS += $(ARM_ARCH_SELECTOR)
>>  endif
>>
>> +TPROGS_LDLIBS := $(KBUILD_HOSTLDLIBS)
>
>Please group TPROGS_LDLIBS definition together with the one below,
>there doesn't seem to be a reason to split them this way.
No. It's used in Makefile.target and should be here, following hostprog logic.

>
>But also, it's kind of weird to use host libraries as cross-compiled
>libraries as well. Is that intentional?
No cross-compile split yet. This patch replace only KBUILD on TPROGS.
It's done in following patches.

>
>> +TPROGS_CFLAGS += $(KBUILD_HOSTCFLAGS) $(HOST_EXTRACFLAGS)
>
>Same here, is it right to use HOSTCFLAGS and HOST_EXTRACFLAGS as a
>base for cross-compiled cflags?
same

[...]

-- 
Regards,
Ivan Khoronzhuk
