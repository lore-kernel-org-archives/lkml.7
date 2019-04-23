Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AACBC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1977721738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mXjEB6+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfDWLBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:01:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33262 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfDWLBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:01:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id j11so11395195lfm.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 04:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gS3jY0cmkbFsh3cNxOmZnt/KE4EI6n91gBXnGpPbZ1Q=;
        b=mXjEB6+lo1HOESakhWrQ9pwSHM0TTBKJ/dIVZh1wzO5Ez4T/92hBLLV44VC07ZRMvt
         snpwDMT78FHiYuZu7KvsC9+pNpkH5OqoliZMNMq9ISIPxXaOUG+mjhEon054XrBbxz51
         TRdLlKbQKoJZ43uJlOvNzLJq7c0WL6mBF5aTukyd2SB/TlV20Tnih0cE0JpN6a7mNuZJ
         LY4BLdbyta/q4t/eIsjKhIxaZhqBrcuf+uXCJRdpF3jKIKNLPyKIWraaJxo5AXBsSJwR
         tH8XtTZqdNUhCNwNMi1D6m201cnljOuVrvh05X9quZt8m4qVGrHtAxfqvOFw5m7O4L7A
         uNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gS3jY0cmkbFsh3cNxOmZnt/KE4EI6n91gBXnGpPbZ1Q=;
        b=Rm7AwCerJF3pykNAOYyO9E0VaEyjbi7LhLWfkkV8HZqv99ltr2tKh2EGoURDi77nNc
         3dOt/C7+gjHAF6Bt/6hDz8rqvvCZH7wCSCIf6cTKFMGnVfxF6msa2o0u073if+vnUV6w
         /DN6PzMTFfFm1Y8k8kvPi/XgYmtCQigNzYocVQvD23v2nGBSMVmK1xDKc5BOAdEhwYFn
         L9b5xpAyIc9QlTuE5m0AtyjoqWljUxtqVOVWPUjmwO/5wu0DcevXiXYy/2eNo7mgNmVB
         Facz5UM+muHhqQ1czok3r3DAbSIsHqVAmrfHceuZ1yAdU3/XX8Vqj8T94SLf1AXC8YH+
         mx7Q==
X-Gm-Message-State: APjAAAVS46ewgNLK7+c1WBiGHCCDXZ/jo7mxVUr3Epofv/PWU5IhpbSE
        SNIv4KBajgCQbrg6ufOVzmI0v1MmSOM6OQzGvXmfBA==
X-Google-Smtp-Source: APXvYqxHCBLuMMwfVuMemjoZPJ1cT1LWnsQq1xx6AGcVpGsdx6BL5lCuQ04MVK7flKgJBhn7Yi1G2d9ABJZDm7cT+PU=
X-Received: by 2002:a19:f001:: with SMTP id p1mr14389561lfc.27.1556017272455;
 Tue, 23 Apr 2019 04:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-16-fparent@baylibre.com>
 <CACRpkdZZ6-+MVdK4bOP4SHxQ8uQ8zENcir7DSteHy4g+B5uySQ@mail.gmail.com> <b1e4eb6c-0d53-0307-99e4-9fef9e2b33d8@gmail.com>
In-Reply-To: <b1e4eb6c-0d53-0307-99e4-9fef9e2b33d8@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 13:01:00 +0200
Message-ID: <CACRpkdZ8gq+hGRT6EAyP2w9K0jz5RAzWeZ6_UrW+v-BOjd-wbg@mail.gmail.com>
Subject: Re: [PATCH 15/24] dt-bindings: pinctrl: pinctrl-mt65xx: add support
 for MT8516
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Yong Mao <yong.mao@mediatek.com>, jjian.zhou@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-i2c@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        linux-spi <linux-spi@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        stephane.leprovost@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 11:12 AM Matthias Brugger
<matthias.bgg@gmail.com> wrote:

> Hi Linus,
>
> On 08/04/2019 22:44, Linus Walleij wrote:
> > On Sat, Mar 23, 2019 at 10:17 PM Fabien Parent <fparent@baylibre.com> wrote:
> >
> >> Add binding documentation of pinctrl-mt65xx for MT8516 SoC.
> >>
> >> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> >
> > Patch applied with Rob's ACK.
> >
>
> I don't see this in your for-next branch. Did the patch got lost?

I usually push the devel branch to be tested by the build robots
and then mix down the for-next branch.

Recent week(s) the build robot was not responding so it got delayed.

Yours,
Linus Walleij
