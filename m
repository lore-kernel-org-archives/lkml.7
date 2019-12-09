Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CA6C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E1320726
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ea4Z1cQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfLIMpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 07:45:22 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44538 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfLIMpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 07:45:22 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19so15399330lji.11;
        Mon, 09 Dec 2019 04:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0EqX6cEm7s4jaUP8gqU2WgVaUAwSF8/ZNfo7D9M8hX0=;
        b=ea4Z1cQ4j6pVroJI93taTqrNYi4d55Dj2qnxcURpemD++k1BEhkABPoa3SP+An7qJa
         hqOcS0dm14hhp7GHCdMy90aT9j7kxxGG06b9lh0kzY5z5ShRTjcq7q4XTCmx2aiyOnLx
         VAUgCFXP0bed1Wtxma48iO60LicJGzeXvmxmGG7/d3YYtIrHxHKsRp36j4goGEB93LnA
         eueH1BYrBFj81qVyHY8Ur24otJj76LOnZ4uygKZmRqZbVSwi9cyDENQgpvhyKV3YQDBC
         4RKheWS7M4YZYVOqKwxmbeQZhgSg+puxqhejgz3ankmYLGoQPyFtJhVz8NGzR/KBFMKm
         9O9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0EqX6cEm7s4jaUP8gqU2WgVaUAwSF8/ZNfo7D9M8hX0=;
        b=gFuDyUxu249i9UArEDhDqMtLFWo1HymbSREjtPoRHXknRfzMAoZspRR7h9J+OP2aXN
         TN7oHu/zKBxof1MWMsl6b04DIydkjjwAhUVffSwtv2LsQhiDlEZXavzShnLqmecYFCj1
         jV0oHGO6xtEEf4n4P5P1TRyA/ddT/cg80r3hrFtNjXostLaKwNsKeDaXrd4GISOVbggd
         vIJlvioK3kJlLMGPH3JbqZWd8z0Ft7IVJkI8AlTXuquYD3rTVJsrZk5ydgMSlKm1fZt/
         YbpT/7NMKIwLm7uz9PAh+iz73/HCi04QWlQ9Ajz0j6R+9QAU+5voj+NWIfi2YgNmvTCS
         Zmmg==
X-Gm-Message-State: APjAAAVuI0cXxaSB4v3RXDWuWFUVIZKFxd3T9870zM8MLQNMoKKcA2JI
        WAvNRDFBNeGey8VlmUXS4ge1YJ4U
X-Google-Smtp-Source: APXvYqxu678dkp/5vM+8A/RpDAIhinyjuBIeVcmRDlVaSxwyt6q83NX/ycTAw/NrVajhxzxdCwC2jg==
X-Received: by 2002:a2e:98c4:: with SMTP id s4mr16745523ljj.102.1575895519630;
        Mon, 09 Dec 2019 04:45:19 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id y72sm4442818lfa.12.2019.12.09.04.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 04:45:18 -0800 (PST)
Subject: Re: Build regressions/improvements in v5.5-rc1
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
References: <20191209105613.2491-1-geert@linux-m68k.org>
 <CAMuHMdV+4Q2atJUPsYuc+UFxyoh1fscQL7aLUp4CWrb7=U706g@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <33f03ef9-c868-8bd5-ae5d-3da703d21fa9@gmail.com>
Date:   Mon, 9 Dec 2019 15:45:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAMuHMdV+4Q2atJUPsYuc+UFxyoh1fscQL7aLUp4CWrb7=U706g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

09.12.2019 14:02, Geert Uytterhoeven пишет:
> On Mon, Dec 9, 2019 at 11:57 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> Below is the list of build error/warning regressions/improvements in
>> v5.5-rc1[1] compared to v5.4[2].
>>
>> Summarized:
>>   - build errors: +2/-8
>>   - build warnings: +84/-87
>>
>> Happy fixing! ;-)
>>
>> Thanks to the linux-next team for providing the build service.
>>
>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e42617b825f8073569da76dc4510bfa019b1c35a/ (all 232 configs)
>> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/219d54332a09e8d8741c1e1982f5eae56099de85/ (all 232 configs)
>>
>>
>> *** ERRORS ***
>>
>> 2 error regressions:
>>   + error: "clk_set_min_rate" [drivers/devfreq/tegra30-devfreq.ko] undefined!:  => N/A
>>   + error: tegra30-devfreq.c: undefined reference to `clk_set_min_rate':  => .text+0xcc8)
> 
> sh-all{mod,yes}config
> 
> Legacy non-CCF platform do not provide clk_set_min_rate(), so this needs
> a dependency on CCF.

Hello Geert,

Thanks for the report, I'll make a patch to fix it.

> BTW, it seems this was already known back in June...
> https://lore.kernel.org/linux-pm/5301c593-97e1-db4e-067b-0522537b55d9@gmail.com/

Yes, I was a bit confused about why only T20 driver was causing the
trouble.
