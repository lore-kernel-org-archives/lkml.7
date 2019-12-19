Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CFBC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A7824672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPvnJcQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfLSVph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:45:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53726 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727217AbfLSVph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 16:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576791936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vQsQ64j8rIzWWFMU2EqmrtWGy2tcICz2bdufNKttS6Y=;
        b=LPvnJcQV9dkkOiRqx0a5eyRuCTLwMTKaed6PJUdRUf0JhjAm0Np8AJn4270UcOD8aEIqbi
        3wj/Y/KIb9nnWQYOcEwYg/QebvTCqIFW3fgG9vmkO0fuMoA0f8b+JyUsLG3d2lTWh2giVI
        RIZ5G1sjwKW1MCexpfES39ZI3UspP5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-UZ8bwUbMM1-XkVRULI5pig-1; Thu, 19 Dec 2019 16:45:33 -0500
X-MC-Unique: UZ8bwUbMM1-XkVRULI5pig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6618107ACC5;
        Thu, 19 Dec 2019 21:45:31 +0000 (UTC)
Received: from krava (ovpn-204-20.brq.redhat.com [10.40.204.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 805F51001DC0;
        Thu, 19 Dec 2019 21:45:30 +0000 (UTC)
Date:   Thu, 19 Dec 2019 22:45:27 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     'Arnaldo Carvalho de Melo' <acme@kernel.org>
Cc:     "fujita.yuya@fujitsu.com" <fujita.yuya@fujitsu.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'Ingo Molnar' <mingo@redhat.com>,
        'Jiri Olsa' <jolsa@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf tools: Fix variable name's inconsistency in
 hists__for_each macro
Message-ID: <20191219214527.GD27481@krava>
References: <OSAPR01MB1588E1C47AC22043175DE1B2E8520@OSAPR01MB1588.jpnprd01.prod.outlook.com>
 <20191219085106.GA8141@krava>
 <20191219165424.GA13699@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219165424.GA13699@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 01:54:24PM -0300, 'Arnaldo Carvalho de Melo' wrote:
> Em Thu, Dec 19, 2019 at 09:51:06AM +0100, Jiri Olsa escreveu:
> > On Thu, Dec 19, 2019 at 08:08:32AM +0000, fujita.yuya@fujitsu.com wrote:
> > > From: Yuya Fujita <fujita.yuya@fujitsu.com>
> > > 
> > > Variable names are inconsistent in hists__for_each macro.
> > > Due to this inconsistency, the macro replaces its second argument with "fmt" 
> > > regardless of its original name.
> > > So far it works because only "fmt" is passed to the second argument.
> > 
> > hum, I think it works because all the instances that use these macros
> > have 'fmt' variable passed in
> 
> Exactly, that is what he said :-)

ugh, I read too fast, sry

jirka

> 
> Nice catch!
>  
> > > However, this behavior is not expected and should be fixed.
> > > 
> > > Fixes: f0786af536bb ("perf hists: Introduce hists__for_each_format macro")
> > > Fixes: aa6f50af822a ("perf hists: Introduce hists__for_each_sort_list macro")
> > 
> > nice ;-)
> > 
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> Applied.
>  
> > thanks,
> > jirka
> > 
> > > Signed-off-by: Yuya Fujita <fujita.yuya@fujitsu.com>
> > > ---
> > >  tools/perf/util/hist.h |    4 ++--
> > >  1 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> > > index 4528690..0aa63ae 100644
> > > --- a/tools/perf/util/hist.h
> > > +++ b/tools/perf/util/hist.h
> > > @@ -339,10 +339,10 @@ static inline void perf_hpp__prepend_sort_field(struct perf_hpp_fmt *format)
> > >  	list_for_each_entry_safe(format, tmp, &(_list)->sorts, sort_list)
> > >  
> > >  #define hists__for_each_format(hists, format) \
> > > -	perf_hpp_list__for_each_format((hists)->hpp_list, fmt)
> > > +	perf_hpp_list__for_each_format((hists)->hpp_list, format)
> > >  
> > >  #define hists__for_each_sort_list(hists, format) \
> > > -	perf_hpp_list__for_each_sort_list((hists)->hpp_list, fmt)
> > > +	perf_hpp_list__for_each_sort_list((hists)->hpp_list, format)
> > >  
> > >  extern struct perf_hpp_fmt perf_hpp__format[];
> > >  
> > > -- 
> > > 1.7.1
> > > 
> 
> -- 
> 
> - Arnaldo
> 

