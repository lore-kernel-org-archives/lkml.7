Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64E8C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784792070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q8dtbXc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKVXrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:47:43 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35502 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfKVXrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:47:40 -0500
Received: by mail-lj1-f194.google.com with SMTP id j6so220797lja.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 15:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BUKr4yoGpKaxYmTEmTDH/7ICwo7GEhPoNnnopGTuMFc=;
        b=Q8dtbXc+uzPlnQ7A3hyBJf9uHmj4UbqP18hCKWDZhmVvKvjKGssVYIijTzf0ayTkVO
         LAEg4y9VzSoF/UnQ2ptgX5kr3ovEqBBhLP10m920O87sMgbXTALiqLwGLiYm+BsjHzNr
         09usHFb7cS5XOfK9/diQukOnyjNUlcwP5GZdpBPAwx+wj33CfNIM1bNH8kaX6DcGAD+u
         qgIv5rdhBD4DEwr/Nwnvi1OIOJrxJ0E2E04ivUsCckocWk+PvRXZ7JpQCHoQVn/cGwDe
         eTKQwJvbO6GE63u/3wsmEDuSX6u+vuIPuLf/X1GL65Qkvko/beBq4O2+gMkISVjy+2rM
         cRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=BUKr4yoGpKaxYmTEmTDH/7ICwo7GEhPoNnnopGTuMFc=;
        b=se9V2pYLMS2kWXlaeD0CWXXUsOEve8u7+ac2n4OIRw70hdMDT7YXCEFot4SmdltTqd
         82qLKwWAX7g4k6yPy+iXrGTYwGyg0IJMHYzSxk0Y56j/MDIx8hrmz+ef/J8rvCwRElOf
         q5qCsyRNP7m9UhcFf3TfMQwWKUE8TMkioZkbDgbjAVGzW2sN6N9blQ7lLw5hh4UEgSSU
         7o/9003C26g67P5+AJa3Vjvq86B+K4Vhq7fC9N7kyCz6ePL9VowEV9+SryguRth1XPQs
         GVDSCbWbf3oyqyrCP7hWEH8+pg+NculaOvQSyjyh+c/ZoaFBr9N95VFHdvpQyrmUHevO
         lDwA==
X-Gm-Message-State: APjAAAUGPoz9n+8ahqfbTeXgx/77/TRDfJ4fdpNVFya9SWeHlJZU2x2J
        u/icOOGHAGubsBaxCPMVxzyLoQ==
X-Google-Smtp-Source: APXvYqz0tvkYX9lNjGIZfLY/VjLXdb9DDKAILAvxppaODGA/mHO1za/hr61E9lBoBkP1KloPumXSOg==
X-Received: by 2002:a2e:9a95:: with SMTP id p21mr13622079lji.175.1574466456985;
        Fri, 22 Nov 2019 15:47:36 -0800 (PST)
Received: from khorivan (57-201-94-178.pool.ukrtel.net. [178.94.201.57])
        by smtp.gmail.com with ESMTPSA id t12sm3744290lfc.73.2019.11.22.15.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 15:47:36 -0800 (PST)
Date:   Sat, 23 Nov 2019 01:47:34 +0200
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        clang-built-linux@googlegroups.com, ilias.apalodimas@linaro.org,
        sergei.shtylyov@cogentembedded.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH v5 bpf-next 11/15] libbpf: don't use cxx to test_libpf
 target
Message-ID: <20191122234733.GA2474@khorivan>
Mail-Followup-To: Stanislav Fomichev <sdf@fomichev.me>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        clang-built-linux@googlegroups.com, ilias.apalodimas@linaro.org,
        sergei.shtylyov@cogentembedded.com,
        Andrii Nakryiko <andriin@fb.com>
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
 <20191011002808.28206-12-ivan.khoronzhuk@linaro.org>
 <20191121214225.GA3145429@mini-arch.hsd1.ca.comcast.net>
 <CAEf4BzZWPwzC8ZBWcBOfQQmxBkDRjogxw2xHZ+dMWOrrMmU0sg@mail.gmail.com>
 <20191122163211.GB3145429@mini-arch.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191122163211.GB3145429@mini-arch.hsd1.ca.comcast.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 08:32:11AM -0800, Stanislav Fomichev wrote:
>On 11/21, Andrii Nakryiko wrote:
>> On Thu, Nov 21, 2019 at 1:42 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
>> >
>> > On 10/11, Ivan Khoronzhuk wrote:
>> > > No need to use C++ for test_libbpf target when libbpf is on C and it
>> > > can be tested with C, after this change the CXXFLAGS in makefiles can
>> > > be avoided, at least in bpf samples, when sysroot is used, passing
>> > > same C/LDFLAGS as for lib.
>> > > Add "return 0" in test_libbpf to avoid warn, but also remove spaces at
>> > > start of the lines to keep same style and avoid warns while apply.
>> > Hey, just spotted this patch, not sure how it slipped through.
>> > The c++ test was there to make sure libbpf can be included and
>> > linked against c++ code (i.e. libbpf headers don't have some c++
>> > keywords/etc).
>> >
>> > Any particular reason you were not happy with it? Can we revert it
>> > back to c++ and fix your use-case instead? Alternatively, we can just
>> > remove this test if we don't really care about c++.
>> >
>>
>> No one seemed to know why we have C++ pieces in pure C library and its
>> Makefile, so we decide to "fix" this. :)
>It's surprising, the commit 8c4905b995c6 clearly states the reason
>for adding it. Looks like it deserved a real comment in the Makefile :-)

I dislike changing things like this, but I was asked while review and
it seemed logical enough. The comment could prevent us from doing this.

>
>> But I do understand your concern. Would it be possible to instead do
>> this as a proper selftests test? Do you mind taking a look at that?
>Ack, will move this test_libbpf.c into selftests and convert back to
>c++.

-- 
Regards,
Ivan Khoronzhuk
