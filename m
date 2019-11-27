Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68903C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3714020678
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SMS3LbaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfK0OAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:00:18 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:42052 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfK0OAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 09:00:18 -0500
Received: by mail-vk1-f194.google.com with SMTP id r4so5459363vkf.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 06:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xv0agzTrWmCHWWQdEdnjrauxL6G7A6I1j0PhE1Au3GA=;
        b=SMS3LbaEfWEtk84MXTU1uY5sFT4i44DeL2NZO367/zZdh7MGxJwvobTxGQZIvkXmjt
         HKCivkes+H/swMNZxbygP2FDC6U+xHFyiW05trlZU1cniHBIu60/1Ik96HlX/dL/RH27
         Le3sp14Ldq4KMTRYJNQKVZZLhHUiDylCzNRBnESSO4lHsd3c3knyPh7TClIcSdxRGZX1
         N9HCa83BV9qLZHtXkGgqq469wsJeY0mdHM1TCf7UcvPhCkxgZCa2pK1yweCcAZjj4KNw
         +qE41yWCXXY+Ue6T0MSwV/Eb6ZcRLspo3Jlp4dxp5mBSEWDYthXsphbE+mMoG36oY64I
         RW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xv0agzTrWmCHWWQdEdnjrauxL6G7A6I1j0PhE1Au3GA=;
        b=qcNiOuTDO98702OYEadJNX9Ox9eNdza7C5riazGNiRc/zH7wTov0k1CEqNKPlat5vw
         k5im0tsYYFq7cLqF0bkCQyhaQ1m2U4YH/vyWW5AVtZZQ89qbcKNGdelayAVnhIEwBFwj
         SWGng8Jp4C40HTKxwpW/TIJ7lYrKI13lwK9JUdCCzgrKjU7uvfarjCdkkYeg8Uc7vio7
         fIJwYtQU5tUQuPspk3atOFLQPWhoaKnTu6ANI4eIGZjHC40Kc9bvPgENo3R36sFjRZh5
         XzV+PMa5T5NhiAqnMWh2TYhM92ECrQ0aObFSD8G2P+fmqMKJaueFqoTSV6bmIeoLIHyz
         Q03g==
X-Gm-Message-State: APjAAAWBalcWL9WLaHZDwn+pn3udiFiQHkJ182Ho7aFK+iMYa9QOIjjL
        GLt/vPpedduRvvr8TrYjybWXyohhDrv6LXa7nT4uyw==
X-Google-Smtp-Source: APXvYqy2z1ESn19JzZsxw2MQg1P7KKVZTecOuQKJc1YhRGnEfvelj4LBPw5SELJgHKFj9GZ2pB9Vdn4PruN7+IvV/3w=
X-Received: by 2002:a1f:cf43:: with SMTP id f64mr2942105vkg.18.1574863217253;
 Wed, 27 Nov 2019 06:00:17 -0800 (PST)
MIME-Version: 1.0
References: <20191124205110.48031-1-stephan@gerhold.net>
In-Reply-To: <20191124205110.48031-1-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Nov 2019 15:00:06 +0100
Message-ID: <CACRpkdYnR3jYtrEWyKf=fi2c1Mvype9FeiKKmoLjK+1R73iVBQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: ux500: Use "arm,pl031" compatible for PL031
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 24, 2019 at 9:52 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> The Ux500 device tree uses "arm,rtc-pl031" as compatible for PL031.
> All other boards in Linux describe it using "arm,pl031" instead.
> This works because the compatible is not actually used in Linux:
> AMBA devices get probed based on "arm,primecell" and their peripheral ID.
>
> Nevertheless, some other projects (e.g. U-Boot) rely on the compatible
> to probe the device with the correct driver. Those will look for
> "arm,pl031" instead of "arm,rtc-pl031", preventing the RTC from being
> probed.
>
> Change it to "arm,pl031" to match all other boards.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Patch applied.

Yours,
Linus Walleij
