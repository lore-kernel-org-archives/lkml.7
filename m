Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFE0C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742A420856
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="okJuwlFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfHELaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:30:04 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46626 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfHELaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:30:03 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so79133913ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 04:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b27Uxet0wS8heQ/uw8g5KksWqeArgR34fWuxvwa86go=;
        b=okJuwlFFgvTnn/ENXSu5uVLZd90esmr0PeAasyEAjvvQOBioQ9CraF3qaK1yHy4Tsc
         05Ax1mQL+MZtfVgufZvPgI7hFgVPUQCn5R3wPoFj+Pk1COAuj+FvYi2goUZyvm/26/J+
         +QW4FoLOBSgcpnI9cQAciCUXFGt/Rz9n5bU/j17HrjmCaEdULpMhnrMCSB1buBCtfO8L
         lPXsHxCRQNoKliMkLwhXohkAqw2qP9Ak5uY9RfPakkL1eysnWxN1CahKPVGsFqDq5ANh
         Y6roI+60yj//+P1IJXT0e/EwMBTMFM+LpZc2z4c2cC2b5TDXfAsKxupjovUqZKAqaek6
         1BDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b27Uxet0wS8heQ/uw8g5KksWqeArgR34fWuxvwa86go=;
        b=P5yhmxa8NYLSpzvsnPNZrEjU56nuQR6X907NlAjsrSf42XOnYFnAsaEoM116Sfy966
         muvHQqAel3e/b6I4+G2kVLAdyRqiYcESz8ErtRqgCsr0D3nQyQ4qZW1fWF5EG67KE58f
         UAmlMJaZqsMYF+VQ9CBfvfg9bTwkRNa4cjJKfb9wBabfeCkjmIxtRlOHT0v2CpPyKqDY
         0/wjn/++C6VvYjQFn54+3OdXCOCAs+l7WXHEDYjaGi1oW2p3JDYndEKPQBNgGJJLVnnu
         pFEnEs6GL+0SWMbz03ZC0xs1gd/if7GVo26PdjQGYZ+cvwdp9fgDcIfHAQUQAEx1+76l
         ccnA==
X-Gm-Message-State: APjAAAV9/N2Mh78yxoaJidjE+6yy1QdjTRc9hLFel/3NCKxjm7IUyrfU
        RfU7khbbnGUri1++7IEX22Q49iA1jBcp8zyOXnjYrg==
X-Google-Smtp-Source: APXvYqyWjX7ImD434EUnGcBL+cAcnTOa29T0Gg9vkUy0uyuDubU+396J3QMFCOfCS8owfk3sgIVLrR367Ak25N4S+Do=
X-Received: by 2002:a2e:2c14:: with SMTP id s20mr16587126ljs.54.1565004601793;
 Mon, 05 Aug 2019 04:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190731132917.17607-1-geert+renesas@glider.be> <20190731132917.17607-2-geert+renesas@glider.be>
In-Reply-To: <20190731132917.17607-2-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Aug 2019 13:29:50 +0200
Message-ID: <CACRpkdY0A5dTORVD12jvTJrQQq0jJUtF78uF4g42PE_LWCxYhw@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: devicetree: Use strlen() instead of
 hardcoded number
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 3:29 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Improve readability by replacing a hardcoded number requiring a comment
> by strlen().
>
> Gcc is smart enough to evaluate the length of a constant string at
> compile-time.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied.

Yours,
Linus Walleij
