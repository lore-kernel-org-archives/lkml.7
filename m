Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E05C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6A520B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8TYwCph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733111AbfFMPoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:44:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36946 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbfFMPoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:44:13 -0400
Received: by mail-lj1-f195.google.com with SMTP id 131so19033875ljf.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 08:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aeSaLtysUhVZqqrP3nPvYNbe4HwweI7WGntZ/Db3p8E=;
        b=o8TYwCph8F6Zw0zSI173WRNNuJ9VYvLFHvYJ3//mpo0H++iwmfY4O2LBH2lWsQN179
         Os7vZTzzwNQvWBBc27KDaZAohaC3tJm38YSYu0Z8Y8u6gLMCX9K2bfyn6R1RligqF4JX
         HPZiWRLhTp6QmcPzvCzwqSezVsCqgzcz263KaaONbboEHDO3gxiBRLTGHvpmMVccYOkt
         Bq9CWik3l9wbWWA+sRCC2Z38pCDN9xVh5iph80M/GqYS2G2b74rGK0Ap+4Kd9yerMe/E
         y64uDJsHxCooI7j3kbYE/YFTxHA4wu/5vtRQmQhlhicwNk1ZE27eaJPzfZCTDnloN3wY
         p4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aeSaLtysUhVZqqrP3nPvYNbe4HwweI7WGntZ/Db3p8E=;
        b=k0y8liiHKxz74mGpUukAY2oeVu6Vj2l7fw69RE0BOBzdDrCuX/1o2q75aP8q+7Az0k
         AjbcmH/39F1Qpw5UrjYFgWstO8RUgwNJRN/wsBstcvK38TBbDz3yUGt/EGmaR9LSqpBt
         1yv4H9tUwrG7oSd8fS+4qSBc/3YN/HnyTbZqARLjCrfvGIdHy7od3rOFtaX8PttIi7jw
         dGV/wrMWxQr+4WrB7CJ44Cinq/0Dz0Y7Wz/W+A52CDTxDXGP0k4pEVnpKCjuHWn9DpZ5
         HIJr8thgqKy3Uwdd9Exvir03ri/akhh5YOUQFt0aqO+tVT2KQ4i/8mNH84kSNv/E1Ix4
         uIkQ==
X-Gm-Message-State: APjAAAVgXgZSBNmxUOcNIynedDmZhqpQy+gX61ScjgjEwHH1OfC+ZE5o
        rC2z7HtGQlMxpxxE/kE5yv/cIBY3vowy4Ou8c4EPXA==
X-Google-Smtp-Source: APXvYqzDl8aZ71rEDJAzz+at+3iJ0jmbSQCM57+PHRZzFNYODa5kE1RGaoSGllClbnSt3dnYLQWCwnvx3i9/f9IgeEk=
X-Received: by 2002:a2e:9e4c:: with SMTP id g12mr22711728ljk.3.1560440650723;
 Thu, 13 Jun 2019 08:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190612202927.54518-1-tkjos@google.com> <20190613054136.GA19717@kroah.com>
In-Reply-To: <20190613054136.GA19717@kroah.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 13 Jun 2019 08:43:59 -0700
Message-ID: <CAHRSSEwqg9dOddrPE1dUBwOqTbkR+tvzS41hQSpJD4o-f9YX4w@mail.gmail.com>
Subject: Re: [PATCH] binder: fix possible UAF when freeing buffer
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Todd Kjos <tkjos@android.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 10:41 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 12, 2019 at 01:29:27PM -0700, Todd Kjos wrote:
> > There is a race between the binder driver cleaning
> > up a completed transaction via binder_free_transaction()
> > and a user calling binder_ioctl(BC_FREE_BUFFER) to
> > release a buffer. It doesn't matter which is first but
> > they need to be protected against running concurrently
> > which can result in a UAF.
> >
> > Signed-off-by: Todd Kjos <tkjos@google.com>
> > ---
> >  drivers/android/binder.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
>
> Does this also need to go to the stable kernels?

This patch won't apply cleanly to stable kernels so I'll submit a new
patch directly to stable@ (4.14, 4.19) once this one lands.

>
> thanks,
>
> greg k-h
