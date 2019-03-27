Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47E1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B1F20651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DU07es9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfC0Rmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:42:32 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40070 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfC0Rmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:42:31 -0400
Received: by mail-io1-f67.google.com with SMTP id d201so14821643iof.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 10:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZhukHlxTtepUFFhI/+26fbuf2j8cU5UZH4qojDumCm8=;
        b=DU07es9HQmzjwQmyT6PpW6qRheFryy6e6kYKUbOlvFqL1ZnPDmPMVkJeRoR6B8bMgR
         wcW90pKlyUCiJRtehGdXcfOeIDOzYu+4+UJj+HeomyQfhAQzAfMRVwKTuotfhm3SCUWJ
         yr3yK8O0qEC5sXq/u0uYzd7t/lKIF0fQ7Lr0OBwc6aL6pJ8gQwLmZM/1lOudKWqr8glo
         a5rGkA7lvGOcnf9YvecTZ83meM0IXyZRwtZZjAR4ahZ0UgCtVNA9I87b7J5qDBCm3aXM
         SGzY4+JqgkngjOcU6SCupd5cJwpinUlOcPpVYjDUXz+apuFwM3g7QUKyzz7ZoS8PtERm
         0eCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZhukHlxTtepUFFhI/+26fbuf2j8cU5UZH4qojDumCm8=;
        b=RZXAdTXRN0TaYAYAzk4v10dKTY1BADIBb0g72giIlnYW9906AmWh5P0B21tqjjjNnh
         a8YaTxDwHL+x8GZcTowUcWH5Q8Cj92foEb+RhZWqCno77KKtLd7/wk/8XblyA1CpYAz2
         iG6Y+SmYksRU8b8a3uk0+GYa0kQjJMSCdCN2HOUWMFiClY4FdYLnNsp57pogBom0NdrV
         6BFX8WG6450y5TWVtvw1137MulAy9aMoQvmdd1Qa+7PrFb9R8EJvUvwFSVin9NiQeNhH
         8oz6DpbqpMVBWwm3JpEI1VIomHAmUcSYRpNfB+zXSoeu3Q4qjBlw7kuHaROZbokc/Ek8
         nYkw==
X-Gm-Message-State: APjAAAWpItrzHhtVsZ3xShn6EcNPAw2py1GJDEr09wLtajAiTqr8Ta/g
        EN70nYwdKTfli1zwORvoXuSE/U8n+3zRAMdAfx5iNw==
X-Google-Smtp-Source: APXvYqyOZhCHju1KvvCuJb9wIr4rdTVTzeA8XxQLVSHIsFMdL2U+qaK3Osw6to+Ja4YqzSGwkrCNDg5c/vl880NwpnI=
X-Received: by 2002:a6b:e509:: with SMTP id y9mr26200848ioc.169.1553708550687;
 Wed, 27 Mar 2019 10:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-26-matthewgarrett@google.com> <CALCETrXDF2c2-gnOyNTnEn-uPAZp0AaSB_PB8e2y8jf7zo=Cyg@mail.gmail.com>
 <20190327003057.GA27311@kroah.com> <CALCETrVDDf4dj3Md1Nxc5P_NCToXGnAbEO3bGfwgKSfeVmU4Kw@mail.gmail.com>
 <20190327050615.GA548@kroah.com> <16124107-70D3-4CA0-9766-36FC6DC10128@amacapital.net>
 <20190327053342.GA17484@kroah.com> <CALCETrUW=r=xyr4pGiGnn9zUEevf=z6PP3111Ds6qguV5SjYUQ@mail.gmail.com>
In-Reply-To: <CALCETrUW=r=xyr4pGiGnn9zUEevf=z6PP3111Ds6qguV5SjYUQ@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 27 Mar 2019 10:42:18 -0700
Message-ID: <CACdnJus=zXgmNas+XVkWfe+ohAHEGMYLtfuYe0TH-eE=4p0oRw@mail.gmail.com>
Subject: Re: [PATCH V31 25/25] debugfs: Disable open() when kernel is locked down
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 10:40 AM Andy Lutomirski <luto@kernel.org> wrote:
> As far as I'm concerned, preventing root from crashing the system
> should not be a design goal of lockdown at all.  And I think that the
> "integrity" mode should be as non-annoying as possible, so I think we
> should allow reading from debugfs.

I have no horse in this game - I'm happy to bring back the previous
approach for integrity mode and block reads entirely in
confidentiality mode, but I'd rather not spend another release cycle
arguing about it.
