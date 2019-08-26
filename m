Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFCEC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E74206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMuVd3XU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfHZWOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 18:14:24 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45769 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfHZWOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 18:14:24 -0400
Received: by mail-qk1-f193.google.com with SMTP id m2so15407455qki.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 15:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IY+6z63cE2IP5vrlfB5gE/ArU++KdvKsnYZ7o5PvLdc=;
        b=YMuVd3XUqqLqsbx4Ax2WGBSeXbRSjLKnWBNJPU11ms32wtNLd/7lGEukmL4H7hstA8
         X0F4jqgqqNd5smQd0LZsNmnraqhO7uzOpwxE+xa3sOr+MxlAWNYzq5sim5b+Lf2J/0lW
         bjjV9q6xZ3OEdNacPLxZ7WAfAdOsUhkZ/BErYuRjqF7oLKulSM9a6TzytYPhkCmtu39U
         KhArdGSEbXQyjkI+5p/xmb62KXhVFleFFkmS1ixRQCriluusH8xO55mIUC6n4dP79NKa
         mCW5VcbUtKuyIhbQM0ebrwsNIHqmY46SngWBJGgkL0Z0q5MZsPqYmvO62TxxHJSz0hkM
         o9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IY+6z63cE2IP5vrlfB5gE/ArU++KdvKsnYZ7o5PvLdc=;
        b=sL1wGV1N8IApI5rHYcmxSIh/z+txvn2pi/MA1pde0w4Ozetcu4kAqLi4QODDnXqowd
         yzHe9HkFLcTFgENW9smNaIJ7rJ+cbO6kMJsDDGmD77JbztKRdd/IKx4WIOD8Z0SdqXXD
         EniXn6oe2nlvuAOOJ750DDjSTyoov5gGQD/G0VFljNzNwVYnW4VN5r/69GjPkxSYB9L3
         BC73mWrl6II1DS3HQ5Jgyr2MzTdJ9BAvu+DlDk/WdNs3nO0/7phRNQtwT2LXnA3Iy3Kh
         olddPmUEPU0ZXCnmmQ3zqA2uQnM52y/o7qSKiY69WHewsP+BlnLWpuTJCBWCG9SPGasl
         CD3w==
X-Gm-Message-State: APjAAAXXaZt7I+DVkBDsz0hZFyMSLmD95iSg5/n2IWVrLRaD2MrdK+5M
        Dq0Ocoyu6Pp/FXPQpbrsnqA=
X-Google-Smtp-Source: APXvYqwpiAtrVMqSt/yaLqpFx1aqiDvA7Gnlg3/u11HKiwK9c3iTrw2aDhSygea7rcN9R7Q02116jA==
X-Received: by 2002:a37:ef0c:: with SMTP id j12mr17396718qkk.345.1566857662971;
        Mon, 26 Aug 2019 15:14:22 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id s4sm7121062qkb.130.2019.08.26.15.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 15:14:22 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D9DBE40916; Mon, 26 Aug 2019 19:14:19 -0300 (-03)
Date:   Mon, 26 Aug 2019 19:14:19 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 00/12] libperf: Add events to perf/event.h
Message-ID: <20190826221419.GC21761@kernel.org>
References: <20190825181752.722-1-jolsa@kernel.org>
 <20190826160627.GE24801@kernel.org>
 <20190826161849.GF24801@kernel.org>
 <20190826165852.GC8926@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826165852.GC8926@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 26, 2019 at 06:58:52PM +0200, Jiri Olsa escreveu:
> On Mon, Aug 26, 2019 at 01:18:49PM -0300, Arnaldo Carvalho de Melo wrote:
> 
> SNIP
> 
> > [perfbuilder@490c2c7bdaab ~]$ grep 'printf("lost' /tmp/build/perf/builtin-sched.i
> >  printf("lost %" "l" "ll""u" " events on cpu %d\n", event->lost.lost, sample->cpu);
> > [perfbuilder@490c2c7bdaab ~]$
> > 
> > And if we do this on a fedora:30 x86_64:
> > 
> > $ make -C tools/perf O=/tmp/build/perf /tmp/build/perf/builtin-sched.i
> > [acme@quaco perf]$ grep -A4 'printf("lost' /tmp/build/perf/builtin-sched.i
> >  printf("lost %" "l" 
> > # 2646 "builtin-sched.c" 3 4
> >                 "l" "u" 
> > # 2646 "builtin-sched.c"
> >                          " events on cpu %d\n", event->lost.lost, sample->cpu);
> > [acme@quaco perf]$
> > 
> > I.e. on 32-bit arches we shouldn't add that extra "l", right?
> 
> hum, I guess we could #ifdef it 64/32 bits

I tried to figure out how to fix this better, but the int-ll64.h versus
int-l64.h versus how __u64 is defined got me confused and I ended up
with:

#if __WORDSIZE == 64
/*
 * /usr/include/inttypes.h uses just 'lu' for PRIu64, but we end up defining
 * __u64 as long long unsigned int, and then -Werror=format= kicks in and
 * complains of the mismatched types, so use these two special extra PRI
 * macros to overcome that.
 */
#define PRI_lu64 "l" PRIu64
#define PRI_lx64 "l" PRIx64
#else
#define PRI_lu64 PRIu64
#define PRI_lx64 PRIx64
#endif

Builds in all the containers I have, 32-bit, 64-bit, old gccs/clangs,
new ones, uclibc, musl libc, glibc, etc
 
> > 
> > I bet the build for the mips/mipsel will fail too, lemme see... Yeah,
> > both failed:
> > 
> > 
>> [root@quaco ~]# grep -m1 -A6 -- -Werror=format=  dm.log/debian\:experimental-x-mips
> > builtin-sched.c:2646:9: error: unknown conversion type character 'l' in format [-Werror=format=]
> >   printf("lost %" PRI_lu64 " events on cpu %d\n", event->lost.lost, sample->cpu);
> >          ^~~~~~~~
> > In file included from builtin-sched.c:31:
> > /usr/mips-linux-gnu/include/inttypes.h:47:28: note: format string is defined here
> >  #  define __PRI64_PREFIX "ll"
> >                             ^
> > [root@quaco ~]#
> > 
> > [root@quaco ~]# grep -m1 -A6 -- -Werror=format=  dm.log/debian\:experimental-x-mipsel
> > builtin-sched.c:2646:9: error: unknown conversion type character 'l' in format [-Werror=format=]
> >   printf("lost %" PRI_lu64 " events on cpu %d\n", event->lost.lost, sample->cpu);
> >          ^~~~~~~~
> > In file included from builtin-sched.c:31:
> > /usr/mipsel-linux-gnu/include/inttypes.h:47:28: note: format string is defined here
> >  #  define __PRI64_PREFIX "ll"
> >                             ^
> > [root@quaco ~]#
> > 
> > And also on a uclibc ARC arch container:
> > 
> > [root@quaco ~]# grep -m1 -A6 -- -Werror=format=  dm.log/fedora\:24-x-ARC-uClibc
> > builtin-sched.c:2646:9: error: unknown conversion type character 'l' in format [-Werror=format=]
> >   printf("lost %" PRI_lu64 " events on cpu %d\n", event->lost.lost, sample->cpu);
> >          ^~~~~~~~
> > In file included from builtin-sched.c:31:0:
> > /arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install/arc-snps-linux-uclibc/sysroot/usr/include/inttypes.h:47:28: note: format string is defined here
> >  #  define __PRI64_PREFIX "ll"
> >                             ^
> > [root@quaco ~]#
> > 
> > The _fix_ will come after lunch :)
> 
> thanks ;-)
> 
> jirka

-- 

- Arnaldo
