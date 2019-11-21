Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEC0C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815EF206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1TlkZ8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfKUOoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:44:54 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:41733 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUOox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:44:53 -0500
Received: by mail-qk1-f175.google.com with SMTP id m125so3217219qkd.8;
        Thu, 21 Nov 2019 06:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LwOJszrhWRDo4WAS8gX989XJuXFDN8fl3mRHgqmJa+E=;
        b=u1TlkZ8bzQUTl0GP+xLpzCnY7YN8h8o1KNCWI8t/XY7xwapn7blcjFFaqgety/iHDA
         0Mp+dh7r/Gb6KAjDKjS5MPhbujptHV5XWakqiFpSCoylB4CgCc+ZGDgOnorTgTCBqK9k
         2cEwbnsc9K0vSOv5deMeBt+CLtsYR9bcOrU85FQTVBxRdosCZwLZzlNqCQRAbOtgLJqU
         mC/nJb3SG7aFcWxyGbNYUQtsFqlgG1jM82K0E2ZdYCQDwS1/Ck3SgZLppJIw76+kS6S4
         8aOmmRH0AyN5Wo8rsvE/+zisxvW5VmtsbruQlnoBHxOSbt2VJVUU6hE8UPRKBdHqPsJP
         74mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LwOJszrhWRDo4WAS8gX989XJuXFDN8fl3mRHgqmJa+E=;
        b=qihrPs7dArYrOTEU7DuRA/QISP4JW/ftAtNT1SuQs8lh8Fx3pYJxPzVvNe8ZkwYI4z
         ifGPL+VXvHysjCk187Hs9UYVE0dWIOdeVu1ZQ7RNDQWDD40N0r7L7tP33DlrtO7LBxfm
         e3UQEQ4Eb5kghONGtoCPZl2bEX3qpNigCqAtKCTXul9DAon6uKEfld/kKs9T0+GsI6GM
         hr2NZo1CYJ+z7oDrCTfJn/t+j0koXjCZCf6yjRdsbq4DuQqsdAS+ftscavwnAA8RUA9n
         myrSr5m+aWCWS8FHGbWwIPCA0tUL55PBHbNEVPln0Wqrjb1qD8B0dMY61v6JZxU22AJd
         UcIA==
X-Gm-Message-State: APjAAAW7DYSfdbijuj8UvKPqV/6T9FBMpuaraqdh/kVWdorrw6OJNRDL
        jM+hVFFde14Ti8mR5RvcuiIPFUlfUM4=
X-Google-Smtp-Source: APXvYqzH+wS9xpGwD7kNUUPO05lAopc2lbdUBSzjFSEWP17uTob/zXGXLyV2wl/6IoZ/zv1sxsjpKQ==
X-Received: by 2002:a05:620a:4cf:: with SMTP id 15mr7981563qks.445.1574347492191;
        Thu, 21 Nov 2019 06:44:52 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id g83sm1488928qke.100.2019.11.21.06.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 06:44:51 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5997F40D3E; Thu, 21 Nov 2019 11:44:49 -0300 (-03)
Date:   Thu, 21 Nov 2019 11:44:49 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Colin King <colin.king@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] perf probe: fix spelling mistake "addrees" ->
 "address"
Message-ID: <20191121144449.GH5078@kernel.org>
References: <20191121092623.374896-1-colin.king@canonical.com>
 <20191121203035.5eae09a076f376472cd4465b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121203035.5eae09a076f376472cd4465b@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 21, 2019 at 08:30:35PM +0900, Masami Hiramatsu escreveu:
> Hi Colin,
> 
> On Thu, 21 Nov 2019 09:26:23 +0000
> Colin King <colin.king@canonical.com> wrote:
> 
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > There is a spelling mistake in a pr_warning message. Fix it.
> 
> Oops, good catch! (How my finger miss-typed this...)
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks, applied.

- Arnaldo
 
> Thank you!
> 
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  tools/perf/util/probe-finder.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> > index 38d6cd22779f..c470c49a804f 100644
> > --- a/tools/perf/util/probe-finder.c
> > +++ b/tools/perf/util/probe-finder.c
> > @@ -812,7 +812,7 @@ static int verify_representive_line(struct probe_finder *pf, const char *fname,
> >  	if (strcmp(fname, __fname) || lineno == __lineno)
> >  		return 0;
> >  
> > -	pr_warning("This line is sharing the addrees with other lines.\n");
> > +	pr_warning("This line is sharing the address with other lines.\n");
> >  
> >  	if (pf->pev->point.function) {
> >  		/* Find best match function name and lines */
> > -- 
> > 2.24.0
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

-- 

- Arnaldo
