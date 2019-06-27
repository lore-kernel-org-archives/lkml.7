Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81803C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486A32147A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ELLVpV9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfF0Nov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 09:44:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50412 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfF0Nov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 09:44:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id c66so5803121wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 06:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bVQftFEeU6e/9RXFCEZbl6jNZ5OfdlHXeUPnCUtGpQo=;
        b=ELLVpV9QPMrlwu5Z+qXRKYNI924m8/qMUmSzi9+xccUsl6X9FWMmjky1VnjLiOlEMN
         XJZ3tsoK24PkUf4+1lUw9C4caEFZUNsK2L328gBPFonibboiuIUG4v2MyK+SNvaoAWNl
         a7zOW2OUIgCQGQUJh0dBjV3QvNGDYR8skKV1SBVsrDIw4FIz+D3Zygo5+p3ejErtFSml
         CTStHy3v05iNrwUT4X70fXPCwtNZ+2r3a5AFUvZ8YciGCPR/u7Sv0XGELjLKyzk7xSoP
         VI4kS/vr++8AWfIVrYELRsnqqZ8Kl3yd4cFyAri7/TC5ArKkygeJdZB2CiY2uVFh31JI
         j7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bVQftFEeU6e/9RXFCEZbl6jNZ5OfdlHXeUPnCUtGpQo=;
        b=dnFS4PHAeI37sJAEIm55gXfqT3AImWZ8XOq4u9LlhRNF2A7Gc01TsO98P/o5GCTcKg
         hDctot9nvhIorTJ2kkRJoE5i0+CfEMAZ5lSmkRyoCKbqoRr8AIGzII5sW1N6sKctwd51
         vEmP8IhlDyhIlkC7po/YaBAg3+50d46rXWEEXYW720JbHmL+LrLl4kYRsXiO96CcMKX5
         7m6oFv52UXj1tiN9rUWlWH8mZFSKACNdOE0Z6wyqqIA1Z/Kv9cnlZ3wsDahZFhrxiPM6
         JHqZPWVxGoMqlQkJTfWFwUOJmbs1ojmb+yFd+tH+24S8c8H+TeAUqA5EO4wXpGu6IXDt
         lt/g==
X-Gm-Message-State: APjAAAXamReETQIqcgE/Eyf4JLsimuLW+/oUNq5ATRjEOa2gMvqhqGPr
        hijwn4BFx0rkd0Tp2XcLeUAWz7KTRso=
X-Google-Smtp-Source: APXvYqz2RJVi7O+LB2r6oya827nW/k5HhsIXsNtRy5G73pEatPWLjLDRipP9CEk7bXdu8Rp3GBgAiw==
X-Received: by 2002:a05:600c:230c:: with SMTP id 12mr3224249wmo.166.1561643088812;
        Thu, 27 Jun 2019 06:44:48 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id 5sm4732843wmg.42.2019.06.27.06.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 06:44:48 -0700 (PDT)
Date:   Thu, 27 Jun 2019 14:44:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mfd: Add support for Merrifield Basin Cove PMIC
Message-ID: <20190627134446.GD2000@dell>
References: <20190612101945.55065-1-andriy.shevchenko@linux.intel.com>
 <20190624161348.GB21119@dell>
 <20190626092601.GH9224@smile.fi.intel.com>
 <20190626101727.GN21119@dell>
 <20190626111043.GJ9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190626111043.GJ9224@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019, Andy Shevchenko wrote:

> On Wed, Jun 26, 2019 at 11:17:27AM +0100, Lee Jones wrote:
> > On Wed, 26 Jun 2019, Andy Shevchenko wrote:
> > > On Mon, Jun 24, 2019 at 05:13:48PM +0100, Lee Jones wrote:
> > > > On Wed, 12 Jun 2019, Andy Shevchenko wrote:
> 
> > > > > Add an MFD driver for Intel Merrifield Basin Cove PMIC.
> 
> > > > > +	for (i = 0; i < ARRAY_SIZE(irq_level2_resources); i++) {
> > > > > +		ret = platform_get_irq(pdev, i);
> > > > 
> > > > If you already know the order, define the children's device IDs in the
> > > > parent's shared header ('intel_soc_pmic_mrfld.h'?) and retreive them
> > > > like:
> > > > 
> > > >   platform_get_irq(pdev->parent, <SUITABLE_DEFINED_ID>);
> > > > 
> > > > Then you can skip all of this platform device -> platform device hoop
> > > > jumping.
> > > 
> > > The idea of MFD is to get children to be parent agnostic
> > > (at least to some extent). What you are proposing here
> > > seems like disadvantage from MFD philosophy. No?
> > 
> > Not at all.  The idea of MFD is to split up support for monolithic h/w
> > such that they can be handled properly by their appropriate
> > subsystems, and by extension, maintained by the associated subject
> > matter experts.
> > 
> > Children are often aware of their parents (some siblings are even
> > aware of each other!), and many expect and depend on the data-sets
> > provided by their parents.
> 
> Yes, that's true and that's why I put wording "to some extent" above.
> 
> > For instance (this example may come to bite me in the behind, but),
> > taken from this very patch, where is this consumed?
> > 
> >  platform_set_drvdata(pdev, pmic);
> 
> Yes. It's used in children. BUT. This structure covers several PMIC chips and
> the children driver doesn't know which generation / version of PMIC is serving.
> 
> What you are proposing with the change is to strictly link the children driver
> to PMIC gen X ver Y, while above example doesn't do that.

Well that is a different argument. :)

I still don't really like the idea of sucking one set of platform data
just to place in another.  The implementation even looks hacky.

What if you were to provide the child driver with its IRQ index?
Perhaps via platform data?

> So, I'm not convinced it's a good change to have.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
