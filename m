Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5B2C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D442178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hG7GUWYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389086AbfKGNzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:55:12 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42665 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388428AbfKGNzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:55:12 -0500
Received: by mail-qt1-f193.google.com with SMTP id t20so2432399qtn.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dpRiWCiXTOk6NTahvtwy4e0/ppZu6SLn3CsXlxawHag=;
        b=hG7GUWYC4Laqcz+mhF13PaSxq3LhWIR8BPs1AFzxJAtSMqi3b3aEZEmOniB54HzU12
         MKdykuFhCNaIdXWGK78nzDKZjkOoxBEWX1F4jnOco3F+em7fUxQt1u6XgF3tg5VA7YQq
         jRAqjozULQh4TaBaF7Xws5ixYpYtvsi9SSVjk302RK6VbiJECpw9OZLwVbqUpTH7bnUa
         8sR1p9xjvOf+GqSL+l6/sZ5jJw/Kb1DljQdPRf8Jio4Yvuq6uLI4uaThYJv+yWYjFlSB
         kUUwhlT8AJsELP2qyGJMe0F2vW5HRocr/+YzpJ0Ix8qz5pKc9QOBnf68+M8+fZhHzicN
         k9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dpRiWCiXTOk6NTahvtwy4e0/ppZu6SLn3CsXlxawHag=;
        b=l/s/s3ZK84uRXC1CcVjaM+l2Stj1jMfOGlWlfJDTJs3D4eJ7duyEKV4vq+QKxG0RE4
         HbRbtjU0+AZatCZNEOHB/SNlEfUe2g8CpLmPhBOu74ACaEvMbBOTmrUR4rnE3xu6TLjO
         k8Xq+cMV/Ih8j/yyHdin+uInuA92jt+sgFuBdfUuCTi7floYbO9HVTJA/FJMKoWpD+Dd
         19tNwg5Z5+oBwuxQHNIxiAoCdOsFnwtT58WoGr1jhYPu+wjqKCFTMFwsmp2a/iP9NPjw
         4TJFA1qL8Zg848PokcpWr6TEnZbU2mPGzcCebHkTWaKovc+IU4BC7QX8oAxX6ctV8AV0
         UBYA==
X-Gm-Message-State: APjAAAU/KxDG2HVAKxNZ3MVYaMwg/bQinsxCeoGGvNENx2AVcRmsZXs+
        Zf2OgmtyWi7I8pvA1bfCvJ4=
X-Google-Smtp-Source: APXvYqzbW4k1z8KMN/tDMz0q8AvRore28rl5eJeZfvmYpwzoTFX57qyascehqLSOO1zDhSyIjjHNKw==
X-Received: by 2002:ac8:151:: with SMTP id f17mr3837848qtg.92.1573134910920;
        Thu, 07 Nov 2019 05:55:10 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id u187sm412512qkc.7.2019.11.07.05.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 05:55:10 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CD74740B1D; Thu,  7 Nov 2019 10:55:07 -0300 (-03)
Date:   Thu, 7 Nov 2019 10:55:07 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 2/5] perf probe: Generate event name with line number
Message-ID: <20191107135507.GE11372@kernel.org>
References: <157291299825.19771.5190465639558208592.stgit@devnote2>
 <157291301924.19771.11830065569894242974.stgit@devnote2>
 <20191106195432.GB11935@kernel.org>
 <20191107224341.9b8d91e010913386f95b3cd3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107224341.9b8d91e010913386f95b3cd3@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 07, 2019 at 10:43:41PM +0900, Masami Hiramatsu escreveu:
> Hi Arnaldo,
> 
> On Wed, 6 Nov 2019 16:54:32 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > Em Tue, Nov 05, 2019 at 09:16:59AM +0900, Masami Hiramatsu escreveu:
> > > Generate event name from function name with line number
> > > as <function>_L<line_number>. Note that this is only for
> > > the new event which is defined by function and lines.
> > > 
> > > If there is another event on same line, you have to use
> > > "-f" option. In that case, the new event has "_1" suffix.
> > 
> > So I don't like this, the existing practice of, if given a function
> > name, just create the probe:name looks more natural, if one states
> > kernel:1, then, sure, appending L1 to them is natural, better than the
> > previous naming convention,
> 
> OK, then what about adding L* only when the user add it on a
> specific line (like kernel_read:1) ?
> IOW, _L0 will be skipped.

Exactly, agreed.
 
> Thank you,
> 
> > 
> > Thanks,
> > 
> > - Arnaldo
> >  
> > >  e.g.
> > >   # perf probe -a kernel_read
> > >   Added new event:
> > >     probe:kernel_read_L0 (on kernel_read)
> > > 
> > >   You can now use it in all perf tools, such as:
> > > 
> > >   	perf record -e probe:kernel_read_L0 -aR sleep 1
> > > 
> > >   # perf probe -a kernel_read:1
> > >   Added new events:
> > >     probe:kernel_read_L1 (on kernel_read:1)
> > > 
> > >   You can now use it in all perf tools, such as:
> > > 
> > >   	perf record -e probe:kernel_read_L1_1 -aR sleep 1
> > > 
> > >   # perf probe -l
> > >     probe:kernel_read_L0 (on kernel_read@linux/linux/fs/read_write.c)
> > >     probe:kernel_read_L1 (on kernel_read@linux/linux/fs/read_write.c)
> > > 
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > ---
> > >  tools/perf/util/probe-event.c |    8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > > index 91cab5f669d2..d14b970a6461 100644
> > > --- a/tools/perf/util/probe-event.c
> > > +++ b/tools/perf/util/probe-event.c
> > > @@ -1679,6 +1679,14 @@ int parse_perf_probe_command(const char *cmd, struct perf_probe_event *pev)
> > >  	if (ret < 0)
> > >  		goto out;
> > >  
> > > +	/* Generate event name if needed */
> > > +	if (!pev->event && pev->point.function
> > > +			&& !pev->point.lazy_line && !pev->point.offset) {
> > > +		if (asprintf(&pev->event, "%s_L%d", pev->point.function,
> > > +			pev->point.line) < 0)
> > > +			return -ENOMEM;
> > > +	}
> > > +
> > >  	/* Copy arguments and ensure return probe has no C argument */
> > >  	pev->nargs = argc - 1;
> > >  	pev->args = zalloc(sizeof(struct perf_probe_arg) * pev->nargs);
> > 
> > -- 
> > 
> > - Arnaldo
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

-- 

- Arnaldo
