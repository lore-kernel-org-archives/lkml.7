Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D19C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15998217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfGZHni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 03:43:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48345 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfGZHni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:43:38 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hqusy-0004Ot-9i; Fri, 26 Jul 2019 09:43:28 +0200
Date:   Fri, 26 Jul 2019 09:43:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     John Hubbard <jhubbard@nvidia.com>
cc:     "H. Peter Anvin" <hpa@zytor.com>, john.hubbard@gmail.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] x86/boot: clear some fields explicitly
In-Reply-To: <ffd7a9b6-8017-2d2c-c4f7-65563094ccd0@nvidia.com>
Message-ID: <alpine.DEB.2.21.1907260923370.1791@nanos.tec.linutronix.de>
References: <20190724231528.32381-1-jhubbard@nvidia.com> <20190724231528.32381-2-jhubbard@nvidia.com> <B7DC31CA-E378-445A-A937-1B99490C77B4@zytor.com> <alpine.DEB.2.21.1907250848050.1791@nanos.tec.linutronix.de> <345add60-de4a-73b1-0445-127738c268b4@nvidia.com>
 <alpine.DEB.2.21.1907252343180.1791@nanos.tec.linutronix.de> <3DFA2707-89A6-4DD2-8DFB-0C2D1ABA1B3C@zytor.com> <alpine.DEB.2.21.1907252358240.1791@nanos.tec.linutronix.de> <e080b061-562f-568f-782d-b014556acdba@zytor.com>
 <ffd7a9b6-8017-2d2c-c4f7-65563094ccd0@nvidia.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2019, John Hubbard wrote:
> On 7/25/19 3:28 PM, H. Peter Anvin wrote:
> > On 7/25/19 3:03 PM, Thomas Gleixner wrote:
> >> On Thu, 25 Jul 2019, hpa@zytor.com wrote:
> >>> On July 25, 2019 2:48:30 PM PDT, Thomas Gleixner <tglx@linutronix.de> wrote:
> >>>>
> >>>> But seriously I think it's not completely insane what they are doing
> >>>> and the table based approach is definitely more readable and maintainable
> >>>> than the existing stuff.
> >>>
> >>> Doing this table based does seem like a good idea.
> >>
> >> The question is whether we use a 'toclear' table or a 'preserve' table. I'd
> >> argue that the 'preserve' approach is saner.
> >>
> > 
> > I agree.
> > 
> 
> OK, I can polish up something and post it, if you can help me with one more
> quick question: how did you want "to preserve" to work?
> 
> a) copy out fields to preserve, memset the area to zero, copy back preserved
> fields? This seems like it would have the same gcc warnings as we have now,
> due to the requirement to memset a range of a struct... 

Use the same trick I used for the toclear variant.

#define PRESERVE(m)			\
	{				\
		.start = offsetof(m),	\
		.len   = sizeof(m),	\
	}

sanitize_boot_params(bp, scratch)
{
	char *p1 = bp, *p2 = scratch;

	preserve[] = {
		PRESERVE(member1),
		...
		PRESERVE(memberN),
	};

	for_each_preserve(pr)
		memcpy(p2 + pr->start, p1 + pr->start, pr->len)
	memcpy(bp, scratch, ...);
}


Thanks,

	tglx
