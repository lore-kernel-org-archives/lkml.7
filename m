Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C858C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEB520869
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2HRAq47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731961AbfKFS6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 13:58:22 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41679 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfKFS6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 13:58:20 -0500
Received: by mail-qk1-f194.google.com with SMTP id m125so25566412qkd.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 10:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+GdGOoe6ZnJmfTS6lHkMGHRdKkX8MaWmhPSEAWY022I=;
        b=G2HRAq475cJ++2IYh0NsQ0VSr0xf7vZl55ggnBFreaqOOw/sAYcYMvD5gVKG3Xc/ls
         QfCB8iRRXnn1Yx8rTVZkWPPFSx2TsfjM+tCebp30g15nDlij6OLWg9H7bzh+3bP2J2ZU
         bASZeKbe1BdMjBYcbu8IRJeu22xeN7k2lWNhaxMCqjgiVD1sqZCmZWCQCU7ZUchEN+c5
         Q3JUMevEzatt8AREz/ZUyOxThSSimQMi/V5FC+U/tnNZBqli3UIZXbVRvWT9pq5gimKD
         /YqHk6GCCIYdjFPR0d0LlCChoxuE7cbG247BdTuF+eydgJAGGEOima5skhBELmud+7R6
         LwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+GdGOoe6ZnJmfTS6lHkMGHRdKkX8MaWmhPSEAWY022I=;
        b=LUXZxh9VTANDSUZrc59dK3FMOk7lqVsHs50K3f/nstP2t0GtAZND/5wiAU/1gjNVKy
         kTPs5T2y4mMqPNspxV6YNRKG2XlDOdURqUCf8irnac2QihCUdVi+Tuqq/aAbsCAcTsQ7
         HHUiTk94CX9hzIAB/uRlmhTUzVuFTwlybn8DpqiGgqMdCTfxs+ZpLJo0grtjgWe0YhRB
         ZfMfKFL35gO7pFjCl/wOzReNl4mTaGtMeYxG7bcE9Dzs8vs5sIiPhExre9eGFpgNDZYR
         QCojsXpAgFNDuHZyx2uyCpO44T9KzCnXwEwrq7mX2pr7Zuwl48gFm/mI66eEwQy1rGCf
         7Cng==
X-Gm-Message-State: APjAAAUDDyc44XHINRu3zCF1gsLIuQg37ZTQRGwyZHbqSiKFmGwalmM1
        UmzJIimugVxlCEGOg0Ef1zI=
X-Google-Smtp-Source: APXvYqwrIz2GujMkEIjd0G7idIrJTkY1RRgehwmNsbBDe9RzbDUedseYivpfddUe6karojZxWqaIPA==
X-Received: by 2002:a37:8b03:: with SMTP id n3mr3472545qkd.493.1573066697228;
        Wed, 06 Nov 2019 10:58:17 -0800 (PST)
Received: from quaco.ghostprotocols.net (187-26-100-98.3g.claro.net.br. [187.26.100.98])
        by smtp.gmail.com with ESMTPSA id o28sm14981710qtk.4.2019.11.06.10.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 10:58:16 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4D11740B1D; Wed,  6 Nov 2019 15:58:07 -0300 (-03)
Date:   Wed, 6 Nov 2019 15:58:07 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     jsun4 <jiwei.sun@windriver.com>, acme@redhat.com,
        arnaldo.melo@gmail.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, mpetlan@redhat.com,
        namhyung@kernel.org, a.p.zijlstra@chello.nl,
        adrian.hunter@intel.com, Richard.Danter@windriver.com,
        jiwei.sun.bj@qq.com
Subject: Re: [PATCH v5] perf record: Add support for limit perf output file
 size
Message-ID: <20191106185807.GC3636@kernel.org>
References: <20191022080901.3841-1-jiwei.sun@windriver.com>
 <20191101081300.GA2172@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101081300.GA2172@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 01, 2019 at 09:13:00AM +0100, Jiri Olsa escreveu:
> On Tue, Oct 22, 2019 at 04:09:01PM +0800, jsun4 wrote:
> > The patch adds a new option to limit the output file size, then based
> > on it, we can create a wrapper of the perf command that uses the option
> > to avoid exhausting the disk space by the unconscious user.
> > 
> > In order to make the perf.data parsable, we just limit the sample data
> > size, since the perf.data consists of many headers and sample data and
> > other data, the actual size of the recorded file will bigger than the
> > setting value.
> > 
> > Testing it:
> > 
> >  # ./perf record -a -g --max-size=10M
> >  Couldn't synthesize bpf events.
> >  [ perf record: perf size limit reached (10249 KB), stopping session ]
> >  [ perf record: Woken up 32 times to write data ]
> >  [ perf record: Captured and wrote 10.133 MB perf.data (71964 samples) ]
> > 
> >  # ls -lh perf.data
> >  -rw------- 1 root root 11M Oct 22 14:32 perf.data
> > 
> >  # ./perf record -a -g --max-size=10K
> >  [ perf record: perf size limit reached (10 KB), stopping session ]
> >  Couldn't synthesize bpf events.
> >  [ perf record: Woken up 0 times to write data ]
> >  [ perf record: Captured and wrote 1.546 MB perf.data (69 samples) ]
> > 
> >  # ls -l perf.data
> >  -rw------- 1 root root 1626952 Oct 22 14:36 perf.data
> > 
> > Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>
> > ---
> > v5 changes:
> >   - Change the output format like [ perf record: perf size limit XX ]
> >   - change the killing perf way from "raise(SIGTERM)" to set "done == 1"
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo
