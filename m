Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C151C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A6B2173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNztOClg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfHZWlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 18:41:42 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37999 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfHZWlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 18:41:42 -0400
Received: by mail-qt1-f194.google.com with SMTP id q64so7898521qtd.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 15:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sG4TIFhm02SXCt/mIzw0vmCFG0zhNUfYTc9SGIQEZRc=;
        b=oNztOClgv1LhfUPcvDFL5VDYbHaB2dc6TDeJOBYlZxIGAppfW5p6453WjD8tm1njuH
         yF8AFMdrDQFKn+3AJaHqBDA9wGEb23VrNMyF/Nl5sw+7O8s0w6zILB4eBplFBbuWgaLy
         VkjPqfU531IH2r7cV/rFLqxotAS1aUPPNnsSlsmAIiUTqXWMoWt/473aQg/zWj7Fzjm9
         DOT9ojrDTiSga4WFY2pNm+JHkBI639fP86tPCFidMU80fvVB5iZPKGQyzvSFYODHQTCo
         3yMpKTFWRk4EWWbCNC0nQuksorfTlISbq+LWMcVGh4UiyPfSMd5Xgbv086eh5ngresAJ
         56JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sG4TIFhm02SXCt/mIzw0vmCFG0zhNUfYTc9SGIQEZRc=;
        b=El2Uqc4E6r8AodIdarfs4vaqa220BoRUlsdDJriAUS3+OK90oqHN8gtHDnleTJ+Dso
         zhac0MJhpw6qcODuUBToCJ+wX8l0PEQNu4IpXJZ3LWHelglN3jLWG8JMJZefTv70qe9F
         kOR6U8j7kDP7d0YER9gmRHg0vizcCAORIQBdGNk8ukwDm+cVD+uTpWRuohVcIRvP7VCW
         BAMIGqzYsel6pW+AHh37IW9eX0DBa1nfsh1ARfPtVoFoO36PcoNoxvpEUfR3EgM2ouNH
         7QJTAn7AMfzh1H9ASo/p5mTgnXNeAzFQf9ywphii12ckbHQqfmzvN4rGYrWhUEdNSzZB
         AghQ==
X-Gm-Message-State: APjAAAUYkCqidsrNqOJUoOhXk85Hokhe4oItFTYSXPHKyAclDZPekzzl
        d38C0WFJDTUwq/ZowEuwlVZkaR9j
X-Google-Smtp-Source: APXvYqx6eTmuVnr3ki5RNJAdXa0WqohfFmmvcQVmKNVm0ivOQNBmN594ghwo6Rxi/RyFPrNLoF3noA==
X-Received: by 2002:a0c:8695:: with SMTP id 21mr18024783qvf.166.1566859300329;
        Mon, 26 Aug 2019 15:41:40 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id q25sm6692114qkm.30.2019.08.26.15.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 15:41:39 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 095F840916; Mon, 26 Aug 2019 19:41:37 -0300 (-03)
Date:   Mon, 26 Aug 2019 19:41:36 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 00/12] libperf: Add events to perf/event.h
Message-ID: <20190826224136.GD21761@kernel.org>
References: <20190825181752.722-1-jolsa@kernel.org>
 <20190826160627.GE24801@kernel.org>
 <20190826161849.GF24801@kernel.org>
 <20190826165852.GC8926@krava>
 <20190826221419.GC21761@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826221419.GC21761@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 26, 2019 at 07:14:19PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Aug 26, 2019 at 06:58:52PM +0200, Jiri Olsa escreveu:
> > On Mon, Aug 26, 2019 at 01:18:49PM -0300, Arnaldo Carvalho de Melo wrote:
> > 
> > SNIP
> > 
> > > [perfbuilder@490c2c7bdaab ~]$ grep 'printf("lost' /tmp/build/perf/builtin-sched.i
> > >  printf("lost %" "l" "ll""u" " events on cpu %d\n", event->lost.lost, sample->cpu);
> > > [perfbuilder@490c2c7bdaab ~]$
> > > 
> > > And if we do this on a fedora:30 x86_64:
> > > 
> > > $ make -C tools/perf O=/tmp/build/perf /tmp/build/perf/builtin-sched.i
> > > [acme@quaco perf]$ grep -A4 'printf("lost' /tmp/build/perf/builtin-sched.i
> > >  printf("lost %" "l" 
> > > # 2646 "builtin-sched.c" 3 4
> > >                 "l" "u" 
> > > # 2646 "builtin-sched.c"
> > >                          " events on cpu %d\n", event->lost.lost, sample->cpu);
> > > [acme@quaco perf]$
> > > 
> > > I.e. on 32-bit arches we shouldn't add that extra "l", right?
> > 
> > hum, I guess we could #ifdef it 64/32 bits
> 
> I tried to figure out how to fix this better, but the int-ll64.h versus
> int-l64.h versus how __u64 is defined got me confused and I ended up
> with:
> 
> #if __WORDSIZE == 64

Make that:

#ifdef __LP64__ to build on Alpine/musl libc.

- Arnaldo

> /*
>  * /usr/include/inttypes.h uses just 'lu' for PRIu64, but we end up defining
>  * __u64 as long long unsigned int, and then -Werror=format= kicks in and
>  * complains of the mismatched types, so use these two special extra PRI
>  * macros to overcome that.
>  */
> #define PRI_lu64 "l" PRIu64
> #define PRI_lx64 "l" PRIx64
> #else
> #define PRI_lu64 PRIu64
> #define PRI_lx64 PRIx64
> #endif
> 
> Builds in all the containers I have, 32-bit, 64-bit, old gccs/clangs,
> new ones, uclibc, musl libc, glibc, etc
>  
> > > 
> > > I bet the build for the mips/mipsel will fail too, lemme see... Yeah,
> > > both failed:
> > > 
> > > 
> >> [root@quaco ~]# grep -m1 -A6 -- -Werror=format=  dm.log/debian\:experimental-x-mips
> > > builtin-sched.c:2646:9: error: unknown conversion type character 'l' in format [-Werror=format=]
> > >   printf("lost %" PRI_lu64 " events on cpu %d\n", event->lost.lost, sample->cpu);
> > >          ^~~~~~~~
> > > In file included from builtin-sched.c:31:
> > > /usr/mips-linux-gnu/include/inttypes.h:47:28: note: format string is defined here
> > >  #  define __PRI64_PREFIX "ll"
> > >                             ^
> > > [root@quaco ~]#
> > > 
> > > [root@quaco ~]# grep -m1 -A6 -- -Werror=format=  dm.log/debian\:experimental-x-mipsel
> > > builtin-sched.c:2646:9: error: unknown conversion type character 'l' in format [-Werror=format=]
> > >   printf("lost %" PRI_lu64 " events on cpu %d\n", event->lost.lost, sample->cpu);
> > >          ^~~~~~~~
> > > In file included from builtin-sched.c:31:
> > > /usr/mipsel-linux-gnu/include/inttypes.h:47:28: note: format string is defined here
> > >  #  define __PRI64_PREFIX "ll"
> > >                             ^
> > > [root@quaco ~]#
> > > 
> > > And also on a uclibc ARC arch container:
> > > 
> > > [root@quaco ~]# grep -m1 -A6 -- -Werror=format=  dm.log/fedora\:24-x-ARC-uClibc
> > > builtin-sched.c:2646:9: error: unknown conversion type character 'l' in format [-Werror=format=]
> > >   printf("lost %" PRI_lu64 " events on cpu %d\n", event->lost.lost, sample->cpu);
> > >          ^~~~~~~~
> > > In file included from builtin-sched.c:31:0:
> > > /arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install/arc-snps-linux-uclibc/sysroot/usr/include/inttypes.h:47:28: note: format string is defined here
> > >  #  define __PRI64_PREFIX "ll"
> > >                             ^
> > > [root@quaco ~]#
> > > 
> > > The _fix_ will come after lunch :)
> > 
> > thanks ;-)
> > 
> > jirka
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
