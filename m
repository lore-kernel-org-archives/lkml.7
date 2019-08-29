Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E44CC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D481B206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Xxl0pnBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfH2VkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 17:40:14 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46495 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfH2VkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 17:40:14 -0400
Received: by mail-oi1-f194.google.com with SMTP id t24so3728694oij.13;
        Thu, 29 Aug 2019 14:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cq8CRLootqGMTweGV8Ok4eYTbsPlYEJFn0+4P0RKCak=;
        b=Xxl0pnBhck4XgihUbXtH6j4EsV7coEfMGXndZILcows6xSd3zpNi27Kc7JpGVJ9zdr
         hIYnuQSxW4hlwCjjhWQSkvfc0nvB+QDOJq4+MM0maTELQH+N3kqFwaa5/h31mEdEKlHX
         NLfCBxpeHXps442TVFhtDxFH8off6EPBYfXPatYukO3hmos9/Utamxp/XmLe0Uwz4XBG
         GFBIANsc5Wf64Wsj1jQchBCcq2izmqV+LgPSX6Xn5WgeBae/a+8WzHZnzOycSPwTqGJZ
         E8R9C2zbnfKmkh4exTV5qYEVpp5mtOXjLjzAYiCuGQuvL5Lf3fiHTQrLyk1V2HiUoAxQ
         7Dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cq8CRLootqGMTweGV8Ok4eYTbsPlYEJFn0+4P0RKCak=;
        b=gAgp20JlO2d7q9HS61S612S1d/9n2ndS0+jeySEp2uq+n7Fwdzcg+pIf6jtruHoFgq
         jm0vWe4hIYLlhXV8bSHY3uoTwrVYvMwWPv8l43/hbcVQw8534eIVnHkVcM+Ylu1ep07E
         O/uI0NXgEYfgQ2eizBbDFN2FVUl+ZMk5MwWxz5DWVpqiE93nxYd5vAutyUj4/2cqTGXb
         2sHuVzwAtKcKkKl9aF6I+Y3LScOxeyMzRXZdLtSvenWdcA8MgjyxD+RojJj7KtaikP7F
         Z85KjpyU9+/NlwOv62YiS99j/3grsxfXBt64AsjhFSmmfp8pemXQ56PJIBmJMV2dbnNQ
         /0VQ==
X-Gm-Message-State: APjAAAWNhatA3QDlPWI1ttAF/v+D3GqDUbByq+xgwLWUn91rg4F3ns7k
        iRZeHG1e4oF+iSm+0OzdHN/2ZuA/oCikQFUuKmQ=
X-Google-Smtp-Source: APXvYqwLDh9PobQ8kYYaM9Eo+KhgWvVAv7mVdP8ikaeELKD6XgwU/1ogmMzCWsyLzS04mJTw6AHwxueWx1N64k+7Yeg=
X-Received: by 2002:a05:6808:b14:: with SMTP id s20mr7973133oij.15.1567114812848;
 Thu, 29 Aug 2019 14:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <90cc600d6f7ded68f5a618b626bd9cffa5edf5c3.1566531960.git.eswara.kota@linux.intel.com>
 <20190824211158.5900-1-martin.blumenstingl@googlemail.com>
 <3813e658-1600-d878-61a4-29b4fe51b281@linux.intel.com> <CAFBinCA_B9psNGBeDyhkewhoutNh6HsLUN+TRfO_8vuNqhis4Q@mail.gmail.com>
 <48b90943-e23d-a27a-c743-f321345c9151@linux.intel.com> <CAFBinCD1oKxYm8QD7XfZUWq_HC5A4GLMmLCnZrcRvpTxrKo30w@mail.gmail.com>
 <19719490-178a-18fd-64f2-f77d955897f7@linux.intel.com> <CAFBinCDmi4HN4Ayg4T8aKUeu4hrUmVQ+z-hTN-6XMhiOCUcHjg@mail.gmail.com>
 <34336c9a-8e87-8f84-2ae8-032b7967928f@linux.intel.com>
In-Reply-To: <34336c9a-8e87-8f84-2ae8-032b7967928f@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 29 Aug 2019 23:40:01 +0200
Message-ID: <CAFBinCDfM3ssHisMBKXZUFkfoAFw51TaUuKt_aBgtD-mN+9fhg@mail.gmail.com>
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

On Thu, Aug 29, 2019 at 4:51 AM Chuan Hua, Lei
<chuanhua.lei@linux.intel.com> wrote:

> >
> > I'm not surprised that we got some of the IP block layout for the
> > VRX200 RCU "wrong" - all "documentation" we have is the old Lantiq UGW
> > (BSP).
> > with proper documentation (as in a "public datasheet for the SoC") it
> > would be easy to spot these mistakes (at least I assume that the
> > quality of the Infineon / Lantiq datasheets is excellent).
> >
> > back to reset-intel-syscon:
> > assigning only one job to the RCU hardware is a good idea (in my opinion).
> > that brings up a question: why do we need the "syscon" compatible for
> > the RCU node?
> > this is typically used when registers are accessed by another IP block
> > and the other driver has to access these registers as well. does this
> > mean that there's more hidden in the RCU registers?
> As I mentioned, some other misc registers are put into RCU even they
> don't belong to reset functions.
OK, just be aware that there are also rules for syscon compatible
drivers, see for example: [0]
if Rob (dt-bindings maintainer) is happy with the documentation in
patch 1 then I'm fine with it as well.
for my own education I would appreciate if you could describe these
"other misc registers" with a few sentences (I assume that this can
also help Rob)

[...]
> >>>>>> 4. Code not optimized and intel internal review not assessed.
> >>>>> insights from you (like the issue with the reset callback) are very
> >>>>> valuable - this shows that we should focus on having one driver.
> >>>>>
> >>>>>> Based on the above findings, I would suggest reset-lantiq.c to move to
> >>>>>> reset-intel-syscon.c
> >>>>> my concern with having two separate drivers is that it will be hard to
> >>>>> migrate from reset-lantiq to the "optimized" reset-intel-syscon
> >>>>> driver.
> >>>>> I don't have access to the datasheets for the any Lantiq/Intel SoC
> >>>>> (VRX200 and even older).
> >>>>> so debugging issues after switching from one driver to another is
> >>>>> tedious because I cannot tell which part of the driver is causing a
> >>>>> problem (it's either "all code from driver A" vs "all code from driver
> >>>>> B", meaning it's hard to narrow it down).
> >>>>> with separate commits/patches that are improving the reset-lantiq
> >>>>> driver I can do git bisect to find the cause of a problem on the older
> >>>>> SoCs (VRX200 for example)
> >>>> Our internal version supports XRX350/XRX500/PRX300(MIPS based) and
> >>>> latest Lighting Mountain(X86 based). Migration to reset-intel-syscon.c
> >>>> should be straight forward.
> >>> what about the _reset callback on the XRX350/XRX500/PRX300 SoCs - do
> >>> they only use level resets (_assert and _deassert) or are some reset
> >>> lines using reset pulses (_reset)?
> >>>
> >>> when we wanted to switch from reset-lantiq.c to reset-intel-syscon.c
> >>> we still had to add support for the _reset callback as this is missing
> >>> in reset-intel-syscon.c currently
> >> Yes. We have reset pulse(assert, then check the reset status).
> > only now I realized that the reset-intel-syscon driver does not seem
> > to use the status registers (instead it's looking at the reset
> > registers when checking the status).
> > what happened to the status registers - do they still exist in newer
> > SoCs (like LGM)? why are they not used?
> Reset status check is there. regmap_read_poll_timeout to check status
> big. Status register offset <4) from request register. For legacy, there
> is one exception, we can add soc specific data to handle it.
I see, thank you for the explanation
this won't work on VRX200 for example because the status register is
not always at (reset register - 0x4)

> > on VRX200 for example there seem to be some cases where the bits in
> > the reset and status registers are different (for example: the first
> > GPHY seems to use reset bit 31 but status bit 30)
> > this is currently not supported in reset-intel-syscon
> This is most tricky and ugly part for VRX200/Danube. Do you have any
> idea to handle this nicely?
with reset-lantiq we have the following register information:
a) reset offset: first reg property
b) status offset: second reg property
c) reset bit: first #reset-cell
d) status bit: second #reset-cell

reset-intel-syscon derives half of this information from the two #reset-cells:
a) reset offset: first #reset-cell
b) status offset: reset offset - 0x4
c) reset bit: second #reset-cell
d) status bit: same as reset bit

I cannot make any suggestion (yet) how to handle VRX200 and LGM in one
driver because I don't know enough about LGM (yet).
on VRX200 my understanding is that we have 64 reset bits (2x 32bit
registers) and 64 status bits (also 2x 32bit registers). each reset
bit has a corresponding status bit but the numbering may be different
it's not clear to me how many resets LGM supports and how they are
organized. for example: I think it makes a difference if "there are 64
registers with each one reset bit" versus "there are two registers
with 32 bits each"
please share some details how it's organized internally, then I can
try to come up with a suggestion.

... after writing this I noticed that we are discussing the binding.
we definitely need to share a summary with Rob on patch #1 and check
with him if he sees any problems with the approach that we may come up
with


Martin


[0] https://lkml.org/lkml/2019/8/27/849
