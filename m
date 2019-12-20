Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6242C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BD8222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfLTPgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 10:36:52 -0500
Received: from gentwo.org ([3.19.106.255]:47830 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727384AbfLTPgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 10:36:51 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 22ECC3F872; Fri, 20 Dec 2019 15:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 222233EBB9;
        Fri, 20 Dec 2019 15:36:51 +0000 (UTC)
Date:   Fri, 20 Dec 2019 15:36:51 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Tejun Heo <tj@kernel.org>
cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        =?ISO-8859-15?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Dennis Zhou <dennis@kernel.org>
Subject: Re: Percpu variables, benchmarking, and performance weirdness
In-Reply-To: <20191220151239.GE2914998@devbig004.ftw2.facebook.com>
Message-ID: <alpine.DEB.2.21.1912201536120.16819@www.lameter.com>
References: <CAJ+HfNgNAzvdBw7gBJTCDQsne-HnWm90H50zNvXBSp4izbwFTA@mail.gmail.com> <20191220103420.6f9304ab@carbon> <20191220151239.GE2914998@devbig004.ftw2.facebook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2019, Tejun Heo wrote:

> On Fri, Dec 20, 2019 at 10:34:20AM +0100, Jesper Dangaard Brouer wrote:
> > > So, my question to the uarch/percpu folks out there: Why are percpu
> > > accesses (%gs segment register) more expensive than regular global
> > > variables in this scenario.
> >
> > I'm also VERY interested in knowing the answer to above question!?
> > (Adding LKML to reach more people)
>
> No idea.  One difference is that percpu accesses are through vmap area
> which is mapped using 4k pages while global variable would be accessed
> through the fault linear mapping.  Maybe you're getting hit by tlb
> pressure?

And there are some accesses from remote processors to per cpu ares of
other cpus. If those are in the same cacheline then those will cause
additional latencies.

