Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0F9C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1C222387
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mKfQrgZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbfGWWXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 18:23:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41522 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389328AbfGWWXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 18:23:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so19839633pff.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 15:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4dVf29ZcpSVwk+wf2XXFiYUsmnLURtHLTcUwHGDctgs=;
        b=mKfQrgZH4urgsDsGJ7VgdXJjU2+ey7ZEBJRkId+E9EA2DwPgMTfd0w3mx0YpvYbDBk
         6Hxb19kjJn2P4LmT8RVunb3SWGwQWWhltD9hoYDBYN3DpVaNH6GaaQ4HA2jd3H5zko8v
         YS4q7hEUaVQPsvfTWmeAQMxIusbVsmM4WuUU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4dVf29ZcpSVwk+wf2XXFiYUsmnLURtHLTcUwHGDctgs=;
        b=Je0rKx3kkCVDksHwDANDLP3ZJ1yO1JPjrsXExNO/e1bADUXOCNnhLjQDysSrFYXA0y
         rhxrwXQ3NHWM0xydR/ActlZOiDqkRLQo99Sq+0PHfJ34qSdi+uB7rtEitNv/lgFY9u8g
         TrtedqCzJBj+mFiCEQGBMQz5IH6bt7WmL/H5722Hm4FB/Y9jzqdvMSmHJ62iKhtS42xo
         KG+aVk/ms/m1wzjJR3/u+9oQv89V3kMQmqbychcu0/8C0MvQRMaaIopmWUmaBNFVU3qr
         5qyPbyeeTdQBkLCtswZ67M7Qiq81SaK/n/7dAK0xB9VsVn6AB6FgDE42UfYlBtLbkQiR
         6Glg==
X-Gm-Message-State: APjAAAX9mIfHpnx853zmkUoKohJ3BrmW5TE7HlNGotmzqFDuV8zIJffd
        SNL8zbCr6bBh8GccWFI4cIeWMw==
X-Google-Smtp-Source: APXvYqy9WkSt/8srF0QZ3mt1p4nRA9Uc/JH89PMYcwm6549t32se0npxhWekUjS1CiDtbevVGfSTOQ==
X-Received: by 2002:a17:90a:974b:: with SMTP id i11mr83444934pjw.21.1563920624498;
        Tue, 23 Jul 2019 15:23:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u16sm42936978pjb.2.2019.07.23.15.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 15:23:43 -0700 (PDT)
Date:   Tue, 23 Jul 2019 15:23:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Solar Designer <solar@openwall.com>
Cc:     Sasha Levin <sashal@kernel.org>, corbet@lwn.net, will@kernel.org,
        peterz@infradead.org, gregkh@linuxfoundation.org,
        tyhicks@canonical.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation/security-bugs: provide more information
 about linux-distros
Message-ID: <201907231520.D659BD32@keescook>
References: <20190717231103.13949-1-sashal@kernel.org>
 <201907181457.D61AC061C@keescook>
 <20190719003919.GC4240@sasha-vm>
 <201907181833.EF0D93C@keescook>
 <20190719084215.GA24691@openwall.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719084215.GA24691@openwall.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 10:42:15AM +0200, Solar Designer wrote:
> - The reporter having been directed to post from elsewhere (and I
> suspect this documentation file) without being aware of list policy.

Perhaps specify "linux-distros@" without a domain, so it's more clear?
Or re-split the Wiki into two pages to avoid confusion?

> - The reporter not mentioning (and sometimes not replying even when
> asked) whether they're also coordinating with security@k.o or whether
> they want someone on linux-distros to help coordinate with security@k.o.
> (Maybe this is something we want to write about here.)

Yeah, that seems useful to include in both places.

> - The Linux kernel bug having been introduced too recently to be of much
> interest to distros.

Right; that'd be good to add as well. I see a lot of panic on twitter,
for example, about bugs that only ever existed in -rc releases.

> > Sending to the distros@ list risks exposing Linux-only flaws to non-Linux
> > distros.
> 
> Right.
> 
> > This has caused leaks in the past
> 
> Do you mean leaks to *BSD security teams or to the public?  I'm not
> aware of past leaks to the public via the non-Linux distros present on
> the distros@ list.  Are you?

I don't know the origin of the leaks, but it only happened when distros@
was used instead of linux-distros@. I think this happened with DirtyCOW,
specifically.

-- 
Kees Cook
