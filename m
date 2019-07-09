Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81F8C606D7
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 09:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5F320665
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 09:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OOW1rTUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfGIJgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 05:36:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39633 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfGIJgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 05:36:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so18863656ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 02:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qhjUpDgndm8ekwrFAo69LPTowsaMFYgyulNhotUCOnQ=;
        b=OOW1rTUUsLyy9ppEo+DT+6XteDLqnEDFlCsR94YDxnEMUr9T1flAgWjdSMoG80Jh4A
         CeDatbdtkUvZP8J/ANKKuQJBUfyget/hPUlbe4atTLqrdK79ttfcMHiT8CrmvUttDtdk
         GpXGKg3wNvTLmsjcQs05ZryztiPJ57IZdO5mCNwWKdbLdIODAgblw8Q6/i+HKtDakar/
         8p0S+zvb+g3k2vQR3QCYPaOS4/97yPYSFWxFlHk/gjlIMJBAQFoDhQKJB1jRmGQlVAxI
         4kvYbSqUoYdcYS01MfQzun0poaxq9H7YT5meFAYHzG+IkgLsxhvnt16o7mCqeKrMbNF0
         VoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhjUpDgndm8ekwrFAo69LPTowsaMFYgyulNhotUCOnQ=;
        b=okj/rxwu1hg1JDKDikmqEzvj+4Ak//ouBegzCiuDhm5UcWis8kXLMhUa+yquzmLD2r
         MfJBBjNEe+uZ2q27CcBKKdUEPsy6NHO/YtNSF+yH7q0DKleFfTsHRct5n0XvF5SSQfwL
         1oJvhtXPO6ZgfPCgDd/qGq8JryOLhyB9jfsF4N+sFGSgzjCZnFs40FWOIDV5hQP4hoN1
         EPDCf9TgY89BehCAQjqWKlnmPqtVnrP1nf9GIH8PxJkXaLQd3ZT5LUmzSKYnIvOsic4N
         TZ0StSyrl4SiFaRI9GiZ+RC4Mow02MdYJrieWkPvbB0RsvG2Z4mgDQC7MIe0hzuLGjqp
         /MPQ==
X-Gm-Message-State: APjAAAVaKTWkw0fK8Guf64tr9AP6CiFWHzTW7xQM+oH545gg8KrQYMkq
        5filN+JpZDNKYbZuzpkD9bxenOIlN9GB6zMX5NMm+g==
X-Google-Smtp-Source: APXvYqzd5qaTN0SLD7LsokiKmNmPlx93wTsdxRg5AVYVegFwrPyNtxwMLB1gdj1gZmV3nncmBwjXXO2zzcRn3B7xdVQ=
X-Received: by 2002:a2e:970a:: with SMTP id r10mr12574045lji.115.1562665004281;
 Tue, 09 Jul 2019 02:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <1560421833-27414-1-git-send-email-sumit.garg@linaro.org>
 <1560421833-27414-4-git-send-email-sumit.garg@linaro.org> <20190708153908.GA28253@jax>
 <CAFA6WYNzs=RErreWaa5BmF-P03Vf9nzQjvY_JpMckw87k9z12w@mail.gmail.com> <20190709070354.GA5791@jax>
In-Reply-To: <20190709070354.GA5791@jax>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 9 Jul 2019 15:06:33 +0530
Message-ID: <CAFA6WYPHVXbsOjzGVT1WWziMRKmWns=3YkD6_j+C1OJxTUbDmw@mail.gmail.com>
Subject: Re: [RFC 3/7] tee: add private login method for kernel clients
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, corbet@lwn.net,
        dhowells@redhat.com, jejb@linux.ibm.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>, jmorris@namei.org,
        serge@hallyn.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tee-dev@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2019 at 12:33, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> On Tue, Jul 09, 2019 at 11:26:19AM +0530, Sumit Garg wrote:
> > Thanks Jens for your comments.
> >
> > On Mon, 8 Jul 2019 at 21:09, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > >
> > > Hi Sumit,
> > >
> > > On Thu, Jun 13, 2019 at 04:00:29PM +0530, Sumit Garg wrote:
> > > > There are use-cases where user-space shouldn't be allowed to communicate
> > > > directly with a TEE device which is dedicated to provide a specific
> > > > service for a kernel client. So add a private login method for kernel
> > > > clients and disallow user-space to open-session using this login method.
> > > >
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > ---
> > > >  drivers/tee/tee_core.c   | 6 ++++++
> > > >  include/uapi/linux/tee.h | 2 ++
> > > >  2 files changed, 8 insertions(+)
> > > >
> > > > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > > > index 0f16d9f..4581bd1 100644
> > > > --- a/drivers/tee/tee_core.c
> > > > +++ b/drivers/tee/tee_core.c
> > > > @@ -334,6 +334,12 @@ static int tee_ioctl_open_session(struct tee_context *ctx,
> > > >                       goto out;
> > > >       }
> > > >
> > > > +     if (arg.clnt_login == TEE_IOCTL_LOGIN_REE_KERNEL) {
> > > TEE_IOCTL_LOGIN_REE_KERNEL is defined as 0x80000000 which is in the
> > > range specified and implementation defined by the GP spec. I wonder if
> > > we shouldn't filter the entire implementation defined range instead of
> > > just this value.
> >
> > Agree. Will rather check for entire implementation defined range:
> > 0x80000000 - 0xFFFFFFFF.
> >

I had a second thought on this. It would be more restrictive for
user-space TEE client library which may need to use implementation
defined login method. So either we could define specific ranges for
kernel and user-space or we can start with single login method
reserved for kernel.

> > >
> > > > +             pr_err("login method not allowed for user-space client\n");
> > > pr_debug(), if it's needed at all.
> > >
> >
> > Ok will use pr_debug() instead.
> >
> > > > +             rc = -EPERM;
> > > > +             goto out;
> > > > +     }
> > > > +
> > > >       rc = ctx->teedev->desc->ops->open_session(ctx, &arg, params);
> > > >       if (rc)
> > > >               goto out;
> > > > diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
> > > > index 4b9eb06..f33c69c 100644
> > > > --- a/include/uapi/linux/tee.h
> > > > +++ b/include/uapi/linux/tee.h
> > > > @@ -172,6 +172,8 @@ struct tee_ioctl_buf_data {
> > > >  #define TEE_IOCTL_LOGIN_APPLICATION          4
> > > >  #define TEE_IOCTL_LOGIN_USER_APPLICATION     5
> > > >  #define TEE_IOCTL_LOGIN_GROUP_APPLICATION    6
> > > > +/* Private login method for REE kernel clients */
> > > It's worth noting that this is filtered by the TEE framework, compared
> > > to everything else which is treated opaquely.
> > >
> >
> > IIUC, you are referring to login filter in optee_os. Change to prevent
> > filter for this login method is part of this PR [1].
> >
> > [1] https://github.com/OP-TEE/optee_os/pull/3082
>
> No, I was referring to the changes in tee_ioctl_open_session() above.
> It's relevant for user space to know since it will be prevented from
> using that range of login identifiers.

Ok, so you mean to extend the comment here for user-space to know that
this login method/range is filtered by the TEE framework. Will do
that.

> This will restrict the user space
> API, but I think the risk of breakage is minimal as OP-TEE is the only
> in-tree driver registering in the TEE framework. I'm not aware of any
> out-of-tree drivers registering.

I am not sure if I follow you here. How do you expect this change to
break out-of-tree TEE driver registration?

-Sumit

>
> Thanks,
> Jens
>
> >
> > -Sumit
> >
> > > > +#define TEE_IOCTL_LOGIN_REE_KERNEL           0x80000000
> > > >
> > > >  /**
> > > >   * struct tee_ioctl_param - parameter
> > > > --
> > > > 2.7.4
> > > >
> > >
> > > Thanks,
> > > Jens
