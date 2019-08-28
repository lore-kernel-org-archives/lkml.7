Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527A5C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BA12173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IGR9CiXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfH1Rjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:39:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39979 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfH1Rjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:39:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so103977pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 10:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GuCbGVwHRmEGqfMBjZZ+2u4NovL8Rt/IpkZfKDrFBI8=;
        b=IGR9CiXHZQSh/xjQMoY6pRAdfAFxdTZNImDxml/hjjOXvJ+gRYKyeoRx8mYWbRhZvz
         GrByy0qWFHCi/YCnq0nk0i2F0Uyh3zew2GKE8iw1N3pmmuOwEaPeSFiy1MRX8CzcMuRZ
         mkQ13VgaMibRHsM8YDcSX84q45vyxMq3XHi0YOSc/Vn9seZ/HrhxmFEBsJMH50ohZon3
         3GRUl2ipzTQISk5T0eHK9Exwck0dA+Y54K8x2HMFLy+sXXha95k9CGPrjVar0ijiCvgl
         0MxX1s9Z/4QIb0NNa+jEur5DCeeV9hDAw3GHwjG97CDGBh3JGZBHUx3Qf5sn1ZCR17+h
         +pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GuCbGVwHRmEGqfMBjZZ+2u4NovL8Rt/IpkZfKDrFBI8=;
        b=XT+1f5lsT/0fWXjvsbPDdoNb0zkQ0mQrRnvZYq955QEiawTfjIcAZGHH0sm1Vzy9pI
         122T/C+yP1jtIOFLZU4fFnrgJOeTS78G8VCqx3SJxQF0vCqQHwGa9MKSGXtWtgl1OPN9
         q2Z5LwsLR6dW7NClga8M9/LHgBlKFObDlVgXYrOIzy69ap2K+VIUVJHMP4H1D7obl2Lf
         dzrsvrKXhGuJqFGrsZawUzwm24XBA4FtAQidRkcsJZX3zyQy02tNZkXWDXnSl4PsoycP
         SgFbVt2IRGkN+9+c54GwCR25s06RVFkjQanhtw00zPoapveURmgWVh8mfGDlwMowxESK
         PalA==
X-Gm-Message-State: APjAAAVQIfdfSJhMb/9NdoDFeLFlLspUJepgk91nIE49RGWmd3/LBK6B
        TIRVk3KcCC9TeFBrVO/rd40f7w1PrSDjxLg1rWZxJw==
X-Google-Smtp-Source: APXvYqzdtkFSXhZjMKVoVzXBpdLNDINY5K3kMdUxm75M/4l37E4Q0dysGQ/lGI2Jnh2fcoAoGM+YptMYIOb8HnteoXE=
X-Received: by 2002:a17:90a:c20f:: with SMTP id e15mr5304440pjt.123.1567013970427;
 Wed, 28 Aug 2019 10:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190815225844.145726-1-nhuck@google.com> <20190827004155.11366-1-natechancellor@gmail.com>
 <CAK7LNATHj5KrnFa0fvHjuC-=5mV8VBT14vrpPMfuNKWw7wabag@mail.gmail.com> <CANiq72ndWZWD-KBT1s-mUxQNa1jaD7oDaCB2+NPiT1chf14Z_g@mail.gmail.com>
In-Reply-To: <CANiq72ndWZWD-KBT1s-mUxQNa1jaD7oDaCB2+NPiT1chf14Z_g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 28 Aug 2019 10:39:19 -0700
Message-ID: <CAKwvOdkuDPfOusJRneeTzg7tZ4VKxaRCNg2SgmjVas58cDwe8w@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Do not enable -Wimplicit-fallthrough for clang
 for now
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 9:45 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Aug 28, 2019 at 6:21 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Applied to linux-kbuild. Thanks.
> >
> > (If other clang folks give tags, I will add them later.)
>
> Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

I verified that GCC didn't get support for -Wimplicit-fallthrough
until GCC ~7.1 release, so the cc-option guard is still required.
Acked-by: Nick Desaulniers <ndesaulniers@google.com>
Thanks for the patch Nathan.
-- 
Thanks,
~Nick Desaulniers
