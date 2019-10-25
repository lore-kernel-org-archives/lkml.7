Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58957CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFD920684
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGwv2Rk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436889AbfJYO2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:28:38 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41248 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730064AbfJYO2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:28:37 -0400
Received: by mail-qk1-f195.google.com with SMTP id p10so1917929qkg.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 07:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XdYJcYMzVhQgoFmob+oynB67MiEVSjs4OZR3a6ZTGLY=;
        b=YGwv2Rk5+KotYS/VCzmFtyamoqtqiGyCDe/FQfko1jffk1zDfQS49YVUM//q5jr/lI
         OnoWikuXiUAPvGp0XL5l8xYN83UZp607lHFfOusvCV7nO7t1MMEb3LbxUV0HNlUk021H
         TtNmcx3Kicb4hHiD2tjLOMsbh9GlR78kRygmcsRgcTIPztXUtoqhs9KrIpKEszrfJHCs
         oU6XnvJqLiUpe+48Zs9PdiDK9KGDk6AAT0Zb+PZE1H5Dp5g54rOKBkXF0JX63XmSznLA
         8dNKyziNDarAKClOYgeVaab/VtLBWsgUU3H5PCnGF6HtljBNUtQICIx095g2BZOMZWw/
         kXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XdYJcYMzVhQgoFmob+oynB67MiEVSjs4OZR3a6ZTGLY=;
        b=rGNzD0rgb5fozQn/kVc+B3S/q7FUudUUZp6eg9lIN/C1N02MieDzAXLVKUULLjaJH8
         gujSQJW3v18Qnk+6AmptZ7yFlc7JfwYN0hEmDdyasU2uP59rxa6IoZrbXFSrSirkGnzl
         pP74hEsf4rPAcUaSK6supsuf283jmqQ3J8E4T+PlP6KurgQ+W7S9n5XE5wr3w9cCOiyp
         sEvxhZKenFI5AuaXUrvIQ4k41/nOBfo44ltM0Tr64+xNMrrYGiZiSsG7tJNYMeSY2VyY
         8I0sv7fFL3AqL+iUdu/uJYDAAzo6DLzBQsMLyk1CTAQNTl8URNb3tIWihWZgirsaZC+M
         n1og==
X-Gm-Message-State: APjAAAUGPjuufSG1rQlsskTvH9IEcWjFByFIq3roBODBggzXYLUw2BaL
        Atq9d8nztDwDRai9L2wla8j6q0KN
X-Google-Smtp-Source: APXvYqxms4d03xqmmuuy0/+2YbNpwgLjlKuvKLJr8gZfMliDEvRV0NhxVceZwsO+mMTKPitNS9DWBw==
X-Received: by 2002:ae9:f707:: with SMTP id s7mr3307181qkg.82.1572013716173;
        Fri, 25 Oct 2019 07:28:36 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id m25sm1683727qtc.0.2019.10.25.07.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 07:28:34 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7493941199; Fri, 25 Oct 2019 11:28:32 -0300 (-03)
Date:   Fri, 25 Oct 2019 11:28:32 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH 1/6] perf/probe: Fix wrong address verification
Message-ID: <20191025142832.GA15617@kernel.org>
References: <157199317547.8075.1010940983970397945.stgit@devnote2>
 <157199318513.8075.10463906803299647907.stgit@devnote2>
 <20191025121448.GC23511@kernel.org>
 <20191025213633.b1227d0721b97edc8e8f9335@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025213633.b1227d0721b97edc8e8f9335@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 25, 2019 at 09:36:33PM +0900, Masami Hiramatsu escreveu:
> Hi,
> 
> On Fri, 25 Oct 2019 09:14:48 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > Em Fri, Oct 25, 2019 at 05:46:25PM +0900, Masami Hiramatsu escreveu:
> > > Since there are some DIE which has only ranges instead of the
> > > combination of entrypc/highpc, address verification must use
> > > dwarf_haspc() instead of dwarf_entrypc/dwarf_highpc.
> > > 
> > > Also, the ranges only DIE will have a partial code in different
> > > section (e.g. unlikely code will be in text.unlikely as "FUNC.cold"
> > > symbol). In that case, we can not use dwarf_entrypc() or
> > > die_entrypc(), because the offset from original DIE can be
> > > a minus value.
> > > 
> > > Instead, this simply gets the symbol and offset from symtab.
> > > 
> > > Without this patch;
> > >   # tools/perf/perf probe -D clear_tasks_mm_cpumask:1
> > >   Failed to get entry address of clear_tasks_mm_cpumask
> > >     Error: Failed to add events.
> > > 
> > > And with this patch
> > >   # tools/perf/perf probe -D clear_tasks_mm_cpumask:1
> > >   p:probe/clear_tasks_mm_cpumask clear_tasks_mm_cpumask+0
> > >   p:probe/clear_tasks_mm_cpumask_1 clear_tasks_mm_cpumask+5
> > >   p:probe/clear_tasks_mm_cpumask_2 clear_tasks_mm_cpumask+8
> > >   p:probe/clear_tasks_mm_cpumask_3 clear_tasks_mm_cpumask+16
> > >   p:probe/clear_tasks_mm_cpumask_4 clear_tasks_mm_cpumask+82
> > 
> > Ok, so this just asks for the definition, but doesn't try to actually
> > _use_ it, which I did and it fails:
> > 
> > [root@quaco tracebuffer]# perf probe -D clear_tasks_mm_cpumask:1
> > p:probe/clear_tasks_mm_cpumask _text+919968
> > p:probe/clear_tasks_mm_cpumask_1 _text+919973
> > p:probe/clear_tasks_mm_cpumask_2 _text+919976
> > [root@quaco tracebuffer]#
> > [root@quaco tracebuffer]# perf probe clear_tasks_mm_cpumask
> > Probe point 'clear_tasks_mm_cpumask' not found.
> >   Error: Failed to add events.
> > [root@quaco tracebuffer]#
> > 
> > So I'll tentatively continue to apply the other patches in this series,
> > maybe one of them will fix this.
> 
> Yes, it should be fixed by [2/6] :)

Yeah, it is, works there, but unfortunately I couldn't see it in action
even having put it successfuly into place:

[root@quaco ~]# perf probe clear_tasks_mm_cpumask:0
Added new event:
  probe:clear_tasks_mm_cpumask (on clear_tasks_mm_cpumask)

You can now use it in all perf tools, such as:

	perf record -e probe:clear_tasks_mm_cpumask -aR sleep 1

[root@quaco ~]# perf trace -e probe:clear_tasks_mm_cpumask/max-stack=16/

Doesn't seem to be used in x86-64...

[acme@quaco perf]$ find . -name "*.c" | xargs grep clear_tasks_mm_cpumask
./kernel/cpu.c: * clear_tasks_mm_cpumask - Safely clear tasks' mm_cpumask for a CPU
./kernel/cpu.c:void clear_tasks_mm_cpumask(int cpu)
./arch/xtensa/kernel/smp.c:	clear_tasks_mm_cpumask(cpu);
./arch/csky/kernel/smp.c:	clear_tasks_mm_cpumask(cpu);
./arch/sh/kernel/smp.c:	clear_tasks_mm_cpumask(cpu);
./arch/arm/kernel/smp.c:	clear_tasks_mm_cpumask(cpu);
./arch/powerpc/mm/nohash/mmu_context.c:	clear_tasks_mm_cpumask(cpu);
[acme@quaco perf]$ find . -name "*.h" | xargs grep clear_tasks_mm_cpumask
./include/linux/cpu.h:void clear_tasks_mm_cpumask(int cpu);
[acme@quaco perf]$

:-)
 
> Actually, a probe point with offset line and no-offset are handled
> a bit differently.

What is the difference? Anyway, things seem to work as advertised, so
I'm happy ;-)

- Arnaldo
