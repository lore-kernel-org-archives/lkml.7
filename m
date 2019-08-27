Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22DDC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7521120856
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hN/V/xLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbfH0VPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 17:15:50 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40765 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfH0VPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:15:50 -0400
Received: by mail-ot1-f68.google.com with SMTP id c34so600788otb.7;
        Tue, 27 Aug 2019 14:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3MnYvi8VtaRcp/rHbI9KPdInu4N0A1KOA+/94epMvU=;
        b=hN/V/xLbq6sNZT2zD85XgAV3HLqcYmzYQZ5mR63DRtrdtxzqoJwrLfdMp5YVeebXEz
         AjRoVm8EV3UD2rVr8CVuIL3z6pvMQV49HkO4jW0kgprFGEyZL6qN/aHXT4F28uTDEuoL
         42oVAUjk/LtxrrJBUDyvlSEpVEy112r3wpzLT4mLtWl7FLYGJuKaes4milIJtyqB3y/y
         kmXD8VcUOF9pJWQVUCXWVCAMOijzXsGIBKZoUyYp3f41Y4d4CKbIw2WWf2iUn9zBCf+N
         pF5X7evX7doPM1BFgAyC4GKWe6YSrQa4N6N9K5whGsnV9tANtdJKo42CfIKKgypDulsm
         S+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3MnYvi8VtaRcp/rHbI9KPdInu4N0A1KOA+/94epMvU=;
        b=GOutm2IzO1ndngHBWSLqltOFlTFalZDJBjgsMMmtpBQQjz4nP9rhGG+sR7L4v93PY9
         PxFPMRn5VKMcuGiTGeaK9PtgQO0T7/N55LqzHUADXw0fhLVyFwnToxVefDm0uJ4fVIk7
         7lfAu+r/LcJU8+3qfJeD2+6pbd+z84ubGvfBK+UoRxzWv60pUNnxe895L8UGRTiKpkTk
         f3ey1p1Nh/TG0MpQgJTnQJ4C9+8EAT+NIqCxvcijjBE6bnsnoeaBayuymVNL2jatSWGK
         oSMJr5BdMH2Kgi11OtmwQoxE64Bsep+tHF9A8JwZsretq0LsdoWpvYIGXpaIzJFr3IVL
         Ja0g==
X-Gm-Message-State: APjAAAX/Hk9FQIb5hjTIMGwnriA2dRLHy947b0zC93OGbFpqNanByrye
        McvG9Ue+ZuWvV243TwURe977CPNLQYXt5uEEXxI+1O1T
X-Google-Smtp-Source: APXvYqz5epXJ0wSrOtLw7u+zw/bJIZIAxyYcBrg5i6btHpM6tr7VMvNV2NLotNhwQR3sflpkB9AdGQbAAQES/g9QEvs=
X-Received: by 2002:a9d:1d5:: with SMTP id e79mr595425ote.98.1566940548656;
 Tue, 27 Aug 2019 14:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <90cc600d6f7ded68f5a618b626bd9cffa5edf5c3.1566531960.git.eswara.kota@linux.intel.com>
 <20190824211158.5900-1-martin.blumenstingl@googlemail.com>
 <3813e658-1600-d878-61a4-29b4fe51b281@linux.intel.com> <CAFBinCA_B9psNGBeDyhkewhoutNh6HsLUN+TRfO_8vuNqhis4Q@mail.gmail.com>
 <48b90943-e23d-a27a-c743-f321345c9151@linux.intel.com>
In-Reply-To: <48b90943-e23d-a27a-c743-f321345c9151@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 27 Aug 2019 23:15:37 +0200
Message-ID: <CAFBinCD1oKxYm8QD7XfZUWq_HC5A4GLMmLCnZrcRvpTxrKo30w@mail.gmail.com>
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

On Tue, Aug 27, 2019 at 4:23 AM Chuan Hua, Lei
<chuanhua.lei@linux.intel.com> wrote:
[...]
> >> 1. reset-lantiq.c use index instead of register offset + bit position.
> >> index reset is good for a small system (< 64). However, it will become very
> >> difficult to use if you have  > 100 reset. So we use register offset +
> >> bit position
> > reset-lantiq uses bit bit positions for specifying the reset line.
> > for example this is from OpenWrt's vr9.dtsi:
> >    reset0: reset-controller@10 {
> >      ...
> >      reg = <0x10 4>, <0x14 4>;
> >      #reset-cells = <2>;
> >    };
> >
> >    gphy0: gphy@20 {
> >      ...
> >      resets = <&reset0 31 30>, <&reset1 7 7>;
> >      reset-names = "gphy", "gphy2";
> >    };
> >
> > in my own words this means:
> > - all reset0 reset bits are at offset 0x10 (parent is RCU)
> > - all reset0 status bits are at offset 0x14 (parent is RCU)
> > - the first reset line uses reset bit 31 and status bit 30
> > - the second reset line uses reset bit 7 and status bit 7
> > - there can be multiple reset-controller instances, each taking the
> > reset and status offsets (OpenWrt's vr9.dtsi specifies the second RCU
> > reset controller "reset1" with reset offset 0x48 and status offset
> > 0x24)
>
> in reset-lantiq.c, we split each reset request /status pair into one
> reset controller.
>
> Each reset controller handles up to 32 resets. It will create up to 9
> even more
> reset controllers in the new SoCs. In reality, there is only one RCU
> controller for all
> SoCs. These designs worked but did not follow what hardware implemented.
>
> After checking the existing code and referring to other implementation,
> we decided to
> use register offset + bit position method. It can support all SoCs with
> this methods
> without code change(device tree change only).
maybe I have a different interpretation of what "RCU" does.
let me explain it in my own words based on my knowledge about VRX200:
- in my own words it is a multi function device with the following
functionality:
- it contains two reset controllers (reset at 0x10, status 0x14 and
reset at 0x48, status at 0x24)
- it contains two USB2 PHYs (PHY registers at 0x18, ANA cfg at 0x38
and PHY registers at 0x34, ANA cfg at 0x3c)
- it contains the configuration for the two GPHY IP blocks (at 0x20 and 0x68)
- it contains endianness configuration registers (for PCI, PCIe, ...)
- it contains the watchdog boot status (whether the SoC was previously
reset by the WDT)
- maybe more, but I don't know anything else about it

we tried our best to document this in
Documentation/devicetree/bindings/mips/lantiq/rcu.txt

I'm not sure about the details of the RCU on the LGM SoCs:
if it contains more than just reset controllers then please let Rob
Herring (dt-bindings maintainer) know about this.
we may only have one chance to do it right, if we start with a
"broken" binding then devices with incompatible bootloaders etc. may
have already shipped
(in general: that is why the devicetree maintainers want to have all
device properties documented in the binding, even if the driver does
not support all of them yet)

> >> 2. reset-lantiq.c does not support device restart which is part of the
> >> reset in
> >> old lantiq SoC. It moved this part into arch/mips/lantiq directory.
> > it was moved to the .dts instead of the arch code. again from
> > OpenWrt's vr9.dtsi [0]:
> >    reboot {
> >      compatible = "syscon-reboot";
> >      regmap = <&rcu0>;
> >      offset = <0x10>;
> >      mask = <0xe0000000>;
> >    };
> >
> > this sets the reset0 reset bits 31, 30 and 29 at reboot
> ok. but not sure why we need to reset bit 31 and 29. global softwre
> reset is bit 30.
I don't know either. depending on what the LGM SoCs need you can
change the "mask" property to the value that fits that SoC best

[...]
> > - other reset lines only support reset pulses. the _reset function
> > should be used in this case
> > - the _reset function should only assert the reset line, then wait
> > until the hardware automatically de-asserts it (without any further
> > write)
> Yes, this is called hardware reset. We can't control reset duration.
> > is this the same for all, old and new SoCs?
>
> New SoCs have removed support for hardware reset after software's feedback.
>
> Old SoCs such as VRX200/ARX300 has both software/hardware resets
nice, it's good to see teamwork between hardware and software teams!

[...]
> >> 4. Code not optimized and intel internal review not assessed.
> > insights from you (like the issue with the reset callback) are very
> > valuable - this shows that we should focus on having one driver.
> >
> >> Based on the above findings, I would suggest reset-lantiq.c to move to
> >> reset-intel-syscon.c
> > my concern with having two separate drivers is that it will be hard to
> > migrate from reset-lantiq to the "optimized" reset-intel-syscon
> > driver.
> > I don't have access to the datasheets for the any Lantiq/Intel SoC
> > (VRX200 and even older).
> > so debugging issues after switching from one driver to another is
> > tedious because I cannot tell which part of the driver is causing a
> > problem (it's either "all code from driver A" vs "all code from driver
> > B", meaning it's hard to narrow it down).
> > with separate commits/patches that are improving the reset-lantiq
> > driver I can do git bisect to find the cause of a problem on the older
> > SoCs (VRX200 for example)
>
> Our internal version supports XRX350/XRX500/PRX300(MIPS based) and
> latest Lighting Mountain(X86 based). Migration to reset-intel-syscon.c
> should be straight forward.
what about the _reset callback on the XRX350/XRX500/PRX300 SoCs - do
they only use level resets (_assert and _deassert) or are some reset
lines using reset pulses (_reset)?

when we wanted to switch from reset-lantiq.c to reset-intel-syscon.c
we still had to add support for the _reset callback as this is missing
in reset-intel-syscon.c currently


Martin
