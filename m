Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E79C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 02:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA3D206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 02:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/ux8PzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfD0CoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 22:44:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34840 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfD0CoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 22:44:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id h1so2456983pgs.2;
        Fri, 26 Apr 2019 19:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zg0LYhE0P4OXkrauK+ke+LuLcD0+75WxFT63U7jCmBA=;
        b=J/ux8PzFunc2E3LnpYq92iZIJXjEZvOlhXoRx40ua6hgXfExy7TmTOsuLuyhNV9zdn
         F3wbZGguZZCfRzZ3snXGA7dQkEc8aSyUl4nxGxu9PRkM3rP3vlwJFcDksXmN13Ui/9+B
         SbGeNmla285F6CxH6hxEmL0Wo4PEyiS2EEVjAks7A26mn0DPWP214X98Jj+GVowDMQzi
         vmjxqSa3Cp8iFu5iOa4XWPUsDvLwjcjssdEr8trNtl/9gKY+a565/+Evi2zELTeP6ctD
         S92/LR+f7kfZlDRnGOrkO5UcuWbFmrxVkNduDdZEqzSRs8Wx2khS6nBo8GySAJolfIwq
         Q0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zg0LYhE0P4OXkrauK+ke+LuLcD0+75WxFT63U7jCmBA=;
        b=Ls7w9A2Acg36eBhMGpZ3/iNDMX8+GNk+9uffyQgfgBkAf5f05FgaTw2mVzOf55p3NO
         T4/TKteBz2fbdxTNaih7prrQwRT65UDcGQQRjAA/435TPOP7HAzS/y42DlyapKnDzNqH
         uEVf6jDqwUSgUVfwmeMMkdWzgOdKjgh2zH4c9dbnl75ywbdXwQRqRkvD5MCCgd+x32y8
         oIm0zqEpjcAs8NBhltj06cIwfEdjp14LzTfrlUcH0C+JpCgfNjXzzTPCNPbjaRSQFHS+
         eMDmNsmAN2SAesx1NqxSAiKBQdhRfDZa3chF58rVbNZX93hPxx4NUsfiTS2yelses+sT
         pgDQ==
X-Gm-Message-State: APjAAAX5j1RNsBPtIzh29cPvRrPMlhr5jQ753SPH16gtm6JtNhb2BlOo
        mL1tpYaygT3bmOMaU1RF5gQ=
X-Google-Smtp-Source: APXvYqwsl1KxnSp6Ve16GzLS7g+20cGpHYhU1z1XYLC309QH2Gn/1mZkCazPZM2czvgqmMoHIwPaDQ==
X-Received: by 2002:a63:750c:: with SMTP id q12mr47242799pgc.133.1556333043650;
        Fri, 26 Apr 2019 19:44:03 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id k5sm20486930pgi.58.2019.04.26.19.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 19:44:02 -0700 (PDT)
Date:   Sat, 27 Apr 2019 10:43:56 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org
Subject: Re: [PATCH 01/27] Documentation: add Linux x86 docs to Sphinx TOC
 tree
Message-ID: <20190427024355.5wmydcl5dsv4vr3x@mail.google.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
 <20190426153150.21228-2-changbin.du@gmail.com>
 <20190426161640.GH4608@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426161640.GH4608@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 06:16:40PM +0200, Borislav Petkov wrote:
> On Fri, Apr 26, 2019 at 11:31:24PM +0800, Changbin Du wrote:
> > Add a index.rst for x86 support. More docs will be added later.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  Documentation/index.rst     | 1 +
> >  Documentation/x86/index.rst | 9 +++++++++
> >  2 files changed, 10 insertions(+)
> >  create mode 100644 Documentation/x86/index.rst
> > 
> > diff --git a/Documentation/index.rst b/Documentation/index.rst
> > index 80a421cb935e..d65dd4934a1a 100644
> > --- a/Documentation/index.rst
> > +++ b/Documentation/index.rst
> > @@ -101,6 +101,7 @@ implementation.
> >  .. toctree::
> >     :maxdepth: 2
> >  
> > +   x86/index
> >     sh/index
> >  
> >  Filesystem Documentation
> > diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> > new file mode 100644
> > index 000000000000..7612d3142b2a
> > --- /dev/null
> > +++ b/Documentation/x86/index.rst
> > @@ -0,0 +1,9 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=================
> > +Linux x86 Support
> 
> x86-specific Documentation
>
sure.

> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.

-- 
Cheers,
Changbin Du
