Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F3CC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AA621823
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GRcBYNyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfLFJ6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 04:58:00 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42814 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfLFJ57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 04:57:59 -0500
Received: by mail-oi1-f195.google.com with SMTP id j22so5626345oij.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 01:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bd3b8s9M4GfmWGy+FhxvfH9623GW+Z7GHq6ZS9FSEio=;
        b=GRcBYNyOoDchHsvsxvVKzhiW2zFeqsSCfSe3TO1ffjwaO9eHhr8zq6aGVHQbXsaFiu
         jiUOuSU4mtLfxy+snruKr/D40IY6hvP5oRadabynf3MXktNB79rPfpKgwwAjGCA4DNOb
         AZj6s1+HOUvDL4oay8vA+ka9LOQ3DmRsPInjIh4NS+Sb0vXy/eZZ1fqyrCMi8cGmu+9O
         6+Vq6nAyzw7qSjBuWHi/JdVG0fuIs/psUwBnC6WK7FnSWOL+ul4f6cFdFc+YJe9eWo6Y
         okE6HhRKVctWvIGv+hd7ywhVLUB0lNE3/2SaB6Zjhig2uKA8ZlZAjIJneiRdY6h4u6Zm
         AJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bd3b8s9M4GfmWGy+FhxvfH9623GW+Z7GHq6ZS9FSEio=;
        b=d2Kc4CY4hu9yccN5Uc78rogHH1okgzcDxGjBATQgJ1o2Re2+q0Qia8M9oC8N6boEKK
         M4OK4UGwU/Qj5XqKEYkpQUI6EmT+4XA2hYrfojWwr7TVvoi9guCA+h/Vi8K4h2BPQgfi
         60aVhL3ZuFewIH68ZM9xvG3REYBAjcZro/yH8/FWiltJSxIzcECjYCRZX9xwZxcXH8er
         EUTl5CfVQ8zJFWy1d3iBEpWqQXAmRLoObh4FW4b4sjiG2Lblucv6RdVnFCnD0BvssOiP
         6gDyQT+2TGew9Lw2hGhfkmOaNxx3bXaIlev5Ag5ekhJuB7MlchvtCdu3+hOCq+TO0Bgg
         dofA==
X-Gm-Message-State: APjAAAX2ouJ0wpC3WRqS0Im39pupmFzgVotzIU/ssgW47JnasqggZFJq
        Nl+PnUu5g2diKnwIfBdvybc0deNVNvNlIuvZZ6lNZrYn2JCjog==
X-Google-Smtp-Source: APXvYqyDnLc6uv7xzZtApm05mqm0a04G/D0I7RYMQbOUqCTBzRSrVF5EQQbhaRJRrabLzCvuAJo9T7WdLIzjmjrm6MU=
X-Received: by 2002:aca:de03:: with SMTP id v3mr6077838oig.162.1575626278605;
 Fri, 06 Dec 2019 01:57:58 -0800 (PST)
MIME-Version: 1.0
References: <20191115105353.GA26176@jax> <20191116234048.oas2rlfwxlz65jvp@localhost>
 <CAHUa44EQ-1SUd0dDBp43_EGPMPArq_g8=1hSKZ3EC0uELUKH_A@mail.gmail.com>
In-Reply-To: <CAHUa44EQ-1SUd0dDBp43_EGPMPArq_g8=1hSKZ3EC0uELUKH_A@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 6 Dec 2019 10:57:47 +0100
Message-ID: <CAHUa44FaxiMrGwOLPrej_zMrVFyBExfPTqeHfYfocpc8x8LzLg@mail.gmail.com>
Subject: Re: [GIT PULL] tee subsys fixes for v5.4 (take two)
To:     Olof Johansson <olof@lixom.net>
Cc:     arm-soc <arm@kernel.org>, soc@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

On Sun, Nov 17, 2019 at 3:22 PM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> On Sun, Nov 17, 2019 at 12:45 AM Olof Johansson <olof@lixom.net> wrote:
> >
> > On Fri, Nov 15, 2019 at 11:53:53AM +0100, Jens Wiklander wrote:
> > > Hello arm-soc maintainers,
> > >
> > > Please pull these OP-TEE driver fixes. There's one user-after-free issue if
> > > in the error handling path when the OP-TEE driver is initializing. There's
> > > also one fix to to register dynamically allocated shared memory needed by
> > > kernel clients communicating with secure world via memory references.
> > >
> > > "tee: optee: Fix dynamic shm pool allocations" is now from version 2 which
> > > includes a fix up with a small but vital dependency.
> > >
> > > If you think it's too late for v5.4 please queue this for v5.5 instead.
> >
> > Hi,
> >
> > I noticed you based this on -rc3 -- all our other branches are on -rc2 or
> > older.
>
> I'm sorry, I thought -rc3 was old enough. I'll stick to -rc2 or older
> in next time.
>
> >
> > Anyway, I brought this in to the fixes branch, it's the only thing we have
> > queued up at this time so I'll give it a few days in -next before I send it in.

It looks like the two patches in this pull request
(https://git.linaro.org/people/jens.wiklander/linux-tee.git/tag/?h=tee-fixes-for-v5.4)
are still in -next and haven't got any further. Is there anything
wrong? Something I should fix?

Thanks,
Jens
