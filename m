Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB30BC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB9E22CE3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKsStw5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbfHTP0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:26:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40476 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730023AbfHTP0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:26:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id w16so3590657pfn.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 08:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=isVxC+LqE13didJdqthpVRTTgRW7g4nRsrXi7yOH4Pk=;
        b=cKsStw5Xd2pIv4RcrR/6UC56gZWS3ZDioBMmOhAppzgwfdGqEeYlofGZqivtLH6ViU
         V1cXapEaw+qBoF54hRMO5HhvzvODvh2SO/JTbOeq9qIzGvi4eJQ7V7yrRJoJ7BhVe3+0
         rXQKaU5pQ6WUqApPcCzM4E+n8FcQO6wgt9NaXP01Xejl1Lr+7LvXWYrn9NLTl5yC5jyh
         4ULhYHDFYFZea+fEmOm+BfFj4/BgDNkc6vWLcoGQ/C5E/Gcj7mCtlgsDu1bZBYrqN5yY
         AJVPHZpENhKHOTE3cIPWNLKLJECpZkIUyDaqu7N02iPGdEO8ttd54XiA/z27Kh0ZHOuF
         NlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=isVxC+LqE13didJdqthpVRTTgRW7g4nRsrXi7yOH4Pk=;
        b=Qoeo5FS1lt96ZMH1MtZYCd0KGyl1Ql8DYZF2x0g2AjbkQQ4g2Ba74zuHlKlqt7YKs8
         lqAIKM5RVFzyBzpL9xMeEnNM4HG1VAvyfcDPG22Eby2pa36TAsGiRbSo+nAP1/fB2SND
         16dndngSECnsZiY+RUC60vHK9pITJFlARLYQXt72/yMlxnlSwcQgqdoLIDAU179E3qyB
         mw/KVXH5OSGOihyteJvPj2CExlrbJoA/pvEZ7DtrfY1W1UKcEYs2GJrhWolYgrOyM1/v
         qEBVbnlgOgQiMqLeC99pA/eq6CjieYtBmUQQad9CNCihqkLAuVzoRVm5S+lU2hOO1sYS
         NwNA==
X-Gm-Message-State: APjAAAXL/OdY7y2E+oNJcc57rb55+GrLMmHwCtEUNDThrdS3BfAw93CM
        /1bBQw9PwvGtjxKDk7MTXQg=
X-Google-Smtp-Source: APXvYqy6ul/Wi5Gn2+2W3whya9FdpyGGtyqDD0GT3VRIge56nEzTOFeiPBCfGW5faixwfukVWAZtng==
X-Received: by 2002:aa7:9254:: with SMTP id 20mr31677417pfp.212.1566314807634;
        Tue, 20 Aug 2019 08:26:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e185sm9246747pfa.119.2019.08.20.08.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:26:46 -0700 (PDT)
Subject: Re: [PATCH] libperf: Fix arch include paths
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
References: <20190721112506.12306-1-jolsa@kernel.org>
 <20190721112506.12306-29-jolsa@kernel.org>
 <20190818140436.GA21854@roeck-us.net> <20190818194032.GA10666@krava>
 <20190818212816.GA23921@roeck-us.net> <20190819082137.GA9637@krava>
 <20190820124624.GG24105@krava>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8e018cb7-db37-45cc-832a-1f3b499895fb@roeck-us.net>
Date:   Tue, 20 Aug 2019 08:26:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820124624.GG24105@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/19 5:46 AM, Jiri Olsa wrote:
> On Mon, Aug 19, 2019 at 10:21:37AM +0200, Jiri Olsa wrote:
> 
> SNIP
> 
>>> next-20190816, though the problem has been seen since at least
>>> next-20190801. Mainline builds fine.
>>>
>>> Here is the script I used to bisect the problem:
>>>
>>> make mrproper
>>> rm -rf /tmp/linux
>>> mkdir /tmp/linux
>>> make ARCH=x86_64 O=/tmp/linux defconfig
>>> make -j40 ARCH=x86_64 O=/tmp/linux tools/perf
>>>
>>> It looks like the problem is related to "ARCH=x86_64". In mainline,
>>> x86_64 is replaced in the build command with x86. This is no longer
>>> the case, and make now tries to include from tools/arch/x86_64/include/,
>>> which doesn't exist. As it turns out, O=<destdir> is not needed to
>>> reproduce the problem, only ARCH=x86_64 (or ARCH=i386).
>>
>> aaargh.. you're right ;-) it's the SRCARCH, which should
>> be used in libperf instead of ARCH
>>
>> change below fixes that for me
> 
> attaching the full patch
> 
> jirka
> 
> 
> ---
> Guenter Roeck reported problem with compilation
> when the ARCH is specified:
> 
>    $ make ARCH=x86_64
>    In file included from tools/include/asm/atomic.h:6:0,
>                     from include/linux/atomic.h:5,
>                     from tools/include/linux/refcount.h:41,
>                     from cpumap.c:4: tools/include/asm/../../arch/x86/include/asm/atomic.h:11:10:
>    fatal error: asm/cmpxchg.h: No such file or directory
> 
> The problem is that we don't use SRCARCH (the sanitized ARCH
> version) and we don't get the proper include path.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Link: http://lkml.kernel.org/n/tip-408wq8mtajlvs9iir7qo9c84@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   tools/perf/lib/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
> index 8a9ae50818e4..a67efb8d9d39 100644
> --- a/tools/perf/lib/Makefile
> +++ b/tools/perf/lib/Makefile
> @@ -59,7 +59,7 @@ else
>     CFLAGS := -g -Wall
>   endif
>   
> -INCLUDES = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(ARCH)/include/ -I$(srctree)/tools/arch/$(ARCH)/include/uapi -I$(srctree)/tools/include/uapi
> +INCLUDES = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/ -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
>   
>   # Append required CFLAGS
>   override CFLAGS += $(EXTRA_WARNINGS)
> 

