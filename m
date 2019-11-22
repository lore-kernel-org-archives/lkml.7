Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961DCC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5439A20707
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwFLEOub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfKVNtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 08:49:23 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41691 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfKVNtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 08:49:22 -0500
Received: by mail-qk1-f193.google.com with SMTP id m125so6277541qkd.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 05:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9lGOVl7goUMPuM8EAE9V69q6aiUf8keyhgaSMsntTSE=;
        b=UwFLEOubYhNyvmDOjLgw3o72Frrk4FRn7etSXzIoNuh4tV4SzKhXjE4umxNcvV00xl
         AOnSxc62as4xGeJLd9+6FFGbhVEs7fQUueQXZjDbclzJxuFfQoZ6C1rowdoLEVixCXco
         qyHt/IVI7C3vYStvuLswOB6jsj9k+noxcQXz20me98u+Ro8+vxyZrrL6u3maDqZOli/P
         VhG888Bs7+yG2zFgp/Cbu05NpsnFw5jKsnBcfWOhgpfaIC9//45JgkvZHdyf/sj74zKj
         UsEnU4i/kv4SCCA02qnNnCzF0C0vDpRc4Ltp8vp34evgofw+LtE/B3uqUcJFYN+j218Y
         1ISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9lGOVl7goUMPuM8EAE9V69q6aiUf8keyhgaSMsntTSE=;
        b=pVYRSVI6AQQ2kceBg4Yd+LRb7zBwxEDmp0Esvt0Rz40DOYWURJcgWNfONte42ItAwU
         NXuiMTR2YUP8DskvTPlHq8YuVKC9pKiI4uZfhDYvAiK3P4aC9O/GSwBt4apVhIEUcQsH
         VHiOeJk0z28EZ1WGJXMAprOVbN3lUvFUf5r3rMmiUmPj3aHZW3xuWQlAoHtN5jqMQfyj
         1Kpy1Zt/3tfsU2yvVuTPJvxAEi3IPWd4KmlDrbPeIBMPjafo3Jh/Cz/60WudGmYrc2Mx
         pJY1qdQMD38z56PVB1qW/UUSMI1NjH4HwcIJKefrvZqmVNxOHwdnG2Z/eVfNXZt1XKmL
         3IvQ==
X-Gm-Message-State: APjAAAWXEwCfZy0lyllZCQJIuLzqVgsfVADjQE7lZMUZJYMW84/YUIp9
        kuLt91RTUE53Dmw8MZylC+E=
X-Google-Smtp-Source: APXvYqzfXvNAR4Bf/im+3GVgvaVtKAMJ/q3eTDbX74zJ8Qvx4n19bkf5BApatxTA5/EgUR12GFq8DQ==
X-Received: by 2002:a37:9f94:: with SMTP id i142mr1768985qke.244.1574430561839;
        Fri, 22 Nov 2019 05:49:21 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id q8sm3463352qta.31.2019.11.22.05.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 05:49:21 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 19CA340D3E; Fri, 22 Nov 2019 10:49:18 -0300 (-03)
Date:   Fri, 22 Nov 2019 10:49:18 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf record: Fix perf_can_aux_sample_size()
Message-ID: <20191122134918.GB9996@kernel.org>
References: <20191122094856.10923-1-adrian.hunter@intel.com>
 <20191122134257.GA9996@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122134257.GA9996@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 22, 2019 at 10:42:57AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Nov 22, 2019 at 11:48:56AM +0200, Adrian Hunter escreveu:
> > perf_can_aux_sample_size() always returned true because it did not pass
> > the attribute size to sys_perf_event_open, nor correctly check the
> > return value and errno.
> > 
> > Before:
> > 
> >   # perf record --aux-sample -e '{intel_pt//u,branch-misses:u}'
> >   Error:
> >   The sys_perf_event_open() syscall returned with 7 (Argument list too long) for event (branch-misses:u).
> >   /bin/dmesg | grep -i perf may provide additional information.
> > 
> > After:
> > 
> >   # perf record --aux-sample -e '{intel_pt//u,branch-misses:u}'
> >   AUX area sampling is not supported by kernel
> 
> Since this hasn't been sent to Ingo, I combined it with the patch that
> introduced the problem, this one:
> 
> c31d79e7a052 perf record: Add a function to test for kernel support for AUX area sampling
> 
> Thanks for the quick fix,

Wrapping up, at the end of the series I now get:

  [root@quaco ~]# perf record --aux-sample -e '{intel_pt//u,branch-misses:u}'
  AUX area sampling is not supported by kernel
  [root@quaco ~]#
  [root@quaco ~]# uname -a
  Linux quaco 5.4.0-rc8 #1 SMP Mon Nov 18 06:15:31 -03 2019 x86_64 x86_64 x86_64 GNU/Linux
  [root@quaco ~]#

Thanks,

- Arnaldo
