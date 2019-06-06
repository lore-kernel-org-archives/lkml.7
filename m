Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE8FC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF3D206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lfcvSghZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfFFTwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:52:21 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35262 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfFFTwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:52:21 -0400
Received: by mail-oi1-f194.google.com with SMTP id y6so2494819oix.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 12:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AlGSYF3m5pRxceZLV64eIzJ0xhu9mM8TneWE5MMLmMo=;
        b=lfcvSghZm2oCpWdLgEjYrXEVmh8XE+PsjXfnX3AHi/5voOTkTXZLCTq+seq0WuXEel
         gtGQ11Z1rgR+Mt1F+lcn7IABiI9vZHDD7nU3a/iM3t7PwlXEjvfNN8k3KEdGWjJ5BYj+
         umcRd8UAGrHMIxhJCDMnC/d21mFu5JvnYzfihDu+ibXE6SB1fm6V8AFy2/etSwZeFX5s
         d/M1M2xQrQYxWua9RLY+hs5y2z8gmaM7EMo1FUTViNaC3BmcGNIbRNSyHc1CRuNrZ8NZ
         hugYIf7UcC+Tt6/EuroDU5yesWKZEiTJ+nbfBdiqkgs9ssxc4eaooHZgdb1B837ArR+w
         CF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AlGSYF3m5pRxceZLV64eIzJ0xhu9mM8TneWE5MMLmMo=;
        b=GSM0MQSiB4Z1Iwf86/trAFV+OjnaiPyawYwb4ewnnjN7Y1fRv3dJdqmllN1MGq3Ub6
         kycs9SutbOpuKaFTEiWOB3muKEyK93HQC2sjhUHL7mDfZrjKU95sCvoQi9xEWpO2I1+Q
         U18rW/8qeDDGcMj4avPknXYHT3V932Og7tj8cGofdvJ1Eh9/F8VBAmbIdjVS5mTLiYwQ
         0c4Z5xvpyI7W0lsLGjmSeakzG69lhnBKYFwrSD237n0TkfBMCrPfj+eqn20XGHKXoRBJ
         qYxLry9l6ZKIS960+0fu3RxBOHZRGXP7Yiwcv2N87e878wS1WkPE966Hc9dGST8IuPpy
         fOKA==
X-Gm-Message-State: APjAAAWVr1KQUyRX4wfSz91cK1V6JafPLCKBLlh7AQzXAURrBOkHaN9L
        h8lbJ+qa/VAgKHo+2T34nlmPkW5ictKsWoFRSeQ=
X-Google-Smtp-Source: APXvYqzL1PgG0HqdxQzrFaOHvyXNmJ5u5UlGgFrUhioJzm2uaHHH1bWzUlTIRoEmVXlAGFJ1/lpYoiz4ZwltUZn9/8w=
X-Received: by 2002:aca:4403:: with SMTP id r3mr1313417oia.39.1559850740303;
 Thu, 06 Jun 2019 12:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190527132200.17377-1-narmstrong@baylibre.com>
 <20190527132200.17377-3-narmstrong@baylibre.com> <CAFBinCBTK=6OW4kG=i0KZe-+AzGVXyou9g0frnh9yqLsdmB5+w@mail.gmail.com>
 <b54c7899-95b3-1202-d70b-9b8ee2955164@baylibre.com> <CAFBinCB9PZ-mjyjCafK24cH3sN5E1r4vt1z=m+uvkHsmRW2PFQ@mail.gmail.com>
 <bbf3c69f-8695-d665-c7ca-587b7e77eb4f@baylibre.com>
In-Reply-To: <bbf3c69f-8695-d665-c7ca-587b7e77eb4f@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 6 Jun 2019 21:52:09 +0200
Message-ID: <CAFBinCA5tjZ9hxbbQkHE22BYMqQboE4UQ3Vk=w9-zCeQLn6OOA@mail.gmail.com>
Subject: Re: [PATCH 02/10] arm64: dts: meson-gxm-khadas-vim2: fix Bluetooth support
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 10:57 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi,
>
> On 29/05/2019 20:08, Martin Blumenstingl wrote:
> > On Wed, May 29, 2019 at 12:25 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >> On 27/05/2019 20:36, Martin Blumenstingl wrote:
> >>> On Mon, May 27, 2019 at 3:22 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>>>
> >>>> From: Christian Hewitt <christianshewitt@gmail.com>
> >>>>
> >>>> - Remove serial1 alias
> >>>> - Add support for uart_A rts/cts
> >>>> - Add bluetooth uart_A subnode qith shutdown gpio
> >>> I tried this on my own Khadas VIM2:
> >>> Bluetooth: hci0: command 0x1001 tx timeout
> >>> Bluetooth: hci0: BCM: Reading local version info failed (-110)
> >>>
> >>> I'm not sure whether this is specific to my board or what causes this.
> >>
> >> Which kernel version ?
> > 5.2-rc2
> >
> > it's a Khadas VIM2 Basic (thus it has a AP6356S), board revision v1.2
>
> Can you try with :
>
> clocks = <&wifi32k>;
> clock-names = "lpo";
>
> added in the bluetooth node ?
that did it!

I think I also found the explanation why:
on my Khadas VIM2 SD card I don't have linux-firmware installed.
Thus the wifi driver will disable the 32kHz LPO clock again, breaking Bluetooth

are you going to send patches for the existing boards or do you want
someone else to do it?


Martin
