Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A6AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799C620644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfEHHke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:40:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbfEHHke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:40:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E6BA300398D;
        Wed,  8 May 2019 07:40:33 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0AC4C5D9C8;
        Wed,  8 May 2019 07:40:30 +0000 (UTC)
Date:   Wed, 8 May 2019 09:40:30 +0200
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
Message-ID: <20190508074030.GG17416@krava>
References: <20190503081841.1908-1-jolsa@kernel.org>
 <20190503081841.1908-8-jolsa@kernel.org>
 <8385E7AF-756B-4113-9388-BD81D0F58374@fb.com>
 <20190507081350.GA17416@krava>
 <37A033AF-567C-47F5-8FBB-DBD26ED1BD13@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37A033AF-567C-47F5-8FBB-DBD26ED1BD13@fb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 08 May 2019 07:40:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 06:29:07PM +0000, Song Liu wrote:
> 
> 
> > On May 7, 2019, at 1:13 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > On Mon, May 06, 2019 at 09:38:55PM +0000, Song Liu wrote:
> > 
> > SNIP
> > 
> >>> 
> >>> Link: http://lkml.kernel.org/n/tip-99g9rg4p20a1o99vr0nkjhq8@git.kernel.org
> >>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >>> ---
> >>> tools/include/linux/kernel.h  |  1 +
> >>> tools/lib/vsprintf.c          | 19 +++++++++++++++++++
> >>> tools/perf/builtin-script.c   |  1 +
> >>> tools/perf/util/map.c         |  6 ++++++
> >>> tools/perf/util/symbol_conf.h |  1 +
> >>> 5 files changed, 28 insertions(+)
> >>> 
> >>> diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
> >>> index 857d9e22826e..cba226948a0c 100644
> >>> --- a/tools/include/linux/kernel.h
> >>> +++ b/tools/include/linux/kernel.h
> >>> @@ -102,6 +102,7 @@
> >>> 
> >>> int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
> >>> int scnprintf(char * buf, size_t size, const char * fmt, ...);
> >>> +int scnprintf_pad(char * buf, size_t size, const char * fmt, ...);
> >>> 
> >>> #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
> >>> 
> >>> diff --git a/tools/lib/vsprintf.c b/tools/lib/vsprintf.c
> >>> index e08ee147eab4..149a15013b23 100644
> >>> --- a/tools/lib/vsprintf.c
> >>> +++ b/tools/lib/vsprintf.c
> >>> @@ -23,3 +23,22 @@ int scnprintf(char * buf, size_t size, const char * fmt, ...)
> >>> 
> >>>       return (i >= ssize) ? (ssize - 1) : i;
> >>> }
> >>> +
> >>> +int scnprintf_pad(char * buf, size_t size, const char * fmt, ...)
> >>> +{
> >>> +	ssize_t ssize = size;
> >>> +	va_list args;
> >>> +	int i;
> >> 
> >> nit: I guess we can avoid mixing int, ssize_t and size_t here?
> > 
> > I copied that from scnprintf ;-)
> > 
> > the thing is that at the end we call vsnprintf, which takes size_t
> > as size param and returns int, so there will be casting at some
> > point in any case..
> > 
> > I guess the ssize_t was introduced to compare the size_t value with int
> > 
> 
> Interesting. Given scnprintf works fine, I think we can keep the patch
> as-is. 

I actualy found off by one issue in here.. I'll send new version

thanks,
jirka
