Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4436DC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198332080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bqY8uKMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406694AbfITSe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 14:34:59 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45652 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405396AbfITSe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 14:34:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id q64so7971544ljb.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 11:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pnD+O0ovrq1F6qN8k3Y2ZgHyJhSBoQdXb5evY3Rg4Cc=;
        b=bqY8uKMYN5NCM6qjXOyTo3GavIiiiafNBzRaCqO4/1LIT9iV6hBLBucLJ/HZJ0OgZD
         thKmQSPWYASptQ6dsQG3Gy+Mdy4QNYH6K4cmbCjPhmxQKKUrInjNLD3TPtvAfPfvqS5K
         q7PX3cVnCzRyAjngm6osaoQej4LjswgsZCxIfa1fBukdORMQe3f9qPTu0BSpFBPONZnR
         6hpPHBSMQoNREbN2MI2EzZSa4MUlvIZ6CpspsjwL0UBJKXK/X3EvVG818MW67iWDk7HD
         sJrgaFZBw7vcxrXUuQ/6n7DmBSZGus02ZPGRZ+eqido3MD4dUxMb9gqBD+RbsTD8Tfaj
         zn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=pnD+O0ovrq1F6qN8k3Y2ZgHyJhSBoQdXb5evY3Rg4Cc=;
        b=cafqKYH7G6lhhjCeErmjHhwF/5Rk+uT1iPAm07DUfLhocSg9vAUlKOfmzJgF/D74LI
         WpbO4vZvqf1UhVCYYDCa6my5CsOzfeov4tDr1CfPWAg4yP/KXZd5ubI6nE8NVzUUVcS1
         h6MunlWBDMlDlYjXw03euIm6II3K4QadEez1LacHtjG94ri7oBEqpbr6AtOCVSlAIr/B
         xpovVd8XU1OxRfi6xQ5LzaZAro8ni8nRaH4zSXW23DZm3GrMpm6sW4dTEtNsLKHEhTyY
         TSkFSZaBxQrU0xJl4jjhM4nDjWWmAjlAAANhGP4yNUx8EPlXp9xV9YYKg/YYXe892Afa
         f5+w==
X-Gm-Message-State: APjAAAXeI+AzRK42mLwKR+HW0/5ylLu+LtDzQ7crlA7yaJbu2LGOg5NX
        qLdfiRxRLh+occ/YqKFXAZciNQ==
X-Google-Smtp-Source: APXvYqxahYm7w9C/AAIYcYbrY1/vHicqz99sVruFFdLm+qfCxiAg/w2zKMWIq5IhGN7dLvCQN49sNg==
X-Received: by 2002:a2e:a0c5:: with SMTP id f5mr3903494ljm.114.1569004493847;
        Fri, 20 Sep 2019 11:34:53 -0700 (PDT)
Received: from khorivan (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id 77sm603953ljj.84.2019.09.20.11.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Sep 2019 11:34:53 -0700 (PDT)
Date:   Fri, 20 Sep 2019 21:34:51 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Yonghong Song <yhs@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] libbpf: fix version identification on busybox
Message-ID: <20190920183449.GA2760@khorivan>
Mail-Followup-To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190919160518.25901-1-ivan.khoronzhuk@linaro.org>
 <CAEf4BzbCjCYr5NMPctDkUggwpehnqZPVBSqZOsd9MvSq6WmnZQ@mail.gmail.com>
 <20190920082204.GC8870@khorivan>
 <CAEf4BzaVuaN3HhMu8W_i9z4n-2zfjqxBXyOEOaQHexxZq7b3qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAEf4BzaVuaN3HhMu8W_i9z4n-2zfjqxBXyOEOaQHexxZq7b3qg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 09:41:54AM -0700, Andrii Nakryiko wrote:
>On Fri, Sep 20, 2019 at 1:22 AM Ivan Khoronzhuk
><ivan.khoronzhuk@linaro.org> wrote:
>>
>> On Thu, Sep 19, 2019 at 01:02:40PM -0700, Andrii Nakryiko wrote:
>> >On Thu, Sep 19, 2019 at 11:22 AM Ivan Khoronzhuk
>> ><ivan.khoronzhuk@linaro.org> wrote:
>> >>
>> >> It's very often for embedded to have stripped version of sort in
>> >> busybox, when no -V option present. It breaks build natively on target
>> >> board causing recursive loop.
>> >>
>> >> BusyBox v1.24.1 (2019-04-06 04:09:16 UTC) multi-call binary. \
>> >> Usage: sort [-nrugMcszbdfimSTokt] [-o FILE] [-k \
>> >> start[.offset][opts][,end[.offset][opts]] [-t CHAR] [FILE]...
>> >>
>> >> Lets modify command a little to avoid -V option.
>> >>
>> >> Fixes: dadb81d0afe732 ("libbpf: make libbpf.map source of truth for libbpf version")
>> >>
>> >> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> >> ---
>> >>
>> >> Based on bpf/master
>> >>
>> >>  tools/lib/bpf/Makefile | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
>> >> index c6f94cffe06e..a12490ad6215 100644
>> >> --- a/tools/lib/bpf/Makefile
>> >> +++ b/tools/lib/bpf/Makefile
>> >> @@ -3,7 +3,7 @@
>> >>
>> >>  LIBBPF_VERSION := $(shell \
>> >>         grep -oE '^LIBBPF_([0-9.]+)' libbpf.map | \
>> >> -       sort -rV | head -n1 | cut -d'_' -f2)
>> >> +       cut -d'_' -f2 | sort -r | head -n1)
>> >
>> >You can't just sort alphabetically, because:
>> >
>> >1.2
>> >1.11
>> >
>> >should be in that order. See discussion on mailing thread for original commit.
>>
>> if X1.X2.X3, where X = {0,1,....99999}
>> Then it can be:
>>
>> -LIBBPF_VERSION := $(shell \
>> -       grep -oE '^LIBBPF_([0-9.]+)' libbpf.map | \
>> -       sort -rV | head -n1 | cut -d'_' -f2)
>> +_LBPFLIST := $(patsubst %;,%,$(patsubst LIBBPF_%,%,$(filter LIBBPF_%, \
>> +           $(shell cat libbpf.map))))
>> +_LBPFLIST2 := $(foreach v,$(_LBPFLIST), \
>> +               $(subst $() $(),,$(foreach n,$(subst .,$() $(),$(v)), \
>> +                       $(shell printf "%05d" $(n)))))
>> +_LBPF_VER := $(word $(words $(sort $(_LBPFLIST2))), $(sort $(_LBPFLIST2)))
>> +LIBBPF_VERSION := $(patsubst %_$(_LBPF_VER),%,$(filter %_$(_LBPF_VER), \
>> +        $(join $(addsuffix _, $(_LBPFLIST)),$(_LBPFLIST2))))
>>
>> It's bigger but avoids invocations of grep/sort/cut/head, only cat/printf
>> , thus -V option also.
>>
>
>No way, this is way too ugly (and still unreliable, if we ever have
>X.Y.Z.W or something). I'd rather go with my original approach of
Yes, forgot to add
X1,X2,X3,...XN, where X = {0,1,....99999} and N = const for all versions.
But frankly, 1.0.0 looks too far.

>fetching the last version in libbpf.map file. See
>https://www.spinics.net/lists/netdev/msg592703.html.
>
>> >
>> >>  LIBBPF_MAJOR_VERSION := $(firstword $(subst ., ,$(LIBBPF_VERSION)))
>> >>
>> >>  MAKEFLAGS += --no-print-directory
>> >> --
>> >> 2.17.1
>> >>
>>
>> --
>> Regards,
>> Ivan Khoronzhuk

-- 
Regards,
Ivan Khoronzhuk
