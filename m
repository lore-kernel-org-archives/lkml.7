Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D28C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA762077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfDZOoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:44:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfDZOoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:44:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B71803005FE7;
        Fri, 26 Apr 2019 14:44:08 +0000 (UTC)
Received: from krava (unknown [10.40.205.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A511277C2;
        Fri, 26 Apr 2019 14:44:07 +0000 (UTC)
Date:   Fri, 26 Apr 2019 16:44:06 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf/report: Report OOM in perf report status line
Message-ID: <20190426144406.GD12922@krava>
References: <20190423105303.61683-1-tmricht@linux.ibm.com>
 <20190426140907.GB22086@kernel.org>
 <20190426141032.GA23426@kernel.org>
 <20190426141607.GB23426@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190426141607.GB23426@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 26 Apr 2019 14:44:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 11:16:07AM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> > util/session.c: In function ‘perf_session__process_events’:
> > util/session.c:1936:7: error: ‘skip’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
> >    err = skip;
> >    ~~~~^~~~~~
> > util/session.c:1874:6: note: ‘skip’ was declared here
> >   s64 skip;
> >       ^~~~
> > cc1: all warnings being treated as errors
> > mv: cannot stat '/tmp/build/perf/util/.session.o.tmp': No such file or directory
> > make[4]: *** [/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/session.o] Error 1
> > make[3]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
> > make[2]: *** [Makefile.perf:559: /tmp/build/perf/perf-in.o] Error 2
> > make[1]: *** [Makefile.perf:215: sub-make] Error 2
> > make: *** [Makefile:110: install-bin] Error 2
> > make: Leaving directory '/home/acme/git/perf/tools/perf'
> 
> So, here is your patch:
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index b17f1c9bc965..e89716175588 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1930,10 +1930,10 @@ reader__process_events(struct reader *rd, struct perf_session *session,
> 
>         if (size < sizeof(struct perf_event_header) ||
>             (skip = rd->process(session, event, file_pos)) < 0) {
> -               pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
> +               pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%s]\n",
>                        file_offset + head, event->header.size,
> -                      event->header.type);
> -               err = -EINVAL;
> +                      event->header.type, strerror(-skip));
> +               err = skip;
>                 goto out;
>         }
> 
> [acme@quaco perf]$
> 
> What happens if (size < sizeof(struct perf_event_header)) is true? size
> will have an undefined value, so the right thing is to have this patch
> on top of yours, so that err get, as before, set to -EINVAL when the
> size is less than the perf_event_header sizeof:

I'd think you need to squash your change with the original patch
for the bisecting sake, right?

> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index e89716175588..bad5f87ae001 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1928,6 +1928,8 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  
>  	size = event->header.size;
>  
> +	skip = -EINVAL;
> +
>  	if (size < sizeof(struct perf_event_header) ||
>  	    (skip = rd->process(session, event, file_pos)) < 0) {
>  		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%s]\n",
> 
> ---
> 
> With two Reviewed-by tags, I jumped to quickly at applying, please
> compile test next time guys ;-) :-)

ugh.. need to slow down, this is happening too often now :-\

jirka
