Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AD3C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C6620872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555419290;
	bh=tBz4qqTz9PQ/H6dWlOMBzyFYTI3ugAxa00FsDjnuN8o=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=RWvEVVx4fp33o5L77kYVNh9oVA3Ag2bme+4TRLoR5SM6ssTRX0B748Xc/pb5TA6UQ
	 AXhIJD2LiJOka+WF9ysXtIYvAjQhxWQw9sl3A3IXbsQ2agF+0WiT5f1+9N56oziS/3
	 IAicQ8ghYJR1C6cglmQP1nPcZFDABcR2lGzb/U3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfDPMyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbfDPMys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:54:48 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A176205ED;
        Tue, 16 Apr 2019 12:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555419287;
        bh=tBz4qqTz9PQ/H6dWlOMBzyFYTI3ugAxa00FsDjnuN8o=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=YyiyejyCIq69cV1LSFMOdIGoyRAUu55+ljOtwg0QDUgfF2BpgCHcrlD5m5/JeX7u9
         g4rSekO30RMZXJ05VRz9VZiz3rrLOCZxcpZdmu8b7o2FogrW/7K1NpjwGhIqU4vnzA
         8p+23l/XAGTJf4PVmRu9Rvqvnud5zZ3ZExVMRmcA=
Date:   Tue, 16 Apr 2019 14:54:44 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH] livepatch: Enforce reliable stack trace as config
 dependency
In-Reply-To: <nycvar.YFH.7.76.1904161345560.9803@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1904161453550.9803@cbobk.fhfr.pm>
References: <20190209091728.23046-1-kamalesh@linux.vnet.ibm.com> <20190211140813.z7kap634gz3gp6a4@treble> <20190212094608.bzwc26j67daqnx6x@pathway.suse.cz> <nycvar.YFH.7.76.1904161345560.9803@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019, Jiri Kosina wrote:

> > Do you mean to convert the error into warning?
> > 
> > For example, the change below. Note that I did not mention
> > the possibility to force the transition by intention. It is risky
> > and people should not get used to it.
> > 
> > Heh, I think that this was the main reason why it was the error.
> > We did not want to get people used to forcing livepatches.
> > 
> > 
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index d1af69e9f0e3..8d9bce251516 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -1035,11 +1035,10 @@ int klp_enable_patch(struct klp_patch *patch)
> >  		return -ENODEV;
> >  
> >  	if (!klp_have_reliable_stack()) {
> > -		pr_err("This architecture doesn't have support for the livepatch consistency model.\n");
> > -		return -EOPNOTSUPP;
> > +		pr_warn("This architecture doesn't have support for the livepatch consistency model.\n");
> > +		pr_warn("Only one livepatch can be installed.\n");
> >  	}
> >  
> > -
> 
> This seems to have been lost.
> 
> I think we should take this aproach before Miroslav is ready with 
> realiable stack traces for s390. At the same time, I'd suggest issuing a 
> proper WARN() there instead of just pr_warn(). The kernel might be in a 
> potentially funky state, so let's at least get the 'W' taint in place.

Ignore the above, there is nothing wrong with the kernel unless the patch 
is forced.

So we should be good taking it as-is. Petr, could you please send it with 
proper changelog and signoff? Thanks,

-- 
Jiri Kosina
SUSE Labs

