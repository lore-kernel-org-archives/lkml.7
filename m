Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F899C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09E9206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733124AbfHZQri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 12:47:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728922AbfHZQrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 12:47:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B990281D1;
        Mon, 26 Aug 2019 16:47:37 +0000 (UTC)
Received: from krava (ovpn-204-96.brq.redhat.com [10.40.204.96])
        by smtp.corp.redhat.com (Postfix) with SMTP id 50C3F194BB;
        Mon, 26 Aug 2019 16:47:35 +0000 (UTC)
Date:   Mon, 26 Aug 2019 18:47:34 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 00/12] libperf: Add events to perf/event.h
Message-ID: <20190826164734.GE17554@krava>
References: <20190825181752.722-1-jolsa@kernel.org>
 <20190826154138.GD24801@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826154138.GD24801@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Mon, 26 Aug 2019 16:47:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 12:41:38PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, Aug 25, 2019 at 08:17:40PM +0200, Jiri Olsa escreveu:
> > hi,
> > as a preparation for sampling libperf interface, moving event
> > definitions into the library header. Moving just the kernel 
> > non-AUX events now.
> > 
> > In order to keep libperf simple, we switch 'u64/u32/u16/u8'
> > types used events to their generic '__u*' versions.
> > 
> > Perf added 'u*' types mainly to ease up printing __u64 values
> > as stated in the linux/types.h comment:
> > 
> >   /*
> >    * We define u64 as uint64_t for every architecture
> >    * so that we can print it with "%"PRIx64 without getting warnings.
> >    *
> >    * typedef __u64 u64;
> >    * typedef __s64 s64;
> >    */
> > 
> > Adding and using new PRI_lu64 and PRI_lx64 macros to be used for
> > that.  Using extra '_' to ease up the reading and differentiate
> > them from standard PRI*64 macros.
> 
> I think we should take advantage of this moment to rename those structs
> to have the 'perf_record_' prefix on them, I guess we could even remove
> the _event from them, i.e.:
> 
> 'struct mmap_event' becomes 'perf_record_mmap', as it is the description
> for the PERF_RECORD_MMAP meta-data event, are you ok with that?

hum, not sure about loosing the '_event' here, but we are
not public yet, so we can always change back ;-) I do like
it'd follow the enum name

> I can go ahead and do it myself, updating each patch on this series to
> do that.

sure, I thought we'd do it later, but feel free to do it,
maybe in separate changes?

thanks,
jirka
