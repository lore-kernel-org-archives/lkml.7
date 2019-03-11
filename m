Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86C8C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21432075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfCKLKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:10:35 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38571 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfCKLKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:10:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id s1so4479703qte.5;
        Mon, 11 Mar 2019 04:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gb51/j4K8i5vftAvGniJ93ONNzQCtuElB7vIMJFE9IM=;
        b=ZEtp6rUVb3PXK/++EfRxsNgW/Qg8hBYY7aCZen8mXIeBQT/1zPgQsNoONfrocaBFYD
         ELtFIxDmimKWj41qx9G8uQPrhoSVEa1dkeBeDVwzil7BWXvq7+/RRgGV6+bAPlpJhhG7
         9K8mD8TFkfENLFFGun7qBy6ZTM6MGrBr5/gY82WKGUrfEoQwIPy7lM0OHf8O1PQLG37c
         x0lfhzryi/RYFwoAwIxBaZIWH4+l3cNc6wx9VyPi29eRQfF+PWYYl90yYtcpFkSL+bZN
         QKsOPu06wM3gG3xEnJkS8QuLOOtyH7PwTptRJVW89f4lEQGhgAFsYCI2IP4iPAb8TorM
         3oLg==
X-Gm-Message-State: APjAAAU+sQySzuxxwk6XTTLFgPRJ7T5D3JkZg04AW8uZRYCRYGp9FVVl
        swl6iE41c6SUDmgGcorrkp2vm+rGxcvMs2YPlKw=
X-Google-Smtp-Source: APXvYqyn5H3KfKyWddFxtu/tDkxWBKDiSOJLx2uh1qpGjKFXhtoOLjB5+CuQgtQqkveKJDnhttzSJGoSiU7tdo3fLHY=
X-Received: by 2002:ac8:2bcf:: with SMTP id n15mr24154150qtn.96.1552302634165;
 Mon, 11 Mar 2019 04:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190307214546.9624-1-natechancellor@gmail.com>
 <CAKwvOdkeVmcoD7WusKE83MmRjX+h73rnHDY=Rn_a7LXsULPsrw@mail.gmail.com> <20190310093738.72c1019b@archlinux>
In-Reply-To: <20190310093738.72c1019b@archlinux>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Mar 2019 12:10:18 +0100
Message-ID: <CAK8P3a3X1FbFPxOW54AtqeJgOTvjtnLwzVNCv+x-439Df_cEPw@mail.gmail.com>
Subject: Re: [PATCH] iio: common: ssp_sensors: Initialize calculated_time in ssp_common_process_data
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 10:37 AM Jonathan Cameron <jic23@kernel.org> wrote:
> On Thu, 7 Mar 2019 16:35:26 -0800 Nick Desaulniers <ndesaulniers@google.com> wrote:
> > On Thu, Mar 7, 2019 at 1:46 PM Nathan Chancellor <natechancellor@gmail.com> wrote:
> > >
> > > When building with -Wsometimes-uninitialized, Clang warns:
> > >
> > > drivers/iio/common/ssp_sensors/ssp_iio.c:95:6: warning: variable
> > > 'calculated_time' is used uninitialized whenever 'if' condition is false
> > > [-Wsometimes-uninitialized]
> > >
> > > While it isn't wrong, this will never be a problem because
> > > iio_push_to_buffers_with_timestamp only uses calculated_time
> > > on the same condition that it is assigned (when scan_timestamp
> > > is not zero). While iio_push_to_buffers_with_timestamp is marked
> > > as inline, Clang does inlining in the optimization stage, which
> > > happens after the semantic analysis phase (plus inline is merely
> > > a hint to the compiler).
> > >
> > > Fix this by just zero initializing calculated_time.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/394
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> >
> > Knowing that the same invariant holds across function boundaries to
> > protect access of unitialized values and thus undefined behavior
> > sounds tricky to diagnose accurately.  Thanks for the patch.
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.
>
> Note this is going to be a while before it hits mainline but as
> it is a false (if reasonable!) warning I'm not going to rush
> it in as a fix.

I think it's actually a correct warning, it just doesn't trigger
on gcc because of a known gcc bug.

I'm not sure however why I don't see the warning with clang-8
on my local build. Is this something I have to enable
separately?

       Arnd
