Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D71C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A863B2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="osrgXa++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfFRINa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:13:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35935 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfFRIN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:13:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so4770187wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 01:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=06HNdPNgDbi2f1j2ONuEOl1EHxJYMZdY3r9dArsvaPQ=;
        b=osrgXa++2Q+19SyQ1z7d1ONbADxeD3tCbVl2v95iwqfC2jN8JrzlBbSbotWm1ib1eH
         k7pfiV8Atc1w84Uk1cJi29Cb/UH0z9GWMSdfcZVUWHhC1pWzLNZPt7jAEYRWVNgNRFJP
         NqTDPRy3PAzP5J5RLPVLnNb322kTOi6Lsx7CDeIoXEPdV3UjpG1pw2m4vzq6tihzWGKg
         9iJ7ltctXwXheg7nvUO2gp+tSjBbWlAAjX8rUnmWm8D+us+OU94WWgzoJc7Wpb2fspXj
         4OfKrLEbehWaBOkEwT7wILE7J8EufELTCIawMLqMicz4oyI0EF2xahSvlbEdMWsufMqb
         n9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=06HNdPNgDbi2f1j2ONuEOl1EHxJYMZdY3r9dArsvaPQ=;
        b=iFGvRB7nIVvJe+9WbdVkWKiBOy3y1O7C+H1Dt8j19S1f/x0Bhigma/goI8t2ZUaPcu
         Eo5a4Q0O+QIY6C8x746s8iATK3E9NBHQKh6nr2LHnhCqsZirg9JZExVgqEMnUh8FjXNq
         PU2Y2I3Kr7W9lV/YkvBbgx2Y5yiposi/gvAyv3mlGQoo/V3TCkAlD/aKSBbTQxlpKJd9
         jfjADwkPCaepeAQ4j2WeAlhVPAhEhi/jt36OLrRxcrusBWBGeOBsDGXUoQ+6DDpFfq3t
         RCQfEX2iFJsQiEdwTisDIRv8KLvlOiu/oEdZDmvgyP+sr0LkmVqnE78bOesrDveaSSWl
         9G1Q==
X-Gm-Message-State: APjAAAX8IenWIWJI/jdFPuCOXQwZf22Pj3NrwIta9TpqoqOIrnXNjft/
        vPobbxoM46P4x49B06O1BRmoew==
X-Google-Smtp-Source: APXvYqzwXi+RbIPkFmf4CacE1T+w7xAM0/5ckvB5TE8zDrHsOAfEV+IgJ4W1J07pX0Aa83hlfmc9WQ==
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr3195081wrp.245.1560845606659;
        Tue, 18 Jun 2019 01:13:26 -0700 (PDT)
Received: from dell ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id v204sm1871127wma.20.2019.06.18.01.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 01:13:26 -0700 (PDT)
Date:   Tue, 18 Jun 2019 09:13:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lgirdwood@gmail.com, robh+dt@kernel.org, afaerber@suse.de,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.liau@actions-semi.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH 3/4] regulator: Add regulator driver for ATC260x PMICs
Message-ID: <20190618081324.GK16364@dell>
References: <20190617155011.15376-1-manivannan.sadhasivam@linaro.org>
 <20190617155011.15376-4-manivannan.sadhasivam@linaro.org>
 <20190617163015.GD5316@sirena.org.uk>
 <20190617163413.GA16152@Mani-XPS-13-9360>
 <20190617170356.GG5316@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190617170356.GG5316@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019, Mark Brown wrote:

> On Mon, Jun 17, 2019 at 10:04:13PM +0530, Manivannan Sadhasivam wrote:
> 
> > > > + * Copyright (C) 2019 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> > > You definitely didn't assign copyright to your employer?
> 
> > Yeah, that was intentional. This work is not part of Linaro working hours and
> > falls into my spare time works where I'm trying to complete the upstream support
> > for Actions Semi Owl series SoCs and target boards which I'm co-maintaining
> > (sort of)...
> 
> OK...  seems very weird to use your work address for developing on
> products closely associated with your employer in non-work time.

I use my Linaro address for everything.  So long as the work is of the
required standard, I cannot see anyone having reservations.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
