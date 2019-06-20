Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B62C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53B920652
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OFzTjUo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfFTUN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:13:27 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36098 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfFTUN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 16:13:26 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so1093238ioh.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 13:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1icci/FsKBkA+YdqOQYL2S4BNlawV+2fYSo6CDrDd30=;
        b=OFzTjUo6dM5S4TV8R6STTtXuVSs45v8xQQEev2XuL3pcVD1YpdD/JMoJqp54BN6TSR
         OfknnbirwIqLRmAdWF2FEFm7F5eOS17C0VbPa1w/MEoWHTf0kgiv4qMAeuEn7rrJL3Pa
         8Tg2FjOBYeInzzjePv82w96YiKDFmdOV2pl70Yds80E9IKrb9aW5q9a6tcp1dAlrrIdP
         ygVOxXS4DM2DFX2VVKjVgNmUA9nSdTTpyQ0L+kiuE/WOv/LU99b6L+7Ml/EbK/b7lE0b
         LaezwiXe75eA+j80W8tXrC+KmBO1u6vE6DCuCk6EAyk8NjdKHX1UsvvLLMBJSQvDl2Zw
         3K7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1icci/FsKBkA+YdqOQYL2S4BNlawV+2fYSo6CDrDd30=;
        b=g0TY9lzE9LnxFGN+3wrLgWKgborNxwPJNaiXEeSTdKYow3XSnsMnbk/9eHWN7TNWBa
         nzrMNUiKkZvH9c5oW7BTzAsS+mqxam/86p32c97G+s7/XRXV+XqCkmVpIHcEMQEFw1Et
         6ZFJZWm7lbC6pfXa0uQzibVNfERj6ixkh11zcvSC8aiG5TiXTBZmOcPBBg2Lwgh1J9Qq
         YJGzI6M6mstho2vPIoRAOT+zp+2IPiw1pmD559k7ermBaZP2YNPIUp2HYKq7S5cwypG+
         thlE+Cx2Ddwfdc/2duqaQwp0gjKZqlgOfI6XUWcarDJMR+MJQkV85rHfGJ1/DoKOy6GO
         6eig==
X-Gm-Message-State: APjAAAUcg+c0mzIBsHQyAGD05o28+tG75RYR1rb4UFGlfCabHkaFpPNb
        G72vYPQM27Nno05ZQUw+ORHOr/x3b1ZCIHUC5QMhGw==
X-Google-Smtp-Source: APXvYqy5XLKKsD1B8qTF0RHJgd30Yqv2xlevMqcCWwO+nauQQqpylbYaKOb1+IRUM+dLixzsmqrMrnG2DXqlZVofGXw=
X-Received: by 2002:a5d:96d8:: with SMTP id r24mr32836485iol.269.1561061605185;
 Thu, 20 Jun 2019 13:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190620184523.155756-1-mka@chromium.org> <CAKwvOdn-o9UszRW+MQ9Z0Ds9B2wSVBWUsPBPSF0S2DYxVFYpqA@mail.gmail.com>
In-Reply-To: <CAKwvOdn-o9UszRW+MQ9Z0Ds9B2wSVBWUsPBPSF0S2DYxVFYpqA@mail.gmail.com>
From:   Doug Anderson <dianders@google.com>
Date:   Thu, 20 Jun 2019 13:13:12 -0700
Message-ID: <CAD=FV=WcH=dVeVWznO7Ti5A8HBDRM=rPvvH=-XJ2o1PKXvHAQw@mail.gmail.com>
Subject: Re: [PATCH] gen_compile_command: Add support for separate
 KBUILD_OUTPUT directory
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Tom Roeder <tmroeder@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Ryan Case <ryandcase@chromium.org>, Yu Liu <yudiliu@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 20, 2019 at 12:53 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> I do miss Doug's Kbuild caching patches' speedup.

You actually get quite a bit of this by grabbing a new version of
ccache (assuming you use ccache).  :-P  You still have to pay the
penalty (twice) for all the options that are tested that the compiler
_doesn't_ support, but at least you get the cache for the commands
that the compiler does support.

Specifically, make sure you have a ccache with:

    * https://github.com/ccache/ccache/pull/365
    * https://github.com/ccache/ccache/pull/370

I still have it in my thoughts to avoid the penalty for options that
the compiler doesn't support but haven't had time to work on it
recently.


-Doug
