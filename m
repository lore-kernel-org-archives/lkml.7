Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FE3C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4505020868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfDPSVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:21:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbfDPSVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:21:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC539F74B3;
        Tue, 16 Apr 2019 18:21:43 +0000 (UTC)
Received: from krava (ovpn-204-66.brq.redhat.com [10.40.204.66])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2AE7D19C71;
        Tue, 16 Apr 2019 18:21:39 +0000 (UTC)
Date:   Tue, 16 Apr 2019 20:21:39 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 02/12] perf tools: Separate generic code in
 dso_cache__read
Message-ID: <20190416182139.GC10125@krava>
References: <20190416160127.30203-1-jolsa@kernel.org>
 <20190416160127.30203-3-jolsa@kernel.org>
 <20190416171712.GB8631@mini-arch.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416171712.GB8631@mini-arch.hsd1.ca.comcast.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 16 Apr 2019 18:21:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:17:13AM -0700, Stanislav Fomichev wrote:
> On 04/16, Jiri Olsa wrote:
> > Moving file specific code in dso_cache__read function
> > into separate file_read function. I'll add bpf specific
> > code in following patches.
> > 
> > Link: http://lkml.kernel.org/n/tip-7f7d717uzrqt5ka2xp29ige3@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/dso.c | 47 ++++++++++++++++++++++++-------------------
> >  1 file changed, 26 insertions(+), 21 deletions(-)
> > 
> > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > index cb6199c1390a..6baad22ec8a9 100644
> > --- a/tools/perf/util/dso.c
> > +++ b/tools/perf/util/dso.c
> > @@ -794,6 +794,30 @@ dso_cache__memcpy(struct dso_cache *cache, u64 offset,
> >  	return cache_size;
> >  }
> >  
> > +static ssize_t file_read(struct dso *dso, struct machine *machine,
> > +			 u64 offset, char *data)
> > +{
> > +	ssize_t ret;
> > +
> > +	pthread_mutex_lock(&dso__data_open_lock);
> > +
> > +	/*
> > +	 * dso->data.fd might be closed if other thread opened another
> > +	 * file (dso) due to open file limit (RLIMIT_NOFILE).
> > +	 */
> > +	try_to_open_dso(dso, machine);
> > +
> > +	if (dso->data.fd < 0) {
> > +		dso->data.status = DSO_DATA_STATUS_ERROR;
> pthread_mutex_unlock(&dso__data_open_lock) here?

oops, yea.. thanks

jirka
