Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80452C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521ED206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LnfTfmTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfFTUZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:25:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42640 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfFTUZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 16:25:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so2289630pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 13:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ycDhdoPGK0tl2WgTFRv4StbyxU966OO2E0jZjJjKefo=;
        b=LnfTfmTpOc2aDOFcvxvxCyRx2oTQo3uolnpHY/CpqTZYP4dvR5XNkE6ksddEmruRbQ
         va8N/dMCLiQxEanR2iZyGXYun4/nKM79XDE1/GJgx5bD7Yc64a4eYaH4AzocNkAvznko
         FEcTm5xUZhg2kW37BqX9OPTzUGNPvIjtIOmNs5ioOPG3tmIXFh4ClycYiDGF7qmYdY/v
         j3ZqM6OvsYcZZy49XAzng667IFn64Pm0wRHobE2XNni7k2Gjg59eMyDKOIYfoZgAldMZ
         8iarFmlMFEfcdrPtKnIzLlms1w9bOg65MD3DxOKTAeIZXi7tgKe8FJil4QaUY0Y44+AE
         E4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ycDhdoPGK0tl2WgTFRv4StbyxU966OO2E0jZjJjKefo=;
        b=uWbgnb5qLNeEZCLuOFhouPXM4EDDoOdrCZBqNdsucQJPPY068pzfKW+IyQhviNIiYk
         r4JcE00FQOvazFL/wThzeNQjNQILcqfOm8cexIcrjvxYI9Pn7qkF98sIs5co8o87Qt3b
         RiJ3yl9ljxYvTEa/Uxys8WP+/Jtu1N3o5MXQiYu+Z9OiZuYOch0GimgzXWU/ST+Q3UZP
         GnppKONz45ZMr7l/y8GukpFDZ/M0SStxoCqU6XOWAKpDH7Tgqkv8iAipoRMszy4mBidh
         KrPHhMLif2aKnFzW4bOVeipAEGXzvSnV2M9lID+0tXO0ISqSWR/CAfUmkFGcSvjiBHGB
         VtGw==
X-Gm-Message-State: APjAAAU7/dRP6tfNxDT3aHo4E7g3XgyPwsE8SfSs5xmPW1F+GKq4I0Sw
        2HLdlJ9j3fr0Jclcz7mdHvZBIr+EcUHdssVquJPpkg==
X-Google-Smtp-Source: APXvYqwfuCPR2jr4PyIupl/TQ75vO5GLNJXNZviHm1k/btpNEIQ6pIVqvW1+Bg9SD6e/P3wobLs9tr7obdcIVV4yucI=
X-Received: by 2002:a63:52:: with SMTP id 79mr14320167pga.381.1561062347264;
 Thu, 20 Jun 2019 13:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190620184523.155756-1-mka@chromium.org> <CAKwvOdn-o9UszRW+MQ9Z0Ds9B2wSVBWUsPBPSF0S2DYxVFYpqA@mail.gmail.com>
 <CAD=FV=WcH=dVeVWznO7Ti5A8HBDRM=rPvvH=-XJ2o1PKXvHAQw@mail.gmail.com>
In-Reply-To: <CAD=FV=WcH=dVeVWznO7Ti5A8HBDRM=rPvvH=-XJ2o1PKXvHAQw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 20 Jun 2019 13:25:36 -0700
Message-ID: <CAKwvOd=twuZAAyKsBRSeJEFuQZGdyTw+=JAwmJugUhV+bppdtg@mail.gmail.com>
Subject: Re: [PATCH] gen_compile_command: Add support for separate
 KBUILD_OUTPUT directory
To:     Doug Anderson <dianders@google.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Tom Roeder <tmroeder@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Yu Liu <yudiliu@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 1:13 PM Doug Anderson <dianders@google.com> wrote:
> On Thu, Jun 20, 2019 at 12:53 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > I do miss Doug's Kbuild caching patches' speedup.
>
> You actually get quite a bit of this by grabbing a new version of
> ccache (assuming you use ccache).  :-P  You still have to pay the
> penalty (twice) for all the options that are tested that the compiler
> _doesn't_ support, but at least you get the cache for the commands
> that the compiler does support.

Hello darkness my old friend:
https://nickdesaulniers.github.io/blog/2018/06/02/speeding-up-linux-kernel-builds-with-ccache/
Man, that post has not aged well.  Here's what we do now:
https://github.com/ClangBuiltLinux/continuous-integration/blob/45ab5842a69cb0c72d27d34e73b0599ec2a0e2ed/driver.sh#L227-L245

> Specifically, make sure you have a ccache with:
>
>     * https://github.com/ccache/ccache/pull/365
>     * https://github.com/ccache/ccache/pull/370

Oh! Interesting finds and thanks for the pointers.  Did these make it
into a release version of ccache, yet? If so, do you know which
version?

> I still have it in my thoughts to avoid the penalty for options that
> the compiler doesn't support but haven't had time to work on it
> recently.

It had better not be autoconf! (Hopefully yet-to-be-written GNU C
extensions can support feature detection via C preprocessor)
-- 
Thanks,
~Nick Desaulniers
