Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3B1C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED832064B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfGBNym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:54:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfGBNyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:54:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0DD9D308620E;
        Tue,  2 Jul 2019 13:54:36 +0000 (UTC)
Received: from krava (unknown [10.43.17.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F256919730;
        Tue,  2 Jul 2019 13:54:32 +0000 (UTC)
Date:   Tue, 2 Jul 2019 15:54:32 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?iso-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>
Subject: Re: [PATCH 23/43] tools lib: Adopt skip_spaces() from the kernel
 sources
Message-ID: <20190702135432.GC12694@krava>
References: <20190702022616.1259-1-acme@kernel.org>
 <20190702022616.1259-24-acme@kernel.org>
 <20190702121240.GB12694@krava>
 <20190702134603.GA15462@kernel.org>
 <20190702134815.GB15462@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190702134815.GB15462@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 02 Jul 2019 13:54:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 10:48:15AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 02, 2019 at 10:46:03AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Jul 02, 2019 at 02:12:40PM +0200, Jiri Olsa escreveu:
> > > On Mon, Jul 01, 2019 at 11:25:56PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > 
> > > > Same implementation, will be used to replace ad-hoc equivalent code in
> > > > tools/.
> > > > 
> > > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > > Cc: André Goddard Rosa <andre.goddard@gmail.com>
> > > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > > Link: https://lkml.kernel.org/n/tip-dig691cg9ripvoiprpidthw7@git.kernel.org
> > > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > ---
> > > >  tools/include/linux/string.h |  4 +++-
> > > >  tools/lib/string.c           | 14 ++++++++++++++
> > > >  2 files changed, 17 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
> > > > index 6c3e2cc274c5..cee239350a6b 100644
> > > > --- a/tools/include/linux/string.h
> > > > +++ b/tools/include/linux/string.h
> > > > @@ -29,4 +29,6 @@ static inline bool strstarts(const char *str, const char *prefix)
> > > >  	return strncmp(str, prefix, strlen(prefix)) == 0;
> > > >  }
> > > >  
> > > > -#endif /* _LINUX_STRING_H_ */
> > > > +extern char * __must_check skip_spaces(const char *);
> > > > +
> > > > +#endif /* _TOOLS_LINUX_STRING_H_ */
> > > > diff --git a/tools/lib/string.c b/tools/lib/string.c
> > > > index 93b3d4b6feac..50d400822bb3 100644
> > > > --- a/tools/lib/string.c
> > > > +++ b/tools/lib/string.c
> > > > @@ -17,6 +17,7 @@
> > > >  #include <string.h>
> > > >  #include <errno.h>
> > > >  #include <linux/string.h>
> > > > +#include <linux/ctype.h>
> > > >  #include <linux/compiler.h>
> > > >  
> > > >  /**
> > > > @@ -106,3 +107,16 @@ size_t __weak strlcpy(char *dest, const char *src, size_t size)
> > > >  	}
> > > >  	return ret;
> > > >  }
> > > > +
> > > > +/**
> > > > + * skip_spaces - Removes leading whitespace from @str.
> > > > + * @str: The string to be stripped.
> > > > + *
> > > > + * Returns a pointer to the first non-whitespace character in @str.
> > > > + */
> > > > +char *skip_spaces(const char *str)
> > > > +{
> > > > +	while (isspace(*str))
> > > > +		++str;
> > > > +	return (char *)str;
> > > > +}
> > > > -- 
> > > > 2.20.1
> > > > 
> > > 
> > > this breaks objtool build, because it adds _ctype dependency via isspace call
> > > patch below fixes it for me
> > 
> > Thanks for  spotting this, I'll have it in my next pull request.
> 
> I'm adding a Signed-off-by: you, ok?

sure, I did not post full patch, because I thought you might thought
of some other solution

thanks,
jirka
