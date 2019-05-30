Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6895BC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3C025BC9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfE3OyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:54:07 -0400
Received: from ms.lwn.net ([45.79.88.28]:57006 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfE3OyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:54:05 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5DD576D9;
        Thu, 30 May 2019 14:54:05 +0000 (UTC)
Date:   Thu, 30 May 2019 08:54:04 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] docs: by default, build docs a lot faster with
 Sphinx >= 1.7
Message-ID: <20190530085404.54973d02@lwn.net>
In-Reply-To: <20190529225305.213d8c36@coco.lan>
References: <cover.1558955082.git.mchehab+samsung@kernel.org>
        <baf19095789f2b2ed0c7a940703037a00cd77850.1558955082.git.mchehab+samsung@kernel.org>
        <20190529170202.65c7f9ca@lwn.net>
        <20190529202005.04dcd4a0@coco.lan>
        <20190529174716.4f0e21ad@lwn.net>
        <20190529225305.213d8c36@coco.lan>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 22:53:05 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> > Yup.  The point is that I see the sphinx-build output *in the docs-build
> > output", not when I run it standalone (where it does the expected thing).  
> 
> Weird... could some versions of Sphinx be redirecting the output of
> --version to stderr instead of stdout?
> 
> If so, something like:
> 
> 	perl -e 'open IN,"sphinx-build --version 2>&1 |"; while (<IN>) { if (m/([\d\.]+)/) { print "-jauto\n" if ($1 >= "1.7") } ;} close IN'
> 
> would make it print "-jauto" with those other versions you're trying.

That does improve the behavior from the command line; it seems that
sphinx-build is indeed writing to stderr.  BUT that still doesn't fix the
docs build!  To get the option to take effect, I also have to explicitly
export SPHINXOPTS.  So the winning combination is:

  export SPHINXOPTS = $(shell perl -e 'open IN,"sphinx-build --version
  2>&1 |"; while (<IN>) { if (m/([\d\.]+)/) { print "-jauto" if ($$1 >= "1.7") } ;} close IN')

I don't have any weird version of make, so I'm not sure why you see
different results than I do here.

I can apply those tweaks to your patch if it's OK with you.

> I didn't try the python2 versions, though.

Interestingly, I would appear to have both versions installed, with
python2 winning in $PATH.

jon
