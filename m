Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C608C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 21:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34B82342C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 21:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DsgC74iZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfIAVif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 17:38:35 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38147 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbfIAVie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 17:38:34 -0400
Received: by mail-ot1-f67.google.com with SMTP id r20so11892124ota.5;
        Sun, 01 Sep 2019 14:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gkDTWqFGqrNSxPpmWmpKZXSgxoeSOJ67hdaa05GAmTI=;
        b=DsgC74iZG5FsVjRdO+sefzcee6bOl+UH817p4aZy/Bx4DiTHNYJyeXBK7gwgIQTDgv
         i82TmRav7leXgAUhN8u4f6c8hCsPcHtV2w1FmXCEjydGeJZecsnWgaZYF+H/G4cKvtSr
         f6skGwy8w12E7/idzS0iJpW76QrLlxhnI/0a+0nQYDQCqcTPvsE4BoiSaXzNolZUX66T
         LBTiS2Q/xy10eZCHEzEMGIJuu5enb6Xg0OU+bpPQPo8NTp4EdBvt2xfbcvW7SYNupjEv
         KXOgGUBhe57CUhn3ScSLNOyL72T3vVFyX5UDTznf/7xuItef3NQVf5VGaQzgtgDGDdWN
         oH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gkDTWqFGqrNSxPpmWmpKZXSgxoeSOJ67hdaa05GAmTI=;
        b=IdnxCtxX0WqAG3vdEpup5rFOeAhtOD7wxpdbOTqVvE4BqvfpIK3cTizzSGbn2Zc18B
         L8qm34QmyoaDyUr/YoIkDMjt6zb8Q8mt3u63Q3Itu8wWfL+ot+IBjctU1PWAEpRJwf49
         RDlAPpoZEvhB++UckwVS7UiIfFtXDEtzIvXFBJSU3CxIcwSqwlGmhW3q/DglACSgahRD
         ahKZ7eiEcmugjEGs2HEnzLTiDP29KvOVQQW6ZdY8BPVHKz+Q0VcdY+oayK0SxMYWG6QB
         xB9HfKiVj229ViCoBGnrNamq9ULguTqYcSL0Qml1+lF8DW5NtEwMgsM2BNKnUjVLsbak
         +ysw==
X-Gm-Message-State: APjAAAXc8bU3O3SNrTZddOnJh9tXKwup/kzWxayMN35Gp6O56vizRsd4
        ty9sxFcwIISx2K6mHgGDliCWzBL2NwOJkDQx2kM=
X-Google-Smtp-Source: APXvYqxqbMuxISVKBZmHz7nvATFZT+GFYxX+d41hEKVFDNAQ4G1GIfyJm4+Sm7gx6X9Y7e5u33bkX/m982JHlvn3WLc=
X-Received: by 2002:a05:6830:1509:: with SMTP id k9mr7931439otp.42.1567373913125;
 Sun, 01 Sep 2019 14:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <90cc600d6f7ded68f5a618b626bd9cffa5edf5c3.1566531960.git.eswara.kota@linux.intel.com>
 <20190824211158.5900-1-martin.blumenstingl@googlemail.com>
 <3813e658-1600-d878-61a4-29b4fe51b281@linux.intel.com> <CAFBinCA_B9psNGBeDyhkewhoutNh6HsLUN+TRfO_8vuNqhis4Q@mail.gmail.com>
 <48b90943-e23d-a27a-c743-f321345c9151@linux.intel.com> <CAFBinCD1oKxYm8QD7XfZUWq_HC5A4GLMmLCnZrcRvpTxrKo30w@mail.gmail.com>
 <19719490-178a-18fd-64f2-f77d955897f7@linux.intel.com> <CAFBinCDmi4HN4Ayg4T8aKUeu4hrUmVQ+z-hTN-6XMhiOCUcHjg@mail.gmail.com>
 <34336c9a-8e87-8f84-2ae8-032b7967928f@linux.intel.com> <CAFBinCDfM3ssHisMBKXZUFkfoAFw51TaUuKt_aBgtD-mN+9fhg@mail.gmail.com>
 <657d796d-cb1b-472d-fe67-f7b9bf12fd79@linux.intel.com>
In-Reply-To: <657d796d-cb1b-472d-fe67-f7b9bf12fd79@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 1 Sep 2019 23:38:21 +0200
Message-ID: <CAFBinCA5sRp1-siqZqJzFL2nuD3BtjrbD65QtpWbnTgtPNXY1A@mail.gmail.com>
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

On Fri, Aug 30, 2019 at 5:02 AM Chuan Hua, Lei
<chuanhua.lei@linux.intel.com> wrote:
>
> Hi Martin,
>
> On 8/30/2019 5:40 AM, Martin Blumenstingl wrote:
> > Hi,
> >
> > On Thu, Aug 29, 2019 at 4:51 AM Chuan Hua, Lei
> > <chuanhua.lei@linux.intel.com> wrote:
> >
> >>> I'm not surprised that we got some of the IP block layout for the
> >>> VRX200 RCU "wrong" - all "documentation" we have is the old Lantiq UGW
> >>> (BSP).
> >>> with proper documentation (as in a "public datasheet for the SoC") it
> >>> would be easy to spot these mistakes (at least I assume that the
> >>> quality of the Infineon / Lantiq datasheets is excellent).
> >>>
> >>> back to reset-intel-syscon:
> >>> assigning only one job to the RCU hardware is a good idea (in my opinion).
> >>> that brings up a question: why do we need the "syscon" compatible for
> >>> the RCU node?
> >>> this is typically used when registers are accessed by another IP block
> >>> and the other driver has to access these registers as well. does this
> >>> mean that there's more hidden in the RCU registers?
> >> As I mentioned, some other misc registers are put into RCU even they
> >> don't belong to reset functions.
> > OK, just be aware that there are also rules for syscon compatible
> > drivers, see for example: [0]
> > if Rob (dt-bindings maintainer) is happy with the documentation in
> > patch 1 then I'm fine with it as well.
> > for my own education I would appreciate if you could describe these
> > "other misc registers" with a few sentences (I assume that this can
> > also help Rob)
> For LGM, RCU is clean. There would be no MISC register after software's
> feedback. These misc registers will be moved to chiptop/misc
> groups(implemented by syscon). For legacy SoC, we do have a lot MISC
> registers for different SoCs.
OK, I think I understand now: chiptop != RCU
so RCU really only has one purpose: handling resets
while chiptop manages all the random bits

does this means we don't need RCU to match "syscon"?

> >
> > [...]
> >>>>>>>> 4. Code not optimized and intel internal review not assessed.
> >>>>>>> insights from you (like the issue with the reset callback) are very
> >>>>>>> valuable - this shows that we should focus on having one driver.
> >>>>>>>
> >>>>>>>> Based on the above findings, I would suggest reset-lantiq.c to move to
> >>>>>>>> reset-intel-syscon.c
> >>>>>>> my concern with having two separate drivers is that it will be hard to
> >>>>>>> migrate from reset-lantiq to the "optimized" reset-intel-syscon
> >>>>>>> driver.
> >>>>>>> I don't have access to the datasheets for the any Lantiq/Intel SoC
> >>>>>>> (VRX200 and even older).
> >>>>>>> so debugging issues after switching from one driver to another is
> >>>>>>> tedious because I cannot tell which part of the driver is causing a
> >>>>>>> problem (it's either "all code from driver A" vs "all code from driver
> >>>>>>> B", meaning it's hard to narrow it down).
> >>>>>>> with separate commits/patches that are improving the reset-lantiq
> >>>>>>> driver I can do git bisect to find the cause of a problem on the older
> >>>>>>> SoCs (VRX200 for example)
> >>>>>> Our internal version supports XRX350/XRX500/PRX300(MIPS based) and
> >>>>>> latest Lighting Mountain(X86 based). Migration to reset-intel-syscon.c
> >>>>>> should be straight forward.
> >>>>> what about the _reset callback on the XRX350/XRX500/PRX300 SoCs - do
> >>>>> they only use level resets (_assert and _deassert) or are some reset
> >>>>> lines using reset pulses (_reset)?
> >>>>>
> >>>>> when we wanted to switch from reset-lantiq.c to reset-intel-syscon.c
> >>>>> we still had to add support for the _reset callback as this is missing
> >>>>> in reset-intel-syscon.c currently
> >>>> Yes. We have reset pulse(assert, then check the reset status).
> >>> only now I realized that the reset-intel-syscon driver does not seem
> >>> to use the status registers (instead it's looking at the reset
> >>> registers when checking the status).
> >>> what happened to the status registers - do they still exist in newer
> >>> SoCs (like LGM)? why are they not used?
> >> Reset status check is there. regmap_read_poll_timeout to check status
> >> big. Status register offset <4) from request register. For legacy, there
> >> is one exception, we can add soc specific data to handle it.
> > I see, thank you for the explanation
> > this won't work on VRX200 for example because the status register is
> > not always at (reset register - 0x4)
>
> As I mentioned, VRX200 and all legacy SoCs (MIPS based) can be solved
> with one soc data in the compatible array.
>
> For example(not same as upstream, but idea is similar)
>
> static u32 intel_stat_reg_off(struct intel_reset_data *data, u32 req_off)
> {
>      if (data->soc_data->legacy && req_off == RCU_RST_REQ)
>          return RCU_RST_STAT;
>      else
>          return req_off + 0x4;
> }
>
> >
> >>> on VRX200 for example there seem to be some cases where the bits in
> >>> the reset and status registers are different (for example: the first
> >>> GPHY seems to use reset bit 31 but status bit 30)
> >>> this is currently not supported in reset-intel-syscon
> >> This is most tricky and ugly part for VRX200/Danube. Do you have any
> >> idea to handle this nicely?
> > with reset-lantiq we have the following register information:
> > a) reset offset: first reg property
> > b) status offset: second reg property
> > c) reset bit: first #reset-cell
> > d) status bit: second #reset-cell
> >
> > reset-intel-syscon derives half of this information from the two #reset-cells:
> > a) reset offset: first #reset-cell
> > b) status offset: reset offset - 0x4
> > c) reset bit: second #reset-cell
> > d) status bit: same as reset bit
> >
> > I cannot make any suggestion (yet) how to handle VRX200 and LGM in one
> > driver because I don't know enough about LGM (yet).
> > on VRX200 my understanding is that we have 64 reset bits (2x 32bit
> > registers) and 64 status bits (also 2x 32bit registers). each reset
> > bit has a corresponding status bit but the numbering may be different
> > it's not clear to me how many resets LGM supports and how they are
> > organized. for example: I think it makes a difference if "there are 64
> > registers with each one reset bit" versus "there are two registers
> > with 32 bits each"
> > please share some details how it's organized internally, then I can
> > try to come up with a suggestion.
> LGM reset organization is more clean compared with legacy SoCs. We have
> 8 x 32bit reset and status registers(more modules need to be reset,
> overall ideas are similar without big change). Their request and status
> bit is at the same register bit position.  Hope this will help you.
have you already discussed using only one reset cell?
if there's only one big reset controller in RCU then why not let the
reset controller driver do it's job of translating a reset line? also
this represents the hardware best (dt-bindings should describe the
hardware, drivers then translate that into the various subsystems
offered by the kernel).

we have to translate it into:
- status register and bit
- reset register and bit

for LGM the implementation seems to be the easiest because the reset
line can be mapped easily to the registers and bit offsets (for
example like reset-meson.c does it, which also supports 256 reset
lines together with for example
include/dt-bindings/reset/amlogic,meson-g12a-reset.h. the latter is
nice to have but optional)
we can then implement special translation logic (in other words: a
separate of_xlate callback) for VRX200 which then has to do more
"magic" (like you have shown in your example code above: "if the reset
line belongs to the second set of 32 reset lines then use reset offset
X and status offset Y" - or even use a translation table as
reset-imx7.c does)

the current binding is a mix of specifying reset register and bit in
.dts but calculating the status register.
I missed the calculation of the status register until you pointed it out earlier


Martin
