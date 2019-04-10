Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F490C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED7B20820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uUVA1+v1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731833AbfDJN2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:28:43 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41741 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbfDJN2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:28:43 -0400
Received: by mail-qt1-f193.google.com with SMTP id w30so2774054qta.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 06:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vhu9n+e0v6CtTUkgscrYfdh/L2VhFbMYME3Ss0ljXL0=;
        b=uUVA1+v1WnXtO4J5phvBGDq1TCT/GAHWaQMbS39sn6fq87KFwnRWi+5llw3tJSmt5+
         T6Aw0ZeXakjfyr2+3eFS7qP9N/vhyqRg7jZg6e3iJHKtnAzastA/2qRcHPK4A5Ev31m4
         ux1/XbKcJKr+Z/DxwR52JUCjVFuJTGWo1AgrxLVERYpJl7TYHgUX5wfhU8ne63dHgeCF
         C8FGleKuDiYl4cap3iUTgs/iWsw90bX2+QrtxfUdVGOlsqGCie0EuCotYJGAMp94C4GS
         iMJIsTAP8VZKlCX7VEt0WgjzW2z0NPO8FdCG9E0SBnKeG6OGdZNGw/cgC8kLei+rIBaB
         AhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vhu9n+e0v6CtTUkgscrYfdh/L2VhFbMYME3Ss0ljXL0=;
        b=GrkF9gCTSvNU7eVUOYWEFX0K2RdVFwvWU5ehz1Z4EAuzsUbfZ4Vt347uExNkE71kkI
         EEJXo5X9svThMgZFcRYBkVpzF2mvQDqj/AJ40OsEvmDY/gJfrvPdWTKpwiyVuxZ0ggNl
         EDVy8FwIQXmHuiu0fb6o+Tel223GJgty5vpDzp1NMw11YQ7A32BTVsNxefN56FVoPKfp
         B/GzCHOJUHoV38UaVXHCQSLsFoVzvDX7z6wgC3SkKhjNyBytY8jdS6oq7HuNRqlE8/rB
         F6JQkf2F50w9XjnN5zRVTCDGV6FCKx2RHf9wxSVEjLoGRlf2cGLmMLFHKP3eHhVYI3wz
         xyaA==
X-Gm-Message-State: APjAAAXik96yyDe+ftdDjujnW9cKCIfkuXdLMmCD+SsdGpoMZc/AV/uN
        GfW0o3D0EQ9qtliai1Ga1E0=
X-Google-Smtp-Source: APXvYqwRwM9wwDodPi7F6cINpNv8lOt9d/HUQXnHUSE+wtRrpGF2TyZjsQZkASrSlEp/eSMv1p+cTQ==
X-Received: by 2002:aed:3eea:: with SMTP id o39mr35206413qtf.25.1554902921556;
        Wed, 10 Apr 2019 06:28:41 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id m46sm24705952qtk.95.2019.04.10.06.28.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 06:28:40 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 440E74039C; Wed, 10 Apr 2019 10:28:37 -0300 (-03)
Date:   Wed, 10 Apr 2019 10:28:37 -0300
To:     Mao Han <han_mao@c-sky.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 1/3] perf: use hweight64 instead of hweight_long
Message-ID: <20190410132837.GG13888@kernel.org>
References: <cover.1554883878.git.han_mao@c-sky.com>
 <29ad7947dc8fd1ff0abd2093a72cc27a2446be9f.1554883878.git.han_mao@c-sky.com>
 <20190410130841.GE13888@kernel.org>
 <20190410131042.GF13888@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410131042.GF13888@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 10, 2019 at 10:10:42AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Apr 10, 2019 at 10:08:41AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Apr 10, 2019 at 04:16:43PM +0800, Mao Han escreveu:
> > > On 32-bits platform with more than 32 registers, the 64 bits mask is
> > > truncate to the lower 32 bits and the return value of hweight_long will
> > > always smaller than 32. When kernel outputs more than 32 registers, but
> > > the user perf program only counts 32, there will be a data mismatch
> > > result to overflow check fail.
> > > 
> > > CC: Peter Zijlstra <peterz@infradead.org>
> > > CC: Ingo Molnar <mingo@redhat.com>
> > > CC: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > CC: Jiri Olsa <jolsa@redhat.com>
> > > CC: Namhyung Kim <namhyung@kernel.org>
> > > 
> > > Signed-off-by: Mao Han <han_mao@c-sky.com>
> > > ---
> > >  tools/perf/util/evsel.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index 7835e05..73c78be 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -2322,7 +2322,7 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
> > >  		if (data->user_regs.abi) {
> > >  			u64 mask = evsel->attr.sample_regs_user;
> > >  
> > > -			sz = hweight_long(mask) * sizeof(u64);
> > > +			sz = hweight64(mask) * sizeof(u64);
> > >  			OVERFLOW_CHECK(array, sz, max_size);
> > >  			data->user_regs.mask = mask;
> > >  			data->user_regs.regs = (u64 *)array;
> > 
> > Later on, in the same function, perf_evsel__parse_sample() we have:
> > 
> >         data->intr_regs.abi = PERF_SAMPLE_REGS_ABI_NONE;
> >         if (type & PERF_SAMPLE_REGS_INTR) {
> >                 OVERFLOW_CHECK_u64(array);
> >                 data->intr_regs.abi = *array;
> >                 array++;
> > 
> >                 if (data->intr_regs.abi != PERF_SAMPLE_REGS_ABI_NONE) {
> >                         u64 mask = evsel->attr.sample_regs_intr;
> > 
> >                         sz = hweight_long(mask) * sizeof(u64);
> >                         OVERFLOW_CHECK(array, sz, max_size);
> >                         data->intr_regs.mask = mask;
> >                         data->intr_regs.regs = (u64 *)array;
> >                         array = (void *)array + sz;
> >                 }
> >         }
> > 
> > You forgot to convert that one, doing it for you,
> 
> Also in perf_event__sample_event_size() we need to do the same thing,
> right?

and perf_event__synthesize_sample()

Done, resulting patch is at the end of this messages, and matches the
kernel, that uses only hweight64().

I've also added Fixes tags to the patches that used hweight_long() in
various places, to help with the stable trees backporting process,
please consider doing it next time.

- Arnaldo

commit 21e6dfe04861c2c1b529f2759850bc62a80ca050
Author: Mao Han <han_mao@c-sky.com>
Date:   Wed Apr 10 16:16:43 2019 +0800

    perf evsel: Use hweight64() instead of hweight_long(attr.sample_regs_user)
    
    On 32-bits platform with more than 32 registers, the 64 bits mask is
    truncate to the lower 32 bits and the return value of hweight_long will
    always smaller than 32. When kernel outputs more than 32 registers, but
    the user perf program only counts 32, there will be a data mismatch
    result to overflow check fail.
    
    Signed-off-by: Mao Han <han_mao@c-sky.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Stephane Eranian <eranian@google.com>
    Fixes: 6a21c0b5c2ab ("perf tools: Add core support for sampling intr machine state regs")
    Fixes: d03f2170546d ("perf tools: Expand perf_event__synthesize_sample()")
    Fixes: 0f6a30150ca2 ("perf tools: Support user regs and stack in sample parsing")
    Link: http://lkml.kernel.org/r/29ad7947dc8fd1ff0abd2093a72cc27a2446be9f.1554883878.git.han_mao@c-sky.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 66d066f18b5b..966360844fff 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2368,7 +2368,7 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 		if (data->user_regs.abi) {
 			u64 mask = evsel->attr.sample_regs_user;
 
-			sz = hweight_long(mask) * sizeof(u64);
+			sz = hweight64(mask) * sizeof(u64);
 			OVERFLOW_CHECK(array, sz, max_size);
 			data->user_regs.mask = mask;
 			data->user_regs.regs = (u64 *)array;
@@ -2424,7 +2424,7 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 		if (data->intr_regs.abi != PERF_SAMPLE_REGS_ABI_NONE) {
 			u64 mask = evsel->attr.sample_regs_intr;
 
-			sz = hweight_long(mask) * sizeof(u64);
+			sz = hweight64(mask) * sizeof(u64);
 			OVERFLOW_CHECK(array, sz, max_size);
 			data->intr_regs.mask = mask;
 			data->intr_regs.regs = (u64 *)array;
@@ -2552,7 +2552,7 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 	if (type & PERF_SAMPLE_REGS_USER) {
 		if (sample->user_regs.abi) {
 			result += sizeof(u64);
-			sz = hweight_long(sample->user_regs.mask) * sizeof(u64);
+			sz = hweight64(sample->user_regs.mask) * sizeof(u64);
 			result += sz;
 		} else {
 			result += sizeof(u64);
@@ -2580,7 +2580,7 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 	if (type & PERF_SAMPLE_REGS_INTR) {
 		if (sample->intr_regs.abi) {
 			result += sizeof(u64);
-			sz = hweight_long(sample->intr_regs.mask) * sizeof(u64);
+			sz = hweight64(sample->intr_regs.mask) * sizeof(u64);
 			result += sz;
 		} else {
 			result += sizeof(u64);
@@ -2710,7 +2710,7 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 	if (type & PERF_SAMPLE_REGS_USER) {
 		if (sample->user_regs.abi) {
 			*array++ = sample->user_regs.abi;
-			sz = hweight_long(sample->user_regs.mask) * sizeof(u64);
+			sz = hweight64(sample->user_regs.mask) * sizeof(u64);
 			memcpy(array, sample->user_regs.regs, sz);
 			array = (void *)array + sz;
 		} else {
@@ -2746,7 +2746,7 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 	if (type & PERF_SAMPLE_REGS_INTR) {
 		if (sample->intr_regs.abi) {
 			*array++ = sample->intr_regs.abi;
-			sz = hweight_long(sample->intr_regs.mask) * sizeof(u64);
+			sz = hweight64(sample->intr_regs.mask) * sizeof(u64);
 			memcpy(array, sample->intr_regs.regs, sz);
 			array = (void *)array + sz;
 		} else {
