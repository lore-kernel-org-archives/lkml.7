Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290D2C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34F6206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7ckL2eS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbfGaOXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:23:23 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46444 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfGaOXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:23:22 -0400
Received: by mail-lf1-f65.google.com with SMTP id z15so43317167lfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 07:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Mwmelmzw6bH/7dTu0yxXhnmtM+/gvfBNAeELEGk+uk=;
        b=b7ckL2eSD9hJ7+SslSVgXgqXaYtTrghJzWVqnzRH5arC0as5UaAex1ADlOstZ0ZAgH
         w5ZSSbXXNcoX8jtKyrctiyVtd6HsBbsFQtSIzZfS28PPueiU1cGACGc9zWiXCdQJ0wpk
         DuLQOPY6YkD5kUNXs40RHrruT+f6kC9kF/wo6v+T1ORrj4UiuM6wfpvSj2z9NXqnYLZx
         HgBwJ+wmjHC5w/e9yaL+cigyFxUP3EOJu/ohNtfLocTQL4WpgiRDQdhC4JvAcqraz54h
         jeVh4ugy80tt9CPL8cyTLUzJDd1ZgLNDIcSfQc8LqwcMzYNldlPqEfbX2KUc9A9DpGGy
         yiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Mwmelmzw6bH/7dTu0yxXhnmtM+/gvfBNAeELEGk+uk=;
        b=Ww7da1Hdcy8EWIV2NzkMy+gO1/ix1DHvaHC3iWS34tX2BuqbQZ575+HCdpjqWoBEMh
         fwgj72aJ0uAXzKS7YctUfB7J2fPuBlHI3PFhlnAhtGzxBVIsc2vkskvFBlsWfLF+ZVgB
         Jsvnr3zlDsok0HmyY43HRqPYd+7ar0feQViwehCBB8gTdmY8JVNXNADXefkYqSD5wYXS
         izD0MuA6d4A1IXflPQU8KLhRXhX84Q69GJh9YSGzxI4yKGZdNaeai0USguPHrA0/Bh3r
         Wsyt1FR4TAuR5QSt0ABicjMacuTvKns/NqAXWJo9bBA9ct6OpxiUFwbj3n8M7Xq8C1Pq
         tJAg==
X-Gm-Message-State: APjAAAW9mkIkhH/zimb4y/h6GXRn9OcdkvQFbv+Su6VlqzIm2DsVkQ1I
        b4ChqjYIN9szPtfjCd5t9G2B0QKU4Aw1fzvtII7t1Q==
X-Google-Smtp-Source: APXvYqzO1Rb1XuGHlY4gc7gehMJjpGhQ7bcBJg5KgrHrj/rbdrN0MlhufGWBshlYJcrDu7aQUEzfCCAGZ0ad3gulmm0=
X-Received: by 2002:a19:c7ca:: with SMTP id x193mr3049727lff.151.1564583000498;
 Wed, 31 Jul 2019 07:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
 <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com>
 <CAFA6WYPJAzbPdcpBqioxjY=T8RLw-73B_hpzX4cGnwVvm5zpJw@mail.gmail.com> <CAE=Ncrb23q++z8R8UMbjDE2epEq4YVcNGzrRD31eH3JAooYejg@mail.gmail.com>
In-Reply-To: <CAE=Ncrb23q++z8R8UMbjDE2epEq4YVcNGzrRD31eH3JAooYejg@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 31 Jul 2019 19:53:08 +0530
Message-ID: <CAFA6WYOKcOzSwakHhgshZcebD8ZBMSi7xQdjWYFS79=Xc+odOg@mail.gmail.com>
Subject: Re: [RFC v2 0/6] Introduce TEE based Trusted Keys support
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, dhowells@redhat.com,
        jejb@linux.ibm.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 at 16:33, Janne Karhunen <janne.karhunen@gmail.com> wrote:
>
> On Wed, Jul 31, 2019 at 1:26 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> > > Interesting, I wrote something similar and posted it to the lists a while back:
> > > https://github.com/jkrh/linux/commit/d77ea03afedcb5fd42234cd834da8f8a0809f6a6
> > >
> > > Since there are no generic 'TEEs' available,
> >
> > There is already a generic TEE interface driver available in kernel.
> > Have a look here: "Documentation/tee.txt".
>
> I guess my wording was wrong, tried to say that physical TEEs in the
> wild vary massively hardware wise. Generalizing these things is rough.
>

There are already well defined GlobalPlatform Standards to generalize
the TEE interface. One of them is GlobalPlatform TEE Client API [1]
which provides the basis for this TEE interface.

>
> > > I implemented the same
> > > thing as a generic protocol translator. The shared memory binding for
> > > instance already assumes fair amount about the TEE and how that is
> > > physically present in the system. Besides, the help from usage of shm
> > > is pretty limited due to the size of the keydata.
> > >
> >
> > If you look at patch #1 and #2, they add support to register kernel
> > memory buffer (keydata buffer in this case) with TEE to operate on. So
> > there isn't any limitation due to the size of the keydata.
>
> Ah, didn't mean that. Meant that the keydata is typically pretty small
> in size, so there is limited benefit from passing that in via shm if
> that complicates anything.
>

Ah, ok. Do you think of any better approach rather than to use SHM?

[1] https://globalplatform.org/specs-library/tee-client-api-specification/

-Sumit

>
> --
> Janne
