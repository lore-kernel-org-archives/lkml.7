Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52BDC2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 17:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93041206D3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 17:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576861815;
	bh=0nWV2DP8rQY7x4HqApfNuKyW1SsHr1o9BnNWwT2DIjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aF7nVYLr3zmwB+zC6zRuo7Hbkz+gvS0byjwIDUqHNbAxa+NnDIRqknO143GvHJ/+t
	 VX70Wq1LB4m8iRNY3fhfoxL5vluCwylDgOMm0ijuT2gPVlkK7fYSnsHwUw+lURjWi7
	 KBaNE5HwpJaY4e+iHxULGRfv01f7wNaVkawR4JPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfLTRKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:10:14 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:41399 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfLTRKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 12:10:09 -0500
Received: by mail-qt1-f177.google.com with SMTP id k40so8778566qtk.8;
        Fri, 20 Dec 2019 09:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ferOHgTa8+mlLQrIZxEyrkrIqrPKTFyh2LphB/p/Y74=;
        b=Ap0rfrdfbbLbLNGVD/0/6sdxw7QE6ImhrXMatl7LwaEfi8kmACmuENu/+EjXFWhad0
         SyEHb9WaxymkZzKML9Gvm9r7jBw1HjLi6w8CrBmVLVK49Hq9tnvXd1sFi0hWlAnFk5Sq
         OniO8I0UMWWNv0HVOTxbOG7KL7v1Zl/KQDkdx0xhpFGjM+JiC0og1VvAdFIhfdmVTfAK
         o4DQBbwDYgL+Dd2LyKOCnEC9cJPufcceU/oLvKp8tWFycR8wjuWv3S6oWTG4R+kEL7LK
         hK+S3IycE5CIgNFq8lmo2SBSkjB6Q4ZptbAiM9dTXqcLJWx286T5fi4mgZe3+676meyU
         6g7g==
X-Gm-Message-State: APjAAAWuFvohAKWvKyjlfGLPHLhxfdQ9OCC7Z9x92Hs8XZAxVznj4YfU
        ZDwYZNWC4Qj2r/ifOZjC9TQ=
X-Google-Smtp-Source: APXvYqy9wmFFx+y+koK6r++euYWrETDk9FOrHZXQe7LsY/ExxBcxq/00ERtiYrgP1BLTF9s2xAQK7w==
X-Received: by 2002:aed:3fb7:: with SMTP id s52mr12533978qth.311.1576861808329;
        Fri, 20 Dec 2019 09:10:08 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:480::8d30])
        by smtp.gmail.com with ESMTPSA id k14sm2977023qki.66.2019.12.20.09.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 09:10:07 -0800 (PST)
Date:   Fri, 20 Dec 2019 11:10:04 -0600
From:   Dennis Zhou <dennis@kernel.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Percpu variables, benchmarking, and performance weirdness
Message-ID: <20191220171004.GA8596@dennisz-mbp.dhcp.thefacebook.com>
References: <CAJ+HfNgNAzvdBw7gBJTCDQsne-HnWm90H50zNvXBSp4izbwFTA@mail.gmail.com>
 <20191220103420.6f9304ab@carbon>
 <20191220151239.GE2914998@devbig004.ftw2.facebook.com>
 <alpine.DEB.2.21.1912201536120.16819@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1912201536120.16819@www.lameter.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 03:36:51PM +0000, Christopher Lameter wrote:
> On Fri, 20 Dec 2019, Tejun Heo wrote:
> 
> > On Fri, Dec 20, 2019 at 10:34:20AM +0100, Jesper Dangaard Brouer wrote:
> > > > So, my question to the uarch/percpu folks out there: Why are percpu
> > > > accesses (%gs segment register) more expensive than regular global
> > > > variables in this scenario.
> > >
> > > I'm also VERY interested in knowing the answer to above question!?
> > > (Adding LKML to reach more people)
> >
> > No idea.  One difference is that percpu accesses are through vmap area
> > which is mapped using 4k pages while global variable would be accessed
> > through the fault linear mapping.  Maybe you're getting hit by tlb
> > pressure?

bpf_redirect_info is static so that should be accessed via the linear
mapping as well if we're embedding the first chunk.

> 
> And there are some accesses from remote processors to per cpu ares of
> other cpus. If those are in the same cacheline then those will cause
> additional latencies.
> 

I guess we could pad out certain structs like bpf_redirect_info, but
that isn't really ideal.
