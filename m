Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1385FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE86320820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EeaCBoP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfDDCon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:44:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38956 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfDDCon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:44:43 -0400
Received: by mail-pl1-f194.google.com with SMTP id b65so382074plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 19:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WqIILRsDwgRrSgwCZEpx/nU60S68BDOTaPRzozxi2ls=;
        b=EeaCBoP0lttzjxIjlyvZzIJJyBATEHXCCtYD9RH+59OMWZg0HaAh9fjEtChbXLpqqu
         Lcs1HXeAw2wz3Mu3+69jsO0l1xZ3+jXmjN+RiO0QPPP2k9V4P80ORbtO2pN6ionZwtcT
         27fCtGJp6UdE+s07NNyegQwQqErnK05TTLetQdg+WCAhdolnOY9W0YWg66ormowz/+/8
         fJDXUiSst6Cue8Z2KGAwbspn1Px3F2rKmUFDmTDbAEeNTG3961KEPaCQGp+olYsnCc8+
         bxEZJLb0crB+USJplvBn0X0cQj7AQlRE0LLOuHERQUYzZv7U50Lon+fypisYzxuuHEby
         izSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WqIILRsDwgRrSgwCZEpx/nU60S68BDOTaPRzozxi2ls=;
        b=Gof3p9X5A9YUZatzD2j3YL25bdksggELKepCs1ahzoPfLLIvEooowoI1v/GfpUYGi6
         bk5x3qFaDmtNtpvCTkPXCEEjyma9Xa5yRfwispy7E0lu7gwIBuas8sc/kPixnJNbsKZ3
         5+YxolSQ+asg4um6n84gub2MLBMWqR/ok1eP1gVzS3L81a0vXzACtSBuUI1EC2lGB/+O
         t8T2WM0gT5MOMLDHlWVdrSR6BwnobyOy1qjDZO8y7xe9hNt8VVUqNEVGPdL7ZUOSfIw1
         GjUXeFW9BUfvwdCYU59nb3ry6+lTqFRd5/xST6SdJxHJKGpQqjkzBclL5xw8FMg4QDdd
         nL0Q==
X-Gm-Message-State: APjAAAWS5YFYdbMHvamqNTRN+7Kq5pKGEQzJPfple7Sb36pbGHrRNNrZ
        AUn2+pE58S1xfBbcedVOls59sah+UkyqdQ==
X-Google-Smtp-Source: APXvYqwRGdsb6cNMefkD2KxmgAu4T/ieQ7sx3AwiJRzjolcduePOb7ZyP0LzcVv6YqTLzS9BsAcu6Q==
X-Received: by 2002:a17:902:29ca:: with SMTP id h68mr3583425plb.297.1554345882501;
        Wed, 03 Apr 2019 19:44:42 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id w18sm29540613pfg.75.2019.04.03.19.44.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 19:44:41 -0700 (PDT)
Date:   Thu, 4 Apr 2019 03:44:36 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz,
        tony@atomide.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 3/4] mfd: ti-lmu: Remove LM3532 backlight driver
 references
Message-ID: <20190404024436.GA6830@dell>
References: <20190321142838.22985-1-dmurphy@ti.com>
 <20190321142838.22985-3-dmurphy@ti.com>
 <8769a95d-179f-6219-0a63-9dd623cdd297@gmail.com>
 <20190325075317.GW4731@dell>
 <c950b7d3-eeb1-2dc2-b732-3a40d5b3a8b7@gmail.com>
 <20190403075709.GD11301@dell>
 <8b771488-a914-0d75-6e9b-9a67b4c5017e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b771488-a914-0d75-6e9b-9a67b4c5017e@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Apr 2019, Jacek Anaszewski wrote:

> On 4/3/19 9:57 AM, Lee Jones wrote:
> > On Mon, 25 Mar 2019, Jacek Anaszewski wrote:
> > 
> > > On 3/25/19 8:53 AM, Lee Jones wrote:
> > > > On Sat, 23 Mar 2019, Jacek Anaszewski wrote:
> > > > 
> > > > > Hi Lee,
> > > > > 
> > > > > Can we have your ack for this going via LED tree, please?
> > > > 
> > > > Patch looks okay.
> > > > 
> > > > You can take it through the LED, but if you do I will need you to send
> > > > me a pull-request to a minimised immutable branch please.
> > > > 
> > > > If you cannot do this, I can apply the set and provide the same to
> > > > you.
> > > > 
> > > > If you choose the former:
> > > > 
> > > >     Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > > 
> > > > Please let me know what you decide
> > > > 
> > > 
> > > I've been exposing integration branches in the past, but after Linus'
> > > message [0] I have my doubts now. I wonder if it wouldn't make more
> > > sense if I just took the patches, and you'd cherry-pick them only in
> > > case such a need occurs. This way we would avoid this whole merge
> > > noise, which in an optimistic and very plausible case will not be needed
> > > at all.
> > > 
> > > [0] https://lkml.org/lkml/2017/4/19/1104
> > 
> > That email is 2 years old, and does not seem relevant to what we're
> > trying to achieve.  I've only ever had issues when *not* creating
> > immutable branches for these, cross subsystem scenarios.  The
> > shared branches I create are always minimalist and never change.
> > 
> > I'm happy to take the patches and create a suitable pull-request for
> > you if you are uncomfortable with the process.  I just need your Ack
> > to do so.  Up to you.
> 
> I don't have any problem with the process. The clear gain of cherry
> picking is more linear history. And the branch can be always created
> when such a need occurs in linux-next.
> 
> That being said, I will send you a pull request once we sort out
> the problem with obtaining a reference to the backlight node.

Sounds good.  Thanks Jacek.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
