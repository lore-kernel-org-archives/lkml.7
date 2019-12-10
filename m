Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F53CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF855207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hoxv3CR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfLJTvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:51:18 -0500
Received: from mail-vs1-f51.google.com ([209.85.217.51]:40004 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJTvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:51:18 -0500
Received: by mail-vs1-f51.google.com with SMTP id g23so14009162vsr.7;
        Tue, 10 Dec 2019 11:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PLo1+CdokGn3M0C4M/Z8r3XxdNJphgdqxYqLYU05NX4=;
        b=Hoxv3CR05D0V+1kD8ZpcygUbH1j+eusWeEphmulTH+iHgu3mARpVr++WG6Y1Gw28Wx
         ktklpF1USGkuBl85pL4WrtXtzLz5IP+GsCOBrxqrEj9SPq04Nx3AbwD9jEsP0vl2bQXm
         fdFcRhcdvnYhzdUxPW2DR4mfPSUNDmghheXe0atqOPYMzvxf8/vW4uA6jxAJNyxXJ7PI
         l1eNk+1wWnlz4fYLhSTg2Bnin15liRBxJNs7XCZdPhsdl7kiitWl5YdAs4PYpisVnmKG
         x3od1m9kNJkjY9FbT7sP4Jhb85qxxTJvGi6qo1QtX530/oZ29kdl05pd0tPP1RAxtLQv
         ZEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PLo1+CdokGn3M0C4M/Z8r3XxdNJphgdqxYqLYU05NX4=;
        b=OtlO/noSIuKu9DvTC+nzuCHmdZSE/lFZ9XQq04Tu755V/e/4TIMWyF7XKrk1q4Tbt/
         h+c8Gl3BLk34VikeSagc2siV2CVEmbLW4eUmhA/Ezp/J7T6ol9hMOdh6g8sQeIxe/dtH
         kCaRBTwOFkUQ1C9EjhJ4aRITPomO9wX3zSdrJeniQShjEz+YLoYcrmSJjCKzkft02yWk
         vJpDfHZA3OpXPCib6jYirSRkTqWpG9pU76PNsUfrjYevhGcWbriu3l9oUG0bdqjAwBTM
         iFFHalfBSUkV/4Yvx9YxErMmRqI+fbzdEXSPwEfaVEYsph04vsBzJVDZbjslbTWqwQi/
         K+Zg==
X-Gm-Message-State: APjAAAXVJo7kQLPv3N5Lk80TDiinPOvqtsjNamxxyhU7THoUiPY7vcSM
        Q0C0bBV4dRIJp7ZzsofaVwk=
X-Google-Smtp-Source: APXvYqzkb90ID18G1GEgd3XNc2zb+btQvYK+4V7dANgvkpSEy+G1rDq9qqCRWNUwC247qAak9oKf1w==
X-Received: by 2002:a05:6102:405:: with SMTP id d5mr26373149vsq.94.1576007477323;
        Tue, 10 Dec 2019 11:51:17 -0800 (PST)
Received: from quaco.ghostprotocols.net (179-240-167-103.3g.claro.net.br. [179.240.167.103])
        by smtp.gmail.com with ESMTPSA id a23sm2586262vso.20.2019.12.10.11.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 11:51:16 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DF0AC40352; Tue, 10 Dec 2019 16:51:13 -0300 (-03)
Date:   Tue, 10 Dec 2019 16:51:13 -0300
To:     John Garry <john.garry@huawei.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        mark.rutland@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linuxarm <linuxarm@huawei.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: perf top for arm64?
Message-ID: <20191210195113.GD13965@kernel.org>
References: <1573045254-39833-1-git-send-email-john.garry@huawei.com>
 <20191106140036.GA6259@kernel.org>
 <418023e7-a50d-cb6f-989f-2e6d114ce5d8@huawei.com>
 <20191210163655.GG14123@krava>
 <952dc484-2739-ee65-f41c-f0198850ab10@huawei.com>
 <20191210170841.GA23357@krava>
 <9a31536b-f266-e305-1107-2f745d0a33e3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a31536b-f266-e305-1107-2f745d0a33e3@huawei.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 10, 2019 at 05:17:56PM +0000, John Garry escreveu:
> On 10/12/2019 17:08, Jiri Olsa wrote:
> > On Tue, Dec 10, 2019 at 04:52:52PM +0000, John Garry wrote:
> > > On 10/12/2019 16:36, Jiri Olsa wrote:
> > > > On Tue, Dec 10, 2019 at 04:13:49PM +0000, John Garry wrote:
> > > > > Hi all,
> > > > > 
> > > > > I find to my surprise that "perf top" does not work for arm64:
> > > > > 
> > > > > root@ubuntu:/home/john/linux# tools/perf/perf top
> > > > > Couldn't read the cpuid for this machine: No such file or directory
> > > > 
> > > 
> > > Hi Jirka,
> > > 
> > > > there was recent change that check on cpuid and quits:
> > > >     608127f73779 perf top: Initialize perf_env->cpuid, needed by the per arch annotation init routine
> > > > 
> > > 
> > > ok, this is new code. I obviously didn't check the git history...
> > > 
> > > But, apart from this, there are many other places where get_cpuid() is
> > > called. I wonder what else we're missing out on, and whether we should still
> > > add it.
> > 
> > right, I was just wondering how come vendor events are working for you,
> > but realized we have get_cpuid_str being called in there ;-)
> > 
> > I think we should add it as you have it prepared already,
> > could you post it with bigger changelog that would explain
> > where it's being used for arm?
> 
> ok, I can look to do that.
> 
> But, as you know, we still need to fix perf top for other architectures
> affected.

Right, I need to make that just a pr_debug() message and then check in
the annotation code when that is needed to see if it is set, if not,
then show a popup error message and refuse to do whatever annotation
feature requires that.

Anyway, your patch should make sense and provide info that the ARM64
annotation may use now or in the future.

- Arnaldo
