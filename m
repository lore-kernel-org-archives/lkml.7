Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270CCC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 18:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4B520657
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 18:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbfFXSGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 14:06:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727763AbfFXSGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 14:06:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B9F3030832C6;
        Mon, 24 Jun 2019 18:06:41 +0000 (UTC)
Received: from krava (ovpn-204-119.brq.redhat.com [10.40.204.119])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4F688608BA;
        Mon, 24 Jun 2019 18:06:35 +0000 (UTC)
Date:   Mon, 24 Jun 2019 20:06:34 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@intel.com>, Jiri Olsa <jolsa@kernel.org>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tom Vaden <tom.vaden@hpe.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Alok Kataria <akataria@vmware.com>
Subject: Re: [RFC] perf/x86/intel: Disable check_msr for real hw
Message-ID: <20190624180634.GB7292@krava>
References: <20190614112853.GC4325@krava>
 <20190621174825.GA31027@tassilo.jf.intel.com>
 <20190623224031.GB5471@krava>
 <20190624164617.GB31027@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624164617.GB31027@tassilo.jf.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 24 Jun 2019 18:06:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 09:46:17AM -0700, Andi Kleen wrote:
> > > The other hypervisors are relatively obscure, but eventually
> > > someone will hit problems.
> > 
> > any idea if there's any other flag/way we could use to detect those?
> 
> I'm not aware of a generic way to detect any hypervisor unfortunately.
> 
> There are hypervisor reserved cpuid ranges, in theory you could
> probe the existence of those. But there might be always some which
> don't have extra CPUIDs.
> 
> > 
> > adding few virtualization folks to the loop
> > and attaching the original patch
> > 
> > thanks,
> > jirka
> > 
> > 
> > ---
> > Tom Vaden reported false failure of check_msr function, because
> > some servers can do POST tracing and enable LBR tracing during
> > the boot.
> 
> Just to understand the original problem, the LBR registers
> get locked somehow? It would be reasonable to not use LBRs
> in this case. We just need to make sure everything 
> else is still probed.

Tom, plz correctme if I'm wrongm but AFAIK because the LBR tracing is
enabled during the boot the lbr_from/lbr_to registers will fail the
check_msr 'val_new != val_tmp' check

if there's no good way to detect this, maybe we add boot option
to disable the check_msr check

jirka
