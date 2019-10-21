Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF045CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E13205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuVPuU0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfJUMUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:20:33 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46020 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbfJUMUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:20:33 -0400
Received: by mail-qt1-f196.google.com with SMTP id c21so20614505qtj.12;
        Mon, 21 Oct 2019 05:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EHQGi1rYFameRxiNvB1skGoZnnvzYmd+wh9UydY2+FU=;
        b=UuVPuU0YIJOdqQv/fZQ/a0xKNrGV83V+RWMrf7ZgRWWnGS5wDmcQxvjJDUT2vpkhXq
         QRonf5gCW2PxmqkQvwhnVVjLV1lOa5yS8GkWeeOpHEG0tWjf4ZpHXtJMdo3zo4iqT4U1
         stK6RZ7FF2K9o2/xYrLzmbI3iiE/PLAVA4MWNvknnxpCBiuFuPma09nQOQcdDlaJ/R/V
         YKW/ljNLbZqmMOuK1yLScpIOSItA5qFROyiMBoTHp9NHwMtVm23pZdxIXVSd91yM8MFO
         1oWcdMgs4q4ZVFYlBwCy+QVCFrX0q3+rGxilbwr3GUP0NzPajSgFim71bxyrOhx/zbsR
         tjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EHQGi1rYFameRxiNvB1skGoZnnvzYmd+wh9UydY2+FU=;
        b=sROLJis99vkxq6l0p0stJg8hdhbRCg+YJbnXEsgy8RaZbo1xk5xN3tfplR83BjWFzV
         Gsicnx8jXU8YoAoAG/JWAqnaYUd1tjpoVbLlYdOfI1bycMT/LjQeP7oV6U1e1Xgl4CLZ
         /35AsWB3hchAyVGffLkvGPOl2S/esokDKtZwTp6vEcS2x5gLi1c0vBKBPv/vFTU1NfI4
         yAbYqUb3+ozTtni4TgI5XcCH5OC8Rah2xhpCIkQ2C3h9BtKLiz9XKqC4O43CjqSqv4ca
         gxMNOiDYIkuCN/5ysRQXDpE0dtQCOieXIlaqbRhmepa7GL3FPpKAdu1vs4CjoyRtDUV5
         /KyA==
X-Gm-Message-State: APjAAAW/pF6NZswPTk+aRPvwaaTRaaB0k59tIK0x94PG/miCTbENHeC3
        /ayC3yuvyNsy4Ed3GFMugVQ=
X-Google-Smtp-Source: APXvYqyECqv25JdzLY8N6OSAKUE63NeQYpcq/hMFePuEAEsG71GeKG4sro4mazxE6XoE1Lt7sIzTyg==
X-Received: by 2002:ad4:4c0b:: with SMTP id bz11mr13247592qvb.102.1571660431576;
        Mon, 21 Oct 2019 05:20:31 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id b4sm2003132qtt.26.2019.10.21.05.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 05:20:30 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7191A4035B; Mon, 21 Oct 2019 09:20:28 -0300 (-03)
Date:   Mon, 21 Oct 2019 09:20:28 -0300
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/urgent fixes
Message-ID: <20191021122028.GA10134@kernel.org>
References: <20191017160301.20888-1-acme@kernel.org>
 <20191021062354.GA22042@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021062354.GA22042@gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 21, 2019 at 08:23:54AM +0200, Ingo Molnar escreveu:
> * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 	Please consider pulling,

<SNIP>

> >  tools/perf/util/header.c              |  4 +++-
> >  tools/perf/util/util.c                |  6 ++++--
> >  12 files changed, 65 insertions(+), 17 deletions(-)
 
> Pulled, thanks a lot Arnaldo!

Thanks!
 
> A minor bugreport:
 
> There's a new nuisance message that I noticed when 'perf top' is started: 
> a "vmlinux file has not been found" - with a "press any key" - but the 
> message doesn't actually wait for the keypress, it's cleared on the first 
> screen refresh...

I'll investigate the problems reported after pushing out the current
perf/core lot, thanks for the detailed report!

- Arnaldo
 
> I'd argue that both the keypress action and the warning message is 
> superfluous:
> 
>  - It annoys users while not actually giving any straightforward way to 
>    fix it. It's displayed on every startup of perf top, which is highly 
>    distracting.
> 
>  - At least on Ubuntu it appears to be wrong, because the vmlinux is 
>    available and symbol resolution/annotation appears to be working fine:
> 
> 	# uname -a
> 	Linux dagon 5.4.0-rc3-custom-00557-gb6c81ae120e0 #1 SMP PREEMPT Sun Oct 20 15:28:00 CEST 2019 x86_64 x86_64 x86_64 GNU/Linux
> 
> 	# dpkg -l | grep gb6c81ae120e
> 	ii  linux-headers-5.4.0-rc3-custom-00557-gb6c81ae120e0   5.4.0-rc3-custom-00557-gb6c81ae120e0-1                     amd64        Linux kernel headers for 5.4.0-rc3-custom-00557-gb6c81ae120e0 on amd64
> 	ii  linux-image-5.4.0-rc3-custom-00557-gb6c81ae120e0     5.4.0-rc3-custom-00557-gb6c81ae120e0-1                     amd64        Linux kernel, version 5.4.0-rc3-custom-00557-gb6c81ae120e0
> 	ii  linux-image-5.4.0-rc3-custom-00557-gb6c81ae120e0-dbg 5.4.0-rc3-custom-00557-gb6c81ae120e0-1                     amd64        Linux kernel debugging symbols for 5.4.0-rc3-custom-00557-gb6c81ae120e0
> 	ii  linux-libc-dev:amd64                                 5.4.0-rc3-custom-00557-gb6c81ae120e0-1                     amd64        Linux support headers for userspace development
> 
>    Note that the 'dbg' package is installed which includes the vmlinux, 
>    and perf does seem to find it:
> 
> 	# dpkg-query -L linux-image-5.4.0-rc3-custom-00557-gb6c81ae120e0-dbg | grep vmlinux$
> 	/usr/lib/debug/lib/modules/5.4.0-rc3-custom-00557-gb6c81ae120e0/vmlinux
> 
>    I can see annotated kernel functions just fine.
> 
>  - Finally, when I run perf as root then kallsyms and /proc/kcore is used 
>    to annotate the kernel. So the 'cannot resolve' message cannot even be 
>    true. :-)
> 
> Instead I believe some sort of explanation should be printed in the 
> natural flow when there's an unknown symbol or someone tries to enter a 
> kernel symbol that cannot be further resolved. Even there it probably 
> shouldn't be a 'warning' message, but something printed in-line where 
> usually we'd see the annotated output - to disrupt the normal workflow as 
> little as possible.
> 
> Secondly, there also appears to be a TUI weirdness when the annotated 
> kernel functions are small (or weird): the blue cursor is stuck at the 
> top and I cannot move between the annotated instructions with the down/up 
> arrow:
> 
> Samples: 13M of event 'cycles', 4000 Hz, Event count (approx.): 1272420588851
> clear_page_rep  /usr/lib/debug/boot/vmlinux-5.4.0-rc3-custom-00557-gb6c81ae120e0 [Percent: local period]
>   0.01 │     mov  $0x200,%ecx                                                                                                                                                                      ▒
>        │   xorl %eax,%eax                                                                                                                                                                          ▒
>   0.01 │     xor  %eax,%eax                                                                                                                                                                        ▒
>        │   rep stosq                                                                                                                                                                               ▒
>  99.27 │     rep  stos %rax,%es:(%rdi)                                                                                                                                                             ▒
>        │   ret                                                                                                                                                                                     ▒
>   0.71 │   ← retq                         
> 
> I can still exit the screen with 'q', and can move around in larger 
> annotated kernel functions. Not sure whether it's related to function 
> size, or perhaps to the 'hottest' instruction that the cursor is normally 
> placed at.
> 
> Thanks,
> 
> 	Ingo

-- 

- Arnaldo
