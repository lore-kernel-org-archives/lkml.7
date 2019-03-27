Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6EAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8839E206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6Zs5WVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbfC0PPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:15:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40784 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbfC0PPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:15:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id b11so3457091plr.7;
        Wed, 27 Mar 2019 08:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b3+1IHopH84D/nrpmyaF02B+wdE/nIwmLo+NmobSkq8=;
        b=D6Zs5WVmJMSNO0hy+zAx7r4sycG76HBywte/wfDNwG+Vg33oOMaZcx/mYPLKMB4NxO
         XQpT5dJBvlztrtwoXfI9Psz8KaSJMX9NaqT2GhsEpjleyzA3IvLHaI/J2NTCtps3Aju9
         jvCAEiuwD2kNT8+SVRA8v7RZB2fjl6fijMt3Yjl0LW4GJQa/6ZFSKFq9nkOGJ1la4dYa
         BgK8O2xOZYZXtYfU0j2CzAfzPvT8XLSQCuXz9894UbzatAQncMie+nbBl3t5ZevQl8iJ
         DbnBrGQRA9nUKei2Kfxk8QxdhGrzkDYj/6yOC1XX393wvuAOmey4QUFCNyqugCe0bL+k
         wstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b3+1IHopH84D/nrpmyaF02B+wdE/nIwmLo+NmobSkq8=;
        b=DStU1xxw7WTFg6u7He9MsHRndbX3A0ewiw8BqD0gkrcplhnndFlkMqCpT1iLm8tNXC
         yL8tUBnnOtn3eesn69QWE2jubodM2So2llsAFVsgjqp0Pcm+CcYVq8LdwKoO8EUYptU0
         3P9tjYPF/eGpb+eozzDz0dkUeLhlpmDPbZ43vtqagPWfL0W06RzZBSZOOk0KYoLGXjKg
         9H2i0zXAaTnPcrpESClvHesvtWIZz2twCud3p5lzPDF9TSoZl67vICUYUnX9BGrKuuZ1
         HNk0L/isLh8hMAGk7IHUZ75zw1EUis34tind+Gd1ynlJxu5J4aznlFfno9+MVQqqKLvd
         CpFg==
X-Gm-Message-State: APjAAAXPiFbO0S8XsdYl8ge2Dhn1gCDHKjZWgW8Q3YYZay75ju+IJTZx
        Zwz8QAhyDQSo40pg1XGsdl4=
X-Google-Smtp-Source: APXvYqxnx8gTx/W7ZYd0mBsiadwg5eMhF24yZ+BKwc3TbYSzt7AWJsIvoiIn03U4JUkci7I5riiUBQ==
X-Received: by 2002:a17:902:8ec1:: with SMTP id x1mr25873648plo.328.1553699709074;
        Wed, 27 Mar 2019 08:15:09 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::ca40])
        by smtp.gmail.com with ESMTPSA id u17sm3126733pfn.19.2019.03.27.08.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 08:15:08 -0700 (PDT)
Date:   Wed, 27 Mar 2019 08:15:05 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Luca Boccassi <bluca@debian.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the net tree
Message-ID: <20190327151503.5pdaqiwb7ugm3ly4@ast-mbp>
References: <20190327091437.68ec6903@canb.auug.org.au>
 <20190327015623.ur46t5gdmraagi2q@ast-mbp>
 <df699947253913a7e572fd1252b99e594431e261.camel@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df699947253913a7e572fd1252b99e594431e261.camel@debian.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 09:26:02AM +0000, Luca Boccassi wrote:
> On Tue, 2019-03-26 at 18:56 -0700, Alexei Starovoitov wrote:
> > On Wed, Mar 27, 2019 at 09:14:37AM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Today's linux-next merge of the bpf-next tree got a conflict in:
> > > 
> > >   tools/lib/bpf/Makefile
> > > 
> > > between commit:
> > > 
> > >   1d382264d911 ("bpf, libbpf: fix version info and add it to shared
> > > object")
> > > 
> > > from the net tree and commit:
> > > 
> > >   60e4786e229d ("tools/bpf: generate pkg-config file for libbpf")
> > > 
> > > from the bpf-next tree.
> > > 
> > > I fixed it up (see below) and can carry the fix as necessary. This
> > > is now fixed as far as linux-next is concerned, but any non trivial
> > > conflicts should be mentioned to your upstream maintainer when your
> > > tree
> > > is submitted for merging.  You may also want to consider
> > > cooperating
> > > with the maintainer of the conflicting tree to minimise any
> > > particularly
> > > complex conflicts.
> > 
> > argh. that's a heavy conflict.
> > Since that patch was at the top of the bpf-next I removed it for now
> > and will re-apply when bpf-next gets merged cleanly into net-next and
> > we bring back net changes into bpf-next. Sorry Luca.
> 
> No worries - for the next time, should I have based the patch on net-
> next rather than bpf-next?

new bpf related features -> bpf-next tree
bpf bugfixes -> bpf tree

Linus hasn't pulled Dave's PR yet: https://patchwork.ozlabs.org/patch/1066321/
We need these fixes to land his tree first,
then get propagated into net-next and then bpf-next will get them as well.
Sorry for this unfortunate delay.
This lib/bpf/Makefile conflict is not the only one we're waiting for.
There are verifier and other libbpf fixes in there.

