Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93ADBC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5926B2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AqSeVqV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgAGM22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:28:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgAGM21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=512YgnwE6XKHmE+IOxEt/LFAOvuO2Sym2koW+nQjqUA=; b=AqSeVqV+0danT1jt89bzLqI2W
        Gg1kOMA5dHT8gtgbaotRM8sBU9Zl8La7ZHBQO0SYWOISYZdE81G8ULwgaCI728pEOlGxx8sezlm7E
        4UceAcKy5XPHTIieGAFZPIVFXASVmr6XJofGtjI/rfemw9BAE0rEoUtaPqoEPGqCpDvSdeL6sKXdn
        802lRP4Ib7OLEb+FTy+7R3nUWLmHpU7UCRbo7G3/8WiVUM2mPMRZegmJFisK6OgfPACYrhziYr+iy
        jVmJ4voJGEdU79m8HGGC2yywjrR2dP0HAPzo1+M7wRWKuCfM9/+djuhPC3EQYJbfxQ0Jen+vX7+dI
        k4Pehk4tg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iony0-0004OS-5Y; Tue, 07 Jan 2020 12:28:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9A2143012C3;
        Tue,  7 Jan 2020 13:26:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 27D782B26EAB9; Tue,  7 Jan 2020 13:28:09 +0100 (CET)
Date:   Tue, 7 Jan 2020 13:28:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains v2
Message-ID: <20200107122809.GU2871@hirez.programming.kicks-ass.net>
References: <20191220084252.GL3178@techsingularity.net>
 <CAKfTPtDp624geHEnPmHki70L=ZrBuz6zJG3zW0VFy+_S064Etw@mail.gmail.com>
 <20200103143051.GA3027@techsingularity.net>
 <CAKfTPtCGm7-mq3duxi=ugy+mn=Yutw6w9c35+cSHK8aZn7rzNQ@mail.gmail.com>
 <20200106145225.GB3466@techsingularity.net>
 <CAKfTPtBa74nd4VP3+7V51Jv=-UpqNyEocyTzMYwjopCgfWPSXg@mail.gmail.com>
 <20200107095655.GF3466@techsingularity.net>
 <20200107112255.GV2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107112255.GV2827@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 12:22:55PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 07, 2020 at 09:56:55AM +0000, Mel Gorman wrote:

> > +			unsigned int imbalance_adj;
> > +
> > +			/*
> > +			 * Calculate an acceptable degree of imbalance based
> > +			 * on imbalance_adj. However, do not allow a greater
> > +			 * imbalance than the child domains weight to avoid
> > +			 * a case where the allowed imbalance spans multiple
> > +			 * LLCs.
> > +			 */
> 
> That comment is a wee misleading, @child is not an LLC per se. This
> could be the NUMA distance 2 domain, in which case @child is the NUMA
> distance 1 group.
> 
> That said, even then it probably makes sense to ensure you don't idle a
> whole smaller distance group.

Hmm, one more thing. On AMD EPYC, which the multiple LLCs, you'll have
the single NODE domain in between, and that is not marked with SD_NUMA
(iirc).

So specifically the case you want to handle is not in fact handled. The
first SD_NUMA (distance-1) will have all NODE children, which on EPYC
are not LLCs.
