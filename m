Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BC8C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5154206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VtRxxmvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbfIEUxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:53:35 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37242 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729290AbfIEUxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:53:33 -0400
Received: by mail-ot1-f68.google.com with SMTP id s28so3660589otd.4;
        Thu, 05 Sep 2019 13:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q7TGoGSjz9b7OF3jvUDtXty2QVstVxcyXA+1QLTMymk=;
        b=VtRxxmvTasi/UJdLw8mynlPhpW+T2ao3f9je8xxnMOddHez2JMOeD9ZzLozY5yRjE5
         cQBMRaiKhpOt/kHXDlCAQK0uG/a5CVi61EQlzOXHiKTDBzj462CNTPUIWAeDnjMRzPQx
         B1+4+zGl3zM/QADJ0+gkSBwkx1o5BVP5j1N8t56TLz5W1RuG9SWyeHAXxEiboIl67MGd
         fluOZGDf+GVIOaYoyuysqCsq8y5Pfjn93k26ef26dLDFoB/hU6Ur1+OUqe1kuHHmn19d
         UFNlW0BMUOE78tUagyJ2Wi4vnfU5H8U+3pHz/yCSvcQGg/TiSxMlLp0FZ7RR1JmTIFEB
         3cnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q7TGoGSjz9b7OF3jvUDtXty2QVstVxcyXA+1QLTMymk=;
        b=EfiGnDpRugVpn9op8nM2D7F2RaTp37vqvE5S+MsDyKpnJidLvwv24dSPl1dE0QrUkg
         N0ER3N2IFxLqV+nNrEJD4Zxr2N9k+F2/6N1ihrBbib8bTwZUwx1kewY/3rXpjVn/VjC3
         VivKgr+G2mXGbO1+LF/ynkzbeAp22WF0U9jLqrdlM5cMbSjfyO4zm8IR1rHyITO1ByGx
         RNCKP0cuGWpLmwXM0zmdPQcPC+GX2J7pfLwhiH/eb1d0NT3V9k7Yi+C9Tezhnd0l51Hr
         GSIXtJ6w5aWUmqgvd5BCdSeIQMrwfND06Ik8G3I2Up0VIyAdhSjHOSQfrtBtiV9p+Roa
         7I7g==
X-Gm-Message-State: APjAAAWzfXQpLtuD+45E4W+Jxa0GdvBp2fzR5as0d48qQDJUkGKM4hcq
        d4h5HE0Q4nLnVDhGf2o5i+QtD2UTLtiMhU3yF6U=
X-Google-Smtp-Source: APXvYqy3GqAwDF7shZxn9xhqQEkX8mBhKux6K0kmv8LJ8wZfft7v+0m8V98ooTaUZAz66nkwYuvi4OBcxwHPehKIuBs=
X-Received: by 2002:a9d:5c0f:: with SMTP id o15mr4607962otk.81.1567716812270;
 Thu, 05 Sep 2019 13:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <90cc600d6f7ded68f5a618b626bd9cffa5edf5c3.1566531960.git.eswara.kota@linux.intel.com>
 <20190824211158.5900-1-martin.blumenstingl@googlemail.com>
 <3813e658-1600-d878-61a4-29b4fe51b281@linux.intel.com> <CAFBinCA_B9psNGBeDyhkewhoutNh6HsLUN+TRfO_8vuNqhis4Q@mail.gmail.com>
 <48b90943-e23d-a27a-c743-f321345c9151@linux.intel.com> <CAFBinCD1oKxYm8QD7XfZUWq_HC5A4GLMmLCnZrcRvpTxrKo30w@mail.gmail.com>
 <19719490-178a-18fd-64f2-f77d955897f7@linux.intel.com> <CAFBinCDmi4HN4Ayg4T8aKUeu4hrUmVQ+z-hTN-6XMhiOCUcHjg@mail.gmail.com>
 <34336c9a-8e87-8f84-2ae8-032b7967928f@linux.intel.com> <CAFBinCDfM3ssHisMBKXZUFkfoAFw51TaUuKt_aBgtD-mN+9fhg@mail.gmail.com>
 <657d796d-cb1b-472d-fe67-f7b9bf12fd79@linux.intel.com> <CAFBinCA5sRp1-siqZqJzFL2nuD3BtjrbD65QtpWbnTgtPNXY1A@mail.gmail.com>
 <cebd8f1d-90ab-87e7-9a34-f5c760688ce5@linux.intel.com> <CAFBinCCXo50OX6=8Fz-=nRKuELU_fMOCX=z6iwAcw0_Tfgn1ug@mail.gmail.com>
 <da347f1c-864c-7d68-33c8-045e46651f45@linux.intel.com>
In-Reply-To: <da347f1c-864c-7d68-33c8-045e46651f45@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 5 Sep 2019 22:53:21 +0200
Message-ID: <CAFBinCDhLYmiORvHdZJAN5cuUjc6eWJK5n9Qg26B0dEhhqUqVQ@mail.gmail.com>
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

On Thu, Sep 5, 2019 at 4:38 AM Chuan Hua, Lei
<chuanhua.lei@linux.intel.com> wrote:
[...]
> >>>>>>> I'm not surprised that we got some of the IP block layout for the
> >>>>>>> VRX200 RCU "wrong" - all "documentation" we have is the old Lantiq UGW
> >>>>>>> (BSP).
> >>>>>>> with proper documentation (as in a "public datasheet for the SoC") it
> >>>>>>> would be easy to spot these mistakes (at least I assume that the
> >>>>>>> quality of the Infineon / Lantiq datasheets is excellent).
> >>>>>>>
> >>>>>>> back to reset-intel-syscon:
> >>>>>>> assigning only one job to the RCU hardware is a good idea (in my opinion).
> >>>>>>> that brings up a question: why do we need the "syscon" compatible for
> >>>>>>> the RCU node?
> >>>>>>> this is typically used when registers are accessed by another IP block
> >>>>>>> and the other driver has to access these registers as well. does this
> >>>>>>> mean that there's more hidden in the RCU registers?
> >>>>>> As I mentioned, some other misc registers are put into RCU even they
> >>>>>> don't belong to reset functions.
> >>>>> OK, just be aware that there are also rules for syscon compatible
> >>>>> drivers, see for example: [0]
> >>>>> if Rob (dt-bindings maintainer) is happy with the documentation in
> >>>>> patch 1 then I'm fine with it as well.
> >>>>> for my own education I would appreciate if you could describe these
> >>>>> "other misc registers" with a few sentences (I assume that this can
> >>>>> also help Rob)
> >>>> For LGM, RCU is clean. There would be no MISC register after software's
> >>>> feedback. These misc registers will be moved to chiptop/misc
> >>>> groups(implemented by syscon). For legacy SoC, we do have a lot MISC
> >>>> registers for different SoCs.
> >>> OK, I think I understand now: chiptop != RCU
> >>> so RCU really only has one purpose: handling resets
> >>> while chiptop manages all the random bits
> >>>
> >>> does this means we don't need RCU to match "syscon"?
> >> If we don't support legacy SoC with the same driver, we don't need
> >> syscon, just regmap. Regmap is a must for us since we will use regmap
> >> proxy to implement secure rest via secure processor.
> > I think we should drop the syscon compatible for LGM then
> > even for the legacy SoCs the reset controller should not have a syscon
> > compatible: instead it should have a syscon parent (as the current
> > "lantiq,xrx200-reset" binding requires and as suggested by Rob for
> > another IP block: [0])
> I am not sure if syscon parent really matches hardware implementation.
> In all our Networking SoCs, chiptop is kind of misc register collection.
> Some registers can't belong to any particular group, or they need to
> work together with other modules(therefore, these misc registers would
> be accessed by two or more modules). However, chiptop is not a hardware
> module.
indeed, chiptop should not have any child nodes (based on your explanation).
I was referring to VRX200 where the RCU syscon has various children
(one child node for each hardware module that's part of RCU: reset
controller, 2x USB PHY, ...)

back to LGM:
you said that the LGM RCU registers only contain the reset controller.
thus I see no need for the syscon compatible

> >
> > keeping regmap is great in my opinion because it's a nice API and gets
> > rid of some boilerplate
> > even better if it makes things easier for accessing the secure processor
> >
> >>>>> [...]
> >>>>>>>>>>>> 4. Code not optimized and intel internal review not assessed.
> >>>>>>>>>>> insights from you (like the issue with the reset callback) are very
> >>>>>>>>>>> valuable - this shows that we should focus on having one driver.
> >>>>>>>>>>>
> >>>>>>>>>>>> Based on the above findings, I would suggest reset-lantiq.c to move to
> >>>>>>>>>>>> reset-intel-syscon.c
> >>>>>>>>>>> my concern with having two separate drivers is that it will be hard to
> >>>>>>>>>>> migrate from reset-lantiq to the "optimized" reset-intel-syscon
> >>>>>>>>>>> driver.
> >>>>>>>>>>> I don't have access to the datasheets for the any Lantiq/Intel SoC
> >>>>>>>>>>> (VRX200 and even older).
> >>>>>>>>>>> so debugging issues after switching from one driver to another is
> >>>>>>>>>>> tedious because I cannot tell which part of the driver is causing a
> >>>>>>>>>>> problem (it's either "all code from driver A" vs "all code from driver
> >>>>>>>>>>> B", meaning it's hard to narrow it down).
> >>>>>>>>>>> with separate commits/patches that are improving the reset-lantiq
> >>>>>>>>>>> driver I can do git bisect to find the cause of a problem on the older
> >>>>>>>>>>> SoCs (VRX200 for example)
> >>>>>>>>>> Our internal version supports XRX350/XRX500/PRX300(MIPS based) and
> >>>>>>>>>> latest Lighting Mountain(X86 based). Migration to reset-intel-syscon.c
> >>>>>>>>>> should be straight forward.
> >>>>>>>>> what about the _reset callback on the XRX350/XRX500/PRX300 SoCs - do
> >>>>>>>>> they only use level resets (_assert and _deassert) or are some reset
> >>>>>>>>> lines using reset pulses (_reset)?
> >>>>>>>>>
> >>>>>>>>> when we wanted to switch from reset-lantiq.c to reset-intel-syscon.c
> >>>>>>>>> we still had to add support for the _reset callback as this is missing
> >>>>>>>>> in reset-intel-syscon.c currently
> >>>>>>>> Yes. We have reset pulse(assert, then check the reset status).
> >>>>>>> only now I realized that the reset-intel-syscon driver does not seem
> >>>>>>> to use the status registers (instead it's looking at the reset
> >>>>>>> registers when checking the status).
> >>>>>>> what happened to the status registers - do they still exist in newer
> >>>>>>> SoCs (like LGM)? why are they not used?
> >>>>>> Reset status check is there. regmap_read_poll_timeout to check status
> >>>>>> big. Status register offset <4) from request register. For legacy, there
> >>>>>> is one exception, we can add soc specific data to handle it.
> >>>>> I see, thank you for the explanation
> >>>>> this won't work on VRX200 for example because the status register is
> >>>>> not always at (reset register - 0x4)
> >>>> As I mentioned, VRX200 and all legacy SoCs (MIPS based) can be solved
> >>>> with one soc data in the compatible array.
> >>>>
> >>>> For example(not same as upstream, but idea is similar)
> >>>>
> >>>> static u32 intel_stat_reg_off(struct intel_reset_data *data, u32 req_off)
> >>>> {
> >>>>        if (data->soc_data->legacy && req_off == RCU_RST_REQ)
> >>>>            return RCU_RST_STAT;
> >>>>        else
> >>>>            return req_off + 0x4;
> >>>> }
> >>>>
> >>>>>>> on VRX200 for example there seem to be some cases where the bits in
> >>>>>>> the reset and status registers are different (for example: the first
> >>>>>>> GPHY seems to use reset bit 31 but status bit 30)
> >>>>>>> this is currently not supported in reset-intel-syscon
> >>>>>> This is most tricky and ugly part for VRX200/Danube. Do you have any
> >>>>>> idea to handle this nicely?
> >>>>> with reset-lantiq we have the following register information:
> >>>>> a) reset offset: first reg property
> >>>>> b) status offset: second reg property
> >>>>> c) reset bit: first #reset-cell
> >>>>> d) status bit: second #reset-cell
> >>>>>
> >>>>> reset-intel-syscon derives half of this information from the two #reset-cells:
> >>>>> a) reset offset: first #reset-cell
> >>>>> b) status offset: reset offset - 0x4
> >>>>> c) reset bit: second #reset-cell
> >>>>> d) status bit: same as reset bit
> >>>>>
> >>>>> I cannot make any suggestion (yet) how to handle VRX200 and LGM in one
> >>>>> driver because I don't know enough about LGM (yet).
> >>>>> on VRX200 my understanding is that we have 64 reset bits (2x 32bit
> >>>>> registers) and 64 status bits (also 2x 32bit registers). each reset
> >>>>> bit has a corresponding status bit but the numbering may be different
> >>>>> it's not clear to me how many resets LGM supports and how they are
> >>>>> organized. for example: I think it makes a difference if "there are 64
> >>>>> registers with each one reset bit" versus "there are two registers
> >>>>> with 32 bits each"
> >>>>> please share some details how it's organized internally, then I can
> >>>>> try to come up with a suggestion.
> >>>> LGM reset organization is more clean compared with legacy SoCs. We have
> >>>> 8 x 32bit reset and status registers(more modules need to be reset,
> >>>> overall ideas are similar without big change). Their request and status
> >>>> bit is at the same register bit position.  Hope this will help you.
> >>> have you already discussed using only one reset cell?
> >>> if there's only one big reset controller in RCU then why not let the
> >>> reset controller driver do it's job of translating a reset line? also
> >>> this represents the hardware best (dt-bindings should describe the
> >>> hardware, drivers then translate that into the various subsystems
> >>> offered by the kernel).
> >>>
> >>> we have to translate it into:
> >>> - status register and bit
> >>> - reset register and bit
> >>>
> >>> for LGM the implementation seems to be the easiest because the reset
> >>> line can be mapped easily to the registers and bit offsets (for
> >>> example like reset-meson.c does it, which also supports 256 reset
> >>> lines together with for example
> >>> include/dt-bindings/reset/amlogic,meson-g12a-reset.h. the latter is
> >>> nice to have but optional)
> >> When we implement this driver, we checked other drivers(hisilicon/*,
> >> reset-berlin.c and etc). After evaluation, we think register offset and
> >> register bit are easier for users to understand and use if they follow
> >> the hardware spec.
> > just so I know how the documentation looks like:
> > does the hardware spec document 8 registers, each with (up to) the 32
> > reset lines in it?
> >
> > reset-meson.c does it like that, but the difference there is that the
> > reset registers are continuous because there's no status register in
> > between
> > so your existing way of describing the reset line seems fine if Rob is
> > happy with it as well
> >
> >>> we can then implement special translation logic (in other words: a
> >>> separate of_xlate callback) for VRX200 which then has to do more
> >>> "magic" (like you have shown in your example code above: "if the reset
> >>> line belongs to the second set of 32 reset lines then use reset offset
> >>> X and status offset Y" - or even use a translation table as
> >>> reset-imx7.c does)
> >>>
> >>> the current binding is a mix of specifying reset register and bit in
> >>> .dts but calculating the status register.
> >>> I missed the calculation of the status register until you pointed it out earlier
> >> But we still don't have a good solution for VRX200 status bit issues.
> >> Before we solve this issue, it is very difficult to use one driver for
> > OK, let me summarize what we have so far.
> >
> > all SoC have the following "shared" logic so far:
> > - all reset_control_ops callbacks are the same on VRX200 and LGM
> > (assuming we fix the issues you found in the reset-lantiq.c
> > implementation)
> > - internally we should use regmap (LGM for accessing the secure
> > processor, earlier SoCs because the parent is a syscon)
> > - each reset line consists of a reset register offset and bit as well
> > as a status register offset and bit
> >
> > however, we have differences in:
> > - how to map the registers (LGM maps the RCU registers directly while
> > earlier SoCs fetch the parent syscon)
> > - calculation of the status register
> > - calculation of the status bit
> >
> > I see two ways to use one common driver for LGM and the earlier SoCs:
> >
> > 1) use a reset line mapping table as for example reset-imx7.c does.
> > this would include reset register, reset bit, status register and status bit.
> > LGM can use a macro to get rid of the duplication between status bit
> > and reset bit (and the status register offset if you prefer)
> > this case would use #reset-cells = <1> and we wouldn't need to
> > implement the of_xlate callback
> >
> > 2) on VRX200 (and probably the older SoCs as well) we can encode the
> > following information in one 32-bit value:
> > - reset register (max value: 0x48)
> > - status register (max value: 0x24)
> > - reset bit (max value: 32)
> > - status bit (max value: 32)
> >
> > if this also works for LGM we can determine all required information
> > for a reset line in the of_xlate callback and translate it to one
> > 32-bit value.
> > LGM and earlier SoCs would each use it's own of_xlate implementation.
> > the reset_control_ops callback would then unpack the 32-bit value
> > ("unsigned long id") into the reset register and bit as well as status
> > register and bit (as needed)
> >
> > both ways can work, but it depends on what the dt-bindings maintainers
> > (like Rob) think of the binding itself.
> > (dt-bindings follow what the hardware implements, the driver only does
> > the translation between a vendor specific binding and a given
> > subsystem)
> > so we first need Rob's ACK on the binding, then we can figure out the
> > best driver implementation for that binding
> I will check with Dilip about how we should move forward. syscon parent
> is one issue that we have to solve first.
agreed, let's define the binding first


Martin
