Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB222C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A76206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbfDEO7w convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:59:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43345 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfDEO7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:59:52 -0400
Received: by mail-ed1-f65.google.com with SMTP id t22so788857edw.10;
        Fri, 05 Apr 2019 07:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Umc6Q+4hzr6bE/VI8qB/EdYv3WWhMkem+th93iHEltU=;
        b=moGa3NWv8tP54pBH7UGuODS6/f7nKaOkgEmNMMBes/dHxzwI9Phlrr8EjZGz78tf+q
         V6vRVjp/TEagirNd1iccnoTXBds55YkF5Rkzr+gauq/bNITT16FpxwRXHGXjJisG9VOq
         /9yUqpgy6NsbBFJ6tjHO3jg19KUzE4TtFv8a+6lezqcOrE7CjBo+WWyNzIr/yMHLIOIi
         BjsDVG+Eo08UHvZ7OGz4X3ekHmwVIIGrXumJmNdcwYkcc96bLACSveP28cgpQn0tPdsx
         /2SpCmR7UNpYrOpTss3IC1Snq7gPP9Vx/da9/JoLTqnWcdveyIG1o1rGvgerUTeGzhva
         G+FQ==
X-Gm-Message-State: APjAAAUzFE6evE4dejLXhO9+rli3DH8r7JaJlGzEzeFajUWGjeux5Vgg
        mfcsOzRwYERpWXAT9ycF1Uq4OFVJxwE=
X-Google-Smtp-Source: APXvYqz4HwqQQCPPMcOM3E/t8yri09G2p0a/k66VOSzHlDrIkXU3auI0SViODChDhFIVyjCcJFTSRw==
X-Received: by 2002:a17:906:2e52:: with SMTP id r18mr7534769eji.84.1554476389683;
        Fri, 05 Apr 2019 07:59:49 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id c18sm3955078ejo.35.2019.04.05.07.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 07:59:49 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id s15so8351751wra.12;
        Fri, 05 Apr 2019 07:59:48 -0700 (PDT)
X-Received: by 2002:adf:e648:: with SMTP id b8mr8644325wrn.132.1554476388639;
 Fri, 05 Apr 2019 07:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190404135736.8491-1-peron.clem@gmail.com> <20190404135736.8491-2-peron.clem@gmail.com>
 <20190405090236.e7vnyjzxmzfke3d6@flea> <CAGb2v65wcEAUTwRhC42iRkPaWXLGX1CJeq+TSzHVTOrT+L=8vA@mail.gmail.com>
 <20190405145005.jmmwsvbateqssbyq@flea>
In-Reply-To: <20190405145005.jmmwsvbateqssbyq@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 5 Apr 2019 22:59:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v66cv7dVwj7oyRaHT5Q2XCbNqzuS-Uk9hdNJbVv57QOmUg@mail.gmail.com>
Message-ID: <CAGb2v66cv7dVwj7oyRaHT5Q2XCbNqzuS-Uk9hdNJbVv57QOmUg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: h6: Add watchdog node
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 10:50 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Apr 05, 2019 at 10:35:08PM +0800, Chen-Yu Tsai wrote:
> > On Fri, Apr 5, 2019 at 5:02 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Thu, Apr 04, 2019 at 03:57:36PM +0200, Clément Péron wrote:
> > > > Allwinner H6 has a watchog compatible with A31.
> > > >
> > > > Declare it in the device tree.
> > > >
> > > > Signed-off-by: Clément Péron <peron.clem@gmail.com>
> > >
> > > Applied both, thanks!
> > > Maxime
> >
> > IIRC there are 3 watchdogs on the H6. One is the trusted watchdog,
> > which should be reserved for underlying firmware.
> >
> > The other two are the normal and R-block watchdog. Although they
> > look the same, the "normal" one can't reset the system. :(
> > That one is actually the one ATF currently uses. So reboot doesn't
> > work on the H6.
>
> So that patch will not do anything then?

I'm still on vacation, so I haven't checked the address of the new device.
If it's the normal one, then yeah, it won't do anything. I've tried that.
IIRC Samuel (or someone else) on IRC also mentioned this.

ChenYu
