Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D706C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AFE820869
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+Gg10jV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390944AbfKETdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 14:33:23 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34274 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390314AbfKETdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 14:33:23 -0500
Received: by mail-lj1-f194.google.com with SMTP id 139so23275605ljf.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 11:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+MPyMHNaAjRQvZ6iKHiwm7qDRtza2TDmfA+ceVFOL0=;
        b=b+Gg10jVzxDOyvISO0AonChau01JWusEEKryI39jtyF8bqTketz+BUKTuPtBA+drOv
         YZ3tpMMgMhMB4d6pDYhh2NSVcnEJ4pwtjkD9aMWf5kVdUu6aWtLZjyVVV/p2V11jIMD6
         zLtq1WSoxYy4mfJw67YBK4MHI0fG/BIl6WL2vvUD2mvuMIbeQ90r3Ls63T/EKW/H2AXJ
         mS16h3c0dftKXy00HoC6AGL42ztxQro/6bRUvxdWJJlqCWsYpBnxwvTTSy92uVuCBvgo
         3d5YvgrcVDL2c/w9xBufxdSfk3c6dq9H7oQRu1luipatbwv7kN5VvugmcumEOkvEpEZQ
         LB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+MPyMHNaAjRQvZ6iKHiwm7qDRtza2TDmfA+ceVFOL0=;
        b=YRf2IT3PDHrwBK2Za/3s7REJv1K1Q1UWoZxiSDlfJzzhECK9xQKFT/Iu5Mdfpxfny3
         tXNh3cEy77QWok3qbo46jINzlG812x8tJ7mYIycHh3BfRQQSe0YfDL0Tf2oNyBAfW/vJ
         slBKQzAatuRrtCId1xwflnfZmS0lmu4DoLL6ev8zWZhYIL2OO9bM6LSkWIj0Gfinwe0u
         BKVwZ0jK2N+Gxx9Bhv9KwDzhsW90Wj4ozO+Gh20wzJG/4QsT37GQUAZpBLoYpXHBLDlq
         FTGWQUO8Zyg2PPbJpAyvNMAxBCwzG7FlgaYiMozMgN2sswUWnLstEKQt/h8fZpATfM8v
         uJLA==
X-Gm-Message-State: APjAAAUyvevj7a441ojp5HyX+PgvQa7Isb5WmWae0OtGHja7i+gQVEkb
        ATHbxY9GCcwRMwwl+or8sUrApqnty91xXuwgUI0qj3NV
X-Google-Smtp-Source: APXvYqxWyl+bdXvYXm0tfCa9yYZ/kOxjk6xKZRZDNSZDcR0N7SPIlEfhp2DOrA1agEILcvfyL/jjn+XkaZOcnW/AMG4=
X-Received: by 2002:a2e:9417:: with SMTP id i23mr12150878ljh.152.1572982400796;
 Tue, 05 Nov 2019 11:33:20 -0800 (PST)
MIME-Version: 1.0
References: <20191012200524.23512-1-alistair@alistair23.me>
 <20191016144946.p3tm67vh5lqigndn@gilmour> <CAGb2v67QrTJjSO99UNs-=3ZZnK948am11=izRTHT6gZ06E28eA@mail.gmail.com>
 <20191021111709.dpu6g7jltuw6cbbn@gilmour>
In-Reply-To: <20191021111709.dpu6g7jltuw6cbbn@gilmour>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 5 Nov 2019 11:27:42 -0800
Message-ID: <CAKmqyKN8Ru19h3y=9O13=5wpys3BC2LQM65S+2QYjPdJQn2O4w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sun50i: sopine-baseboard: Expose serial1,
 serial2 and serial3
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Alistair Francis <alistair@alistair23.me>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 4:17 AM Maxime Ripard <mripard@kernel.org> wrote:
>
> Hi,
>
> On Wed, Oct 16, 2019 at 10:54:27PM +0800, Chen-Yu Tsai wrote:
> > On Wed, Oct 16, 2019 at 10:49 PM Maxime Ripard <mripard@kernel.org> wrote:
> > > On Sat, Oct 12, 2019 at 01:05:24PM -0700, Alistair Francis wrote:
> > > > Follow what the sun50i-a64-pine64.dts does and expose all 5 serial
> > > > connections.
> > > >
> > > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > > > ---
> > > >  .../allwinner/sun50i-a64-sopine-baseboard.dts | 25 +++++++++++++++++++
> > > >  1 file changed, 25 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > > > index 124b0b030b28..49c37b21ab36 100644
> > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > > > @@ -56,6 +56,10 @@
> > > >       aliases {
> > > >               ethernet0 = &emac;
> > > >               serial0 = &uart0;
> > > > +             serial1 = &uart1;
> > > > +             serial2 = &uart2;
> > > > +             serial3 = &uart3;
> > > > +             serial4 = &uart4;
> > > >       };
> > > >
> > > >       chosen {
> > > > @@ -280,6 +284,27 @@
> > > >       };
> > > >  };
> > > >
> > > > +/* On Pi-2 connector */
> > > > +&uart2 {
> > > > +     pinctrl-names = "default";
> > > > +     pinctrl-0 = <&uart2_pins>;
> > > > +     status = "disabled";
> > > > +};
> > > > +
> > > > +/* On Euler connector */
> > > > +&uart3 {
> > > > +     pinctrl-names = "default";
> > > > +     pinctrl-0 = <&uart3_pins>;
> > > > +     status = "disabled";
> > > > +};
> > > > +
> > > > +/* On Euler connector, RTS/CTS optional */
> > > > +&uart4 {
> > > > +     pinctrl-names = "default";
> > > > +     pinctrl-0 = <&uart4_pins>;
> > > > +     status = "disabled";
> > > > +};
> > >
> > > Since these are all the default muxing, maybe we should just set that
> > > in the DTSI?
> >
> > Maybe not, since people may want to only use RX/TX, and leave the other
> > two pins for GPIO?
>
> Right, I'll apply that patch.

Ping, just want to make sure this has been applied/will be applied.

Alistair

>
> Thanks!
> Maxime
