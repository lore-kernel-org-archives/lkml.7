Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F5BC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859F121473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfDIQY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:24:26 -0400
Received: from foss.arm.com ([217.140.101.70]:40786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfDIQYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:24:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E60C15AB;
        Tue,  9 Apr 2019 09:24:25 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87FF63F68F;
        Tue,  9 Apr 2019 09:24:23 -0700 (PDT)
Date:   Tue, 9 Apr 2019 17:24:21 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Raphael Gault <raphael.gault@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jpoimboe@redhat.com, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry@arm.com
Subject: Re: [RFC 3/6] objtool: arm64: Adapt the stack frame checks and the
 section analysis for the arm architecture
Message-ID: <20190409162420.GB32587@lakrids.cambridge.arm.com>
References: <20190409135243.12424-1-raphael.gault@arm.com>
 <20190409135243.12424-4-raphael.gault@arm.com>
 <20190409161204.GS11158@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409161204.GS11158@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 06:12:04PM +0200, Peter Zijlstra wrote:
> 
> I'm just doing my initial read-through,.. however
> 
> On Tue, Apr 09, 2019 at 02:52:40PM +0100, Raphael Gault wrote:
> > +		if (!(sec->sh.sh_flags & SHF_EXECINSTR)
> > +			&& (strcmp(sec->name, ".altinstr_replacement") || !IGNORE_SHF_EXEC_FLAG))
> >  			continue;
> 
> could you please not format code like that. Operators go at the end of
> the line, and continuation should match the indentation of the opening
> paren. So the above would look like:
> 
> > +		if (!(sec->sh.sh_flags & SHF_EXECINSTR) &&
> > +		    (strcmp(sec->name, ".altinstr_replacement") || !IGNORE_SHF_EXEC_FLAG))
> >  			continue;
> 
> You appear to be doing that quit consistently, and it is against style.

Raphael, as a heads-up, ./scripts/checkpatch.pl can catch issues like
this. You can run it over a list of patches, so for a patch series you
can run:

 $ ./scripts/checkpatch.pl *.patch

... and hopefully most of the output will be reasonable.

Thanks,
Mark.
