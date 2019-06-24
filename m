Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BA6C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52C920665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbfFXTEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:04:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729865AbfFXTEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:04:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B90AC30832E3;
        Mon, 24 Jun 2019 19:04:47 +0000 (UTC)
Received: from krava (ovpn-204-119.brq.redhat.com [10.40.204.119])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1666C5B687;
        Mon, 24 Jun 2019 19:04:41 +0000 (UTC)
Date:   Mon, 24 Jun 2019 21:04:41 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Kyle Meyer <meyerk@hpe.com>, Kyle Meyer <kyle.meyer@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v1] Increase MAX_NR_CPUS and MAX_CACHES
Message-ID: <20190624190441.GB8743@krava>
References: <20190620193630.154025-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
 <20190624185058.GC4181@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624185058.GC4181@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 24 Jun 2019 19:04:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 03:50:58PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> > diff --git a/samples/bpf/map_perf_test_user.c b/samples/bpf/map_perf_test_user.c
> > index fe5564bff39b..da3c101ca776 100644
> > --- a/samples/bpf/map_perf_test_user.c
> > +++ b/samples/bpf/map_perf_test_user.c
> > @@ -22,7 +22,7 @@
> >  #include "bpf_load.h"
> >  
> >  #define TEST_BIT(t) (1U << (t))
> > -#define MAX_NR_CPUS 1024
> > +#define MAX_NR_CPUS 2048
> >  
> >  static __u64 time_get_ns(void)
> >  {
> > diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> > index 711e009381ec..74d0124d38f3 100644
> > --- a/tools/perf/perf.h
> > +++ b/tools/perf/perf.h
> > @@ -26,7 +26,7 @@ static inline unsigned long long rdclock(void)
> >  }
> >  
> >  #ifndef MAX_NR_CPUS
> > -#define MAX_NR_CPUS			1024
> > +#define MAX_NR_CPUS			2048
> >  #endif
> >  
> >  extern const char *input_name;
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index 06ddb6618ef3..abc9c2145efe 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -1121,7 +1121,7 @@ static int build_caches(struct cpu_cache_level caches[], u32 size, u32 *cntp)
> >  	return 0;
> >  }
> >  
> > -#define MAX_CACHES 2000
> > +#define MAX_CACHES (MAX_NR_CPUS * 4)

maybe we should re-do this via dynamic allocation ;-)
but for now it's ok

would be nice to have perf change separated, anyway for perf part:

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
