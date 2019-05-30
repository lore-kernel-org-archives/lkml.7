Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1482DC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6AE25C40
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559228913;
	bh=K8S1o3hok0TErQKmCVyPVIBGjzoc1w8mVdKqqRTbs4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Eq/M5YohWXMekZk72NkCQ/NM4lh0YI4nai78ME4nMr5fvhnmK4gMcI0YaHubj7Tq9
	 A7PxhBNQmuMczwrSzoVDdDiPqVkfUUWgABLTMiw6UFxepk7+Qj+n8A5tNZWT4lK6Z8
	 7qxHUKuSHKKF+Mba9OnLTVTgXlreyU+5xvQrlXrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfE3PId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:08:33 -0400
Received: from casper.infradead.org ([85.118.1.10]:43944 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfE3PIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1+pzj3s0zzfo7hTFiNb297cHY2u6PGyfMetnDFPkAiU=; b=Ru3PJ70jwGsXP69VmpOtylbB6j
        CAyjE5jRFU4OiGcPm+xCn1w/6OZ7lhUvoRQYqZZjOoCCkekUZSc93AG3CAgFaXgoHgTNWVvIssA9K
        UU7/wg5dCYzwMxJBEH+DYtGFbpPJe/9c//H4T4U+t38z9yRdQq1bh2fGrZ7Ut3hKHbC8OP3ZFCGd6
        PMAGEslsSPz+faXcnAaccOCwpyy6sLXQrL+X4pQOKVCX74xp9+l6nWN+MOvkSywEQOrGu4twJKcg3
        fsZO2t5pGAi9ryOrTLSBTAfrdOmtHIoegB5GrymF9oHFKRMxfi6H8g/gZpZ6a6Vbb6iGEWJI5+ckc
        E4OnCiQw==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWMfN-0000UD-69; Thu, 30 May 2019 15:08:29 +0000
Date:   Thu, 30 May 2019 12:08:24 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] docs: by default, build docs a lot faster with
 Sphinx >= 1.7
Message-ID: <20190530120824.6bc5594c@coco.lan>
In-Reply-To: <20190530085404.54973d02@lwn.net>
References: <cover.1558955082.git.mchehab+samsung@kernel.org>
        <baf19095789f2b2ed0c7a940703037a00cd77850.1558955082.git.mchehab+samsung@kernel.org>
        <20190529170202.65c7f9ca@lwn.net>
        <20190529202005.04dcd4a0@coco.lan>
        <20190529174716.4f0e21ad@lwn.net>
        <20190529225305.213d8c36@coco.lan>
        <20190530085404.54973d02@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 30 May 2019 08:54:04 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Wed, 29 May 2019 22:53:05 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > > Yup.  The point is that I see the sphinx-build output *in the docs-build
> > > output", not when I run it standalone (where it does the expected thing).    
> > 
> > Weird... could some versions of Sphinx be redirecting the output of
> > --version to stderr instead of stdout?
> > 
> > If so, something like:
> > 
> > 	perl -e 'open IN,"sphinx-build --version 2>&1 |"; while (<IN>) { if (m/([\d\.]+)/) { print "-jauto\n" if ($1 >= "1.7") } ;} close IN'
> > 
> > would make it print "-jauto" with those other versions you're trying.  
> 
> That does improve the behavior from the command line; it seems that
> sphinx-build is indeed writing to stderr.  BUT that still doesn't fix the
> docs build!  To get the option to take effect, I also have to explicitly
> export SPHINXOPTS.  So the winning combination is:
> 
>   export SPHINXOPTS = $(shell perl -e 'open IN,"sphinx-build --version
>   2>&1 |"; while (<IN>) { if (m/([\d\.]+)/) { print "-jauto" if ($$1 >= "1.7") } ;} close IN')  
> 
> I don't have any weird version of make, so I'm not sure why you see
> different results than I do here.
> 
> I can apply those tweaks to your patch if it's OK with you.

Yeah, sure! With those changes it work fine here too.

So, feel free to apply the changes.

> 
> > I didn't try the python2 versions, though.  
> 
> Interestingly, I would appear to have both versions installed, with
> python2 winning in $PATH.

It sounds that Fedora 30 is conservative with regards to python :-)

The Sphinx version detection script takes it into account,
suggesting pip3 instead of pip - or when called like:

	$ ./scripts/sphinx-pre-install --no-virtualenv
	Detected OS: Fedora release 30 (Thirty).

	ERROR: please install "python-sphinx", otherwise, build won't work.
	Warning: better to also install "sphinx_rtd_theme".
	You should run:

		sudo dnf install -y python3-sphinx python3-sphinx_rtd_theme

It seeks for the python3 packages on Fedora.

Regards,
Mauro
