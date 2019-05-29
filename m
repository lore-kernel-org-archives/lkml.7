Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAE4C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A32024315
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559172014;
	bh=BEBELwXfQYhjtWaio7ViiW8ZsVmTLumZzieRffAOy44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=husWzVVXHVggXKQnhKBgAgujTaQt+38Y8LicLv7ksf8Go1DqjlCr9D//X5EuJWAI1
	 aK1wyMYlhP9BiCVhcnML/w/2VWcrYctq85/uK5J3LFnFcoVsZgn64Gb8mXl819RcD6
	 adUAcvK7sieimJzwN2LvTQUfphEZJQtJTJ3dkVfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfE2XUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:20:12 -0400
Received: from casper.infradead.org ([85.118.1.10]:38662 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfE2XUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HxAos5nfvGsI/xjg+zDGTU3seNu/Mutb6DCGcKjvXw8=; b=L/HjP6UGpJkvCYRqZTyA1WFFKR
        WxnIrcPjYcS5QRbPWQD9qI7L8w/f17R4osvGmBYeMmT1GYAi4Dfytxp2sxncOp9RKOwxAXcIuVTLH
        HaMQGsPRBYBqEVD+amoV3g3gJKEIxzzPM6hpWUYmibTFMPohDjnAPdgtHUgIdrMF/nTl1imZGWkEn
        +dlFFOaxRz7p2OQL7nWafEBzYG+WB+O4bUwbOqcqrL75JQqARBsAMAhqQcwsgqfgVSoUvECaVR42B
        3mqMmg6Hgtjj65Fps7/+8J897Lh7cIDqt9opaFmKTP7BjNWvAckmPN/lr1V/4Aya24GszmI4Ps8U+
        9jKdW0Kg==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7rd-0004DZ-JC; Wed, 29 May 2019 23:20:09 +0000
Date:   Wed, 29 May 2019 20:20:05 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] docs: by default, build docs a lot faster with
 Sphinx >= 1.7
Message-ID: <20190529202005.04dcd4a0@coco.lan>
In-Reply-To: <20190529170202.65c7f9ca@lwn.net>
References: <cover.1558955082.git.mchehab+samsung@kernel.org>
        <baf19095789f2b2ed0c7a940703037a00cd77850.1558955082.git.mchehab+samsung@kernel.org>
        <20190529170202.65c7f9ca@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 29 May 2019 17:02:02 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Mon, 27 May 2019 08:07:40 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > Since Sphinx version 1.7, it is possible to use "-jauto" in
> > order to speedup documentation builds. On older versions,
> > while -j was already supported, one would need to set the
> > number of threads manually.
> > 
> > So, if SPHINXOPTS is not provided, add -jauto, in order to
> > speed up the build. That makes it *a lot* times faster than
> > without -j.
> > 
> > If one really wants to slow things down, it can just use:
> > 
> > 	make SPHINXOPTS=-j1 htmldocs
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  Documentation/Makefile | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index 380e24053d6f..794233d05789 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -28,6 +28,8 @@ ifeq ($(HAVE_SPHINX),0)
> >  
> >  else # HAVE_SPHINX
> >  
> > +SPHINXOPTS = $(shell perl -e 'open IN,"sphinx-build --version |"; while (<IN>) { if (m/([\d\.]+)/) { print "-jauto" if ($$1 >= "1.7") } ;} close IN')
> > +  
> 
> So this totally fails to work for me with any version of sphinx, and I'm
> not enough of a Perl person to figure it out.  Sometimes I'll see the
> sphinx-build output, i.e.:
> 
>     sphinx-build 1.8.4
> 
> and sometimes (like with 2.0) I don't, but I never get -jauto regardless.

Hmm... with 2.0.0 --version prints the version.

	$ sphinx-build --version
	sphinx-build 2.0.0

Afaikt, only too old versions will output it with a different format:


	$ sphinx-build --version
	Sphinx (sphinx-build) 1.2


> Not sure what's going on here?

Do you have SPHINXOPTS already set on your environment? If so, Makefile
will not override the existing environment.

Here, if I call it by hand (replacing $$1 by $1), it does the right
thing. For example:

1.8.4:

	$ sphinx-build --version
	sphinx-build 1.8.4
	$ perl -e 'open IN,"sphinx-build --version |"; while (<IN>) { if (m/([\d\.]+)/) { print "-jauto\n" if ($1 >= "1.7") } ;} close IN'
	-jauto

2.0.0:
	$ sphinx-build --version
	sphinx-build 2.0.0
	(sphinx_2.0) $ perl -e 'open IN,"sphinx-build --version |"; while (<IN>) { if (m/([\d\.]+)/) { print "-jauto\n" if ($1 >= "1.7") } ;} close IN'
-jauto


Thanks,
Mauro
