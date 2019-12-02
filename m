Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D33EC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 19:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9EF214AF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 19:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvhqdp5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfLBTAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:00:06 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:36355 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbfLBTAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 14:00:06 -0500
Received: by mail-qk1-f172.google.com with SMTP id v19so655006qkv.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 11:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r2RPr5+WEeCgn3rcIKgyHAfvMn76XyIGkeRp91U78ns=;
        b=bvhqdp5JP0jBD/J+jnqxZ6hwpj0aAdfJ6LoNAdeq1eYhNaHtWrU1ncPzvl57anC0cv
         m1D8r9lOpSaPXey4ZK0AjPcppl+A2j+8hxlvxvLyMCXKK6VLBiMikmyP+uzhmiJiGJKc
         6w5Ap66+fkRtmlXffZMilfqD8qk/0Fyhsm/uclA+FlFB/OCSrybV3224PDM+G0q7Ag1Y
         CQdDHBikZ9dqITHJOnSM7GcLrRBhirzNBGUJWII4LwctuRUtbovH7f1Xv3bUL6l7zE31
         cvQ4lwX0gq4Ppxtc55s9ndo7DCGoOF3xzrHTEkhN7hNTsUmBm5bKzEh4j4TE1AVt/fsX
         sflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r2RPr5+WEeCgn3rcIKgyHAfvMn76XyIGkeRp91U78ns=;
        b=PNcfGoRNv43Ee1DBCOwfEan0ugn81U6jmApghy7a0apgCT7dhwGrmU5B9FIYcU89Nv
         JdePGJwIX9wL+lOV1JjcT0kVNRhZwjpHMlGZDthBs9BibZfgbHzaJ/kFIXsuabLQjd+r
         zmpFYKOLZyQKPQIR6KRBAaoA9y3YtfqTzJw4fuyme248H35CMvuJh+h6gqeZAIqFwlRO
         JG+GLnqPBZmhQ1WULMOX+s2HPmV6I0O9kF34KYj7vNLibDav+YWGAbeuXJdnyQN6e/BM
         KdvHWAsrRSPPMigEVT7uNFbghaT57hVu+qdZntDiaTRpDGZ1Wfb41dF7xttppng9pseG
         VyTQ==
X-Gm-Message-State: APjAAAUMaa2WieFQxIngVavboIzMb2RZmpJ59Eo4OgevHrn9exu2J0xF
        ewDLkBZoX/x7UWMeZVZSwTcO9Mp8
X-Google-Smtp-Source: APXvYqyKDg5d2w1pos1D/HxULYrAFisTNLs8QueEGF9uJrrHg1we5RiLN6Wx9g6gU19NXe+ZEUHIIQ==
X-Received: by 2002:a37:a206:: with SMTP id l6mr340465qke.145.1575313203915;
        Mon, 02 Dec 2019 11:00:03 -0800 (PST)
Received: from quaco.ghostprotocols.net (179-240-150-117.3g.claro.net.br. [179.240.150.117])
        by smtp.gmail.com with ESMTPSA id c80sm251001qkb.35.2019.12.02.11.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 11:00:03 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 77C6C405B6; Mon,  2 Dec 2019 15:59:58 -0300 (-03)
Date:   Mon, 2 Dec 2019 15:59:58 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf probe -d failing to delete probes
Message-ID: <20191202185958.GH4063@kernel.org>
References: <20191129151324.GA26963@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129151324.GA26963@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 29, 2019 at 12:13:24PM -0300, Arnaldo Carvalho de Melo escreveu:
> 
> Hi Masami,
> 
>    Can you please take a look at this?
> 
> [root@quaco perf]# perf probe -l
>   probe_perf:map__map_ip (on ui__warn_map_erange+222@perf/tools/perf/builtin-top.c in /home/acme/bin/perf)
>   probe_perf:map__map_ip (on ui__warn_map_erange+222@perf/tools/perf/builtin-top.c in /home/acme/bin/perf)
>   probe_perf:map__map_ip (on perf_evlist__set_paused+222@util/evlist.c in /home/acme/bin/perf)
>   probe_perf:map__map_ip (on perf_evlist__resume+222@util/evlist.c in /home/acme/bin/perf)
>   probe_perf:map__map_ip (on perf_evsel__group_desc+222@util/evsel.c in /home/acme/bin/perf)
>   probe_perf:map__map_ip (on svg_partial_wakeline+222@util/svghelper.c in /home/acme/bin/perf)
> [root@quaco perf]# perf probe -d probe_perf:map_*
> "probe_perf:map_*" does not hit any event.
>   Error: Failed to delete events.
> [root@quaco perf]# perf probe -d probe_perf:*
> "probe_perf:*" does not hit any event.
>   Error: Failed to delete events.
> [root@quaco perf]# perf probe -d probe*:*
> "probe*:*" does not hit any event.
>   Error: Failed to delete events.
> [root@quaco perf]# perf probe -d '*:*'
> "*:*" does not hit any event.
>   Error: Failed to delete events.
> [root@quaco perf]#

[root@quaco ~]# perf probe -l
  probe_perf:map__map_ip (on process_sample_event+6663@tools/perf/builtin-script.c in /home/acme/bin/perf)
  probe_perf:map__map_ip (on process_sample_event+6739@tools/perf/builtin-script.c in /home/acme/bin/perf)
  probe_perf:map__map_ip (on unwind_entry+436@util/machine.c in /home/acme/bin/perf)
  probe_perf:map__map_ip (on machine__process_extra_kernel_map+31@util/machine.c in /home/acme/bin/perf)
  probe_perf:map__map_ip (on __maps__insert+192@util/map.c in /home/acme/bin/perf)
  probe_perf:map__map_ip (on dso__process_kernel_symbol+336@util/symbol-elf.c in /home/acme/bin/perf)
[root@quaco ~]# ls -la /sys/kernel/debug/tracing/events/probe_perf/
total 0
drwxr-xr-x.   3 root root 0 Nov 29 12:09 .
drwxr-xr-x. 113 root root 0 Dec  2 15:56 ..
-rw-r--r--.   1 root root 0 Nov 29 12:09 enable
-rw-r--r--.   1 root root 0 Nov 29 12:09 filter
drwxr-xr-x.   2 root root 0 Nov 29 12:09 map__map_ip
[root@quaco ~]#

Trying to figure out how to remove it via debugfs/tracefs
