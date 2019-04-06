Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA36C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 19:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83997213A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 19:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5jcKS2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfDFTsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 15:48:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33174 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfDFTsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 15:48:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so11827042wrp.0;
        Sat, 06 Apr 2019 12:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x8lMqENYrJ4vm1/Mum3IAFiymhyS6XWsQD5WiguLpDg=;
        b=g5jcKS2BlUf6aJfJQfhwZOIklbVCxDBT/1whYX8cP5TBj1i86JvEB9YzUwZssr3/UH
         JlfGvRJ62V1ZcxSuN9C2TBaJ9T1+7r/idRUgfg6gBZuKZXLDpa3G8pcmdnNDRLZy0Eqc
         LJrWY/EUKlkCSe5IBEzzF88DD59rTfZOC7YKhI+W5Vg2b71Y+gr6siSneJ2PR4KpWq6x
         +iqrKvFTiULhJPaXFJ7B5qrHbvLGgwIuRfXSemau8TsL5FBiTbsYGbD5i8eVfkf7qG2x
         k7ISdnscuqYZzNTK4V8XFcCXNjhI/5kDglpShgXTCCmM3KLvfmzQ0NkHn7EXB9fZzhQd
         p+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x8lMqENYrJ4vm1/Mum3IAFiymhyS6XWsQD5WiguLpDg=;
        b=i3AbffF/IWfV81Ixb299CQ2imDcHrLMmHelriCoQbnmNFmbkEFQhrBoRp1v95JIlso
         SVPUXw+AwlSbAnyuLEXdIzDm034QEzq/qwhBYm3Ms9cnhm9n+yYy5XK6C2+kMop3wCIw
         WqU47lVTxUlt9C0+HovTEsvKfhdcNquAiG4lUPTVLImi+xhDN4ZODopC72tZbzCHKcH0
         R9dURkWTwCzfm2ZdrU/a2RGgVmaqScbU+/3VBW74cPoP5UKpVAPTtrRAgfq49IJCciom
         bfZY8rdGdrzKFn4O0gTiZ5IYsv2Nx68SkiBIYtYFeZBkHqhaMO/JnD8ju3Zh1s4SuXZ3
         kA4g==
X-Gm-Message-State: APjAAAUK6zLfRxVunNM0KqHXqdtHLOzM08LOuJgAO9nSUUMzCU+BHTYT
        cRXy8v4HqYaQ5MICixtALA==
X-Google-Smtp-Source: APXvYqzm5iBmoJ4nNjcsUaL0oC8YT6X3cb6RNR3a6NCcoqj0kczYo4itmq8Qt8yLyV6/m5d+wP16NQ==
X-Received: by 2002:adf:f3ce:: with SMTP id g14mr12653957wrp.129.1554580108223;
        Sat, 06 Apr 2019 12:48:28 -0700 (PDT)
Received: from avx2 ([46.53.240.21])
        by smtp.gmail.com with ESMTPSA id t17sm19402587wrr.26.2019.04.06.12.48.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 12:48:27 -0700 (PDT)
Date:   Sat, 6 Apr 2019 22:48:25 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH] sched/core: expand sched_getaffinity(2) to return number
 of CPUs
Message-ID: <20190406194825.GA5106@avx2>
References: <20190403200809.GA13876@avx2>
 <20190404084249.GS4038@hirez.programming.kicks-ass.net>
 <87wok83gfs.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wok83gfs.fsf@oldenburg2.str.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 12:16:39PM +0200, Florian Weimer wrote:
> * Peter Zijlstra:
> 
> > On Wed, Apr 03, 2019 at 11:08:09PM +0300, Alexey Dobriyan wrote:
> >> Currently there is no easy way to get the number of CPUs on the system.
> 
> The size of the affinity mask is only related to the number of CPUs in
> the system in such a way that the number of CPUs cannot be larger than
> the number of bits in the affinity mask.
> 
> >> Glibc in particular shipped with 1024 CPUs support maximum at some point
> >> which is quite surprising as glibc maitainers should know better.
> 
> This dates back to a time when the kernel was never going to support
> more than 1024 CPUs.
> 
> A lot of distribution kernels still enforce a hard limit, which papers
> over firmware bugs which tell the kernel that the system can be
> hot-plugged to a ridiculous number of sockets/CPUs.
> 
> >> Another group dynamically grow buffer until cpumask fits. This is
> >> inefficient as multiple system calls are done.
> >> 
> >> Nobody seems to parse "/sys/devices/system/cpu/possible".
> >> Even if someone does, parsing sysfs is much slower than necessary.
> >
> > True; but I suppose glibc already does lots of that anyway, right? It
> > does contain the right information.
> 
> If I recall correctly my last investigation,
> /sys/devices/system/cpu/possible does not reflect the size of the
> affinity mask, either.
> 
> >> Patch overloads sched_getaffinity(len=0) to simply return "nr_cpu_ids".
> >> This will make gettting CPU mask require at most 2 system calls
> >> and will eliminate unnecessary code.
> >> 
> >> len=0 is chosen so that
> >> * passing zeroes is the simplest thing
> >> 
> >> 	syscall(__NR_sched_getaffinity, 0, 0, NULL)
> >> 
> >>   will simply do the right thing,
> >> 
> >> * old kernels returned -EINVAL unconditionally.
> >> 
> >> Note: glibc segfaults upon exiting from system call because it tries to
> >> clear the rest of the buffer if return value is positive, so
> >> applications will have to use syscall(3).
> >> Good news is that it proves noone uses sched_getaffinity(pid, 0, NULL).
> 
> Given that old kernels fail with EINVAL, that evidence is fairly
> restricted.
> 
> I'm not sure if it's a good idea to overload this interface.  I expect
> that users will want to call sched_getaffinity (the system call wrapper)
> with cpusetsize == 0 to query the value, so there will be pressure on
> glibc to remove the memset.  At that point we have an API that obscurely
> fails with old glibc versions, but suceeds with newer ones, which isn't
> great.

I can do "if (len == 536870912)" so that bit count overflows on old
kernels into EINVAL and is unlikely to be used ever.
