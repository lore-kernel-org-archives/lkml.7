Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8CAC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833C720643
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EKfDVCMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfCEWNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:13:04 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36636 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbfCEWND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:13:03 -0500
Received: by mail-oi1-f194.google.com with SMTP id t206so8172160oib.3;
        Tue, 05 Mar 2019 14:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WYJMlp5Vut5df0LwvjRW5FdzMglfOFR6RfxA4GeSLr8=;
        b=EKfDVCMXX1msbJMLIyY8hpA1mcUrfM9FK61JvpEImEwroyZum23uexEqYJzsa4gc+e
         hPmyyFRh5IG3/+fQ4HFE7/gDUfc6yUbhqiPy2SIE/hPO52QmPn9lqXMycbG1DBCUvpyI
         ufHMC+8JY3ZJgdvHyYqtQGL6JIEzLHrMGtzXWfVORooZ5mFuJw0PjVXvDpN1kDwS7QKN
         0ZO4LLE7JBKLXpe917duXI//jF54XYU4Z1O39LLA7kL61Qjj4sslelmREwZCvViV+TRB
         JR7DVRTELoZGj6LVGOrpm2wuD9pdCOU1WH0DJwmEEx53W8q+yksgOT9lAUZwtkR0X+TI
         Ar2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WYJMlp5Vut5df0LwvjRW5FdzMglfOFR6RfxA4GeSLr8=;
        b=b1cgWd65xIznRlMfez2cbKqVl2E1990d7s7pEdz8L7hlT+Foj2Aer296iC9b86fhXv
         i5qUwmZjHJmqjoY2+topihLwWZFH/vK1WqiRWX33zCt/H/5PsmeUG9D/ogx9Tannt2ht
         DcgddBcofIOmZHVr4pnIYcmnkt7U98oEUFwIIO+36wYKPhAUmHVyUsH+SdBjvtK0N0gv
         3CtziIr8xySofp8YNksZzJUtElwHgL0jQml+3ngXIEokjh2Ewvtu9iFwVBGpHgYBV2i1
         GLXyFnMxZEknKHvnHrpwjMJEg5FscLx5gX/62BjjQjx/YIolaNwzUs+6jNpywAnd8pPF
         v9/A==
X-Gm-Message-State: APjAAAVgJ8haofydq20U3FloULSLz2Unt/WvTJAmV3sGuR7APDmQjP5H
        mEmZzMaRpAKDXlbiwNKIYKpo2t22jI+Jy65ft0g=
X-Google-Smtp-Source: APXvYqylHzWAsDKPWuTZSoY9gnoPcVZkPUYqAe4nNyKcSRdS+QdPRss2u5afSvvh1AM7Ifn49XQdRG8YusvFuCcZdYQ=
X-Received: by 2002:aca:aacb:: with SMTP id t194mr461318oie.129.1551823982304;
 Tue, 05 Mar 2019 14:13:02 -0800 (PST)
MIME-Version: 1.0
References: <20190301182922.8309-1-martin.blumenstingl@googlemail.com> <98776767-c4d7-1207-6d42-97105f289bec@amlogic.com>
In-Reply-To: <98776767-c4d7-1207-6d42-97105f289bec@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 5 Mar 2019 23:12:51 +0100
Message-ID: <CAFBinCC7P40sqrDGTuM8M=jVOFTgZLDUK6rGdNpigFoepyCASw@mail.gmail.com>
Subject: Re: [RFC PATCH nand-next 0/2] meson-nand: support for older SoCs
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     linux-mtd@lists.infradead.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jianxin.pan@amlogic.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang,

On Mon, Mar 4, 2019 at 5:55 AM Liang Yang <liang.yang@amlogic.com> wrote:
>
> Hello Martin,
>
> On 2019/3/2 2:29, Martin Blumenstingl wrote:
> > Hi Liang,
> >
> > I am trying to add support for older SoCs to the meson-nand driver.
> > Back when the driver was in development I used an early revision (of
> > your driver) and did some modifications to make it work on older SoCs.
> >
> > Now that the driver is upstream I wanted to give it another try and
> > make a real patch out of it. Unfortunately it's not working anymore.
> >
> > As far as I know the NFC IP block revision on GXL is similar (or even
> > the same?) as on all older SoCs. As far as I can tell only the clock
> > setup is different on the older SoCs (which have a dedicated NAND
> > clock):
> > - we don't need the "amlogic,mmc-syscon" property on the older SoCs
> >    because we don't need to setup any muxing (common clock framework
> >    will do everything for us)
> > - "rx" and "tx" clocks don't exist
> > - I could not find any other differences between Meson8, Meson8b,
> >    Meson8m2, GXBB and GXL
> >
> That is right. the serials NFC is almost the same except:
> 1) The clock control and source that M8-serials are not share with EMMC.
> 2) The base register address
> 3) DMA encryption option which we don't care on NFC driver.
great, thank you for confirming this!

> > In this series I'm sending two patches which add support for the older
> > SoCs.
> >
> > Unfortunately these patches are currently not working for me (hence the
> > "RFC" prefix). I get a (strange) crash which is triggered by the
> > kzalloc() in meson_nfc_read_buf() - see below for more details.
> >
> > Can you please help me on this one? I'd like to know whether:
> > - the meson-nand driver works for you on GXL or AXG on linux-next?
> >    (I was running these patches on top of next-20190301 on my M8S
> >    board which uses a 32-bit Meson8m2 SoC. I don't have any board using
> >    a GXL SoC which also has NAND)
> Yes, it works on AXG platform using a MXIC slc nand flash(MX30LF4G); but
> i an not sure it runs the same flow with yours. because i see the print
> "Counld not find a valid ONFI parameter page, ...." in yours. i will try
> to reproduce it on AXG(i don't have a M8 platform now).
I'm looking forward to hear about the test results on your AXG boards
for reference: my board has a SK Hynix H27UCG8T2B (ID bytes: 0xad 0xde
0x94 0xeb 0x74 0x44, 20nm MLC)
I have another board (where I haven't tested the NFC driver yet) with
a SK Hynix H27UCG8T2E (ID bytes: 0xad 0xde 0x14 0xa7 0x42 0x4a, 1Ynm
MLC). if it helps with your analysis I can test on that board as well

> > - you see any issue with my patches? (maybe I missed more differences
> >    between GXL and the older SoCs)
> >
> i think it is ok now.
many thanks for checking my patches!


Regards
Martin
