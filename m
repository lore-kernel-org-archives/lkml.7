Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544CFC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3B224656
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYT3x922"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733155AbfLKPek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:34:40 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45774 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733039AbfLKP2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:28:13 -0500
Received: by mail-vs1-f67.google.com with SMTP id l24so16015120vsr.12;
        Wed, 11 Dec 2019 07:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eI29NPHgR+JJigbHSfSxbr0+0qNwPqbPN+NH3i1Irec=;
        b=YYT3x922MQWm+f4a0aKynxOZDe3KgmaaUs1IKwJxWA5OaHODRf0PX8aGLcJMUDdnDc
         /zzwfy6q0SZxyoiCwFJ9K+W/j6OQpEUbDt0hLQ6NdAR3IEiW7GpS4XU+D/phGMfIM3aW
         mUKZ2Oc9FQsStkX7VFf1NTH3UsfhaKNHQQYQwVTJg5LCtNO6eDZt3pCxEYyeT4ZeKids
         SQCpARlV+mWTaiGw6kXTxSUuWxqGqYY2gzEnCsg/Pn2/qv38da8TgyrEFMrFjPzMcqAe
         peI5pKQQbpVfqrJjbHyPi4s3qM9Jb3mAbHr0LwJ71vMfm8X5sRG+sb4NN+o3Bu+BQ+zW
         U3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eI29NPHgR+JJigbHSfSxbr0+0qNwPqbPN+NH3i1Irec=;
        b=g8abiMnyz5Box+lKy/ITa7tEUvowW8XcBwxAyzZC/Ov/Z5/TRBBQl6hZYu2sWIvaZZ
         BxaJbq9MzS2RtTqYg8oZK0tKxYD7eU26iUMayCbGoAFEAKhq3dZ5Wg9X8S/+DFVbVEA9
         yNmYBSV58mn9k7mUdoYpkmZaQOzCUmGY0UaPxjbEMIa8iiGtpy7LefShMi3GsVf0H6mK
         0qduTG8uEIbs2grI+4h6Gnc/D2Q2eTMs6vshz5+jB1riX2+ha9QkOkJtFkiSGRkQXrE8
         hLF8KVP2GwvHKc8qFO2fwR4ET6kiuqLrHKYonFlsQR4lHlyn8G8UNuxCp0KKJNITfPK+
         0OAA==
X-Gm-Message-State: APjAAAXduZQOeRJ0pdIMHWKjjaO5QqFYSI3GfzFqXImqo/7ZY8JRvzpp
        CH7iODmUIyEfKdK1FdBn94w=
X-Google-Smtp-Source: APXvYqyyXJCCvEUbVBf8RpbJ6qOKhDhEdIqLL7fFWAi8nYzygIRKtZVpy6yH+Yd464dAqw8wm196Xg==
X-Received: by 2002:a67:b03:: with SMTP id 3mr3063976vsl.72.1576078087457;
        Wed, 11 Dec 2019 07:28:07 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id 9sm1679121vkr.39.2019.12.11.07.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:28:06 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8E6D640352; Wed, 11 Dec 2019 12:28:04 -0300 (-03)
Date:   Wed, 11 Dec 2019 12:28:04 -0300
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     John Garry <john.garry@huawei.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linuxarm <linuxarm@huawei.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCHES] Fix 'perf top' breakage on architectures not providing
 get_cpuid() Re: perf top for arm64?
Message-ID: <20191211152804.GD15181@kernel.org>
References: <1573045254-39833-1-git-send-email-john.garry@huawei.com>
 <20191106140036.GA6259@kernel.org>
 <418023e7-a50d-cb6f-989f-2e6d114ce5d8@huawei.com>
 <20191210163655.GG14123@krava>
 <952dc484-2739-ee65-f41c-f0198850ab10@huawei.com>
 <20191210170841.GA23357@krava>
 <9a31536b-f266-e305-1107-2f745d0a33e3@huawei.com>
 <20191210195113.GD13965@kernel.org>
 <20191211133319.GA15181@kernel.org>
 <20191211144643.GC35097@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211144643.GC35097@lakrids.cambridge.arm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 11, 2019 at 02:46:43PM +0000, Mark Rutland escreveu:
> On Wed, Dec 11, 2019 at 10:33:19AM -0300, Arnaldo Carvalho de Melo wrote:
> > So can you take a look at the two patches below and provide me Acked-by
> > and/or Reviewed-by and/or Tested-by?
> 
> I just gave this a spin. With vanilla v5.5-rc1 perf top behaves as John
> reported, and with these applied atop perf works as expected:
> 
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> 
> >From scaning the code, the only other user of get_cpuid() that ends up
> giving up is perf kvm, but AFAICT that never supported arm64, so that
> looks sound to me:
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks guys, added all the tags, appreciated, I also added this:

Fixes: 608127f73779 ("perf top: Initialize perf_env->cpuid, needed by the per arch annotation init routine")

Thanks Jiri for pointing to it.

- Arnaldo
 
> Thanks,
> Mark.
> 
> > From 53c6cde6a71a1a9283763bd2e938b229b50c2cd5 Mon Sep 17 00:00:00 2001
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date: Wed, 11 Dec 2019 10:09:24 -0300
> > Subject: [PATCH 1/2] perf arch: Make the default get_cpuid() return compatible
> >  error
> > 
> > Some of the functions calling get_cpuid() propagate back the error it
> > returns, and all are using errno (positive) values, make the weak
> > default get_cpuid() function return ENOSYS to be consistent and to allow
> > checking if this is an arch not providing this function or if a provided
> > one is having trouble getting the cpuid, to decide if the warning should
> > be provided to the user or just a debug message should be emitted.
> > 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: John Garry <john.garry@huawei.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Will Deacon <will@kernel.org>
> > Link: https://lkml.kernel.org/n/tip-lxwjr0cd2eggzx04a780ffrv@git.kernel.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/header.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index becc2d109423..4d39a75551a0 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -850,7 +850,7 @@ int __weak strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
> >   */
> >  int __weak get_cpuid(char *buffer __maybe_unused, size_t sz __maybe_unused)
> >  {
> > -	return -1;
> > +	return ENOSYS; /* Not implemented */
> >  }
> >  
> >  static int write_cpuid(struct feat_fd *ff,
> > -- 
> > 2.21.0
> > 
> > From c6c6a3e2eb6982e37294abcac389effd298cf730 Mon Sep 17 00:00:00 2001
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date: Wed, 11 Dec 2019 10:21:59 -0300
> > Subject: [PATCH 2/2] perf top: Do not bail out when perf_env__read_cpuid()
> >  returns ENOSYS
> > 
> > 'perf top' stopped working on hw architectures that do not provide a
> > get_cpuid() implementation and thus fallback to the weak get_cpuid()
> > default function.
> > 
> > This is done because at annotation time we may need it in the arch
> > specific annotation init routine, but that is only being used by arches
> > that do provide a get_cpuid() implementation:
> > 
> >   $ find tools/  -name "*.[ch]" | xargs grep 'evlist->env'
> >   tools/perf/builtin-top.c:	top.evlist->env = &perf_env;
> >   tools/perf/util/evsel.c:		return evsel->evlist->env;
> >   tools/perf/util/s390-cpumsf.c:	sf->machine_type = s390_cpumsf_get_type(session->evlist->env->cpuid);
> >   tools/perf/util/header.c:	session->evlist->env = &header->env;
> >   tools/perf/util/sample-raw.c:	const char *arch_pf = perf_env__arch(evlist->env);
> >   $
> > 
> >   $ find tools/perf/arch  -name "*.[ch]" | xargs grep -w get_cpuid
> >   tools/perf/arch/x86/util/auxtrace.c:	ret = get_cpuid(buffer, sizeof(buffer));
> >   tools/perf/arch/x86/util/header.c:get_cpuid(char *buffer, size_t sz)
> >   tools/perf/arch/powerpc/util/header.c:get_cpuid(char *buffer, size_t sz)
> >   tools/perf/arch/s390/util/header.c: * Implementation of get_cpuid().
> >   tools/perf/arch/s390/util/header.c:int get_cpuid(char *buffer, size_t sz)
> >   tools/perf/arch/s390/util/header.c:	if (buf && get_cpuid(buf, 128))
> >   $
> > 
> > For 'report' or 'script', i.e. tools working on perf.data files, that is
> > setup while reading the header, its just top that needs to explicitely
> > read it at tool start.
> > 
> > Reported-by: John Garry <john.garry@huawei.com>
> > Analysed-by: Jiri Olsa <jolsa@kernel.org>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Will Deacon <will@kernel.org>
> > Link: https://lkml.kernel.org/n/tip-lxwjr0cd2eggzx04a780ffrv@git.kernel.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/builtin-top.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > index dc80044bc46f..795e353de095 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -1568,9 +1568,13 @@ int cmd_top(int argc, const char **argv)
> >  	 */
> >  	status = perf_env__read_cpuid(&perf_env);
> >  	if (status) {
> > -		pr_err("Couldn't read the cpuid for this machine: %s\n",
> > -		       str_error_r(errno, errbuf, sizeof(errbuf)));
> > -		goto out_delete_evlist;
> > +		/*
> > +		 * Some arches do not provide a get_cpuid(), so just use pr_debug, otherwise
> > +		 * warn the user explicitely.
> > +		 */
> > +		eprintf(status == ENOSYS ? 1 : 0, verbose,
> > +			"Couldn't read the cpuid for this machine: %s\n",
> > +			str_error_r(errno, errbuf, sizeof(errbuf)));
> >  	}
> >  	top.evlist->env = &perf_env;
> >  
> > -- 
> > 2.21.0
> > 

-- 

- Arnaldo
