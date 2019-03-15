Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E8AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616A621872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aWBsb9Rq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfCOI2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 04:28:04 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36321 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfCOI2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 04:28:03 -0400
Received: by mail-it1-f196.google.com with SMTP id h9so9553036itl.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 01:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KQt/pRQ1amhfev3CC1PXpPQngC/SP7hl1Od228LoTzI=;
        b=aWBsb9Rq1ho33xpOVsaTowrloURGJbM1Tc2YWV8Fv4XG1+Obwd9e2jS80/oJtaG8c8
         BKvm8JIZLQEXJakUrcas2n/YWm+btNMuil43jW+6FFyK6J3oen69+kR6HZmure60zMUH
         CYv/mBv2FGHg0O5LkepZaUcQq1hwsKuKcSf9CVj38FzRhRbEPKuhs1GHJ2gPLTNAyl0g
         XS4e2KZA3XVq8QxwPcb5B9xwya+0KFvb8YCNPVq0Ov6FLj0y8lweZxRDibIOs57aN5iu
         d9ZtPW1bze+i1XO95VtmuP0DibmTMOy5tbmsmgvCbNQMPTUoWymjQt0UjN+67jm+PCoh
         CdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KQt/pRQ1amhfev3CC1PXpPQngC/SP7hl1Od228LoTzI=;
        b=rYkUwCGeBtUQytWcDK1wMrmkpHsLEeKvstSZSkJY0AsUNizSm670LBvB4L97ErG9Ig
         U38ek8rFqzZfGev1q/2J8S+WvtOlMe3cpqjFkvMn1gFtkvPbKK1+cS0CrAXMhmws0mjH
         XQsMdkt4qx5JmjO2U/2vGCkpPIxtXkZc9Yg66qd1BNHOBNUufAeTFKYnF0Wl9DzLeLgr
         ElpE6sAC/Q/2Yir6Ss7rDvkUubAE4qSUSZ5zZBs0ltTqUpu5RXsPqXNs3z4JW+3SFXtx
         hpgrVBLFb45n6SnjMa4wXK0CUL2AhvAgUdy8z3HWmgEIGYMxNVj/3nOUB3Za8q9kniw7
         Ubsg==
X-Gm-Message-State: APjAAAVTVtKWtJM0+nyigrEFc7/IuZWsPi8jv8N6+mExlSPdGBEUhdyY
        YzocwYEUH5YtxfyLf47zFUvHRQP2JiIodxkSSrZ+0Q==
X-Google-Smtp-Source: APXvYqwVExuza9aQvB4sh9y5dzwoQWHVe8Yok8w5NNZaS5azbOuOU0B0oXHXiZdK9krugg3/kxSnJdZF6yniRiSz2AY=
X-Received: by 2002:a05:660c:3d1:: with SMTP id c17mr1168557itl.166.1552638482539;
 Fri, 15 Mar 2019 01:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+Ywimrr3_oD2r=u0-Sz-PFXL2tpXA4q0odKDMM_Tvw0AA@mail.gmail.com>
 <8e8f8ac1-8b72-a21c-f504-74a5ce12b625@kernel.org> <CACT4Y+bJ+o7yLcPwQRbsD4_Ye_SsXe3GfmiozVJ-8w-4asyxbQ@mail.gmail.com>
 <7c37c201-8bca-ffa4-5e8d-5e0b4b268b3f@kernel.org> <CACT4Y+ZV2aMWjobgV=-aUdSLnGU=_2yuf2TOx4TD8ApoVqRVYw@mail.gmail.com>
 <CACT4Y+abRq25axHrxNczh7sVw2RjYJB8y7JOBmyMmVF5xJ+Y1w@mail.gmail.com>
 <CACT4Y+a2aQ31MVxtb0hYZ0mxaXLVmhgeP2iE5gFQgmafv3p7gw@mail.gmail.com> <1694e4f1-de18-bb34-2031-7d570d977495@kernel.org>
In-Reply-To: <1694e4f1-de18-bb34-2031-7d570d977495@kernel.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 15 Mar 2019 09:27:51 +0100
Message-ID: <CACT4Y+aj8cmoBjBt==9y=NCThOrntadAghsgMx2gBFGpD8B8VQ@mail.gmail.com>
Subject: Re: WARNING: ODEBUG bug in vudc_probe
To:     shuah <shuah@kernel.org>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 6:15 PM shuah <shuah@kernel.org> wrote:
>
> Hi Dmitry,
>
> On 3/11/19 8:18 AM, Dmitry Vyukov wrote:
> > On Mon, Mar 11, 2019 at 3:16 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >>
>
> >>
> >> The boot seems to be fixed now, but what commit fixed it?
> >>
> >> This bug makes all kernels starting from 4.14 unbootable for the
> >> purposes of bisection. If we figure out what was the bug and what
> >> fixed it, we can think of possible ways of unbreaking kernel boot.
> >
> >
>
>
> Upstream commit:
> commit e28fd56ad5273be67d0fae5bedc7e1680e729952
>
> 4.14.81 commit:
>
> commit 255624a35b4ca228bac9a1f135263e28c27c4640
>
> Please let me know if you are still seeing the problem. I will start
> looking at it.

Hi Shuah,

Thanks for info.
No, I don't see the problem at head. I am seeing the problem when
trying to do bisection and trying to figure out some practical way of
doing it.
