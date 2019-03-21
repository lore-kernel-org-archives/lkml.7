Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E36C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA562183E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="VZvUY+FB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfCUTyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 15:54:00 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55821 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbfCUTyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 15:54:00 -0400
Received: by mail-it1-f194.google.com with SMTP id z126so138460itd.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 12:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HHmgyQRTSr/2HAXftSSrPXR4GZxQAU7Xv8gC9oYm7W4=;
        b=VZvUY+FBXp1BHAnN8dOQarLWEpxFx3eTAQDAqjS/VOW5XSsdJXTdx7yYDGMXoY4yPG
         HXomjV5WmOtkDS+XFEYeGXZLos4xjCK3sZP7/LKEiTqLlyoQdRGLjKco6/cqJBtI6tA2
         ryXejFBaMS4qODWyrX5ADEJd363cmEco4VxH4hBL7toC6SeYY0dDuy0PNuqkb5U5f3UM
         1nwnyYEmaL35gTgYp339L8BSoailIYDRUtIk9t1HzpoU7qdKDyyzTPZOQFKSx/Tj5c2L
         xtnlDN1ggr6riojdnEVUZoyzNP5jgcbg877jpRxTCNMs3ajb/gKaqkCSR+RR1qt41gEG
         4nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HHmgyQRTSr/2HAXftSSrPXR4GZxQAU7Xv8gC9oYm7W4=;
        b=imoSD3Es2oO/ye90WoSvKuU2qpwqMIiSAlb5k2JFVNeS6J2UoHu1dMBWIEvkF8QX2M
         O4mrWgsKfO5tuW+kq2LiH+kB0A4nmLWmdukqjLJwztp58xqoF+HsCRRunyMG+2v+BHWy
         JYiCrMYQ/q0H7H8WOURzAbCPCDmc7muevsCCdxQwYgUe7OwGcni8B4yDbKoRouccC0tS
         5u4UF+WiAuedVZx6NQtr6Laq7Q3webf9ahRQ4Jpwh0B1jNCt93teqS/xoKqEbq7opR61
         yYT3lx/SX5Vb39g2MocPGJEfIn3YH8t3AUSWk1NNmmd38f7+opC5hQnDZ5EXvlmBWkS+
         +QpA==
X-Gm-Message-State: APjAAAWYppsFFIEXP7lA5keAG1UVWuqgLXbt1AqGavteBYqsJsc08W0v
        nefiuaArjqBtKgFpHbl/ehsgQyyinK+Sslds9YlT0M/8YW8=
X-Google-Smtp-Source: APXvYqw15hj+tynXs0MKmFflXr37df9UvTjSOP/PjyHHNeGLU4ifdwGw85OhRM6mXEFhultZ9vG8GL/Z5oqB6HwpHfE=
X-Received: by 2002:a02:1b54:: with SMTP id l81mr4126508jad.87.1553198039276;
 Thu, 21 Mar 2019 12:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190321075818.24f9703a@canb.auug.org.au> <8a8ce003-c151-d04b-3ac9-8823a6c8ff7b@deltatee.com>
In-Reply-To: <8a8ce003-c151-d04b-3ac9-8823a6c8ff7b@deltatee.com>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Thu, 21 Mar 2019 15:53:47 -0400
Message-ID: <CAPoiz9x9aWMzV3K-UhBz52AXdVpDbCQnLTeM7=nt5tAFL2RPBQ@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the ntb tree
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        NTB Mailing List <linux-ntb@googlegroups.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 5:00 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2019-03-20 2:58 p.m., Stephen Rothwell wrote:
> > Hi all,
> >
> > In commit
> >
> >   f4d0dd1064b8 ("NTB: ntb_transport: Ensure qp->tx_mw_dma_addr is initaliazed")
> >
> > Fixes tag
> >
> >   Fixes: c27ccb899219 ("NTB: ntb_transport: Ensure the destination buffer is mapped for TX DMA")
> >
> > has these problem(s):
> >
> >   - Target SHA1 does not exist
> >
> > Did you mean:
> >
> >   c59666bb32b9 ("NTB: ntb_transport: Ensure the destination buffer is mapped for TX DMA")
>
> My fault. I sent the fix patch with the fixes tag before the original
> patch was merged upstream expecting them to be squashed. c59666bb32b9 is
> the correct hash in upstream now.

I've corrected the patch in my git branches and repushed.

Is there an existing set of tools/scripts I should run to prevent
things like this from happening?

Thanks,
Jon

>
> Logan
>
