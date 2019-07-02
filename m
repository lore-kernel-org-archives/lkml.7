Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E20DC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A2E2063F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfGBNtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:49:32 -0400
Received: from smtprelay0007.hostedemail.com ([216.40.44.7]:52281 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726375AbfGBNtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:49:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id BADAA180A8153;
        Tue,  2 Jul 2019 13:49:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wire67_35a6136ca5946
X-Filterd-Recvd-Size: 2297
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue,  2 Jul 2019 13:49:28 +0000 (UTC)
Message-ID: <5bb30e0ddefe71cdb845b83b43ac6d5f0bd92ad0.camel@perches.com>
Subject: Re: [PATCH 23/43] tools lib: Adopt skip_spaces() from the kernel
 sources
From:   Joe Perches <joe@perches.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?ISO-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>
Date:   Tue, 02 Jul 2019 06:49:26 -0700
In-Reply-To: <20190702134603.GA15462@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
         <20190702022616.1259-24-acme@kernel.org> <20190702121240.GB12694@krava>
         <20190702134603.GA15462@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-02 at 10:46 -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 02, 2019 at 02:12:40PM +0200, Jiri Olsa escreveu:
> > On Mon, Jul 01, 2019 at 11:25:56PM -0300, Arnaldo Carvalho de Melo wrote:
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > 
> > > Same implementation, will be used to replace ad-hoc equivalent code in
> > > tools/.
[]
> > > diff --git a/tools/lib/string.c b/tools/lib/string.c
[]
> > > @@ -106,3 +107,16 @@ size_t __weak strlcpy(char *dest, const char *src, size_t size)
> > >  	}
> > >  	return ret;
> > >  }
> > > +
> > > +/**
> > > + * skip_spaces - Removes leading whitespace from @str.
> > > + * @str: The string to be stripped.
> > > + *
> > > + * Returns a pointer to the first non-whitespace character in @str.
> > > + */
> > > +char *skip_spaces(const char *str)
> > > +{
> > > +	while (isspace(*str))
> > > +		++str;
> > > +	return (char *)str;
> > > +}

pity about duplicating losing the const


