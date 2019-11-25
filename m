Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446D6C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E477207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ERy+HFLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbfKYSUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 13:20:13 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42693 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfKYSUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 13:20:13 -0500
Received: by mail-qk1-f196.google.com with SMTP id i3so13624724qkk.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 10:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W09lgIqIKvECTOE849gv8T7YDNLO2Wc4fhvJ0YJldxk=;
        b=ERy+HFLCmw98rZ+6jHEb6CK3h+hzq2Xd1fFuuD5w5bfjxs7aw6AgNsqMmhI3QlbWoC
         y0EfJHErAyaz5xlU7Jv89vsAFHpCFp5adnNr6SmEtm7k5JicUESHRlKQftaWhofNPGO/
         2k6Bym+4k9FYiNEA40m6ydBprmxzen/r0nvrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W09lgIqIKvECTOE849gv8T7YDNLO2Wc4fhvJ0YJldxk=;
        b=FN4qDixy0hMQ8/GJgPDZZFyG4qAS3OAviIgsni5V7CPGuMsotxAfR07t0jUV4Jkzxk
         6iV5D8BVWfPSPWG7RTOF7Rvf3jIBnRN50ceKD7Th1JzWJ8IGIJ4+BjJDgpP2H8saARua
         H+4fvBwgi3LmLMfxvM6OdhnQnR8hCEk4x3HB4tY2ArYOwksApeFJjq8KH1kJCqBlHrK7
         pvOYsGc2RhFSREGRs2VUmowfCKR6Tpj5WxMeatmnXF9Uv0h62/jEX9LvF1ayZ2mfNzOk
         xpBpBuTZhK4z01XKrH58yazdVYTx833PavdtHoDnVwKcuCHNwE15vioMHPjUJRF7SZ+i
         cEZw==
X-Gm-Message-State: APjAAAV2YjOLMw1VlAZBGu47NEkIYkDR/3g8mjgBvmyJ69Mqqm6lisYZ
        Wl7mUQWdv8AyvO6Wbu0qhaCkZk8VlNhKolfYD+9Yug==
X-Google-Smtp-Source: APXvYqyViSiFgUBvDzO1mVVyfrDrv1aJlHc6bYxT/J8Hw5dcdeuarzA4nQsAObckQJK0CIoKANHAPwHuY9MKcyA5yUo=
X-Received: by 2002:a37:5b02:: with SMTP id p2mr27051982qkb.419.1574706011770;
 Mon, 25 Nov 2019 10:20:11 -0800 (PST)
MIME-Version: 1.0
References: <20191118192123.82430-1-abhishekpandit@chromium.org> <1CEDCBDC-221C-4E5F-90E9-898B02304562@holtmann.org>
In-Reply-To: <1CEDCBDC-221C-4E5F-90E9-898B02304562@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 25 Nov 2019 10:20:00 -0800
Message-ID: <CANFp7mXNPsmfC_dDcxP1N9weiEFdogOvgSjuBLJSd+4-ONsoOQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Bluetooth: hci_bcm: Additional changes for BCM4354 support
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-bluetooth@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

It looks about the same as one of my earlier patch series. Outside a
few nitpicks, I'm ok with merging this.

Thanks
Abhishek

On Sat, Nov 23, 2019 at 2:04 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Abhishek,
>
> > While adding support for the BCM4354, I discovered a few more things
> > that weren't working as they should have.
> >
> > First, we disallow serdev from setting the baudrate on BCM4354. Serdev
> > sets the oper_speed first before calling hu->setup() in
> > hci_uart_setup(). On the BCM4354, this results in bcm_setup() failing
> > when the hci reset times out.
> >
> > Next, we add support for setting the PCM parameters, which consists of
> > a pair of vendor specific opcodes to set the pcm parameters. The
> > documentation for these params are available in the brcm_patchram_plus
> > package (i.e. https://github.com/balena-os/brcm_patchram_plus). This is
> > necessary for PCM to work properly.
> >
> > All changes were tested with rk3288-veyron-minnie.dts.
>
> so I have re-factored your patch set now to apply to latest bluetooth-nex=
t tree and posted it to the mailing list. Please have a look at it if this =
works for you. If it does, then we might just apply it this way and focus o=
n getting detailed PCM codec configuration for all vendors in once we have =
a second vendor to unify it.
>
> Regards
>
> Marcel
>
