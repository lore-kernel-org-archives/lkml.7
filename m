Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFF5C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 21:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C826B2067C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 21:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="enBQ2ke4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLVVpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 16:45:09 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38879 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfLVVpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 16:45:09 -0500
Received: by mail-lj1-f194.google.com with SMTP id k8so15915329ljh.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 13:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J/8DxvJyl/DYTTEBkW4RkS2X5EojflCvltFi0nfAxyo=;
        b=enBQ2ke44xQcWsf/s+g31ipAtkQghq0D2eqcU2AHyWBsO07qQT0r82qsRubz8RF7NA
         jZcFhiPEll35gsiJnV4B+/b3TUWRYONSCluZ3Kx1DUUre78kqgDzSdS5TYDyj5xSKV2U
         TF3wt/Qet8wpKJn802kklba7tbQQ0pbch0A+p37IDkCqdgBhcIda7LoYNJUxYgeFKgvj
         Bll8boAROpkuRLs6m73zBOHRLYfecVTduuDF6YgXa9b7WVw9eUXF4SxLV8jXOtd5umFJ
         MiJ2wJJRbAlW5jeUEsr8ulvYmG6Y4/BOwvYs/VyOn/rYY5eCnLlenYNeIFShrtrDkwLk
         w5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J/8DxvJyl/DYTTEBkW4RkS2X5EojflCvltFi0nfAxyo=;
        b=gKWE5Mbs+NHOtAtLyh8/XJTyQ43hIqCTHc38z+ZDLnNSHtXPZBkx4LtBGw6vR8xpVn
         z5NCt9OfSPdWFwKqBScTPvbdduH1RZHRVLySC846Dv7CtSUFBsRHG92vq3ATvZXUhRj6
         Gvxqaz6bER9F4Lrqlwel6u1oCtIQXx8UwxvA8iYQthLrDSEzMb2HXJKaszZUktbdvjA9
         fWUASKM+pgGQonCTSELmM6/My5lvxW61mJnT0EUBDPuYQVx1eAiSAVxqc4WVJn6ARDe0
         3L8gRo0OOnNxShy85opnJBpSAl7f/xNQk3SVqftxGVd8ptU0oz0ycA0b5Kbk2Yho1N0R
         1Lqw==
X-Gm-Message-State: APjAAAWTNS9mPaPnLrZAAsPSNSKF5j+cn98OtiICiQOOyUQEFbSgbMiV
        dn87oLdo6TGvuzT5LyUvDg13+kDWoA6gTjvOEurJu6RImCE=
X-Google-Smtp-Source: APXvYqy+XNcc05vznXg7I/Hks5Lv+hXplgYpPuTPAaZB4xSWms2trRvgB8bBCZTnH7/PfdjHOKCjFvYmxQkPko555GE=
X-Received: by 2002:a2e:85cd:: with SMTP id h13mr15268705ljj.191.1577051106841;
 Sun, 22 Dec 2019 13:45:06 -0800 (PST)
MIME-Version: 1.0
References: <20191222202735.13910-1-linus.walleij@linaro.org>
In-Reply-To: <20191222202735.13910-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 22 Dec 2019 22:44:55 +0100
Message-ID: <CACRpkda+BJei1Q1Kp6CAk8n_3tBY9N5Xq4pjSv4tfxA9H9RJEQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: db8500-prcmu: Fix DSI LP clock
To:     Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 22, 2019 at 9:27 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> The DB8420 sysclk firmware is missing the ULPPLL
> (ultra-low power phase locked loop) which has repercussions
> on how the DSI LP clock is handled in the PRCMU driver.
> This was missed in the patch adding support for the U8420
> sysclk firmware variant.
>
> Move the functions around a bit to avoid forward declarations.
>
> This fix is not a regression as no systems in the kernel are
> currently using it.
>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Fixes: 22fb3ad0cc5f ("mfd: db8500-prcmu: Support U8420-sysclk firmware")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Scratch this... I realized it is dead code that is superceded by
the proper clock framework. I need to go and fix the
clock driver instead and send another patch deleting this code.

Yours,
Linus Walleij
