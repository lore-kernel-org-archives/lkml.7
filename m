Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFBDC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FB620578
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/JH7bf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfENWVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 18:21:17 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35466 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfENWVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 18:21:13 -0400
Received: by mail-lf1-f67.google.com with SMTP id c17so422075lfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 15:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+OtVSd1FrmNxy/p+usEzY6aM34Bbr0LTU+BRLFlaof8=;
        b=W/JH7bf1mRDquIegV2HHEy4q8VzdjuBFV4xy4Dmop/7ucj5+uG3LzXwOBs7jcB+QCY
         OlPN2V+hSjGpnv7LjMhfeDdzLypPCGFb/uCq6Awe/GX/y26kN/E5W8T6MEGJnR72WM/9
         jcaxAEk3lLlQgwbM43n9Qo9mFrkgMfc7Z96GoHZKhNpWLfVLaOkbewgny7oYSJezrpVr
         zSceu2oFk7PJAgb6ro/LNUDGHsDGu9L1pUOaBDBq7eFPDwAbPQnmT8QiAvFPQmz8RTr0
         AHYrc71tqvsExK6e09Y1CwIquCVpzkH+HXd3lHwg+SpKqKXdD54eIchI+o5AONeADMiK
         OhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+OtVSd1FrmNxy/p+usEzY6aM34Bbr0LTU+BRLFlaof8=;
        b=VFc0QzU57rZ5CT5nCwrQl+BJLwE7ow8YRbgU3klGWKrKBLOMXKu88RXG3UMWz+Rhld
         7wZMzkBP0X7k2Dy6pJxHpCIybZsNVJaR/1ctof8RwQ4NF4lFF7PfOLyYucy3yAMhm/Ah
         tmIqgyJYEqAObJAjTMmdzTUzOf0jdhJXOHbLmdNgGEusPTMbDN2sEW00lOT9eZBtwpav
         ZWy0nVpVLr5MFY1o7VGcSpIiDQPyH16DqVrqyjFjzzHkqNH2/QsHPXZHLhkGT0ACd9nO
         N7I6OGe8BqLJcTqaNyzcZdK7atVo9P9lYYT+mWA7iEtumsa+CbKEQHx3pcfCgE8Rz/96
         7ArA==
X-Gm-Message-State: APjAAAUlzKJ44FAVRDZDbLBtxo8jHloIlqKug7yWPHq9IsTRzWr/j13Y
        l0f0jDnmqfrT9qrKh9O8xkCy0Bgq4lIUeoPSOz8Ip/Ok
X-Google-Smtp-Source: APXvYqy/twYJjwOZb9r2coc1PSAOIHnTXmlPVJwyk16KaXlluPVNflawmyg268sdqFyk/N7+Hg2wii5gdmVnRAqQBio=
X-Received: by 2002:ac2:5621:: with SMTP id b1mr19146942lff.27.1557872471369;
 Tue, 14 May 2019 15:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <1557758781-23586-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1557758781-23586-1-git-send-email-linux@roeck-us.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 May 2019 00:20:59 +0200
Message-ID: <CACRpkdb6EEchXBSnO5SckGq7MY0z26Fq-=y+uJR=2_SCMC0q+Q@mail.gmail.com>
Subject: Re: [PATCH] drm/pl111: Initialize clock spinlock early
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 4:46 PM Guenter Roeck <linux@roeck-us.net> wrote:

> The following warning is seen on systems with broken clock divider.
>
> INFO: trying to register non-static key.
> the code is fine but needs lockdep annotation.
> turning off the locking correctness validator.
> CPU: 0 PID: 1 Comm: swapper Not tainted 5.1.0-09698-g1fb3b52 #1
> Hardware name: ARM Integrator/CP (Device Tree)
> [<c0011be8>] (unwind_backtrace) from [<c000ebb8>] (show_stack+0x10/0x18)
> [<c000ebb8>] (show_stack) from [<c07d3fd0>] (dump_stack+0x18/0x24)
> [<c07d3fd0>] (dump_stack) from [<c0060d48>] (register_lock_class+0x674/0x6f8)
> [<c0060d48>] (register_lock_class) from [<c005de2c>]
>         (__lock_acquire+0x68/0x2128)
> [<c005de2c>] (__lock_acquire) from [<c0060408>] (lock_acquire+0x110/0x21c)
> [<c0060408>] (lock_acquire) from [<c07f755c>] (_raw_spin_lock+0x34/0x48)
> [<c07f755c>] (_raw_spin_lock) from [<c0536c8c>]
>         (pl111_display_enable+0xf8/0x5fc)
> [<c0536c8c>] (pl111_display_enable) from [<c0502f54>]
>         (drm_atomic_helper_commit_modeset_enables+0x1ec/0x244)
>
> Since commit eedd6033b4c8 ("drm/pl111: Support variants with broken clock
> divider"), the spinlock is not initialized if the clock divider is broken.
> Initialize it earlier to fix the problem.
>
> Fixes: eedd6033b4c8 ("drm/pl111: Support variants with broken clock divider")
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied to drm-misc-next-fixes and pushed.

Out of curiosity: do you have a "real" Integrator/CP or is this
QEMU?

Yours,
Linus Walleij
