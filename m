Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33548CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97AD208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s5cydnpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfJ3QXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 12:23:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfJ3QXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MhjZQUW87IyuTxjRvPIP8irpYJjRIJ0bB6+g7tP3LwI=; b=s5cydnpvAKQtVHwFgaFzmGt3i
        HB9X7PYRjKpNEkIdK648f/d/gOX+ehlhvXewdihcqwWlFeoa7keVtyf3iJE7us85zUsCGz/3UPbgj
        f8ad3H9TqqXHqq4hh//UvjLODmdOIrOxqKeI6ZVO+iMqJBjhiaZxeRZfllxjJivHzMsCs0t6xETKd
        MtbkXfHplWHO2R/ZBZY2ty+kDmwDOPnKguvYALR6vd3vbYaU0MyzzjU+t+E7B7NEvou0NebwiT2Xz
        msGP+R9/gNaSJFboylevRAhTsWd/Dj+m7dpr1N0yFtioS97wI5idjg+0vjt1Zb/s8Sq9PMh+4Za8u
        UGDVIq0xQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPqkq-0000hL-PJ; Wed, 30 Oct 2019 16:23:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C82AF306098;
        Wed, 30 Oct 2019 17:22:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 09E7F2B444DB8; Wed, 30 Oct 2019 17:23:26 +0100 (CET)
Date:   Wed, 30 Oct 2019 17:23:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mike Leach <mike.leach@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/6] perf/x86: Add perf text poke event
Message-ID: <20191030162325.GT4114@hirez.programming.kicks-ass.net>
References: <20191025130000.13032-1-adrian.hunter@intel.com>
 <20191025130000.13032-2-adrian.hunter@intel.com>
 <20191030104747.GA21153@leoy-ThinkPad-X240s>
 <20191030124659.GQ4114@hirez.programming.kicks-ass.net>
 <20191030141950.GB21153@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030141950.GB21153@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 10:19:50PM +0800, Leo Yan wrote:
> On Wed, Oct 30, 2019 at 01:46:59PM +0100, Peter Zijlstra wrote:
> > On Wed, Oct 30, 2019 at 06:47:47PM +0800, Leo Yan wrote:

> > Anyway, the below argument doesn't care much, it works for NOP/JMP just
> > fine.
> 
> We can support NOP/JMP case as the first step, but later should can
> extend to support other transitions.

Since all instructions (with the possible exception of RET) are
unconditional branch instructions: NOP, JMP, CALL. It makes no read
difference to the argument below.

( I'm thinking RET might be special in that it reads the return address
from the stack and therefore must emit the whole IP into the stream, as
we cannot know the stack state )

> > > we need to update dso cache for the
> > > 'PERF_TEXT_POKE_UPDATE_PREV' event; if detect the instruction is
> > > changed from branch to nop, we need to update dso cache for
> > > 'PERF_TEXT_POKE_UPDATE_POST' event.  The main idea is to ensure the
> > > branch instructions can be safely contained in the dso file and any
> > > branch samples can read out correct branch instruction.
> > > 
> > > Could you confirm this is the same with your understanding?  Or I miss
> > > anything?  I personally even think the pair events can be used for
> > > different arches (e.g. the solution can be reused on Arm64/x86, etc).
> > 
> > So the problem we have with PT is that it is a bit-stream of
> > branch taken/not-taken decisions. In order to decode that we need to
> > have an accurate view of the unconditional code flow.
> > 
> > Both NOP/JMP are unconditional and we need to exactly know which of the
> > two was encountered.
> 
> If I understand correctly, PT decoder needs to read out instructions
> from dso and decide the instruction type (NOP or JMP), and finally
> generate the accurate code flow.
> 
> So PT decoder relies on (cached) DSO for decoding.  As I know, this
> might be different from Arm CS, since Arm CS decoder is merely
> generate packets and it doesn't need to rely on DSO for decoding.

Given a start point (from a start or sync packet) we scan the
instruction stream forward until the first conditional branch
instruction. Then we consume the next available branch decision bit to
know where to continue.

So yes, we need to have a correct text image available for this to work.

> > With your scheme, I don't see how we can ever actually know that. When
> > we get the PRE event, all we really know is that we're going to change
> > a specific instruction into another. And at the POST event we know it
> > has been done. But in between these two events, we have no clue which of
> > the two instructions is live on which CPU (two CPUs might in fact have a
> > different live instruction at the same time).
> >
> > This means we _cannot_ unambiguously decode a taken/not-taken decision
> > stream.
> > 
> > Does CS have this same problem, and how would the PRE/POST events help
> > with that?
> 
> My purpose is to use PRE event and POST event to update cached DSO,
> thus perf tool can read out 'correct' instructions and fill them into
> instruction/branch samples.

The thing is, as I argued, the instruction state between PRE and POST is
ambiguous. This makes it impossible to decode the branch decision
stream.

Suppose CPU0 emits the PRE event at T1 and the POST event at T5, but we
have CPU1 covering the instruction at T3.

How do you decide where CPU1 goes and what the next conditional branch
is?

