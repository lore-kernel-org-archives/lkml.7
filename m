Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD37C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6D622CE3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqjhG9yp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbfHTRNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:13:50 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41471 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730174AbfHTRNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:13:50 -0400
Received: by mail-qk1-f194.google.com with SMTP id g17so5117114qkk.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Na+6gffEb112VVVNdODoi4mMyuuWBICqePLOsVHkZO0=;
        b=pqjhG9ypHdS0uUoy/HCpHsRI3P4Rltot/YPX+KwM75jreLtmyQ5e9fqMS13TBUfkh1
         LT/MhBkXETWWL+giL03xxJ4YuUuEJ+CR5TzxFrbw/WiySyKNGmuUBVUzIt/RzdaXhElA
         etNSci7TitZxUosEiLJf5KqC3elvoLqbqWliR865AihvkGMvnmc9U3YQDThlX2gAeSdd
         596XuREpM/89wdbn+5ASGGuK+cuuENOeQYh6LjWQhPg7bSU0P1CkhR6TjB8CVl4RclxI
         da3CdIn8QH+HTd/h23fPucUrOp1idpGpz4K0XNfUQM/FsBYBrcg6zc6UtWen/JvoOiGT
         7YAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Na+6gffEb112VVVNdODoi4mMyuuWBICqePLOsVHkZO0=;
        b=ftLvkw2IW4tBk0SzdtbTs0L6TOIBk6wkjwGI4Nmems1tT6ycWHYNRX/7Xy4EYbVjlC
         GnNOpbCOxP+hxE7+I3SMSXqTejnhNgwUu9BdsHsKkbDFmSpM/FAoHxYOcXCWb4KSlzbN
         D0y5F+ODtn793qduJlUXolX/NfiJSFuI2K33iU+TG6ZQkY6LpP9SJf0+grhP1JePKqxE
         KKvJdAr+vsL7H/+nfFmf+ejwL7p032jcCD2VzWj/2HfWpfWcjBHUueU5eGZLov9vcKTL
         Td4gwoPI6UukWHNyzXMKEdFcbO+xx2egu4kZRjh6+O/cOeNaLW2XrwnubUyM914t53JH
         gVmg==
X-Gm-Message-State: APjAAAWGPLduo8aHogtAJnxaSBL8MlO5vNvhUiCFS6M21cQc+Sl73h2m
        k7Ltm3zi6qDMHgpibbsi6Vk=
X-Google-Smtp-Source: APXvYqwzYkkFfAAlFjyQYFHdG5IG3wZhAYzuWXE41Vc09yNKPK4x+y5+YRpP02OYmUEDG1iNLyvjtg==
X-Received: by 2002:a37:649:: with SMTP id 70mr26851894qkg.208.1566321229163;
        Tue, 20 Aug 2019 10:13:49 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.212.43])
        by smtp.gmail.com with ESMTPSA id k74sm8958139qke.53.2019.08.20.10.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:13:46 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3E59A40340; Tue, 20 Aug 2019 14:13:42 -0300 (-03)
Date:   Tue, 20 Aug 2019 14:13:42 -0300
To:     "Lubashev, Igor" <ilubashe@akamai.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        James Morris <jmorris@namei.org>, Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v3 3/4] perf: Use CAP_SYSLOG with kptr_restrict checks
Message-ID: <20190820171342.GD3929@kernel.org>
References: <cover.1565188228.git.ilubashe@akamai.com>
 <291d2cda6ee75b4cd4c9ce717c177db18bf03a31.1565188228.git.ilubashe@akamai.com>
 <CANLsYkxZE0CQJKQ-bFi=zFV5vTCbL2v76+x1fmCpqNruqWiFXg@mail.gmail.com>
 <20190814184814.GM9280@kernel.org>
 <20190814185213.GN9280@kernel.org>
 <23f7b8c7616a467c93ee2c77e8ffd3cf@usma1ex-dag1mb6.msg.corp.akamai.com>
 <CANLsYkxqBcJq8QJq+aLZXQas1VBg_wGh_p5WTUuRVFCYEQWiQw@mail.gmail.com>
 <20190815214236.GA3929@kernel.org>
 <CANLsYkyPkcJWmBZzyjGj3vJRgEtuaun7HQjN1=5wcOyTPnfhmQ@mail.gmail.com>
 <3f70f6be3a464ca5b4cf563433933245@usma1ex-dag1mb6.msg.corp.akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f70f6be3a464ca5b4cf563433933245@usma1ex-dag1mb6.msg.corp.akamai.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 19, 2019 at 10:22:07PM +0000, Lubashev, Igor escreveu:
> On Mon, August 19, 2019 at 12:51 PM Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> > On Thu, 15 Aug 2019 at 15:42, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > Things are working properly on your perf/cap branch.  I tested with on both
> > x86 and ARM.
 
> Mathieu, you are probably testing with euid==0.  If you were to test
> with euid!=0 but with CAP_SYSLOG and no libcap (and kptr_restrict=0,
> perf_event_paranoid=2), you would likely hit the bug that you
> identified in __perf_event__synthesize_kermel_mmap().
 
> See https://lkml.kernel.org/lkml/930a59730c0d495f8c5acf4f99048e8d@usma1ex-dag1mb6.msg.corp.akamai.com for the fix (Option 1 only or Options 1+2).
> 
> Arnaldo, once we decide what the right fix is, I am happy to post the update (options 1, 1+2) as a patch series.

I think you should get the checks for ref_reloc_sym in place so as to
make the code overall more robust, and also go on continuing to make the
checks in tools/perf/ to match what is checked on the other side of the
mirror, i.e. by the kernel, so from a quick read, please put first the
robustness patches (check ref_reloc_sym) do your other suggestions and
update the warnings, then refresh the two patches that still are not in
my perf/core branch:

[acme@quaco perf]$ git rebase perf/core
First, rewinding head to replay your work on top of it...
Applying: perf tools: Use CAP_SYS_ADMIN with perf_event_paranoid checks
Applying: perf symbols: Use CAP_SYSLOG with kptr_restrict checks
[acme@quaco perf]$ 

I've pushed out perf/cap, so you can go from there as it is rebased on
my current perf/core.

Then test all these cases: with/without libcap, with euid==0 and
different than zero, with capabilities, etc, patch by patch so that we
don't break bisection nor regress,

Thanks and keep up the good work!

- Arnaldo
 
> - Igor
> 
> 
> > > > I am not sure how this can be fixed.  I counted a total of 19
> > > > instances where kmap->ref_reloc_sym->XYZ is called, only 2 of wich
> > > > care to check if kmap->ref_reloc_sym is valid before proceeding.  As
> > > > such I must hope that in the 17 other cases, kmap->ref_reloc_sym is
> > > > guaranteed to be valid.  If I am correct then all we need is to
> > > > check for a valid pointer in _perf_event__synthesize_kernel_mmap().
> > > > Otherwise it will be a little harder.
> > > >
> > > > Mathieu
> 

-- 

- Arnaldo
