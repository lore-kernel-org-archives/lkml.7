Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE41C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E61205F4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftc63eNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfFCL5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 07:57:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35731 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFCL5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 07:57:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id c6so7831678wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 04:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zH0gwAXR2vq1LzxeIdBnF5nu1CZS6B3eFInE+nGAFt0=;
        b=ftc63eNWKSOctdyZNlAYGAku04L0is+S+OEP4bRpRestEgSgaHcFo2bqG7Yn5YhkxE
         URi5im1qvT08UtnLoZW1ZEn3CXBoid90GtMgBV9m2m8FSEdDm1UrvVuTmxtikYKdx77O
         rcN5dliZM/eCWO4xpImtvMezKs4kqfQlvw06wgEX8N8hXUa9AVcHrflFAaaZYp/1U8ld
         Za32KkBP83weG8P1hp9UqKNMc0pdJ07OUbSTs8uWn6tMBHPvEEha6R5Yuuwls2Q7vMx3
         vD2uTAe+fqywl3lx04kqqwrT+x08HansnhIiOYTksLR0TmCs0fF+gZqrMiQ355AeE7Au
         CFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zH0gwAXR2vq1LzxeIdBnF5nu1CZS6B3eFInE+nGAFt0=;
        b=CONGfF+rsEH/MGtXp1JIeJNRofuYWsWkxDyF51MspkatNGGsNkJh0T8WW6QwyOxYPp
         teyREHZ53rYet51SiUKWUByNpdluLuHQsPepYydVz7z4spWlLCGwJPQSp2T9mSy/Nay1
         bSgzle1QcRCzItdpDYIBCLpuGioUaJUnPoJcPfEVvReaCpMd7omQioid7JlkQ/0hnPYK
         kDT8yP2TR9qrX0FG/VgxTg7nhmlUvmYW3dDUMO5SIEcnX8xg+Bd2BZlpiJfhUvgBUiic
         nTHBQKsSzRtDBRjsdBfVSLF6p3OkZq+0OolxSkl0TPAwZvk5hENJKN1svXn0tv3ty50T
         4KzA==
X-Gm-Message-State: APjAAAWIQLgC+bwdDZJm9TPjRO/VvWj6mepPc/lzt8vZgBePgWvn2mzf
        /+p2uAK1gsm2e/BKfq3TfITzIHprUgw=
X-Google-Smtp-Source: APXvYqyW4glgD2xmrXxBinQAo2biQZPnENKHNb36mGg6c0c3av8dimZ27SHg7BF981umISYRPDwm3g==
X-Received: by 2002:a1c:7f93:: with SMTP id a141mr4017194wmd.131.1559563041072;
        Mon, 03 Jun 2019 04:57:21 -0700 (PDT)
Received: from [172.16.20.20] ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id 6sm27934997wrd.51.2019.06.03.04.57.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 04:57:20 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 02/10] arm64: dts: meson-gxm-khadas-vim2: fix Bluetooth
 support
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <bbf3c69f-8695-d665-c7ca-587b7e77eb4f@baylibre.com>
Date:   Mon, 3 Jun 2019 15:57:17 +0400
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CD983BAA-CC37-455E-B78A-CF8A72ACE7A4@gmail.com>
References: <20190527132200.17377-1-narmstrong@baylibre.com>
 <20190527132200.17377-3-narmstrong@baylibre.com>
 <CAFBinCBTK=6OW4kG=i0KZe-+AzGVXyou9g0frnh9yqLsdmB5+w@mail.gmail.com>
 <b54c7899-95b3-1202-d70b-9b8ee2955164@baylibre.com>
 <CAFBinCB9PZ-mjyjCafK24cH3sN5E1r4vt1z=m+uvkHsmRW2PFQ@mail.gmail.com>
 <bbf3c69f-8695-d665-c7ca-587b7e77eb4f@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Jun 2019, at 12:57 pm, Neil Armstrong <narmstrong@baylibre.com> =
wrote:
>=20
> On 29/05/2019 20:08, Martin Blumenstingl wrote:
>> On Wed, May 29, 2019 at 12:25 PM Neil Armstrong =
<narmstrong@baylibre.com> wrote:
>>>=20
>>> On 27/05/2019 20:36, Martin Blumenstingl wrote:
>>>> On Mon, May 27, 2019 at 3:22 PM Neil Armstrong =
<narmstrong@baylibre.com> wrote:
>>>>>=20
>>>>> From: Christian Hewitt <christianshewitt@gmail.com>
>>>>>=20
>>>>> - Remove serial1 alias
>>>>> - Add support for uart_A rts/cts
>>>>> - Add bluetooth uart_A subnode qith shutdown gpio
>>>> I tried this on my own Khadas VIM2:
>>>> Bluetooth: hci0: command 0x1001 tx timeout
>>>> Bluetooth: hci0: BCM: Reading local version info failed (-110)
>>>>=20
>>>> I'm not sure whether this is specific to my board or what causes =
this.
>>>=20
>>> Which kernel version ?
>> 5.2-rc2
>>=20
>> it's a Khadas VIM2 Basic (thus it has a AP6356S), board revision v1.2
>=20
> Can you try with :
>=20
> clocks =3D <&wifi32k>;
> clock-names =3D "lpo";
>=20
> added in the bluetooth node ?

Tested and confirmed working with rev 1.2 =E2=80=98basic' and 5.1 kernel =
with those nodes added.

VIM2:~ # dmesg | grep -i blue
[   10.793600] Bluetooth: Core ver 2.22
[   10.793792] Bluetooth: HCI device and connection manager initialized
[   10.793814] Bluetooth: HCI socket layer initialized
[   10.793821] Bluetooth: L2CAP socket layer initialized
[   10.793851] Bluetooth: SCO socket layer initialized
[   10.801928] Bluetooth: HCI UART driver ver 2.3
[   10.801944] Bluetooth: HCI UART protocol H4 registered
[   10.804919] Bluetooth: HCI UART protocol Broadcom registered
[   10.805025] Bluetooth: HCI UART protocol QCA registered
[   11.016629] Bluetooth: hci0: BCM: chip id 101
[   11.018537] Bluetooth: hci0: BCM: features 0x2f
[   11.043112] Bluetooth: hci0: BCM4354A2
[   11.043134] Bluetooth: hci0: BCM4356A2 (001.003.015) build 0000
[   11.075919] Bluetooth: Generic Bluetooth SDIO driver ver 0.1
[   11.359784] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   11.359793] Bluetooth: BNEP filters: protocol multicast
[   11.359811] Bluetooth: BNEP socket layer initialized
[   17.075509] Bluetooth: hci0: BCM4356A2 (001.003.015) build 0266

I use BT remotes to avoid issues with multiple boards responding to IR =
so it was working before at some point. I assume I dropped a change =
somewhere in the process of feeding you the batch of patches - =
apologies!

Christian=
