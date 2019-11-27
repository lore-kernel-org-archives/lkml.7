Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E27C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 23:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23792051A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 23:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PvBbnjaf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfK0XnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 18:43:07 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:36686 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfK0XnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 18:43:06 -0500
Received: by mail-vk1-f196.google.com with SMTP id d10so5938970vke.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 15:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5V1U7K9kHqSmBC9GKmbu10OmsvEfDZWHZBAkdynx/3A=;
        b=PvBbnjafdCvEjlwAHLsw4Jkf5UKDz6s7witD5jd3/x70kOObX+EhN8IhEu1l0vMDao
         eyFB2VR6+BiVNsnhas396vPiie5zwGNVANUKDHufBAXVc0+9hKfbW030dFWNG3Cv/J7l
         hqmrKydCIurQVBzzegb3UutaspJwhtGXO/gKSvIA6Sq2HhXhwRAghpC1UbE1oDheTz8S
         qX4ZaH6B1tEQxHPimTogvOFaHeUSQzd1sKhIPU+fef2bGXQspLHe1EyC9nEza/asyLzJ
         b/YquzQ4e8aWWFpfl2u+fQMt+7m4lbuhnN1p9eHjdQdOaCsEYyXNqrWJj/1kRgyr8e+w
         v8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5V1U7K9kHqSmBC9GKmbu10OmsvEfDZWHZBAkdynx/3A=;
        b=qZkePn7fIqhhEJaj4xWJP4AquD2oVWrWJ6Y7Iq/Oa7LNrxluua4c4oRm50s+j2csCq
         7DPfpKJdX9e5y8yvnvt0xS+IXVM0hJoCiVoBHY6QJpk5Ft9fzYiGKKXV7t4IZr3JA2FV
         GYTpPu0Vezku8EV6sC/pcpY8BOku1Hg6vBTgoa6aEVXJ9LLLN8G4ASDPYFYE3klC7wir
         t0KxsE0L1XyvPMccqb40bxOv8hgGI7aoIzVAK+qfc7pOtGiMjkp9zkAQIAsGM9PuaFT/
         eUDH860u8KeZsXjhuMQW4k3IFxyWr2fRrHgat9VTyFRcUXmiPZI+EX34oI47S3/LB9AB
         jWNg==
X-Gm-Message-State: APjAAAWQnI8HZUi+V69XlRoMtLJyQRT08cOvZMUnKKSI/a5cHew+p6k4
        6bbGpysCifwNVxaR9cqh0SqBQDxBt4WvzL1+EkXqXw==
X-Google-Smtp-Source: APXvYqx1i0KATXqkxu2iu7n10l5sJYYFz7lSnecvNV9HWF093zCgA7YZz4hfleScYvfvsSSdbbjLOGlrCFIaftAte+A=
X-Received: by 2002:a1f:7d88:: with SMTP id y130mr4689848vkc.71.1574898185282;
 Wed, 27 Nov 2019 15:43:05 -0800 (PST)
MIME-Version: 1.0
References: <20191112223046.176097-1-samitolvanen@google.com>
 <20191119201353.2589-1-samitolvanen@google.com> <20191127181940.GB49214@sol.localdomain>
In-Reply-To: <20191127181940.GB49214@sol.localdomain>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 27 Nov 2019 15:42:53 -0800
Message-ID: <CABCJKud-JRT8mNmP8yMobeFajk1gU_iwss9w43keZyX9jasPXw@mail.gmail.com>
Subject: Re: [PATCH v3] crypto: arm64/sha: fix function types
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 10:19 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Nov 19, 2019 at 12:13:53PM -0800, Sami Tolvanen wrote:
> > +static void __sha1_ce_transform(struct sha1_state *sst, u8 const *src,
> > +                             int blocks)
> > +{
> > +     return sha1_ce_transform(container_of(sst, struct sha1_ce_state, sst),
> > +                              src, blocks);
> > +}
> > +
>
> 'return' isn't needed in functions that return void.
>
> Likewise everywhere else in this patch.
>
> Otherwise this patch looks fine.

Thanks for taking a look, Eric. I'll send out v4 with this fixed.

Sami
