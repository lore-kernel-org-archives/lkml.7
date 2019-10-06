Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B14CC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 15:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A8320835
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 15:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgnJVUbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfJFPWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 11:22:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40280 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726245AbfJFPWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 11:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570375354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/kOnrpYd9eSud0Ixupa7J9ljvVudCP2XNDO8TzpsHNE=;
        b=UgnJVUbIQYyPkZEIEPdBviR4ZMZVdZk8P+iJf4ehQqs0dK0TAIfXEzZyz0kCeIB9u8hd01
        rXr+9yXrz/Tc+TTZrDJecvc3D7wTa+piLpqvacdJM8lHOJCAWe6hmzbLTNpQdN98ZoxFtU
        EI0eWR0qJqM36hz5gV5H79UTH5Kq4LY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-nATV75-0NCKb0LAOiqlDzw-1; Sun, 06 Oct 2019 11:22:32 -0400
Received: by mail-ed1-f69.google.com with SMTP id n14so7367527edt.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 08:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eu8O/YhqU7zJEjRc7W99Fi77CUDu2zTF0Sf1rRqLcS8=;
        b=HGeE+iH9X+CYNCWk8af9uftnVUBCDFBqR0CV3ChTaC0gvpcfVPVCLwG6zwvrx3smcf
         N7GlcYg7qXBNIk5df29gxYxA52kumELrmTj43hRtPI+XyXYZLWvh9g5yyZUzte38vrD5
         HcNvumj+qzHTbQZH06a0pkI6B4MNe1cHgP7to7zDQRrTvSbEeyZOlRDK6o8n7uo0QG8A
         YTosDA0kjEgGSOw3PYd8zSKZtMrXcdhx3W3oV0VCIzX6nfASDtrNqocIN4jEAjvPJW1G
         UmApQyxAtaE9TYC3faVgA1kTylO8f+qPkC3U/OTOSPO7UylfSnLrgdUFWEJKO1UENQEe
         L/vg==
X-Gm-Message-State: APjAAAU9wB3zmbxdJWpAQPQbqfrhLyGYcFz9QbYBRlbJ5640pYmzVP+A
        3cUHSk914b2oP9qqmWOYNQXZPsMB3ugLdkOrcSlhXYWkHeolej5wn7aPOV8KdfvBrtf2pfsJhpq
        Mf3T5RcCQdhEun+/mgk5MmemC
X-Received: by 2002:a50:fb16:: with SMTP id d22mr25119890edq.30.1570375351535;
        Sun, 06 Oct 2019 08:22:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxtY8LnU1MoovTCbhwbtJH9YruP7SXFbEh5OkwIhzOI6haHNozTxOEiKJdPxcrBFmzfbNEyQg==
X-Received: by 2002:a50:fb16:: with SMTP id d22mr25119877edq.30.1570375351305;
        Sun, 06 Oct 2019 08:22:31 -0700 (PDT)
Received: from localhost.localdomain ([109.38.129.160])
        by smtp.gmail.com with ESMTPSA id dv15sm1447787ejb.49.2019.10.06.08.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2019 08:22:30 -0700 (PDT)
Subject: Re: [RFC][PATCH 2/3] usb: roles: Add usb role switch notifier.
To:     John Stultz <john.stultz@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Yu Chen <chenyu56@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20191002231617.3670-1-john.stultz@linaro.org>
 <20191002231617.3670-3-john.stultz@linaro.org>
 <20191003112618.GA2420393@kroah.com>
 <CALAqxLWm_u3KsXHn4a6PdBCOKM1vs5k0xS3G5jY+M-=HBqUJag@mail.gmail.com>
 <9cfccb6a-fba1-61a3-3eb6-3009c2f5e747@redhat.com>
 <CALAqxLX3uSJKvRwzcQznaF4WK52BcM5Bh+PNXHmfDe1aTSUL8Q@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fa44a7ab-14bc-24ec-a19b-7bf15e100ce1@redhat.com>
Date:   Sun, 6 Oct 2019 17:22:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLX3uSJKvRwzcQznaF4WK52BcM5Bh+PNXHmfDe1aTSUL8Q@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: nATV75-0NCKb0LAOiqlDzw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/3/19 11:33 PM, John Stultz wrote:
> On Thu, Oct 3, 2019 at 1:56 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 03-10-2019 22:45, John Stultz wrote:
>>> The HiKey960 has only one USB controller, but in order to support both
>>> USB-C gadget/OTG and USB-A (host only) ports. When the USB-C
>>> connection is attached, it powers down and disconnects the hub. When
>>> the USB-C connection is detached, it powers the hub on and connects
>>> the controller to the hub.
>>
>> When you say one controller, do you mean 1 host and 1 gadget controller,
>> or is this one of these lovely devices where a gadget controller gets
>> abused as / confused with a proper host controller?
>=20
> I'm not totally sure myself, but I believe it's the latter, as the
> host ports have to be disabled in order for the gadet/otg port to
> function.
>=20
> There was a similar situation w/ the original HiKey board (dwc2
> controller) as well, though the switching was done fully in hardware
> and we only needed some minor tweaks to the driver to keep the state
> transitions straight.
>=20
>> And since you are doing a usb-role-switch driver, I guess that the
>> role-switch is integrated inside the SoC, so you only get one pair
>> of USB datalines to the outside ?
>=20
> I believe so, but again, I don't have a ton of knowledge about the SoC
> details, Chen Yu would probably be the right person to answer, but I
> don't know if he's doing upstreaming anymore.
>=20
>> This does seem rather special, it might help if you can provide a diagra=
m
>> with both the relevant bits inside the SoC as well as what lives outside
>> the Soc. even if it is in ASCII art...
>=20
> There is a schematic pdf here:
> https://github.com/96boards/documentation/raw/master/consumer/hikey/hikey=
960/hardware-docs/HiKey960_Schematics.pdf
>=20
> The larger block diagram on page 3 might be helpful, but you can find
> more details on the usb hub bits on page 17 and 18.

Ok, so I took a quick look at the schematic and it is really funky.

The USB3 superspeed data pairs are only going to the USB-3 hub and
only the USB-2 lines are muxed between the TypeC and the HUB, so
in theory superspeed devices could keep working while the TypeC is
in device mode, since their data lines will still be connected,
but I guess the controller in the SoC is switched to device mode
then so this does not work. Likewise Vbus is an all or
nothing thing, either both the TypeC connector + the 2 Type-A
reeptacles get Vusb or none of them get Vusb. Also it is seems to use
the TypeC connector in host-mode together with the A receptacles.
I must say this is a weird design...

Anyways back the code to add a usb role switch notifier. I do
not think that this is a good idea, this is making "core" changes
to deal with a special case. If you are going to use a notfier for
this then IMHO the notifier should be part of the hikey960 usb role
swtich driver and not be in the usb-role-switch class code, since
this is very much a device specific hack.

Regards,

Hans

