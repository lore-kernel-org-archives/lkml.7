Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B989C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 05:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E483520880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 05:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hLH1ETLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbfGPFhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 01:37:22 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40661 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfGPFhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 01:37:22 -0400
Received: by mail-ot1-f66.google.com with SMTP id y20so3763524otk.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 22:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8P9WclNgjsC4+31Wz3e9NQ3AB5f9OPn5F6vXObBavI0=;
        b=hLH1ETLo4tIsjAJSzRDfDNE0autKIzMxJhQT+JgPsMwPaBsl5nPTnPa8jIqR8PCimJ
         B0NKglPOybNzfvidPhaFkFIYdlshqZEDyBrPCMLAhZyTLDfr5jRW6jp6wMUz0R+7o1ax
         5p+Y9XwO1K1N1eoPibSg0M/m9tmqxvmLeuk5A4UvE1r4XcTKyDb5b6BOVQyDnv3xBt1v
         nTI2taUAP2v5cSszmYzieInE3wIPcy+UfxGXnqgQzet2jUQfgVCqWTDz34TSmRLlT4Xd
         Tigwk6Wd5tDXHJ6O8sBikqyzPWohTQda52VXFo6PermFnYucaeXDVRl1SIgGOfluf7CH
         9e7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8P9WclNgjsC4+31Wz3e9NQ3AB5f9OPn5F6vXObBavI0=;
        b=UgCaUD+016XIVP/I7oMKLjK4vtZRS+udIqM38teBOU6EpOmJCraupq5jzSfHUVonwA
         v5+9CdoWOnbow7mUUrOYR6Dnrcki1MZr20HhK7veZ/MZB3rYWCo8g0S/hIWjWSw6PQsR
         SwcuTZNVxeWhqkX7427MmA5YqYkU39gd5KIdVLVQW+a3Yv3crRlc2M69VrxSDz5edO6P
         NsrLBj5yW9E2rTSpU4srMrBzjfE8kCfj2XGpFmNAyZRE9DJkCRen86Qolo+41ZqnBGP2
         yW5PCQ1GuLstdJPLPZ/OF9flwmq6yts3zWtiLDm2uxV9V98QShepH+zZkdPbai+udPZs
         jiJA==
X-Gm-Message-State: APjAAAX2vhv0vzTrHyIKxdCo1xS5nnBr6YzHj72YYvNaS8EQ1O954YMP
        HIkGMIIgsWB1ijci4OZqdIixKRrx6h0tWVLb9BQ9AQ==
X-Google-Smtp-Source: APXvYqzvF04zDHERbUuCYIMxv3xeXfypt7JE9gf7GZK5o1SIYENDEHqMEnCHycy8HmzqvA3DtQG9w1noxgI2I8NlLJw=
X-Received: by 2002:a9d:529:: with SMTP id 38mr23246842otw.145.1563255441094;
 Mon, 15 Jul 2019 22:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <4c5812f54e5094fa54a85bdc86687a523df254b3.1563184923.git.baolin.wang@linaro.org>
 <c54077a4-3aae-c95c-8491-db5f05b0305c@intel.com> <CAMz4kuJVhNFUrDiwiRd-UJ_JnsbxQaV-dE_97m32B+5_53kteg@mail.gmail.com>
 <6006e00f-4591-6fd1-425f-5bfcc8790e36@intel.com>
In-Reply-To: <6006e00f-4591-6fd1-425f-5bfcc8790e36@intel.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 16 Jul 2019 13:37:08 +0800
Message-ID: <CAMz4ku+2bDtUKHmNozUGWtefaiDWNde=wLsSktoRbMj5oihXfA@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: sdhci: Fix the incorrect soft reset operation
 when runtime resuming
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Mon, 15 Jul 2019 at 20:39, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 15/07/19 2:37 PM, Baolin Wang wrote:
> > Hi Adrian,
> >
> > On Mon, 15 Jul 2019 at 19:20, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 15/07/19 1:58 PM, Baolin Wang wrote:
> >>> In sdhci_runtime_resume_host() function, we will always do software reset
> >>> for all, but according to the specification, we should issue reset command
> >>> and reinitialize the SD/eMMC card.
> >>
> >> Where does it say that?
> >
> > I checked the SD host controller simplified specification Ver4.20, and
> > in Page 75, Software Reset For All bit, it says "if this bit is set
> > to1, the host driver should issue reset command and  reinitialize the
> > SD card". (I did not check other versions).
>
> That might simply be assuming that the bus power also controls the card power.

Yes.

>
> >
> >>
> >>>                                    However, we only do reinitialize the
> >>> SD/eMMC card when the SD/eMMC card are power down during runtime suspend.
> >>>
> >>> Thus for those platforms that do not power down the SD/eMMC card during
> >>> runtime suspend, we should not do software reset for all.
> >>>                                                           To fix this
> >>> issue, we can add one condition to validate the MMC_CAP_AGGRESSIVE_PM
> >>> to decide if we can do software reset for all or just reset command
> >>> and data lines.
> >>>
> >>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> >>> ---
> >>>  drivers/mmc/host/sdhci.c |    2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >>> index 9715834..470c5e0 100644
> >>> --- a/drivers/mmc/host/sdhci.c
> >>> +++ b/drivers/mmc/host/sdhci.c
> >>> @@ -3333,7 +3333,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
> >>>                       host->ops->enable_dma(host);
> >>>       }
> >>>
> >>> -     sdhci_init(host, 0);
> >>> +     sdhci_init(host, !(mmc->caps & MMC_CAP_AGGRESSIVE_PM));
> >>
> >> We have done a full reset for a long time, so it would be surprising to need
> >> to change it.
> >>
> >> What problem is it causing?
> >
> > If we did not power down the SD card during runtime suspend, and we
> > reset for all when runtime resume, our SD host controller can not work
> > well, will meet some strange behavior, like:
> >
> > [    6.525397] mmc0: Got data interrupt 0x00000002 even though no data
> > operation was in progress.
> > [    6.534189] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> > [    6.540797] mmc0: sdhci: Sys addr:  0x00000008 | Version:  0x00000004
> > [    6.547413] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000000
> > [    6.554029] mmc0: sdhci: Argument:  0x03200101 | Trn mode: 0x00000033
> > [    6.560645] mmc0: sdhci: Present:   0x01f000f0 | Host ctl: 0x00000030
> > [    6.567262] mmc0: sdhci: Power:     0x00000000 | Blk gap:  0x00000000
> > [    6.573877] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
> > [    6.580493] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
> > [    6.587109] mmc0: sdhci: Int enab:  0x037f000b | Sig enab: 0x037f000b
> > [    6.593726] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> > [    6.600342] mmc0: sdhci: Caps:      0x1c6d0080 | Caps_1:   0x08000007
> > [    6.606959] mmc0: sdhci: Cmd:       0x0000061b | Max curr: 0x00ffffff
> > [    6.613574] mmc0: sdhci: Resp[0]:   0x00001201 | Resp[1]:  0x00000000
> > [    6.620190] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> > [    6.626806] mmc0: sdhci: Host ctl2: 0x00003807
> > [    6.631364] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000df062000
> > [    6.638697] mmc0: sdhci: ============================================
> > [    6.645379] mmc0: cache flush error -84
> >
> > Got data interrupt but no data commands are processing now. With this
> > patch, then our SD host controller can work well. Did I miss anything
> > else? Thanks.
>
> The response seems to show the card in state 9 bus-testing, which would
> suggest the use of CMD19 for eMMC.  Perhaps the wrong command is used for
> eMMC re-tuning?

So it is strange, for eMMC we use CMD21 for tuning.

>
> The difficulty with changing long standing flow is that it might reveal
> problems for other existing hardware.  Did you consider making a
> driver-specific change?  The ->reset() callback could be used.

Understood. I will find a way to fix my issue and do not affect the
original logic used by other hardware. Thanks.

-- 
Baolin Wang
Best Regards
