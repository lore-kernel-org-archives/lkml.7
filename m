Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DE0C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FB921721
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfE1QQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 12:16:38 -0400
Received: from foss.arm.com ([217.140.101.70]:60614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfE1QQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 12:16:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA04C341;
        Tue, 28 May 2019 09:16:37 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E9923F59C;
        Tue, 28 May 2019 09:16:36 -0700 (PDT)
Date:   Tue, 28 May 2019 17:16:33 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Raphael Gault <raphael.gault@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com
Subject: Re: [RFC 1/7] perf: arm64: Compile tests unconditionally
Message-ID: <20190528161633.GB28492@lakrids.cambridge.arm.com>
References: <20190528150320.25953-1-raphael.gault@arm.com>
 <20190528150320.25953-2-raphael.gault@arm.com>
 <20190528151938.GC13830@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528151938.GC13830@kernel.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 12:19:38PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, May 28, 2019 at 04:03:14PM +0100, Raphael Gault escreveu:
> > In order to subsequently add more tests for the arm64 architecture
> > we compile the tests target for arm64 systematically.
> 
> Humm, the subject doesn't match the description? I.e. it _was_
> unconditionally built, now it is only built if CONFIG_DWARF_UNWIND is
> set to 'y'.

Perhaps it's hard to read, but we haven't introduced new conditionality.

Previously we'd only build the tests directory if CONFIG_DWARF_UNWIND
was selected, so tests/dwarf-unwind.o was always dependent on that.

Now we always try to build the tests directory, and move the
CONFIG_DWARF_UNWIND guard specifically to tests/dwarf-unwind.o.

Thanks,
Mark.

> 
> - Arnaldo
>  
> > Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> > ---
> >  tools/perf/arch/arm64/Build       | 2 +-
> >  tools/perf/arch/arm64/tests/Build | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/arch/arm64/Build b/tools/perf/arch/arm64/Build
> > index 36222e64bbf7..a7dd46a5b678 100644
> > --- a/tools/perf/arch/arm64/Build
> > +++ b/tools/perf/arch/arm64/Build
> > @@ -1,2 +1,2 @@
> >  perf-y += util/
> > -perf-$(CONFIG_DWARF_UNWIND) += tests/
> > +perf-y += tests/
> > diff --git a/tools/perf/arch/arm64/tests/Build b/tools/perf/arch/arm64/tests/Build
> > index 41707fea74b3..a61c06bdb757 100644
> > --- a/tools/perf/arch/arm64/tests/Build
> > +++ b/tools/perf/arch/arm64/tests/Build
> > @@ -1,4 +1,4 @@
> >  perf-y += regs_load.o
> > -perf-y += dwarf-unwind.o
> > +perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
> >  
> >  perf-y += arch-tests.o
> > -- 
> > 2.17.1
> 
> -- 
> 
> - Arnaldo
