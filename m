Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97AFC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7538D217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CmUtjF4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfDKN3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:29:48 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40841 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfDKN3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:29:48 -0400
Received: by mail-vs1-f66.google.com with SMTP id f22so3450186vso.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 06:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LXcIovZxTvZn11FWVbqbY1we0+r7DuIF0I4xz4b9YLo=;
        b=CmUtjF4OlkiUvmSqlEINExxtGBm1etDEa6b7krf0lnYyOCed5mZURLnYsrc9pZhD4e
         jU5QfWOloyAEQ6BKuGywjN5G0EsHkVKCU20anmbtKFRjcaBgHQUxDBAoEd9Wr0cFM4U5
         w3tI3Sb11aiCZTDJ9vWCbu/ZmdVEFc/ZWeIznkWhuSaxThhPEAoepoP8+t/jxKaErrWf
         HQ1nqcTDHu1CH4Bvi3ujEZ0HyFYN/toftaBjr0NWJ5IsIQuPsbset7KQ2TttcGjq0J2w
         F3ezxsWfZTPYs7txLVOG1GiQaKQ4BBWTEq8I/F2mtsYtCsC+NjGl5XL9ARq2WHesYm99
         VlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LXcIovZxTvZn11FWVbqbY1we0+r7DuIF0I4xz4b9YLo=;
        b=JUd3t9+vlEn6IMHD5T4Iz6GFdNR7t5JOir1fyw/2lDEPsxwe+bilbc1RRVw0aR3r6N
         RsuSWhaTQiJUug6G9VI7VVsFK/+dqnuoP1tQRzTIfr1jeAnV127RqAgO6apVdXHRWtRW
         5+0rjzwjPJMhLt9/IcCQEZMsEp3MsbgcIY1mo26SN9Q4FUPc+thsUWn7NbRSP9GU+ZFA
         kt0n1Tpaq5ibjkMZmkVLCiTGZ5yYdFouddnvsZ67LuLEmEhRa82FS6KL8gdfDMSwh+1e
         G3bW6BImGaYxkbCdO2oCAV2IiZmppnVcYr3v0KRtHCbNZqBD4sJVMKfUgaK3earV+8sf
         NziQ==
X-Gm-Message-State: APjAAAV6/DTlArw32p1440Q4sjrMmamVUGQKDWIzzY7yhW3EyiL+d7jH
        dIhDtMXuYuHxlMeal0pxkyGKEU1XnNuKUCvNZSNU4g==
X-Google-Smtp-Source: APXvYqzMLI54BX7rjd8E4i3Ds4td2Ea+CU/Lxc6+OhGS9fczsEckxYIregfEXYlE6yEwPaaUQn1jNjUpZUkbMwln7Ik=
X-Received: by 2002:a67:2e8c:: with SMTP id u134mr27642736vsu.57.1554989386971;
 Thu, 11 Apr 2019 06:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <1551802205-32188-1-git-send-email-ludovic.Barre@st.com> <5b9fe100-6147-d64f-f676-6a5370a03016@st.com>
In-Reply-To: <5b9fe100-6147-d64f-f676-6a5370a03016@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Apr 2019 15:29:11 +0200
Message-ID: <CAPDyKFpRA4mP-SHt_JuWk-Ee7=2Jgv6jKFh_08n_V20czKyvNg@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: mmci: add busy detect for stm32 sdmmc variant
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019 at 14:37, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> Hi Ulf
>
> Just a gentleman ping about this series.
> I sent this series at same time of dt_mode
> (no dependence between both).

Thanks for pinging.

It's been a busy period, with travels etc. I am just catching up on
everything and I will soon come back to this.

I haven't tried to apply this on top of the other recent queued
changes for mmci, but perhaps you can check if a rebase is needed?
Especially since I plan to run this on my ux500 board.

Kind regards
Uffe

>
> BR
> Ludo
>
> On 3/5/19 5:10 PM, Ludovic Barre wrote:
> > From: Ludovic Barre <ludovic.barre@st.com>
> >
> > This patch series adds busy detect for stm32 sdmmc variant.
> > Some adaptations are required:
> > -Avoid to check and poll busy status when is not expected.
> > -Clear busy status bit if busy_detect_flag and busy_detect_mask are
> >   different.
> > -Add hardware busy timeout with MMCIDATATIMER register.
> >
> > Ludovic Barre (4):
> >    mmc: mmci: avoid fake busy polling
> >    mmc: mmci: fix clear of busy detect status
> >    mmc: mmci: add hardware busy timeout feature
> >    mmc: mmci: add busy detect for stm32 sdmmc variant
> >
> >   drivers/mmc/host/mmci.c | 67 +++++++++++++++++++++++++++++++++++++++----------
> >   drivers/mmc/host/mmci.h |  3 +++
> >   2 files changed, 57 insertions(+), 13 deletions(-)
> >
