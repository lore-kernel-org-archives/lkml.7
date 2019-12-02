Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6029C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 19:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67704217F9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 19:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWvcWkOn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfLBTFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:05:17 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:35999 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfLBTFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 14:05:17 -0500
Received: by mail-qv1-f65.google.com with SMTP id b18so317018qvy.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 11:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8CTZ5aUql8YCdrVBVzvU+J/sOnTSXZSchPxgBH+nZgs=;
        b=CWvcWkOnAORpV+H1GetLi5DUi/zqcgn/H7FcmEuCQZYkKfq3KWXvJLzT5ljD/2Qjq6
         BDmBABbaazS6hz3U3e7UmOf2jF3U4RqN694MIyiS+e8jBmYjsBslzdK8Q7sUbdE8/Znb
         DHEWPdw/hF/FckRn5uGeYvzWmZST+SyCySi71epSLtEBpQMXuC+z2PtTB9kgUvHAuLlA
         lM3tNxvj3SgD7rQlCvzzbkkkPVm4zpQchlYEPQgqkylGWHA2aquG+WYNBmg7Wikccwc5
         kki4ypiC4I+7eWO2jX3x6zuPvZcidTroi1ivPmfxTKBeCzfaTHP65aNXGdlzHqQvZpb/
         6xFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8CTZ5aUql8YCdrVBVzvU+J/sOnTSXZSchPxgBH+nZgs=;
        b=iXwX4pMlSerlNq0h1+Pp0IkynQk6l8zZfihcE90XGZKaYDOemrY/NId4BWQqUBN6cn
         DVBUopQJQBHn6U+Dn88XEDgbwlYlDR4e6nHt1SqZbKLawjMTD5907YAtvASIOY21TwIA
         YmKXo97HNDg6/0reKj5cbGMgpZGji0a9hN2pNU5TVT1vvuQZhteNtOs1BhlHfWWJrDc8
         VGUAfD6SI+qCkPRcQgxB6wji7FRsoJ5yTcBWBVCtvucA51MyGxzq1zFLWC60b/h5azFo
         Yk8d3r74wWMQ2Y9gqLSWe/UQIVqxk+bywAs9ewCKcoj/FLnZykCDPNoKeepy/hUvAjNN
         SJYg==
X-Gm-Message-State: APjAAAXY05KnB50eTyQIrXdMaVaGp11tJnnRKBQQE7yCZ5qwr1jBZn1v
        GoOyPVMIJhjVE2xzOuR59j1EE+iK/SY=
X-Google-Smtp-Source: APXvYqxdCedcEkd13/IT2Wl/epQDjwayZiBySEnzcOI2CoC6ykiBIBLiDcVXDxDqxLxQWgjrj1f/VA==
X-Received: by 2002:ad4:5525:: with SMTP id ba5mr568925qvb.117.1575313515725;
        Mon, 02 Dec 2019 11:05:15 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id c80sm258945qkb.35.2019.12.02.11.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 11:05:15 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 733D0405B6; Mon,  2 Dec 2019 16:04:52 -0300 (-03)
Date:   Mon, 2 Dec 2019 16:04:52 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf probe -d failing to delete probes
Message-ID: <20191202190452.GI4063@kernel.org>
References: <20191129151324.GA26963@kernel.org>
 <20191202185958.GH4063@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202185958.GH4063@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 02, 2019 at 03:59:58PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Nov 29, 2019 at 12:13:24PM -0300, Arnaldo Carvalho de Melo escreveu:
> > 
> > Hi Masami,
> > 
> >    Can you please take a look at this?
> > 
> > [root@quaco perf]# perf probe -l
> >   probe_perf:map__map_ip (on ui__warn_map_erange+222@perf/tools/perf/builtin-top.c in /home/acme/bin/perf)
> >   probe_perf:map__map_ip (on ui__warn_map_erange+222@perf/tools/perf/builtin-top.c in /home/acme/bin/perf)
> >   probe_perf:map__map_ip (on perf_evlist__set_paused+222@util/evlist.c in /home/acme/bin/perf)
> >   probe_perf:map__map_ip (on perf_evlist__resume+222@util/evlist.c in /home/acme/bin/perf)
> >   probe_perf:map__map_ip (on perf_evsel__group_desc+222@util/evsel.c in /home/acme/bin/perf)
> >   probe_perf:map__map_ip (on svg_partial_wakeline+222@util/svghelper.c in /home/acme/bin/perf)
> > [root@quaco perf]# perf probe -d probe_perf:map_*
> > "probe_perf:map_*" does not hit any event.
> >   Error: Failed to delete events.
> > [root@quaco perf]# perf probe -d probe_perf:*
> > "probe_perf:*" does not hit any event.
> >   Error: Failed to delete events.
> > [root@quaco perf]# perf probe -d probe*:*
> > "probe*:*" does not hit any event.
> >   Error: Failed to delete events.
> > [root@quaco perf]# perf probe -d '*:*'
> > "*:*" does not hit any event.
> >   Error: Failed to delete events.
> > [root@quaco perf]#
> 
> [root@quaco ~]# perf probe -l
>   probe_perf:map__map_ip (on process_sample_event+6663@tools/perf/builtin-script.c in /home/acme/bin/perf)
>   probe_perf:map__map_ip (on process_sample_event+6739@tools/perf/builtin-script.c in /home/acme/bin/perf)
>   probe_perf:map__map_ip (on unwind_entry+436@util/machine.c in /home/acme/bin/perf)
>   probe_perf:map__map_ip (on machine__process_extra_kernel_map+31@util/machine.c in /home/acme/bin/perf)
>   probe_perf:map__map_ip (on __maps__insert+192@util/map.c in /home/acme/bin/perf)
>   probe_perf:map__map_ip (on dso__process_kernel_symbol+336@util/symbol-elf.c in /home/acme/bin/perf)
> [root@quaco ~]# ls -la /sys/kernel/debug/tracing/events/probe_perf/
> total 0
> drwxr-xr-x.   3 root root 0 Nov 29 12:09 .
> drwxr-xr-x. 113 root root 0 Dec  2 15:56 ..
> -rw-r--r--.   1 root root 0 Nov 29 12:09 enable
> -rw-r--r--.   1 root root 0 Nov 29 12:09 filter
> drwxr-xr-x.   2 root root 0 Nov 29 12:09 map__map_ip
> [root@quaco ~]#
> 
> Trying to figure out how to remove it via debugfs/tracefs

[root@quaco ~]# cat /sys/kernel/debug/tracing/dynamic_events
p:probe_perf/map__map_ip /home/acme/bin/perf:0x000000000005f257
p:probe_perf/map__map_ip /home/acme/bin/perf:0x000000000005f2a3
p:probe_perf/map__map_ip /home/acme/bin/perf:0x00000000000fda24
p:probe_perf/map__map_ip /home/acme/bin/perf:0x00000000000fdacf
p:probe_perf/map__map_ip /home/acme/bin/perf:0x00000000001028d0
p:probe_perf/map__map_ip /home/acme/bin/perf:0x000000000016dd90
[root@quaco ~]#

[root@quaco ~]# cat /sys/kernel/debug/tracing/kprobe_events
[root@quaco ~]#

[root@quaco ~]# echo > /sys/kernel/debug/tracing/kprobe_events
[root@quaco ~]# perf probe -l
  probe_perf:map__map_ip (on process_sample_event+6663@tools/perf/builtin-script.c in /home/acme/bin/perf)
  probe_perf:map__map_ip (on process_sample_event+6739@tools/perf/builtin-script.c in /home/acme/bin/perf)
  probe_perf:map__map_ip (on unwind_entry+436@util/machine.c in /home/acme/bin/perf)
  probe_perf:map__map_ip (on machine__process_extra_kernel_map+31@util/machine.c in /home/acme/bin/perf)
  probe_perf:map__map_ip (on __maps__insert+192@util/map.c in /home/acme/bin/perf)
  probe_perf:map__map_ip (on dso__process_kernel_symbol+336@util/symbol-elf.c in /home/acme/bin/perf)
[root@quaco ~]#

Finally it works:

[root@quaco ~]# echo > /sys/kernel/debug/tracing/dynamic_events
[root@quaco ~]# cat /sys/kernel/debug/tracing/dynamic_events
[root@quaco ~]#
[root@quaco ~]# perf probe -l
[root@quaco ~]#

A workaround, now to find out why 'perf probe -d '*:*' and the other
reported variants are failing...

- Arnaldo
