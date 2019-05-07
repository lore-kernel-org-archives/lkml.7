Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0DDC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077D5204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfEGIN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 04:13:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfEGINz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 04:13:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07B7F36887;
        Tue,  7 May 2019 08:13:54 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 74E795D9D6;
        Tue,  7 May 2019 08:13:51 +0000 (UTC)
Date:   Tue, 7 May 2019 10:13:50 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 07/12] perf script: Pad dso name for --call-trace
Message-ID: <20190507081350.GA17416@krava>
References: <20190503081841.1908-1-jolsa@kernel.org>
 <20190503081841.1908-8-jolsa@kernel.org>
 <8385E7AF-756B-4113-9388-BD81D0F58374@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8385E7AF-756B-4113-9388-BD81D0F58374@fb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 07 May 2019 08:13:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 09:38:55PM +0000, Song Liu wrote:

SNIP

> > 
> > Link: http://lkml.kernel.org/n/tip-99g9rg4p20a1o99vr0nkjhq8@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> > tools/include/linux/kernel.h  |  1 +
> > tools/lib/vsprintf.c          | 19 +++++++++++++++++++
> > tools/perf/builtin-script.c   |  1 +
> > tools/perf/util/map.c         |  6 ++++++
> > tools/perf/util/symbol_conf.h |  1 +
> > 5 files changed, 28 insertions(+)
> > 
> > diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
> > index 857d9e22826e..cba226948a0c 100644
> > --- a/tools/include/linux/kernel.h
> > +++ b/tools/include/linux/kernel.h
> > @@ -102,6 +102,7 @@
> > 
> > int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
> > int scnprintf(char * buf, size_t size, const char * fmt, ...);
> > +int scnprintf_pad(char * buf, size_t size, const char * fmt, ...);
> > 
> > #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
> > 
> > diff --git a/tools/lib/vsprintf.c b/tools/lib/vsprintf.c
> > index e08ee147eab4..149a15013b23 100644
> > --- a/tools/lib/vsprintf.c
> > +++ b/tools/lib/vsprintf.c
> > @@ -23,3 +23,22 @@ int scnprintf(char * buf, size_t size, const char * fmt, ...)
> > 
> >        return (i >= ssize) ? (ssize - 1) : i;
> > }
> > +
> > +int scnprintf_pad(char * buf, size_t size, const char * fmt, ...)
> > +{
> > +	ssize_t ssize = size;
> > +	va_list args;
> > +	int i;
> 
> nit: I guess we can avoid mixing int, ssize_t and size_t here?

I copied that from scnprintf ;-)

the thing is that at the end we call vsnprintf, which takes size_t
as size param and returns int, so there will be casting at some
point in any case..

I guess the ssize_t was introduced to compare the size_t value with int

> 
> 
> > +
> > +	va_start(args, fmt);
> > +	i = vsnprintf(buf, size, fmt, args);
> > +	va_end(args);
> > +
> > +	if (i < (int) size) {
> > +		for (; i < (int) size; i++)
> > +			buf[i] = ' ';
> > +		buf[i] = 0x0;
> > +	}
> > +
> > +	return (i >= ssize) ? (ssize - 1) : i;
> > +}
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 61cfd8f70989..7adaa6c63a0b 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -3297,6 +3297,7 @@ static int parse_call_trace(const struct option *opt __maybe_unused,
> > 	parse_output_fields(NULL, "-ip,-addr,-event,-period,+callindent", 0);
> > 	itrace_parse_synth_opts(opt, "cewp", 0);
> > 	symbol_conf.nanosecs = true;
> > +	symbol_conf.pad_output_len_dso = 50;
> > 	return 0;
> > }
> > 
> > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > index ee71efb9db62..c3fbd6e556b0 100644
> > --- a/tools/perf/util/map.c
> > +++ b/tools/perf/util/map.c
> > @@ -405,6 +405,7 @@ size_t map__fprintf(struct map *map, FILE *fp)
> > 
> > size_t map__fprintf_dsoname(struct map *map, FILE *fp)
> > {
> > +	char buf[PATH_MAX];
> 
> nit: PATH_MAX vs. 50 is a little weird. 

right, the "staying on the safe side" is too big here, will change 

thanks,
jirka
