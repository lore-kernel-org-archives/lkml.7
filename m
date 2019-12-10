Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5579EC2BD09
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FE52077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="fEtJ5hPt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m4YrBQR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfLJA5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 19:57:16 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59941 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727487AbfLJA5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 19:57:15 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3EDFE22612;
        Mon,  9 Dec 2019 19:57:14 -0500 (EST)
Received: from imap26 ([10.202.2.76])
  by compute7.internal (MEProxy); Mon, 09 Dec 2019 19:57:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=QZSXV0E2wXwjz2l7XHDJiDEjbOAx
        GZT1UKVhqbaYJS8=; b=fEtJ5hPtvSAdSQ2BivWZ7OUUHuFksOY6CDc7SDdWY04X
        BaXoOYVrDWqh2qPUm8fH5X0MJlIJeoIAMjSIMWg/5oultj4Wz+mbXUhwF8QQEJVW
        lFBu5rbkxO1LyGcKPZEW+Vk6gCguhIy9AKqM62AT+ck5dBhy89ZG9/nw2Q+EuDor
        l0txAnqPecnZQI9psuJPysP6/vNB2rhZsGBkkSWnbQBZfGc7LXOg/KNkILPvYMAI
        ebHchkssx1W/1Kqc7B3lDkQ0s/czCG+31W8wlIqaDt7CzRmZaC70Tp7oqucG6oqD
        yvgMm7UZ4wr9eluob6YpoI+NnsUWXBAy9lGelLVZJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=QZSXV0
        E2wXwjz2l7XHDJiDEjbOAxGZT1UKVhqbaYJS8=; b=m4YrBQR/R8XYEOxqL7N4cj
        3h3TFlRcKePgjbCeoMH29mbXXEmDovrya2ovuVSEvgi70R/Io5PsebbxMSs+MQyG
        AuNCDaKnw9NICmc6uVwmabX30OlrJGvBA/lzk+0cP63GsBH+nEo4P7Jp556m+rlG
        RtVD46mnbtpQidkAbGpyNqus3+Nxv1fCV5WlkIXvQyGw5xbafnroQ8+YrwieKsAf
        1VtXSU2QQgHDRm+RaeotgFmRemnGsBgza6nLp6+IecIVrs7WL0qZKQ98+555CnY9
        mdyNliv/hlnV+nQ98Bs89ZNsb+KWswAEDpTzxUQmDcg4rmRONj8O/LsJ4BlwPKAw
        ==
X-ME-Sender: <xms:ae3uXXaMbU9PuTAgFY9hQigs_Z65vPQGS0vt4Fh-3fBHr27Vx9XBjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelvddgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomheptehlihhs
    thgrihhruceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucffohhmrg
    hinhepshhpihhnihgtshdrnhgvthenucfrrghrrghmpehmrghilhhfrhhomheprghlihhs
    thgrihhrsegrlhhishhtrghirhdvfedrmhgvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:ae3uXe8mZ2ugEYMZ1BvAjmp-FXJ-774sqs1jLk2FbNVBVJ4lVWJNcg>
    <xmx:ae3uXRDyMyv3RHp3ckaW3hxkWXBFqA3JWgmKcigXceu9o8aY0SC2mw>
    <xmx:ae3uXSvOKzSH31YiNKC1NXacEPJFBOdvDKBJikquBXqY-guQIMkOKQ>
    <xmx:au3uXTAfTPH-TKoOB3XMECe3IqAp5Q2BpJi8Z-QHq7H84ey-UZ_bHg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 13DBC14200A1; Mon,  9 Dec 2019 19:57:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-612-g13027cc-fmstable-20191203v1
Mime-Version: 1.0
Message-Id: <e5cc3689-14c9-4cb6-bda8-beb6a9e8db7a@www.fastmail.com>
In-Reply-To: <20191209193729.jfw2z4iqlhrzohse@hendrix.lan>
References: <20191207192249.8346-1-alistair@alistair23.me>
 <20191209193729.jfw2z4iqlhrzohse@hendrix.lan>
Date:   Mon, 09 Dec 2019 16:56:51 -0800
From:   Alistair <alistair@alistair23.me>
To:     "Maxime Ripard" <mripard@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wens@csie.org,
        "Alistair Francis" <alistair23@gmail.com>
Subject: =?UTF-8?Q?Re:_[PATCH]_arm64:_allwinner:_Enable_Bluetooth_and_WiFi_on_sop?=
 =?UTF-8?Q?ine_baseboard?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019, at 11:37 AM, Maxime Ripard wrote:
> On Sat, Dec 07, 2019 at 11:22:49AM -0800, Alistair Francis wrote:
> > The sopine board has an optional RTL8723BS WiFi + BT module that can be
> > connected to UART1. Add this to the device tree so that it will work for
> > users if connected.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> > .../dts/allwinner/sun50i-a64-sopine-baseboard.dts | 14 ++++++++++++++
> > 1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > index 920103ec0046..0a91f9d8ed47 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > @@ -214,6 +214,20 @@ &uart0 {
> > status = "okay";
> > };
> >
> > +&uart1 {
> > + pinctrl-names = "default";
> > + pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
> > + status = "okay";
> > +
> > + bluetooth {
> > + compatible = "realtek,rtl8723bs-bt";
> > + reset-gpios = <&r_pio 0 4 GPIO_ACTIVE_LOW>; /* PL4 */
> > + device-wake-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* PL5 */
> > + host-wake-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
> > + firmware-postfix = "pine64";
> > + };
> > +};
> > +
> 
> Output from checkpatch:
> total: 10 errors, 11 warnings, 0 checks, 20 lines checked

Sorry, I should have checked that before I posted.

> 
> More importantly, that binding isn't documented, and doesn't have a
> driver either.

Ah, I confused myself.

I have some patches that will fix this, but from below it looks like someone else beat me to it.

> 
> I guess you want to have a look at:
> https://www.spinics.net/lists/arm-kernel/msg771488.html

Thanks for pointing this out. I will just wait for this to be merged before trying again.

Alistair

> 
> Maxime
> 
