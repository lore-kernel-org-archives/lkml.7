Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B1AC742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E983620651
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XvTriw7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfGLRFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 13:05:19 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43775 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfGLRFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 13:05:19 -0400
Received: by mail-lf1-f66.google.com with SMTP id c19so6945135lfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 10:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s1N8n3V7P+ZrokJdWgOsoXRm7ISeimLMh/wha/tS3sA=;
        b=XvTriw7AVxpugBaAAj32xt2jKI21Tu7sQLu5mGs8WTE9AJuJxhAV1nkUVwsz0rq3fm
         pnu4f07LLR92rHalOArzjmQFRTI5dPFnA8AwlbRlOfDvWvmC+K8aq1XlkvLzryFkSMM/
         U0jh6B3MLyRr7acX1slHST+I8KzVtg0qbUQSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s1N8n3V7P+ZrokJdWgOsoXRm7ISeimLMh/wha/tS3sA=;
        b=IAY1kNyOx/Nx319yMVnSTQ+bkGAEDGfGLx68OzREO4UtkWpFVMcCdrHrPxyOxmqdf1
         b241d5ooh+JUBJyCY42ycaq/CkokYdHnE5NUS2OD3FE0SwsfiRFtQ+eBek4kyJvzvjUL
         FjHZo7bzlFW4IXUBvs3//LZFe4sZBaG+JWNXWUdSHAvaQMto4chuXAu8ycTjMOXjf5/n
         w3bZumcjGDQQEKHPLIoXShn9t5mefgxbur2Ch+ahJIQ5hb8yeieCCm0Dz68eGIfI8uS+
         GKwEe8D7EG2UxsXOQnLPqFheGeGckr9xliqSV7AfV7ZsPx6VJ8gc937AUqGMI4KPGwD6
         dNjw==
X-Gm-Message-State: APjAAAVeSkW3Ds/vrB0S49k+GWrw6j4+zhPMevSJOt7tgik06i2CJbRn
        10G1V5w2lnIHmybEse9oy1SKiXOTBtg=
X-Google-Smtp-Source: APXvYqzpsBanBWetCOk2zPl7FnwYv4wRY6m384rfgh9kKM1eIfCwjqG6kBDBvvv70A19wnwOApMqjQ==
X-Received: by 2002:ac2:419a:: with SMTP id z26mr5377683lfh.21.1562951116981;
        Fri, 12 Jul 2019 10:05:16 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 20sm1542554ljf.21.2019.07.12.10.05.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 10:05:15 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id s19so6932445lfb.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 10:05:15 -0700 (PDT)
X-Received: by 2002:ac2:568e:: with SMTP id 14mr5380609lfr.189.1562951115123;
 Fri, 12 Jul 2019 10:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190627204446.52499-1-evgreen@chromium.org> <CAFqH_53cmq+1Y_uL3D4-84v_vDJsoB0Qxr_zTVnOzX1XD7VEgQ@mail.gmail.com>
 <20190701060137.GB4652@dell> <14282971-65b1-f7db-26b9-d33636054ba6@collabora.com>
In-Reply-To: <14282971-65b1-f7db-26b9-d33636054ba6@collabora.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 12 Jul 2019 10:04:38 -0700
X-Gmail-Original-Message-ID: <CAE=gft6e46pL4-4eC5LPUgePj4ibWzJPzKHJ3_oeFuwoM0K+QQ@mail.gmail.com>
Message-ID: <CAE=gft6e46pL4-4eC5LPUgePj4ibWzJPzKHJ3_oeFuwoM0K+QQ@mail.gmail.com>
Subject: Re: [PATCH v3] platform/chrome: Expose resume result via debugfs
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 6:41 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
>
>
> On 1/7/19 8:01, Lee Jones wrote:
> > On Thu, 27 Jun 2019, Enric Balletbo Serra wrote:
> >
> >> Hi Evan, Lee,
> >>
> >> Missatge de Evan Green <evgreen@chromium.org> del dia dj., 27 de juny
> >> 2019 a les 22:46:
> >>>
> >>> For ECs that support it, the EC returns the number of slp_s0
> >>> transitions and whether or not there was a timeout in the resume
> >>> response. Expose the last resume result to usermode via debugfs so
> >>> that usermode can detect and report S0ix timeouts.
> >>>
> >>> Signed-off-by: Evan Green <evgreen@chromium.org>
> >>
> >> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >>
> >> Lee, actually this patch depends on some patches from chrome-platform
> >> to apply cleanly. Once is fine with you and if you're happy to have
> >> this merged for 5.3, I can just carry the patch with me, shouldn't be
> >> any conflicts with your current changes or if you prefer I can create
> >> an immutable branch for you.
> >
> > I won't be taking any more patches this cycle, so if you're sure that
> > it does not conflict, there is no need for an immutable branch.
> >
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> >
>
> Thanks Lee.
>
> I think the patch is simple enough, I queued for the autobuilders to play with,
> and if all goes well I'll add for 5.3 via chrome-platform.
>

I was hoping to pick this patch from a maintainer's tree, has it
landed anywhere?
-Evan
