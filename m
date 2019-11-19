Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378FAC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 21:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0240C22444
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 21:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JE/sD7xS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfKSVbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 16:31:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfKSVbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 16:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M+CtvlYCWyzkzDNwvhpt28kYAZgspus7o8NYVGe1+LQ=; b=JE/sD7xSL5fxRRAOZmQGXGLSX
        JA/wmenFRZA9tppgdzydyDDXfx2Wl9H+hynaHyQfXlSzEc9ZLEO7wDtFgasD8u4HkEgo5J1Jju+98
        e1MdJxibueUMT1VX90nd6tDeFBWsXwvb0z0plkfrA3LZc8SVqPnw4EDLdiNDJXEXBUD7Iu85ZLB5u
        LH/eGB34EtD2uKjYlHykqAtOZdWtLz/q2Eq+T1oYqgmhm8qI6TrmTMMW0Kjpm91ogzT7MukKnBbCk
        8BqX/v7l61lhTalHwMDHacAjVgg3d7LRNgV8WLjej392JYsGcGnPFgqCyTz+x8ufCxLHKQDeu5d32
        s278NqYWw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXB5r-0005Vi-Bo; Tue, 19 Nov 2019 21:31:27 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5F7D7980E2F; Tue, 19 Nov 2019 22:31:24 +0100 (CET)
Date:   Tue, 19 Nov 2019 22:31:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        Andi Kleen <ak@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH V4 03/13] perf tools: Support new branch sample type for
 LBR TOS
Message-ID: <20191119213124.GO3079@worktop.programming.kicks-ass.net>
References: <20191119143411.3482-1-kan.liang@linux.intel.com>
 <20191119143411.3482-4-kan.liang@linux.intel.com>
 <CABPqkBSkTgvbz0S_iv-F5DkUKdqA49k_dLtoh0wbE49ePQ6V=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBSkTgvbz0S_iv-F5DkUKdqA49k_dLtoh0wbE49ePQ6V=A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 11:00:00AM -0800, Stephane Eranian wrote:
> On Tue, Nov 19, 2019 at 6:35 AM <kan.liang@linux.intel.com> wrote:

> > diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> > index bb7b271397a6..c2da61c9ace7 100644
> > --- a/tools/include/uapi/linux/perf_event.h
> > +++ b/tools/include/uapi/linux/perf_event.h
> > @@ -180,7 +180,10 @@ enum perf_branch_sample_type_shift {
> >
> >         PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT      = 16, /* save branch type */
> >
> > -       PERF_SAMPLE_BRANCH_MAX_SHIFT            /* non-ABI */
> > +       PERF_SAMPLE_BRANCH_MAX_SHIFT            = 17, /* non-ABI */
> > +
> > +       /* PMU specific */
> 
> No! You must abstract this.
> 
> > +       PERF_SAMPLE_BRANCH_LBR_TOS_SHIFT        = 63, /* save LBR TOS */
> >  };
> >
> I don't like this because this is too Intel specific.
> What is the meaning of this field? You need a clear definition so it can be used
> with other PERF_SAMPLE_BRANCH_* implementations.

I also detest the MSB usage. Normal pattern is that any bit >= MAX
will be rejected by the kernel.
