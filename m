Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7696C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 20:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00482073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 20:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fLd2+ATU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKOUVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 15:21:14 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35624 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfKOUVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 15:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iSwFXhxzjDsNXQblKl/f+U30/Olxa5/X6KYBIwZVGy8=; b=fLd2+ATU4rn7p5MlOnZX3BUR6
        osCskSchgEO+9NpWGkhOzWSGulP7zWZbhQ5mW0yiUO9SRBJrnAKP2S863z+C/0jpYRdxbP/6vaIjm
        x68TGLj1oA+mlshWbV3n/5jV70VctLuY42871l95xJ4Rmef7IBlH80oo3K6sQBxa7fdjxzg5XtDwk
        tmvTtkwwRZGfT1IoxkSpoCJMsX9LUe56ciYtCfwOJiAL1XLVtFKEoZZN26GnrkPpt5MDz6Le0pIRT
        gDhCUxKj0Q/ZQpycyXZguBbJ+hqqhq6AzEypyI0bAfRlFItbZe3wARrcBiH+WQH3nktaYWJzq8+oK
        CMnSSTxQg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVi5a-0004Ev-Le; Fri, 15 Nov 2019 20:21:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D5908303D9F;
        Fri, 15 Nov 2019 21:19:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 18D1E2B132F97; Fri, 15 Nov 2019 21:21:05 +0100 (CET)
Date:   Fri, 15 Nov 2019 21:21:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Tejun Heo <tj@kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>,
        Qais Yousef <qais.yousef@arm.com>
Subject: Re: [PATCH v2] sched/uclamp: Fix overzealous type replacement
Message-ID: <20191115202105.GR4131@hirez.programming.kicks-ass.net>
References: <20191115103908.27610-1-valentin.schneider@arm.com>
 <CAKfTPtBoi_5sUiGrTpYuV_u2vPkBK+caUzgaKxY3Ck3PKJXZiw@mail.gmail.com>
 <f4fcc45e-7609-3836-162a-0a1839134bcf@arm.com>
 <2dce8a83-b358-d975-bf43-8088b3bc5557@arm.com>
 <CAKfTPtCvt7BZ8g2sC3j=uoN-8nXfwRDGaO06xtHN0O+d8u5MQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCvt7BZ8g2sC3j=uoN-8nXfwRDGaO06xtHN0O+d8u5MQQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 06:34:19PM +0100, Vincent Guittot wrote:
> On Fri, 15 Nov 2019 at 18:10, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
> >
> > On 15/11/2019 14:29, Valentin Schneider wrote:
> > > On 15/11/2019 14:07, Vincent Guittot wrote:
> > >>> -static inline enum uclamp_id uclamp_none(enum uclamp_id clamp_id)
> > >>> +static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
> > >>
> > >> Out of curiosity why uclamp decided to use unsigned int to manipulate
> > >> utilization instead of unsigned long which is the type of util_avg ?
> > >>
> > >
> > > I didn't stare at the discussion much, but I think it stems from the
> > > design choices behind struct uclamp_se: everything is crammed in an unsigned
> > > int bitfield. Let me see if I can find some relevant mails.
> > >
> >
> > So I think a relevant mail is:
> >
> > https://lore.kernel.org/lkml/20180912174236.GB24106@hirez.programming.kicks-ass.net/
> >
> > Other than that, the uclamp_se.value field was 'int' in v1 and has been
> > 'unsigned int' for all following versions. uclamp_bucket.value is a bitfield
> > of an 'unsigned long' just because we want more headroom for the tasks count,
> > AFAICT.
> 
> Thanks for the pointer and deep diving in the email threads

It was all in an effort to minimize the number of cachelines touched to
maintain this data.
