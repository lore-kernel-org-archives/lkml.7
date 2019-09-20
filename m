Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEA9C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093A3208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568996295;
	bh=GCKtG+CD95R2mS8EzwBNLj/gVyiJwKt4oDtH9SJYBic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gjpPTLmt/a5+EIuuHCj/z1csmD6QCuGV0CfO7GYd/kovtKPb8pwNHeySTqJXVyhBm
	 A8zN5Nl69xgBoNSoD7VePIruheamag/hc57lCXgJ8ywOf4Mah4kFjqUqKB84tH3I+4
	 AEL+ciYMX/E2haFUmfHGvUYk7dTbojLRBoR0y+Do=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393240AbfITQSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:18:14 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43511 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390271AbfITQSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:18:14 -0400
Received: by mail-lf1-f67.google.com with SMTP id u3so5438406lfl.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 09:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/tRAwwujfBovXt36HtC9JZ/4MVaZlXqEF94BXjqBttQ=;
        b=OuqSL56Vss9lPTztD/skWobMCVipuMEUX9+lHEdLASwSyG2xgG8y/svapwJXwLJJ5u
         M79im92CVbCsjPjTYjVv8TYLIjFWLKAMMY6KVlzWgrt2X3MS5NS4puwacoKKKjsNj6mF
         Qa7CZgFDD3VTS2AuGKApg6P+YvbDbM9exl/2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/tRAwwujfBovXt36HtC9JZ/4MVaZlXqEF94BXjqBttQ=;
        b=srPiy9REzUbRPgY5m6JUkCQU8C95G9Sxvg1S+Uo25yAd9QizDMAPWk47aBsLdZ1uCj
         KTnreScsXHma68e9rCbCCBtMBo925qK9/AxSb84bf2qf0pEl6KaNv1K1Av0z1pdgy0Oa
         +pZWVDt/kKXlzO3ppsQeQlptiOnarbXWm6MUFgxih99vAOoDNONilLZYvStanR0E/47n
         MMLwqdp4LtQHT6IY1mu15IKRurYiywdNMU9Ehdpl/S/wwp+69g9fBIXqHciKCxwgups9
         xtJF2i4H/U0Soho4YvSRIegkhH9/X11tuglzSnOYqLI4Cji0zwXI33KFqXHq4f8jt9Xo
         p3sA==
X-Gm-Message-State: APjAAAVtYOI7IOerkf19zSOfRdM86tdGCscxjs4aLiILPJ7ODL7rbNQm
        xzQRRDbTVJsoymfsv6IN+MCvOt6SWKE=
X-Google-Smtp-Source: APXvYqwTKdeDrAerYC+Lk+z2j9Glfv+qyFvUqBU2Qf+YetSX7Qw4SNr3ThAOtI+/VZrmU91Q8/vpRA==
X-Received: by 2002:a05:6512:251:: with SMTP id b17mr9787326lfo.35.1568996291081;
        Fri, 20 Sep 2019 09:18:11 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id a8sm550869ljf.47.2019.09.20.09.18.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 09:18:10 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id m7so7661879lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 09:18:10 -0700 (PDT)
X-Received: by 2002:a2e:3e07:: with SMTP id l7mr9721577lja.180.1568996289896;
 Fri, 20 Sep 2019 09:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org>
In-Reply-To: <be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Sep 2019 09:17:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
Message-ID: <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 12:26 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> This Kselftest update for Linux 5.4-rc1 consists of several fixes to
> existing tests and adds KUnit, a lightweight unit testing and mocking
> framework for the Linux kernel from Brendan Higgins.

So I pulled this, but then I almost immediately unpulled it.

My reason for doing that may be odd, but it's because of the top-level
'kunit' directory. This shouldn't be on the top level.

The reason I react so strongly is that it actually breaks my finger
memory. I don't type out filenames - I auto-compete them. So "kernel/"
is "k<tab>", "drivers/" is "d<tab>" etc.

It already doesn't work for everything ("mm/" is actually "mm<tab>"
not because we have files in the git tree, but because the build
creates various "module" files), but this breaks a common pattern for
me.

> In the future KUnit will be linked to Kselftest framework to provide
> a way to trigger KUnit tests from user-space.

Can the kernel parts please move to lib/kunit/ or something like that?

               Linus
