Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C8EC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CC224387
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfE2XrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:47:18 -0400
Received: from ms.lwn.net ([45.79.88.28]:44142 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbfE2XrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:47:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0A0CD6D9;
        Wed, 29 May 2019 23:47:17 +0000 (UTC)
Date:   Wed, 29 May 2019 17:47:16 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] docs: by default, build docs a lot faster with
 Sphinx >= 1.7
Message-ID: <20190529174716.4f0e21ad@lwn.net>
In-Reply-To: <20190529202005.04dcd4a0@coco.lan>
References: <cover.1558955082.git.mchehab+samsung@kernel.org>
        <baf19095789f2b2ed0c7a940703037a00cd77850.1558955082.git.mchehab+samsung@kernel.org>
        <20190529170202.65c7f9ca@lwn.net>
        <20190529202005.04dcd4a0@coco.lan>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 20:20:05 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> > So this totally fails to work for me with any version of sphinx, and I'm
> > not enough of a Perl person to figure it out.  Sometimes I'll see the
> > sphinx-build output, i.e.:
> > 
> >     sphinx-build 1.8.4
> > 
> > and sometimes (like with 2.0) I don't, but I never get -jauto regardless.  
> 
> Hmm... with 2.0.0 --version prints the version.
> 
> 	$ sphinx-build --version
> 	sphinx-build 2.0.0

Yup.  The point is that I see the sphinx-build output *in the docs-build
output", not when I run it standalone (where it does the expected thing). 

> > Not sure what's going on here?  
> 
> Do you have SPHINXOPTS already set on your environment? If so, Makefile
> will not override the existing environment.

Yeah, I had it set to -j1 because I want to wait as long as possible for my
docs builds :)

No, I didn't have it set separately, made a point of that.

> Here, if I call it by hand (replacing $$1 by $1), it does the right
> thing. For example:
> 
> 1.8.4:
> 
> 	$ sphinx-build --version
> 	sphinx-build 1.8.4
> 	$ perl -e 'open IN,"sphinx-build --version |"; while (<IN>) { if (m/([\d\.]+)/) { print "-jauto\n" if ($1 >= "1.7") } ;} close IN'
> 	-jauto

$ perl -e 'open IN,"sphinx-build --version |"; while (<IN>) { if (m/([\d\.]+)/) { print "-jauto\n" if ($1 >= "1.7") } ;} close IN'
sphinx-build 1.8.4
$

It works properly with 2.0.1 - but only on the command line; I still don't
get the right behavior in a docs build.

Most weird.

This is an Fedora 30 system, FWIW.

jon
