Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B05C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135CF206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfjJXyV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfDZPM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:12:58 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46290 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfDZPM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:12:58 -0400
Received: by mail-qk1-f196.google.com with SMTP id w73so2042142qkb.13;
        Fri, 26 Apr 2019 08:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jeoMtAPjcQIdGn+/TQK0ezwDM3vtfxjXk66o/sfrbDk=;
        b=KfjJXyV+l4ifVEgMgDHEqpFPLO8rh2JbpFeas5x1br6CscQGmsxoUjpMz8UYXmo/ag
         CxE/Pn2576jROQ19mabbBoQCHvuAKlow9px+AxN0HDlO+YwI6bnA6x3DtjuIHOLYazou
         XMktEl0vYRitWhqKJekIkrt85pnDqJzdsyxd/qHbidVxGg2LYoOV0V/t1zsGs50vfqrD
         3yFsHYrRcx+d/q09DkPXhGveR1n5/Y4/GvQusLVND3xYaxs46pTjVy1mNVKvnFpjuue0
         P2h0ouqRM8MMVE/mRK7axkJTY7TWyXmsQYgOw9M+J3QOGUbbJWRhtu9IET081gArQHm0
         zL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jeoMtAPjcQIdGn+/TQK0ezwDM3vtfxjXk66o/sfrbDk=;
        b=AckoHAg6zWQx7C5Fsm6eucMeOAphO/SidgeDpUgkVb9Gqs2ELQCfZEKQ1x332e8v3b
         +x9RHYcMTk24cHjwuFdGCT+MiKnh4PFCfLd9JUEuYt9IgQYXq4s/L9EJW1WPGcVARt4i
         WI0Yimy0s8IbXfNoTAutTuHSizaig2r3fhh9bD3+IarCR94OXtiqhjejTWIB6un9tppd
         ZUeFSBtkqyVQDVTSxIqcwwlzWYR8WZuyOWdrhJLSQBSaqWUm26Rcp6O1edYNBw9lcsoY
         MIHrEz882TYt1+PbtVGOEAqqoJMgCX99+0gZHrX2DgAfmo0zHomBkmsIM8YXkBMIU7nY
         ThMA==
X-Gm-Message-State: APjAAAUYulfEdLv4pQvH/JJaLvO1ttBBH8DeYcYbcAnV0v6GvoTsz+4j
        yJZVso7Zupt3S1pXGKkgTf4=
X-Google-Smtp-Source: APXvYqylrnqKBY9a8ZvTv1g/Hl/8k9Em3hM2iv5HlSMEJQ5CCmfWzhj3goKjOU4mPEbvyvoFOMxNsQ==
X-Received: by 2002:a05:620a:1113:: with SMTP id o19mr33491633qkk.129.1556291576920;
        Fri, 26 Apr 2019 08:12:56 -0700 (PDT)
Received: from quaco.ghostprotocols.net (187-26-100-54.3g.claro.net.br. [187.26.100.54])
        by smtp.gmail.com with ESMTPSA id f2sm5447634qtd.67.2019.04.26.08.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 08:12:56 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 53AE74111F; Fri, 26 Apr 2019 12:12:51 -0300 (-03)
Date:   Fri, 26 Apr 2019 12:12:51 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf/report: Report OOM in perf report status line
Message-ID: <20190426151251.GC23426@kernel.org>
References: <20190423105303.61683-1-tmricht@linux.ibm.com>
 <20190426140907.GB22086@kernel.org>
 <20190426141032.GA23426@kernel.org>
 <20190426141607.GB23426@kernel.org>
 <20190426144406.GD12922@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190426144406.GD12922@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 26, 2019 at 04:44:06PM +0200, Jiri Olsa escreveu:
> On Fri, Apr 26, 2019 at 11:16:07AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> SNIP
> 
> > > util/session.c: In function ‘perf_session__process_events’:
> > > util/session.c:1936:7: error: ‘skip’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
> > >    err = skip;
> > >    ~~~~^~~~~~
> > > util/session.c:1874:6: note: ‘skip’ was declared here
> > >   s64 skip;
> > >       ^~~~
> > > cc1: all warnings being treated as errors
> > > mv: cannot stat '/tmp/build/perf/util/.session.o.tmp': No such file or directory
> > > make[4]: *** [/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/session.o] Error 1
> > > make[3]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
> > > make[2]: *** [Makefile.perf:559: /tmp/build/perf/perf-in.o] Error 2
> > > make[1]: *** [Makefile.perf:215: sub-make] Error 2
> > > make: *** [Makefile:110: install-bin] Error 2
> > > make: Leaving directory '/home/acme/git/perf/tools/perf'
> > 
> > So, here is your patch:
> > 
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index b17f1c9bc965..e89716175588 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -1930,10 +1930,10 @@ reader__process_events(struct reader *rd, struct perf_session *session,
> > 
> >         if (size < sizeof(struct perf_event_header) ||
> >             (skip = rd->process(session, event, file_pos)) < 0) {
> > -               pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
> > +               pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%s]\n",
> >                        file_offset + head, event->header.size,
> > -                      event->header.type);
> > -               err = -EINVAL;
> > +                      event->header.type, strerror(-skip));
> > +               err = skip;
> >                 goto out;
> >         }
> > 
> > [acme@quaco perf]$
> > 
> > What happens if (size < sizeof(struct perf_event_header)) is true? size
> > will have an undefined value, so the right thing is to have this patch
> > on top of yours, so that err get, as before, set to -EINVAL when the
> > size is less than the perf_event_header sizeof:
> 
> I'd think you need to squash your change with the original patch
> for the bisecting sake, right?

Yes, that is what I did.
 
> > +++ b/tools/perf/util/session.c
> > @@ -1928,6 +1928,8 @@ reader__process_events(struct reader *rd, struct perf_session *session,
> >  
> >  	size = event->header.size;
> >  
> > +	skip = -EINVAL;
> > +
> >  	if (size < sizeof(struct perf_event_header) ||
> >  	    (skip = rd->process(session, event, file_pos)) < 0) {
> >  		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%s]\n",
> > 
> > ---
> > 
> > With two Reviewed-by tags, I jumped to quickly at applying, please
> > compile test next time guys ;-) :-)
 
> ugh.. need to slow down, this is happening too often now :-\

Right, I'll test build everything, and I do like reviewers, who don't?
Its just that when I see reviewed-by tags I end up relaxing a bit :-)

- Arnaldo
