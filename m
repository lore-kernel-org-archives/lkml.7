Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1766C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8190214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A07Yg9j4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfLLJhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 04:37:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22741 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728274AbfLLJhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576143436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zCO999uvdViXr9L00zEpbJgceNlZDxYWmmetd0aUHpc=;
        b=A07Yg9j4BmEsEIIPpt68UD0ZLYcAGnStifo4m0ItixOOZ9rnSmwDvkYVRFTo13d49lkE4t
        g4P4WjqNQL59RaG/kK7bviADKupS+UK5M46VtDEP7o0N3ZE3rIE0EmImKbQgWMdPPxuyFB
        j28opSCpqaWC41S7nECfD795wPer/Ec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-KnSwC2bIOpCmtzoiiIAgvg-1; Thu, 12 Dec 2019 04:37:13 -0500
X-MC-Unique: KnSwC2bIOpCmtzoiiIAgvg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FAA7991F9;
        Thu, 12 Dec 2019 09:37:11 +0000 (UTC)
Received: from krava (ovpn-204-197.brq.redhat.com [10.40.204.197])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 46F2826FA2;
        Thu, 12 Dec 2019 09:37:04 +0000 (UTC)
Date:   Thu, 12 Dec 2019 10:37:00 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>, Kajol Jain <kjain@linux.ibm.com>
Subject: Re: [RFC 0/3] perf tools: Add support for used defined metric
Message-ID: <20191212093700.GD22550@krava>
References: <20191211224800.9066-1-jolsa@kernel.org>
 <20191211230126.GC862919@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211230126.GC862919@tassilo.jf.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 03:01:26PM -0800, Andi Kleen wrote:
> On Wed, Dec 11, 2019 at 11:47:57PM +0100, Jiri Olsa wrote:
> > hi,
> > Joe asked for possibility to add user defined metrics. Given that
> > we already have metrics support, I added --metric option that allows
> > to specify metric on the command line, like:
> > 
> >   # perf stat  --metric 'DECODED_ICACHE_UOPS% = 100 * (idq.dsb_uops / \
> >     (idq.ms_uops + idq.mite_uops + idq.dsb_uops + lsd.uops))' ...
> > 
> > The code facilitates the current metric code, and I was surprised
> > how easy it was, so I'm not sure I omitted something ;-)
> 
> There are some asserts you can hit, like for too many events.
> 
> Also some of the syntax (e.g. using @ instead of / and escapes) are
> not super user friendly.
> 
> Other than that it should be ok.
> 
> Of course it would be better to put it into a file,
> and then support comments etc.

should be also reasonable easy, redirecting the input for lex

> 
> I've been considering some extensions to perf to support @file
> reading with comment support.
> 
> Right now there are some very odd bugs when you do that, lie
> 
> -e 'event,<newline>
> event,<newline>
> event...'
> 
> adds the newline to the event name, which breaks the output formats.

should be possible to ignore new lines at some point no?

jirka

