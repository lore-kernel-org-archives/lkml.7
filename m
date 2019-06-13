Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C022C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29E12080A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gRY3cBMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387794AbfFMPmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:42:16 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41838 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731864AbfFMJtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:49:18 -0400
Received: by mail-vs1-f66.google.com with SMTP id g24so12223997vso.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 02:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NdS6xN6Z4DlPhoXqfSjLt1MlPeGtM/DFz1IwvW9UGoo=;
        b=gRY3cBMoBbyhUq/TwCPef50CCDKrv4iYze6tdunxTeCUZpRTxfdIbcrZIu3rL9nBmA
         IKu5OYITIeL6ltUdiFp9D/dQv5KZKcAv6V+fmHeGkWIe6jriJiht2zz2XO9FjHTjfRib
         NIvsg+FMfLXlxWpsnz2tVCHJTpT0XY2bvwC63A4K1b6VMqRrNgGbsb2LGvdXDeeBaEPZ
         m4z3ddfPasyoIKb3AqQ46OdJR6zCS6DXa7xNtmQomcyAaTessCVDKoSiccxpgKSHLEJM
         v8OJqfkxY2CdFdgcNZGppzV0c9uPWuWj07PpFzImXtu18YgRdm3Z/Qdd3ycwG99TvFSh
         91pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NdS6xN6Z4DlPhoXqfSjLt1MlPeGtM/DFz1IwvW9UGoo=;
        b=KOyNG4LkAmGKHYu4soKZH23uqSDWLieU77WBOSRfweAnStzwK6mA2Xq10h/xY/zqod
         MrtEu4YWFBkgJYhmLC4MAiomNR1OFy5jOi2yXvJKCUjud3roAdCxIW7kW+mcwbIxA+q0
         4CysU3KuOGacVLOrv9gbhFe6dasWBfCWgc7GC2YjNb4SxbgzGcSr0xunpGdD/vEWoRhR
         FPcm6h3npZL04Ga3ofbObdd+CUHo3k52jVYOuzpfD7Zob6jQDIc05JNkkXM2UJxF3lnF
         e2j/A1xHjpAIfur/BH/xabDoh9dXBH67j/+EL3M0sA9VvMk1NYr1DTLK68GI+9xDCv5i
         aiBA==
X-Gm-Message-State: APjAAAXOndHLafutT5G02ODUbxpkci+0U+ROZ71H8HPRrf7BZy2klfi0
        A31VQ66p9SKaurynTegaw9MNj87pac0mF7rNPgOBAw==
X-Google-Smtp-Source: APXvYqzWpA6aPKAyHaL8W3hPhJ3CXshgo14ktsq5uXw9v4wanH5DWggs2K573LXj7uMjFiRLQrDiZGsE/zNplvlP1QY=
X-Received: by 2002:a67:ed8b:: with SMTP id d11mr48182216vsp.35.1560419357888;
 Thu, 13 Jun 2019 02:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190607223716.119277-1-dianders@chromium.org>
 <20190607223716.119277-4-dianders@chromium.org> <363DA0ED52042842948283D2FC38E4649C52F8A0@IRSMSX106.ger.corp.intel.com>
 <CAD=FV=U8eo78Ee9xjhGXJMv=8YF9o89KLX024GH3iBRnRjCRvQ@mail.gmail.com>
 <CAPDyKFo=QMRTkNYUVSE2AqiZgytkTVRXF0Mvznn6trVT4-cR=Q@mail.gmail.com>
 <c7c6d3f4-ebb1-8964-0616-973fae1ab47d@broadcom.com> <CAPDyKFpM0+FfvoMo8Z_hxM9rzSjeQZHCsA2SPa8WP+SRDhhsPA@mail.gmail.com>
 <16b4bfb39e0.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <16b4bfb39e0.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Jun 2019 11:48:41 +0200
Message-ID: <CAPDyKFr+nzy4JrtSrudORfOkFvPa==UtgaokQwigo8+c1L9wbQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] brcmfmac: sdio: Disable auto-tuning around
 commands expected to fail
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        brcm80211-dev-list.pdl@broadcom.com,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Double Lo <double.lo@cypress.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Naveen Gupta <naveen.gupta@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        netdev@vger.kernel.org, brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019 at 15:58, Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
>
> On 6/12/2019 1:48 PM, Ulf Hansson wrote:
> > On Wed, 12 Jun 2019 at 13:11, Arend Van Spriel
> > <arend.vanspriel@broadcom.com> wrote:
> >>
> >> On 6/12/2019 12:10 PM, Ulf Hansson wrote:
> >>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c:
> >>>>     mmc_set_data_timeout(md, func->card);
> >>>>     mmc_wait_for_req(func->card->host, mr);
> >>> These are not okay, none of these things calls should really be done
> >>> from an SDIO func driver.
> >>>
> >>> It tells me that the func driver is a doing workaround for something
> >>> that should be managed in a common way.
> >>
> >> We are using some low-level functions passing chain of skbuff to the
> >> device using CMD53 with scatterlist. If I recall correctly Marvell made
> >> an attempt to have a similar function for it in the mmc stack. Not sure
> >> if that ever made it in. If so I can rework our driver using that API.
> >> If not, I can make a new attempt.
> >
> > I recall there were some patches, but not sure why we didn't merge them.
> >
> > Anyway, if you want to move this forward, that would be awesome!
>
> Let's scope it before moving forward. Our use-case is to transfer a
> chain of skbuff's. I am pretty sure that is not something we want to
> deal with in mmc stack api. So I suppose passing a scatterlist is more
> sensible, right? Maybe on sdio layer of the stack we could consider
> dealing with skbuff's for network func drivers?

Passing a scatter gather list seems reasonable. Ideally we should be
highly influenced with how buffers and dealt with for mmc block
requests.

Some information that may be needed by upper SDIO layers is the
segment/block constraints set by the MMC/SDIO host controller/driver.
The below is what we have today (see include/linux/mmc/host.h):

max_seg_size;   /* see blk_queue_max_segment_size */
max_segs;       /* see blk_queue_max_segments */
max_req_size;   /* maximum number of bytes in one req */
max_blk_size;   /* maximum size of one mmc block */
max_blk_count;  /* maximum number of blocks in one req */

Ideally we don't want SDIO func drivers to access these directly from
the ->host pointer, but rather via new SDIO func APIs.

>
> Let me see if I can find those Marvell patches. Might be a good start.

Great! Thanks!

Kind regards
Uffe
