Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72F3C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29DF2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfENKSo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 06:18:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34321 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfENKSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 06:18:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id p27so22116540eda.1;
        Tue, 14 May 2019 03:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ORyjFaWPbaw6KQxgFwnjj56eUspz8KmYIPTpXxpUWBU=;
        b=gLcuWxDxj9m8W93Uk19t6LUgIs6UOPKRCrUw0YSWLNmNUpRGH4IFNx/8Mrk2a7c3GV
         p0iOpnn0pzbYEhGiBKCRDdkRkuKGXFdW7wTxirFSdyh0ohIbzlmBOmnpzCaFTflJeq9B
         JQoowiVaLv8hU7wyvbHOQh3UGf1ASECOK41f9uL99HQqBdHXM6NVig53VJEiTxYzuObM
         1BU2aSwb4Z/HFM93dPt7MScoN7DPqulrxW4vyFPHRIXpmRGXRfMRKzF510i1eJR/1VuZ
         X6gJTK/yGfIc2Q0671oIkhjPIYB2ZsuJaHOHi4y+D3zUT3qnufnfB10x0Dlojgpj1G8D
         i2Wg==
X-Gm-Message-State: APjAAAUg8AKnk2cEWUkQqBmWhwmHHJSsvnEdlJ8vKUGmeOFWKVC4TOki
        Vvwzc38DysAzcyVGm8U5E+vLJRMs2os=
X-Google-Smtp-Source: APXvYqwvv2jSD6YeCe78mDqfCjXli14r53XEk7VexiH8MYKFdBeG9+uEDlBugfU2tSg++E+CjryyqQ==
X-Received: by 2002:a05:6402:648:: with SMTP id u8mr34659643edx.176.1557829121826;
        Tue, 14 May 2019 03:18:41 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id w4sm4357344edf.89.2019.05.14.03.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 03:18:40 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id e15so6140116wrs.4;
        Tue, 14 May 2019 03:18:39 -0700 (PDT)
X-Received: by 2002:a5d:688f:: with SMTP id h15mr10564376wru.44.1557829119553;
 Tue, 14 May 2019 03:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190512174608.10083-1-peron.clem@gmail.com> <20190512174608.10083-6-peron.clem@gmail.com>
 <CAMty3ZBTO9+9HLikR8=KgWZQBp+1yVgxQ_rD-E8WeJ8VvpuAcA@mail.gmail.com>
In-Reply-To: <CAMty3ZBTO9+9HLikR8=KgWZQBp+1yVgxQ_rD-E8WeJ8VvpuAcA@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 14 May 2019 18:18:27 +0800
X-Gmail-Original-Message-ID: <CAGb2v64QpH2uL3Q2=ePEaYhrB1_J5uNT4VnBssBgwbOB0NDD0Q@mail.gmail.com>
Message-ID: <CAGb2v64QpH2uL3Q2=ePEaYhrB1_J5uNT4VnBssBgwbOB0NDD0Q@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v4 5/8] arm64: dts: allwinner: Add mali GPU
 supply for Pine H64
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 2:28 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Sun, May 12, 2019 at 11:16 PM <peron.clem@gmail.com> wrote:
> >
> > From: Clément Péron <peron.clem@gmail.com>
> >
> > Enable and add supply to the Mali GPU node on the
> > Pine H64 board.
> >
> > Signed-off-by: Clément Péron <peron.clem@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> > index 4802902e128f..e16a8c6738f9 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> > @@ -85,6 +85,11 @@
> >         status = "okay";
> >  };
> >
> > +&gpu {
> > +       mali-supply = <&reg_dcdcc>;
> > +       status = "okay";
> > +};
>
> I think we can squash all these board dts changes into single patch.

Yes. Please do so for all patches with the same changes applied to different
boards, and authored by the same person.

ChenYu
