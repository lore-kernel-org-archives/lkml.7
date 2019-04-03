Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1670C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08C220882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tPKwutVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfDCJDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:03:41 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39301 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfDCJDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:03:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id b65so7703057plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 02:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4wwN5BRJGwbTz3oBf5E6XgsD3idZtNOSFTkaDmiSt+s=;
        b=tPKwutVM40UFFQZrHSlTKzsU9n0pl+YWBUGdzKo+iWBIrutVQU0Py00Vnlo/MZ+XrT
         s/1C2HBZAT9magH6h8GgjbvFeEf8+x655vTkdNQjYVZ2V5dcxsoKhvk+R+pqJObtzLMl
         kl8kCvNQVNuPf42MaB+cR7MUJpWLywDyiHgGKNCt1GiKCXAt2+7sd33rcp/xorUVGvG7
         zks3mKYyBuzINTyd8WhjK5QIKEQvv9Zt8Pz3CkwLYdr9IpIBuF5lTgMSi2Vkc6Bwtl7v
         3Hu6ZjHFv5xsTU9n4IRTPEb3yfSKvNM4XEMeKgu+D/gR6vz7kyQZqIDbwo1MfDv+l6Oq
         OrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4wwN5BRJGwbTz3oBf5E6XgsD3idZtNOSFTkaDmiSt+s=;
        b=F/shh4u0BGWis3zSTFoFMlslJS/urHrUsiLCcsaFsSb7cFKxEbrTcwMlhKO3Jfn0ts
         Zx9DJbQR2uL1c/WyWfJJudeuGQ5fMuVsrTx9GFYYNBpTMREj47Go+f6N51nlZPUW/hPi
         +K8lylLDnNw7K6kJmvZwGfDz+OoVGl0aI0lHI5ZDLEvjOcmvWRqI9e+c+D2qgC9fEOyK
         qzX7AOK5p5Raod73GulASfO6+9hOGIT/8caH9dMFK3kTDAQtiuJqcTJFxOZWcigIz5RJ
         /kQF+r0s9ra4KNZrqxR0dHFS4/IC8gKkwBrEY8agkD2bj+s/96cY8hfeakcYLMiHq3/H
         laQg==
X-Gm-Message-State: APjAAAUolaV0cAn6XlVopddEm0558yg35bXBwSYJBmf6lN0fi3mgHva3
        AKNAS1DGdKjcTZMOl2RCNYhdNQ==
X-Google-Smtp-Source: APXvYqy8qvRe6ajEm/rBNvnQLsUkRK88+EE9mchDyc57YYn89EQUcyiq4MboC3DdhDhO90FHWZpsWQ==
X-Received: by 2002:a17:902:2e03:: with SMTP id q3mr74244875plb.166.1554282219868;
        Wed, 03 Apr 2019 02:03:39 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id v189sm45153409pgd.77.2019.04.03.02.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 02:03:39 -0700 (PDT)
Date:   Wed, 3 Apr 2019 10:03:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH 5/6] mfd: da9063: remove leftover platform_data
 definitions
Message-ID: <20190403090334.GH11301@dell>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <20190318154759.21978-6-wsa+renesas@sang-engineering.com>
 <20190403080758.GF11301@dell>
 <20190403085049.4clchelp4tgslikg@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190403085049.4clchelp4tgslikg@ninjato>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Apr 2019, Wolfram Sang wrote:

> On Wed, Apr 03, 2019 at 09:07:58AM +0100, Lee Jones wrote:
> > On Mon, 18 Mar 2019, Wolfram Sang wrote:
> > 
> > > Not used, not needed, remove them.
> > > 
> > > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > ---
> > >  include/linux/mfd/da9063/pdata.h | 65 ----------------------------------------
> > >  1 file changed, 65 deletions(-)
> > >  delete mode 100644 include/linux/mfd/da9063/pdata.h
> > 
> > Can't take this until the last user has been removed.
> > 
> > But for now:
> > 
> > For my own reference:
> >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> As I wrote in the cover-letter, I'd vote for all patches going in via
> MFD. Is that fine with you? Then I'll ping other maintainers for acks.

That's fine by me too.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
