Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487E9C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C40217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UUrkYneq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfHZVti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 17:49:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32872 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfHZVth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 17:49:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id p23so12527743oto.0;
        Mon, 26 Aug 2019 14:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P2jqha8V8ByiibF4urtutm74FTUCiRsGVegLuvKy1vc=;
        b=UUrkYneqJGIgi5bSpPl6N7bUNymkG+gww4Utt3BL5EUlQLIW4c6Q/ezkG6JucoE2Gm
         uttpBlMUDTUWzKM6LgjDpPZyGHdbl7Ey4h6KfluW760yEVlqE3x58TK1o7OP18fvgh/n
         WVgyDHgkxN1NKvgp9bytsMYeNfIQxk0yXJt2/6VHOP+nB8GjmQabD+Ofr+tX/mOqqorp
         /9I8PR3E6bbaBantLjOuEVpAXJ6Nn00moxOWl4vE+rNpqMfSrquLEQfEw3gqhU9Qi7+Q
         /uDAxNz/8Vv5Ck0fvBEZ7uPRs6eQNq466vm+weM+cWoI3u794bYYhAEQCe9hhvQt+BzJ
         qM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P2jqha8V8ByiibF4urtutm74FTUCiRsGVegLuvKy1vc=;
        b=b6fPMJctg+h+jC7hrpxB+i2mHTuWill7cc3iwYylFlm1+OB/G0CJHopaQd5WXmP8rF
         b4Bct+BURGZ13vE2fhhAK0VTxbe3yBbTG+4CN6AAfFVJ7BPhN+OffRVrXkNwipU+GEgv
         T70Yrxb2E3VqnL7v/4htlDb4G1zwdOREQ+GV3t7bIUNWZI/6DRnjUbTYCz+V3cmlxm56
         YDCbkEZcECCmqUmflkKKnZjzLMzDV3DtkgpYxBcD5jLnPJepnKNSBJeQQHwgMsDjHUqs
         BvbZasGmOPbfrlhvSYDTAUz+Ov2NvHze/rrJex4lxaTtkLXGCEC/Z++UWtJ/z+8Bw/8m
         ZWuw==
X-Gm-Message-State: APjAAAUzAkz98B/VUxwNJKQDmFItMBm6hV4ISxNOHX+mb8+q6sYqG0b2
        SnwL3d7YTcaDNg7JeGU/EWSilBWGoPNxTMIhw40=
X-Google-Smtp-Source: APXvYqxpazjd/Ar57NDFJNxQv1s76AdGXHEZZrgd7vE6v0B3ilxg//wmEiNttjvVTfU/aU1aopBQUA7I5SgKRUVPxJ4=
X-Received: by 2002:a9d:7b44:: with SMTP id f4mr8198249oto.42.1566856176220;
 Mon, 26 Aug 2019 14:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <90cc600d6f7ded68f5a618b626bd9cffa5edf5c3.1566531960.git.eswara.kota@linux.intel.com>
 <20190824211158.5900-1-martin.blumenstingl@googlemail.com> <3813e658-1600-d878-61a4-29b4fe51b281@linux.intel.com>
In-Reply-To: <3813e658-1600-d878-61a4-29b4fe51b281@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 26 Aug 2019 23:49:24 +0200
Message-ID: <CAFBinCA_B9psNGBeDyhkewhoutNh6HsLUN+TRfO_8vuNqhis4Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] reset: Reset controller driver for Intel LGM SoC
To:     "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>
Cc:     eswara.kota@linux.intel.com, cheol.yong.kim@intel.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, qi-ming.wu@intel.com, robh@kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 26, 2019 at 6:01 AM Chuan Hua, Lei
<chuanhua.lei@linux.intel.com> wrote:
>
> Hi Martin,
>
> Thanks for your comment.
thank you for the quick reply

> On 8/25/2019 5:11 AM, Martin Blumenstingl wrote:
> > Hi Dilip,
> >
> >> Add driver for the reset controller present on Intel
> >> Lightening Mountain (LGM) SoC for performing reset
> >> management of the devices present on the SoC. Driver also
> >> registers a reset handler to peform the entire device reset.
> > [...]
> >> +static const struct of_device_id intel_reset_match[] = {
> >> +    { .compatible = "intel,rcu-lgm" },
> >> +    {}
> >> +};
> > how is this IP block differnet from the one used in many Lantiq SoCs?
> > there is already an upstream driver for the RCU IP block on the Lantiq
> > SoCs: drivers/reset/reset-lantiq.c
> >
> > some background:
> > Lantiq was started as a spinoff from Infineon in 2009. Intel then
> > acquired Lantiq in 2015. source: [0]
> > Intel is re-using some of the IP blocks from the MIPS Lantiq SoCs
> > (Intel even has some own MIPS SoCs as part of the Lantiq acquisition,
> > typically used for PON/GPON/ADSL/VDSL capable network devices).
> > Thus I think it is likely that the new "Lightening Mountain" SoCs use
> > an updated version of the Lantiq RCU IP.
>
> I would not say there is a fundamental difference since reset is a
> really simple
> stuff from all reset drivers.  However, it did have some difference
> from existing reset-lantiq.c since SoC becomes more and more complex.
OK, let me go through your detailed list

> 1. reset-lantiq.c use index instead of register offset + bit position.
> index reset is good for a small system (< 64). However, it will become very
> difficult to use if you have  > 100 reset. So we use register offset +
> bit position
reset-lantiq uses bit bit positions for specifying the reset line.
for example this is from OpenWrt's vr9.dtsi:
  reset0: reset-controller@10 {
    ...
    reg = <0x10 4>, <0x14 4>;
    #reset-cells = <2>;
  };

  gphy0: gphy@20 {
    ...
    resets = <&reset0 31 30>, <&reset1 7 7>;
    reset-names = "gphy", "gphy2";
  };

in my own words this means:
- all reset0 reset bits are at offset 0x10 (parent is RCU)
- all reset0 status bits are at offset 0x14 (parent is RCU)
- the first reset line uses reset bit 31 and status bit 30
- the second reset line uses reset bit 7 and status bit 7
- there can be multiple reset-controller instances, each taking the
reset and status offsets (OpenWrt's vr9.dtsi specifies the second RCU
reset controller "reset1" with reset offset 0x48 and status offset
0x24)

> 2. reset-lantiq.c does not support device restart which is part of the
> reset in
> old lantiq SoC. It moved this part into arch/mips/lantiq directory.
it was moved to the .dts instead of the arch code. again from
OpenWrt's vr9.dtsi [0]:
  reboot {
    compatible = "syscon-reboot";
    regmap = <&rcu0>;
    offset = <0x10>;
    mask = <0xe0000000>;
  };

this sets the reset0 reset bits 31, 30 and 29 at reboot

> 3. reset-lantiqc reset callback doesn't implement what hardware implemented
> function. In old SoCs, some bits in the same register can be hardware
> reset clear.
>
> It just call assert + assert. For these SoCs, we should only call
> assert, hardware will auto deassert.
I didn't know that. so to confirm I understand this correctly:
- some reset lines must be asserted and de-asserted manually (setting
and clearing the bit manually). the _assert and _deassert functions
should be used in this case
- other reset lines only support reset pulses. the _reset function
should be used in this case
- the _reset function should only assert the reset line, then wait
until the hardware automatically de-asserts it (without any further
write)

is this the same for all, old and new SoCs?

only two mainline Lantiq drivers are using reset lines - both are
using the _assert and _deassert variants:
- drivers/net/dsa/lantiq_gswip.c
- drivers/phy/lantiq/phy-lantiq-rcu-usb2.c

> 4. Code not optimized and intel internal review not assessed.
insights from you (like the issue with the reset callback) are very
valuable - this shows that we should focus on having one driver.

> Based on the above findings, I would suggest reset-lantiq.c to move to
> reset-intel-syscon.c
my concern with having two separate drivers is that it will be hard to
migrate from reset-lantiq to the "optimized" reset-intel-syscon
driver.
I don't have access to the datasheets for the any Lantiq/Intel SoC
(VRX200 and even older).
so debugging issues after switching from one driver to another is
tedious because I cannot tell which part of the driver is causing a
problem (it's either "all code from driver A" vs "all code from driver
B", meaning it's hard to narrow it down).
with separate commits/patches that are improving the reset-lantiq
driver I can do git bisect to find the cause of a problem on the older
SoCs (VRX200 for example)

> What is your opinion?
I explained why I would like to avoid having two separate drivers
(even just for a limited amount of time)


Martin


[0] https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/lantiq/files/arch/mips/boot/dts/vr9.dtsi;h=e8b87dbcc7de2fb928a4e602f1a650030d2f7c35;hb=c3a78955f34a61d402044f357f54f21c75a19ff9#l103
