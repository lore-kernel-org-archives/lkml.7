Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED6AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A809218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qhEZvPbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388215AbfDXVCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:02:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35111 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfDXVCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:02:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so7057303wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 14:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=90V6tHz8ppnNaXZwqYE2RGnONEX+VuNCQ+e64/AEnGs=;
        b=qhEZvPbiCtDdagSWb+UKFJaaytmwkwAFK33k4bwlHO12ATONhxlkrHS9J0ZUH/0TkV
         JAfXLNAT2B0TTVSIjjKuZoMwCLJnFqJtes+OeB5xNkAwQVq/1AxuewWA99Tg7C1MSF8a
         avJ0I9PFm9jCEYB6yXeAc95YKVyOLgfVTBK0c/rSoNtLDEPN+Wd1yaKdJWO/5Mf+qY63
         WCMNP4QUAMZebmkBP/WNeDGbLYbsNRbZaEA7PY8etkl4my16c3I8kT5KcSfxIYlzPk08
         qfTITKExxfkGoRSWDfbNp8qr9+sMRvnWHSWKk+AyaNzXMz7syFlMzcro7dT+rBCRWQjx
         TV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=90V6tHz8ppnNaXZwqYE2RGnONEX+VuNCQ+e64/AEnGs=;
        b=DZQHtQDBMnbbZIDR3VmfgWgKLxD6BxtctOg0/kqutBvYqsC3TdQjY+2+4fKTZwf2Af
         O0cEy+5ex/P7yDX7UHTmu64aOnSCHLbPv7Fq3LB2clyYsY7tgGKhSWRyE9ZzIWxZ/VSF
         DIqyojrwsmqtYlIl8tdZz59p7oZ0NcChvhBsybRYS+U9jbHBlKOkWatRzrvW2gxOkepL
         66XAgyh40Hpn5xRtYOecg44EA1DMZxFmuN/ZCNKkh+W1IATmMqx+oW8zsIGEyvCOBE9N
         xSl6SOAK6iqz8LaHBSSlJ7Ej2jLNfb1CTgHDzzx3PWdZTfYx2ugK3v8V0zgRt9FkVYi+
         gDiQ==
X-Gm-Message-State: APjAAAU/A7E8s8UHpZ2ld0ymAjVm/RrmAcqOPi/U0kW2tINC099JyVd1
        Abfa9aTdE2Vs76ZKdeIm7sAl7B+VwTTonYKgaC5uLg==
X-Google-Smtp-Source: APXvYqxkwHjVPO6pF7Bm3wOO+bfCPOBgXaAE2nbV7tJCx2iA1YrBISkOpy7iEjr5HhBQwdlqb7+sy9a5O3Edk00eIbs=
X-Received: by 2002:a7b:c115:: with SMTP id w21mr740232wmi.55.1556139732439;
 Wed, 24 Apr 2019 14:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org> <20190424205409.GA27952@ravnborg.org>
In-Reply-To: <20190424205409.GA27952@ravnborg.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 24 Apr 2019 14:02:00 -0700
Message-ID: <CALAqxLV198e5Upu-wAFjkTdpFgZJuk6nEsUJEUdisy9AdnbAvw@mail.gmail.com>
Subject: Re: [PATCH 00/25] drm: Kirin driver cleanups to prep for Kirin960 support
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        YiPing Xu <xuyiping@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Chen Feng <puck.chen@hisilicon.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 1:54 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi John.
>
> On Tue, Apr 23, 2019 at 04:20:31PM -0700, John Stultz wrote:
> > This patchset contains one fix (in the front, so its easier to
> > eventually backport), and a series of changes from YiPing to
> > refactor the kirin drm driver so that it can be used on both
> > kirin620 based devices (like the original HiKey board) as well
> > as kirin960 based devices (like the HiKey960 board).
> >
> > The full kirin960 drm support is still being refactored, but as
> > this base kirin rework was getting to be substantial, I wanted
> > to send out the first chunk for some initial review, so that the
> > review burden wasn't overwhelming.
> >
> > The full HiKey960 patch stack can be found here:
> >   https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/hikey960-mainline-WIP
>
> On the mailing list we are missing patch 25/25 - I only realize now.

Oof. Somehow I didn't add my Cc: list to the commit message. Apologies!

You can find it here:
  https://lkml.org/lkml/2019/4/23/1140

thanks
-john
