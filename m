Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65961C43140
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 00:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0622173B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 00:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K0DVaUnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392232AbfIGATQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 20:19:16 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35113 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbfIGATP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 20:19:15 -0400
Received: by mail-lf1-f68.google.com with SMTP id w6so6434498lfl.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 17:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LMaOt4FuyGYZ6GmxTEoNOWFTUVjVfbek7WmSRfSN6/o=;
        b=K0DVaUnOkxgz+BKGM7Jmk5fFVihMqVmZ8hXXahLcWXcTRqMO4z4Fisuh4jSp+34lCI
         q3BxgPAm8qSgHy06TwfpR6TuhCPUBUgumdtMFFCzQC4Izg0n3WRU6McD42+kqdaiJhcM
         oUEZQcFUUG+F4oQWXMZh1jwL2SJ57qEaMSNjtH07rVPPJxrM3Bf0BSm4BoCGo5ooz3fw
         hGEMjhXT2x5q7uWChN33cEQR0+0IkbQFCW18gDg81qIQikzQjr+WASiocZ9cVeMnUhq1
         lwKjnr6PATu0XJ4NFeiYu0LBkXAuzLU3bKsd1fz7cwguDepfSUXPTtnuWQmpxHLiYTGO
         xWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=LMaOt4FuyGYZ6GmxTEoNOWFTUVjVfbek7WmSRfSN6/o=;
        b=tnq8oRs9TYC/lfG57e4XsMKUB0yQrAW9OwmzaQYryS8Tbp8c4zIiP+9yIj142NQnm2
         2YQ7LgWH1u2mphXiPZa/7HNCOxHfggrvVb3AyBzYs+oAzdVZ0lenIljD3TzDp6+/2bpg
         GlZzX2bCI6Gghq24FYbEP70o3ZeHSJALODr7vakdrsNSxWrr5F3tcf5CsOYSdS4Mex9Z
         6+hPkpR4t5I/anVNGzeHjWLEniLnk2qMGgm7QgbiEcuItAYVG2fYdfnyeos0CXJ1Vl6f
         SezneONhOGRdmz0vwh1Cd4v8cE+fiUSsIA19LuLCNNvQ3cWZZFm9XACDRr9QgZnX0KiH
         7DLA==
X-Gm-Message-State: APjAAAV7kp8AJ70RxuWcs1HPr8IPilmwlyb3WydoJroRtkRd3OVtKwwb
        jiY0eo7oJAr5BQMG1G2OtHiB5Q==
X-Google-Smtp-Source: APXvYqzTQQuqgyPV0OhoMW68LUGmu1SvlTcBRhM6FTRiqF/TZROjf7snMsVgox5ANFh6wnVtsDSn4w==
X-Received: by 2002:a19:117:: with SMTP id 23mr8278563lfb.115.1567815553302;
        Fri, 06 Sep 2019 17:19:13 -0700 (PDT)
Received: from khorivan (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id i65sm1138129lji.16.2019.09.06.17.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Sep 2019 17:19:12 -0700 (PDT)
Date:   Sat, 7 Sep 2019 03:19:10 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH bpf-next 2/8] samples: bpf: Makefile: remove target for
 native build
Message-ID: <20190907001909.GB3053@khorivan>
Mail-Followup-To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
References: <20190904212212.13052-1-ivan.khoronzhuk@linaro.org>
 <20190904212212.13052-3-ivan.khoronzhuk@linaro.org>
 <20190906233138.4d4fqdnlbikemhau@ast-mbp.dhcp.thefacebook.com>
 <20190906235207.GA3053@khorivan>
 <CAADnVQKOT8D9156p49AQ0q0z5Zks5te4Ofi6DrBfpnitmRBgmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAADnVQKOT8D9156p49AQ0q0z5Zks5te4Ofi6DrBfpnitmRBgmg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 05:04:08PM -0700, Alexei Starovoitov wrote:
>On Fri, Sep 6, 2019 at 4:52 PM Ivan Khoronzhuk
><ivan.khoronzhuk@linaro.org> wrote:
>>
>> On Fri, Sep 06, 2019 at 04:31:39PM -0700, Alexei Starovoitov wrote:
>> >On Thu, Sep 05, 2019 at 12:22:06AM +0300, Ivan Khoronzhuk wrote:
>> >> No need to set --target for native build, at least for arm, the
>> >> default target will be used anyway. In case of arm, for at least
>> >> clang 5 - 10 it causes error like:
>> >>
>> >> clang: warning: unknown platform, assuming -mfloat-abi=soft
>> >> LLVM ERROR: Unsupported calling convention
>> >> make[2]: *** [/home/root/snapshot/samples/bpf/Makefile:299:
>> >> /home/root/snapshot/samples/bpf/sockex1_kern.o] Error 1
>> >>
>> >> Only set to real triple helps: --target=arm-linux-gnueabihf
>> >> or just drop the target key to use default one. Decision to just
>> >> drop it and thus default target will be used (wich is native),
>> >> looks better.
>> >>
>> >> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> >> ---
>> >>  samples/bpf/Makefile | 2 --
>> >>  1 file changed, 2 deletions(-)
>> >>
>> >> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>> >> index 61b7394b811e..a2953357927e 100644
>> >> --- a/samples/bpf/Makefile
>> >> +++ b/samples/bpf/Makefile
>> >> @@ -197,8 +197,6 @@ BTF_PAHOLE ?= pahole
>> >>  ifdef CROSS_COMPILE
>> >>  HOSTCC = $(CROSS_COMPILE)gcc
>> >>  CLANG_ARCH_ARGS = --target=$(notdir $(CROSS_COMPILE:%-=%))
>> >> -else
>> >> -CLANG_ARCH_ARGS = -target $(ARCH)
>> >>  endif
>> >
>> >I don't follow here.
>> >Didn't you introduce this bug in patch 1 and now fixing it in patch 2?
>> >
>>
>> It looks like but that's not true.
>> Previous patch adds target only for cross compiling,
>> before the patch the target was used for both, cross compiling and w/o cc.
>>
>> This patch removes target only for native build (it's not cross compiling).
>>
>> By fact, it's two separate significant changes.
>
>How so?
>before first patch CLANG_ARCH_ARGS is only used under CROSS_COMPILE.
>After the first patch CLANG_ARCH_ARGS is now suddenly defined w/o CROSS_COMPILE
>and second patch brings it to the state before first patch.

Oh sorry ), messed with my local exp with target bpf, after rebase, even forgot
that's mine. Will drop it, with removing "else" for previous patch.

-- 
Regards,
Ivan Khoronzhuk
