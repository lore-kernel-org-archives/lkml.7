Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BF0C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC1C21019
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apbaedw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfEIQro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 12:47:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41920 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfEIQro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:47:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id l132so1608657pfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 09:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uYk0Stib1S6j7rRokCo3UxF4SoOnEStXPt0j/utJxV0=;
        b=apbaedw7M3uODDt+dMyXOD59+2L9ZFxx145owoGc17moNv28ZyB9a7MDYB5LqCF11l
         MZy5qsnipC/b7MVbqq3eq7V/2F9EASd4be3S8GNhcibsMo7I1FoN0TwHYwWlEL/yyjLR
         KHakab3lnLuooKPYxwuRiyhoSZPRdWRVRQlVyHHxhVDjf5fyqU6mm+FFVEKtt0+Szw3B
         2r65R9+QP6FN5kVPTI9B9oEcXi1BGy/M17Z7kKmBe1nk2o2YenMGeFZ6uILArU8mWJSo
         /a8uFxnkRtS5UiUZ7qX5YrwNfvFQklDRF9yXvmymrnR9lYEojnPA203uRwGF5H178Vbu
         slDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uYk0Stib1S6j7rRokCo3UxF4SoOnEStXPt0j/utJxV0=;
        b=nHx3mYLl+QnFetTP/JRO4CjEVVlIwkPMbNBnBSipxedl/xJX68OGvrzAaSkfbuUOF/
         PJVud64uDXLr0Ag34dR+kbecUkE/LClBcqhD/yZMjm/xc7fhrnnN9vXHkXUXDdzLHnqJ
         xcFC6vGPm9/1nL+Y7zVDmIOGDg0X+1cJP2P4WtXXtA+Pjwa63uoyIrgg2/MOO296g1dU
         mV6jQOe97529gQpRwjlEIcSZM009/O47OtoQH7/0sfIpbFB4ZxQ6/qzXHZ5cCqJtcljF
         c4V4H277v2He/XBJdHJxUcKSsRBqH1whDo5w1tZ9yYJ4NQwHFIfjemP03+qKsowXmsOM
         +2+A==
X-Gm-Message-State: APjAAAVRul3awPpYES74202q6GUTwKxO6l6QpQrNtrwLSJ4ZVU7Rg1yT
        24cx632qOTxmfmgt17+SdTtoET7kdF2iD9ODJX2UitRPDeY=
X-Google-Smtp-Source: APXvYqxz7AitnE/CkDlINuSoVj5oxFBdCUXYpflrpL6vQ9L7ZNgSfzm3dvjnidI4LoyVJ2BxlQxHzXN2Rtp0nIEyhXs=
X-Received: by 2002:aa7:8096:: with SMTP id v22mr6717172pff.94.1557420463262;
 Thu, 09 May 2019 09:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190509064635.1445-1-yamada.masahiro@socionext.com>
 <CA+icZUV03ZF_FWMMyY=36-zQZPWO0YUBuSs9bjQqpmXJzVYYRA@mail.gmail.com> <CAK7LNATgQaHU+6WiMvx0AAf=9AJ5nrL8f8=SJMOCJNQNb_=X1w@mail.gmail.com>
In-Reply-To: <CAK7LNATgQaHU+6WiMvx0AAf=9AJ5nrL8f8=SJMOCJNQNb_=X1w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 9 May 2019 09:47:32 -0700
Message-ID: <CAKwvOdn7bUOeiE8LobyENmPvYGO3j7rt1N+Ht7tcDWaOBuHhdg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add some extra warning flags unconditionally
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        chromeos-toolchain <chromeos-toolchain@google.com>,
        Android-LLVM <android-llvm@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>
> On Thu, May 9, 2019 at 4:11 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > BTW, is this a speedup when doing CC/LD FLAGS etc checks unconditionally?
>
> Yes.
> cc-option is somewhat costly because it invoked the compiler to
> check if the given flag is supported.
>
> So, I want to get rid of as many cc-option calls as possible.
>
>
> > Asking in general - do you have any numbers :-)?
>
> Removing a couple of cc-options does not make
> a measurable difference in general use-cases.
>
> But, this might be more beneficial for chrome OS
> because $(CC) is a wrapper and invoking it is much more expensive.

Android does too, which we plan on removing as we recently measured
the performance cost of 5% for having a Python wrapper to aid in
bisection.

Anyways, I checked these options with clang 4 and gcc 4.6.4 in godbolt.
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
