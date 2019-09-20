Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DA5C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3D62086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nj6dCKWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbfITWOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 18:14:38 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37253 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbfITWOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 18:14:35 -0400
Received: by mail-lj1-f193.google.com with SMTP id l21so8509854lje.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 15:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IRz22h3W/afcIJB0BovjnHm3KrpXLfImRjiuM75f0vE=;
        b=nj6dCKWhmdUQxj5iaCpyF6gklY2n3UMYPwQRJI7eaUvn3ZOJVATTF1m/uWCZktXuBK
         EXP1s8+6sACOn4WGwErbm+uuBKs58dfMtwRkwDfUAhjW3NPuXwFhkVXgyJTbKKi26pVX
         wUClQWsT3XolYSWxXhMS1vqwkt/LBd7DI323UTUsm3IcdnJHgZO/RR1X8mmHm3+19EkE
         XhcvIfV6ncLwpH3w6mf/V/yHGhu0gWQXGzf/qTlB8FGMaUkuAQzCdTAUb61ztfh2c/lB
         hkR8KQqenaCDUHAnBgK25odGBRZ6vhXKyeLhuF+L8dWU6oS3yp3UsJ3BfBIBO01GGyW1
         nKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=IRz22h3W/afcIJB0BovjnHm3KrpXLfImRjiuM75f0vE=;
        b=moJlhW2CoGA12QuYODBH1cUpbjrVvTR66mIn3sKplK4q3nIwFiTjDGhDRix8PY7OmK
         WJLWsfGgUJ3YZoOG9XamqHUxWbZIWJR4Pkzgj2O/r1lSEKJ1MB6cHqAk52+7HraXNqjD
         +Gg9APyvyKDX+M4MxrlWzFxhaY6U5pYKyBGSj38sujSq0L5T4lVEu3wxeqlRTlUzAYo/
         CpILvyaEzbns+WfM4fpyJ2FfUbFy6xn1nZr9WxYLFdjAzcf8MfcwwsyQUU1PE682DDbL
         NQ1M420fzG3OGLnOCK0fD6qkix410390VH/9y8ObREjF+/a11yN9zv7wVCEBjnJX+0qv
         JSAg==
X-Gm-Message-State: APjAAAUbDea6k+XdLAb+L7vYxszV552jOg39QfQuG4cKq1btqY3xetcV
        TpzBTbOJUYju+cL75+MNFDthBg==
X-Google-Smtp-Source: APXvYqywLy+KgGcp2RAVw5wnQazdFc1mY+zJWDkhGpK52VsS2JLEAu2nWxraOw89TpoyEj69bsbXLw==
X-Received: by 2002:a2e:3e07:: with SMTP id l7mr10480272lja.180.1569017671610;
        Fri, 20 Sep 2019 15:14:31 -0700 (PDT)
Received: from khorivan (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id c69sm761013ljf.32.2019.09.20.15.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Sep 2019 15:14:30 -0700 (PDT)
Date:   Sat, 21 Sep 2019 01:14:28 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Yonghong Song <yhs@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] libbpf: fix version identification on busybox
Message-ID: <20190920221427.GD2760@khorivan>
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
 <20190920183449.GA2760@khorivan>
 <20190920191941.GB2760@khorivan>
 <CAEf4BzZGeY-WD17mq6FTd7Rae_f26j4kBAWCmuppeu4VjZxvUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAEf4BzZGeY-WD17mq6FTd7Rae_f26j4kBAWCmuppeu4VjZxvUg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 02:51:14PM -0700, Andrii Nakryiko wrote:
>On Fri, Sep 20, 2019 at 12:19 PM Ivan Khoronzhuk
><ivan.khoronzhuk@linaro.org> wrote:
>>
>> On Fri, Sep 20, 2019 at 09:34:51PM +0300, Ivan Khoronzhuk wrote:
>> >On Fri, Sep 20, 2019 at 09:41:54AM -0700, Andrii Nakryiko wrote:
>> >>On Fri, Sep 20, 2019 at 1:22 AM Ivan Khoronzhuk
>> >><ivan.khoronzhuk@linaro.org> wrote:
>> >>>
>> >>>On Thu, Sep 19, 2019 at 01:02:40PM -0700, Andrii Nakryiko wrote:
>> >>>>On Thu, Sep 19, 2019 at 11:22 AM Ivan Khoronzhuk
>> >>>><ivan.khoronzhuk@linaro.org> wrote:
>> >>>>>
>> >>>>> It's very often for embedded to have stripped version of sort in
>> >>>>> busybox, when no -V option present. It breaks build natively on target
>> >>>>> board causing recursive loop.
>> >>>>>
>> >>>>> BusyBox v1.24.1 (2019-04-06 04:09:16 UTC) multi-call binary. \
>> >>>>> Usage: sort [-nrugMcszbdfimSTokt] [-o FILE] [-k \
>> >>>>> start[.offset][opts][,end[.offset][opts]] [-t CHAR] [FILE]...
>> >>>>>
>> >>>>> Lets modify command a little to avoid -V option.
>> >>>>>
>> >>>>> Fixes: dadb81d0afe732 ("libbpf: make libbpf.map source of truth for libbpf version")
>> >>>>>
>> >>>>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> >>>>> ---
>> >>>>>
>> >>>>> Based on bpf/master
>> >>>>>
>> >>>>>  tools/lib/bpf/Makefile | 2 +-
>> >>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>>>>
>> >>>>> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
>> >>>>> index c6f94cffe06e..a12490ad6215 100644
>> >>>>> --- a/tools/lib/bpf/Makefile
>> >>>>> +++ b/tools/lib/bpf/Makefile
>> >>>>> @@ -3,7 +3,7 @@
>> >>>>>
>> >>>>>  LIBBPF_VERSION := $(shell \
>> >>>>>         grep -oE '^LIBBPF_([0-9.]+)' libbpf.map | \
>> >>>>> -       sort -rV | head -n1 | cut -d'_' -f2)
>> >>>>> +       cut -d'_' -f2 | sort -r | head -n1)
>> >>>>
>> >>>>You can't just sort alphabetically, because:
>> >>>>
>> >>>>1.2
>> >>>>1.11
>> >>>>
>> >>>>should be in that order. See discussion on mailing thread for original commit.
>> >>>
>> >>>if X1.X2.X3, where X = {0,1,....99999}
>> >>>Then it can be:
>> >>>
>> >>>-LIBBPF_VERSION := $(shell \
>> >>>-       grep -oE '^LIBBPF_([0-9.]+)' libbpf.map | \
>> >>>-       sort -rV | head -n1 | cut -d'_' -f2)
>> >>>+_LBPFLIST := $(patsubst %;,%,$(patsubst LIBBPF_%,%,$(filter LIBBPF_%, \
>> >>>+           $(shell cat libbpf.map))))
>> >>>+_LBPFLIST2 := $(foreach v,$(_LBPFLIST), \
>> >>>+               $(subst $() $(),,$(foreach n,$(subst .,$() $(),$(v)), \
>> >>>+                       $(shell printf "%05d" $(n)))))
>> >>>+_LBPF_VER := $(word $(words $(sort $(_LBPFLIST2))), $(sort $(_LBPFLIST2)))
>> >>>+LIBBPF_VERSION := $(patsubst %_$(_LBPF_VER),%,$(filter %_$(_LBPF_VER), \
>> >>>+        $(join $(addsuffix _, $(_LBPFLIST)),$(_LBPFLIST2))))
>> >>>
>> >>>It's bigger but avoids invocations of grep/sort/cut/head, only cat/printf
>> >>>, thus -V option also.
>> >>>
>> >>
>> >>No way, this is way too ugly (and still unreliable, if we ever have
>> >>X.Y.Z.W or something). I'd rather go with my original approach of
>> >Yes, forgot to add
>> >X1,X2,X3,...XN, where X = {0,1,....99999} and N = const for all versions.
>> >But frankly, 1.0.0 looks too far.
>>
>> It actually works for any numbs of X1.X2...X100
>> but not when you have couple kindof:
>> X1.X2.X3
>> and
>> X1.X2.X3.X4
>>
>> But, no absolutely any problem to extend this solution to handle all cases,
>> by just adding leading 0 to every "transformed version", say limit it to 10
>> possible 'dots' (%5*10d) and it will work as clocks. Advantage - mostly make
>> functions.
>>
>> Here can be couple more solutions with sed, not sure it can look less maniac.
>>
>> >
>> >>fetching the last version in libbpf.map file. See
>> >>https://www.spinics.net/lists/netdev/msg592703.html.
>>
>> Yes it's nice but, no sort, no X1.X2.X3....XN
>>
>> Main is to solve it for a long time.
>
>Thinking a bit more about this, I'm even more convinced that we should
>just go with my original approach: find last section in libbpf.map and
>extract LIBBPF version from that. That will handle whatever crazy
>version format we might decide to use (e.g., 1.2.3-experimental).
>We'll just need to make sure that latest version is the last in
>libbpf.map, which will just happen naturally. So instead of this
>Makefile complexity, please can you port back my original approach?
>Thanks!

I don't insist, placed it for history and to show it can be sorted
alphabetically, I can live with cross-compilation that I hope goes soon,
on host no need to worry about this at all. So I better leave this change
up to you.

-- 
Regards,
Ivan Khoronzhuk
