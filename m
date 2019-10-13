Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09FBECE587
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 17:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2B7206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 17:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="MArB/yKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfJMRG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 13:06:29 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42173 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbfJMRG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 13:06:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id c195so10161770lfg.9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 10:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xLbu07FbZMOUGLOKpbGSEAHgMuRzWgnJgVeR/okx9Mc=;
        b=MArB/yKUcZ+UCarFvdsudTlFvo77FpDS6Dg/7V4q6QeKuqqTXC5dH4r6KEcvmp8QZ0
         wNfnzEhhuC4ERBu5zrS0csbx0oCaoXKYWnkluTtT+ZgGLeyjLKxXM3aL30cCHrWgkK46
         AVTbNP0ummZUfg8olJaNY28IZzs1oDEwDbbNFcFS6Qt4+vmlmfFXOEiiB45TqinlYihF
         1sgo/X8It1OREo9KD000bkEOZkD6FemblnyUwEf+NSaFPwpAy8pblpIH77NpEp6qfNti
         2r41cODj75jSq3SdtrHf4PpxSBTm8qY+dflhsUzIYl70+wFyKF5QARDp+1BhR/4SBiap
         ULqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xLbu07FbZMOUGLOKpbGSEAHgMuRzWgnJgVeR/okx9Mc=;
        b=Mp6L+FfWRxxJE0d8Su6FTnbH1uW7eUhV8QuMuguUmlNRUA+bpXxHpKEUNMEvVhFbMl
         hEpnMXzGsjhu99xvsjbV+yljwd2QJSAumYYjZMZRXtCmb0DU2oYSFJjwJitciLbv96k1
         oRxjeY+1o0CY9e/uUFSdhq7ag/rtl4kx4Tm8HksUs7h2f8I1YJhhbUi12sXdddqwU2dg
         b8lPQ844Gd9MCg57pxW7lYIG12zAy8FFUn5rk3be3/XoMF4Aop4MH4pJK/Sqs5LlnO35
         00+Am+wYFo6c4ipbu3IJ4Cq8d26ejNLe5UtXk4dVmQSbY053JIHzSHLkUCRLzasDMRPA
         9Tkw==
X-Gm-Message-State: APjAAAUeOzZVXeAqrLrKole3h2MTk1m6B0Kb6gAVPizgAYk9LVS+z4zA
        DffU05g+z+fbmPcd/TOGoHb+LQ==
X-Google-Smtp-Source: APXvYqyj/4oJ7UHf4MCXDb1qZZMhTQN5/EWewkQNrQNZz5L8TBa+u084ciFzmOKD4pyXqAJgL1nLOw==
X-Received: by 2002:ac2:5c4b:: with SMTP id s11mr15044950lfp.37.1570986386652;
        Sun, 13 Oct 2019 10:06:26 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:4851:f638:84a8:96d0:2933:dfbf? ([2a00:1fa0:4851:f638:84a8:96d0:2933:dfbf])
        by smtp.gmail.com with ESMTPSA id k23sm3568595ljc.13.2019.10.13.10.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Oct 2019 10:06:25 -0700 (PDT)
Subject: Re: [PATCH v5 bpf-next 09/15] samples/bpf: use own flags but not
 HOSTCFLAGS
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com, ilias.apalodimas@linaro.org
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
 <20191011002808.28206-10-ivan.khoronzhuk@linaro.org>
 <99f76e2f-ed76-77e0-a470-36ae07567111@cogentembedded.com>
 <20191011095715.GB3689@khorivan>
 <3fb88a06-5253-1e48-9bea-2d31a443250b@cogentembedded.com>
 <20191012212643.GC3689@khorivan>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <03db016e-5337-0207-3d17-0b3bbe79fa5c@cogentembedded.com>
Date:   Sun, 13 Oct 2019 20:06:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191012212643.GC3689@khorivan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.10.2019 0:26, Ivan Khoronzhuk wrote:

>>>>> While compiling natively, the host's cflags and ldflags are equal to
>>>>> ones used from HOSTCFLAGS and HOSTLDFLAGS. When cross compiling it
>>>>> should have own, used for target arch. While verification, for arm,
>>>>
>>>>   While verifying.
>>> While verification stage.
>>
>>   While *in* verification stage, "while" doesn't combine with nouns w/o
>> a preposition.
> 
> 
> Sergei, better add me in cc list when msg is to me I can miss it.

    Hm, the earlier mails were addressed to you but no the last one --
not sure what happened there, sorry.

> Regarding the language lesson, thanks, I will keep it in mind next
> time, but the issue is not rude, if it's an issue at all, so I better
> leave it as is, as not reasons to correct it w/o code changes and
> everyone is able to understand it.

    Up to you. and the maintainer(s)...

>>>>> arm64 and x86_64 the following flags were used always:
>>>>>
>>>>> -Wall -O2
>>>>> -fomit-frame-pointer
>>>>> -Wmissing-prototypes
>>>>> -Wstrict-prototypes
>>>>>
>>>>> So, add them as they were verified and used before adding
>>>>> Makefile.target and lets omit "-fomit-frame-pointer" as were proposed
>>>>> while review, as no sense in such optimization for samples.
>>>>>
>>>>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>>>> [...]

MBR, Sergei
