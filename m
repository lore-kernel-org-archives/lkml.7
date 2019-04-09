Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2EAC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D24D208C0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554818601;
	bh=/iGOLlZ2LmnG4+GxeSSAeOo+q+PkEY1dl+1g+OpPUcY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BZvks7mfLFbzNZu4tsdGv7qv1K2aA4+xYLOIsnFfz2CUuXY+JiIJNJuWWhJjkeTTf
	 Q+oCI7mwKbb1HIAP/0CNDXGIxTerTee/nvbDI3Q8yg+y6aeu85IIz1kKUQiEI6YHlA
	 rBYoqxzzAqX1jMz/4GF5jHKxORUxkS7xjwNg2464=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfDIODU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:03:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbfDIODU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:03:20 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03571218D2;
        Tue,  9 Apr 2019 14:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554818599;
        bh=/iGOLlZ2LmnG4+GxeSSAeOo+q+PkEY1dl+1g+OpPUcY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f1Zz//H0Cg2Fs09zpE3QCaKP9yb05zG7iLJTw/GlXp1MVqN4W8c8LCVWoEZ6AEBVf
         cJJn3Ps5tkf+Rk7ADcN+BU1k0ANiR1DxymmJ92w5eFwPD+f2IS+zAbQzw7CyAwplgx
         irimpZk4Uu/01NzVkcPelXhYZKoeX2CcNhGb5y7I=
Received: by mail-qt1-f175.google.com with SMTP id w30so19839419qta.8;
        Tue, 09 Apr 2019 07:03:18 -0700 (PDT)
X-Gm-Message-State: APjAAAX/xYR6DkFbAFo//MVYwcgtNblb0rJrxP8ELkmV1mxgmSTh3iG1
        3OdwhMr9xzVAomCVgZrWmNrxaZyb/KnTliOxSg==
X-Google-Smtp-Source: APXvYqyM1Tx6vJxXx8cKc8TxTrSOj9IYi5Zc7ZXbQ30spZ1kCR6fFeW4/jgz39Hu1EQR2VTkmD3CLad6R/scmcN5d9I=
X-Received: by 2002:a0c:b919:: with SMTP id u25mr29990006qvf.216.1554818598130;
 Tue, 09 Apr 2019 07:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <1554359858-21049-1-git-send-email-rjliao@codeaurora.org>
 <1554368908-22017-1-git-send-email-rjliao@codeaurora.org> <1554368908-22017-2-git-send-email-rjliao@codeaurora.org>
 <535c74d4-00b1-eef2-578a-8807f4b9f640@free.fr> <319cbb5f23ed3d9f1ae77c697001378d@codeaurora.org>
In-Reply-To: <319cbb5f23ed3d9f1ae77c697001378d@codeaurora.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 9 Apr 2019 09:03:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKLL8x63wzpi2tfNfvVe5TX=Uxz+owPZbhevhW-84bDAA@mail.gmail.com>
Message-ID: <CAL_JsqKLL8x63wzpi2tfNfvVe5TX=Uxz+owPZbhevhW-84bDAA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: net: bluetooth: Add device property
 nvm-postfix for QCA6174
To:     Rocky Liao <rjliao@codeaurora.org>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 5:15 AM Rocky Liao <rjliao@codeaurora.org> wrote:
>
> On 2019-04-04 20:32, Marc Gonzalez wrote:
> > +robh
> >
> > On 04/04/2019 11:08, Rocky Liao wrote:
> >
> >> This patchs patch adds an optional device property nvm-postfix to
> >> allow the
> >> driver to load customized nvm file based on this property
> >
> > While text /before/ is indeed called a "prefix", text /after/ is not a
> > "postfix",
> > but a "suffix".
> >
> >
> >>  Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git
> >> a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> >> b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> >> index 824c0e2..70cda4b 100644
> >> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> >> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> >> @@ -16,6 +16,7 @@ Optional properties for compatible string
> >> qcom,qca6174-bt:
> >>
> >>   - enable-gpios: gpio specifier used to enable chip
> >>   - clocks: clock provided to the controller (SUSCLK_32KHZ)
> >> + - nvm-postfix: nvm file postfix to load customized nvm file
> >
> > The device tree is supposed to describe hardware.
> >
> > The name of which file to load can hardly be considered part of the HW.
> >
> > Possible solutions:
> > 1) derive the file name from the compatible string
> > 2) pass the name as a module parameter
> > 3) something else
> >
> >
> >> @@ -39,6 +40,7 @@ serial@7570000 {
> >>
> >>              enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
> >>              clocks = <&divclk4>;
> >> +            nvm-postfix = "i2s";
> >>      };
> >>  };
> >
> > If one provides the entire suffix, including the underscore, then you
> > can
> > simplify the code:
> >
> >       snprintf(config.fwname, sizeof(config.fwname), "qca/nvm_%08x%s.bin",
> > soc_ver, suffix ? suffix : "");
> >
> > Regards
> .
> Hi Marc,
>
> The major purpose for that property is about the BT audio bus type, can
> it be considered as part of the HW? If yes maybe we can use a property
> name "audio-bus" to reflect that.
>
> If not then I will adopt the solution 1 to add a new compatible string
> "{ .compatible = "qcom,qca6174-bt-i2s" }" and load specific nvm for this
> compatible string, please feel free to let me know if any other
> concerns.

I don't think the suggestion was to add the nvm string to the
compatible, but rather compatible strings serve as a map key. Having
board specific firmware files for wifi/bt is pretty common, but
parameters for 'i2s' is a bit strange. So a better explanation of what
parameters this contains would help. How/when does it vary, for
example?

Also, if it is only a handful of parameters, making them DT properties
is preferred.

Rob
