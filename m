Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB9CC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FF920718
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575325141;
	bh=qk64Kw3jdw6QWjjwhQTlGwK4tIQeofb9kXqsp+8kYXs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CX/WJPWQVe6OBmbDkdArG4mwegLtuhNR25NNNyCeAUHdk7mFK3IeaJET0xoNtooVA
	 RCx+aHdlx6OUrz9KpBF5HDkg+a772FRm6x5ldquoQEQZw+QKgFdj2zLbpPjfM0SbCQ
	 sOL5dbRj7bsc+HI+kMuh+Bq2eFyTwTpwiNlHU+hw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLBWTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 17:19:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:49224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfLBWTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 17:19:00 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6733B20718;
        Mon,  2 Dec 2019 22:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575325139;
        bh=qk64Kw3jdw6QWjjwhQTlGwK4tIQeofb9kXqsp+8kYXs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wlo2pn8F/AdzTPMFxPGcwhRny2DyGMVio6qQ5XkYkfT4BJm9JA5S1VcbH9xfz2zlB
         UZXJfdxOE73jGyXWlUielmBpwzNVdF2TOQhCTNL17SLdpsGrB8ROdEiL+m5wpRjIes
         9oVS1Y7LedQW2M6uAaHCyWsh0I05Jq7JD+o3QoJY=
Date:   Tue, 3 Dec 2019 07:18:54 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf probe -d failing to delete probes
Message-Id: <20191203071854.37e20e0455626f5c388b3cf3@kernel.org>
In-Reply-To: <20191202190452.GI4063@kernel.org>
References: <20191129151324.GA26963@kernel.org>
        <20191202185958.GH4063@kernel.org>
        <20191202190452.GI4063@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Mon, 2 Dec 2019 16:04:52 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Mon, Dec 02, 2019 at 03:59:58PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Nov 29, 2019 at 12:13:24PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > 
> > > Hi Masami,
> > > 
> > >    Can you please take a look at this?
> > > 
> > > [root@quaco perf]# perf probe -l
> > >   probe_perf:map__map_ip (on ui__warn_map_erange+222@perf/tools/perf/builtin-top.c in /home/acme/bin/perf)
> > >   probe_perf:map__map_ip (on ui__warn_map_erange+222@perf/tools/perf/builtin-top.c in /home/acme/bin/perf)
> > >   probe_perf:map__map_ip (on perf_evlist__set_paused+222@util/evlist.c in /home/acme/bin/perf)
> > >   probe_perf:map__map_ip (on perf_evlist__resume+222@util/evlist.c in /home/acme/bin/perf)
> > >   probe_perf:map__map_ip (on perf_evsel__group_desc+222@util/evsel.c in /home/acme/bin/perf)
> > >   probe_perf:map__map_ip (on svg_partial_wakeline+222@util/svghelper.c in /home/acme/bin/perf)
> > > [root@quaco perf]# perf probe -d probe_perf:map_*
> > > "probe_perf:map_*" does not hit any event.
> > >   Error: Failed to delete events.
> > > [root@quaco perf]# perf probe -d probe_perf:*
> > > "probe_perf:*" does not hit any event.
> > >   Error: Failed to delete events.
> > > [root@quaco perf]# perf probe -d probe*:*
> > > "probe*:*" does not hit any event.
> > >   Error: Failed to delete events.
> > > [root@quaco perf]# perf probe -d '*:*'
> > > "*:*" does not hit any event.
> > >   Error: Failed to delete events.
> > > [root@quaco perf]#
> > 
> > [root@quaco ~]# perf probe -l
> >   probe_perf:map__map_ip (on process_sample_event+6663@tools/perf/builtin-script.c in /home/acme/bin/perf)
> >   probe_perf:map__map_ip (on process_sample_event+6739@tools/perf/builtin-script.c in /home/acme/bin/perf)
> >   probe_perf:map__map_ip (on unwind_entry+436@util/machine.c in /home/acme/bin/perf)
> >   probe_perf:map__map_ip (on machine__process_extra_kernel_map+31@util/machine.c in /home/acme/bin/perf)
> >   probe_perf:map__map_ip (on __maps__insert+192@util/map.c in /home/acme/bin/perf)
> >   probe_perf:map__map_ip (on dso__process_kernel_symbol+336@util/symbol-elf.c in /home/acme/bin/perf)
> > [root@quaco ~]# ls -la /sys/kernel/debug/tracing/events/probe_perf/
> > total 0
> > drwxr-xr-x.   3 root root 0 Nov 29 12:09 .
> > drwxr-xr-x. 113 root root 0 Dec  2 15:56 ..
> > -rw-r--r--.   1 root root 0 Nov 29 12:09 enable
> > -rw-r--r--.   1 root root 0 Nov 29 12:09 filter
> > drwxr-xr-x.   2 root root 0 Nov 29 12:09 map__map_ip
> > [root@quaco ~]#
> > 
> > Trying to figure out how to remove it via debugfs/tracefs
> 
> [root@quaco ~]# cat /sys/kernel/debug/tracing/dynamic_events
> p:probe_perf/map__map_ip /home/acme/bin/perf:0x000000000005f257
> p:probe_perf/map__map_ip /home/acme/bin/perf:0x000000000005f2a3
> p:probe_perf/map__map_ip /home/acme/bin/perf:0x00000000000fda24
> p:probe_perf/map__map_ip /home/acme/bin/perf:0x00000000000fdacf
> p:probe_perf/map__map_ip /home/acme/bin/perf:0x00000000001028d0
> p:probe_perf/map__map_ip /home/acme/bin/perf:0x000000000016dd90
> [root@quaco ~]#
> 
> [root@quaco ~]# cat /sys/kernel/debug/tracing/kprobe_events
> [root@quaco ~]#
> 
> [root@quaco ~]# echo > /sys/kernel/debug/tracing/kprobe_events
> [root@quaco ~]# perf probe -l
>   probe_perf:map__map_ip (on process_sample_event+6663@tools/perf/builtin-script.c in /home/acme/bin/perf)
>   probe_perf:map__map_ip (on process_sample_event+6739@tools/perf/builtin-script.c in /home/acme/bin/perf)
>   probe_perf:map__map_ip (on unwind_entry+436@util/machine.c in /home/acme/bin/perf)
>   probe_perf:map__map_ip (on machine__process_extra_kernel_map+31@util/machine.c in /home/acme/bin/perf)
>   probe_perf:map__map_ip (on __maps__insert+192@util/map.c in /home/acme/bin/perf)
>   probe_perf:map__map_ip (on dso__process_kernel_symbol+336@util/symbol-elf.c in /home/acme/bin/perf)
> [root@quaco ~]#
> 
> Finally it works:
> 
> [root@quaco ~]# echo > /sys/kernel/debug/tracing/dynamic_events
> [root@quaco ~]# cat /sys/kernel/debug/tracing/dynamic_events
> [root@quaco ~]#
> [root@quaco ~]# perf probe -l
> [root@quaco ~]#
> 
> A workaround, now to find out why 'perf probe -d '*:*' and the other
> reported variants are failing...
> 

Thank you for pointing it out. You can use '*' instead of '*:*' to list them all.
Anyway, there seems an inssue when I introduced multiprobe support.
I'll fix it soon.

Thanks,

> - Arnaldo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
