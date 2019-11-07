Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FC3C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D29C207FA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573134239;
	bh=Y+huid7a/CGWG0MlV6/Z2Mm6jQ9P1B8hzuvIQtr1m08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0v/nv6zB+BpyheDCGJCPIW4Adbeqgdx7fNMfR7AOzJ/5WYM8PVIYRLo2DxG1GGzHM
	 9QXMme6+mDIj5yk0DF/cVJ8BvYKlAwLtPNZPoAnaZvEiRHaOcUdcNIpBLW7H/mKeyJ
	 wt5Gbi8rn40hwtyoLluRxqW/GOT2UVK7BJnVl50A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389607AbfKGNn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:43:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:35382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389573AbfKGNnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:43:46 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 158642077C;
        Thu,  7 Nov 2019 13:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573134225;
        bh=Y+huid7a/CGWG0MlV6/Z2Mm6jQ9P1B8hzuvIQtr1m08=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FWW4nnh+3pOARrTeGX4VSL7E5R4wktwaAjhG4ZSynysmasNIwdKAZlYcKZrDF4WIR
         lkOG2Zy7OdI1zB9kh3KwBaEUMUPAZ+7a4ULU+Px6ZozEvnAFvXn5OLIES6DxT1bZCb
         CWgKOb9uSBu0dCIAbVYS5h092W02tILM09ZuvTjs=
Date:   Thu, 7 Nov 2019 22:43:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 2/5] perf probe: Generate event name with line number
Message-Id: <20191107224341.9b8d91e010913386f95b3cd3@kernel.org>
In-Reply-To: <20191106195432.GB11935@kernel.org>
References: <157291299825.19771.5190465639558208592.stgit@devnote2>
        <157291301924.19771.11830065569894242974.stgit@devnote2>
        <20191106195432.GB11935@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Wed, 6 Nov 2019 16:54:32 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Tue, Nov 05, 2019 at 09:16:59AM +0900, Masami Hiramatsu escreveu:
> > Generate event name from function name with line number
> > as <function>_L<line_number>. Note that this is only for
> > the new event which is defined by function and lines.
> > 
> > If there is another event on same line, you have to use
> > "-f" option. In that case, the new event has "_1" suffix.
> 
> So I don't like this, the existing practice of, if given a function
> name, just create the probe:name looks more natural, if one states
> kernel:1, then, sure, appending L1 to them is natural, better than the
> previous naming convention,

OK, then what about adding L* only when the user add it on a
specific line (like kernel_read:1) ?
IOW, _L0 will be skipped.

Thank you,

> 
> Thanks,
> 
> - Arnaldo
>  
> >  e.g.
> >   # perf probe -a kernel_read
> >   Added new event:
> >     probe:kernel_read_L0 (on kernel_read)
> > 
> >   You can now use it in all perf tools, such as:
> > 
> >   	perf record -e probe:kernel_read_L0 -aR sleep 1
> > 
> >   # perf probe -a kernel_read:1
> >   Added new events:
> >     probe:kernel_read_L1 (on kernel_read:1)
> > 
> >   You can now use it in all perf tools, such as:
> > 
> >   	perf record -e probe:kernel_read_L1_1 -aR sleep 1
> > 
> >   # perf probe -l
> >     probe:kernel_read_L0 (on kernel_read@linux/linux/fs/read_write.c)
> >     probe:kernel_read_L1 (on kernel_read@linux/linux/fs/read_write.c)
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  tools/perf/util/probe-event.c |    8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > index 91cab5f669d2..d14b970a6461 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -1679,6 +1679,14 @@ int parse_perf_probe_command(const char *cmd, struct perf_probe_event *pev)
> >  	if (ret < 0)
> >  		goto out;
> >  
> > +	/* Generate event name if needed */
> > +	if (!pev->event && pev->point.function
> > +			&& !pev->point.lazy_line && !pev->point.offset) {
> > +		if (asprintf(&pev->event, "%s_L%d", pev->point.function,
> > +			pev->point.line) < 0)
> > +			return -ENOMEM;
> > +	}
> > +
> >  	/* Copy arguments and ensure return probe has no C argument */
> >  	pev->nargs = argc - 1;
> >  	pev->args = zalloc(sizeof(struct perf_probe_arg) * pev->nargs);
> 
> -- 
> 
> - Arnaldo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
