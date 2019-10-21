Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1DACA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D102053B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YYqrP+N6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfJUOtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:49:15 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:37130 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfJUOtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:49:15 -0400
Received: by mail-vk1-f194.google.com with SMTP id v78so2817476vke.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 07:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jW5VBJqbIKfc0TSTZ4BubhIyInqE5Fh+T6DH/lX3Eug=;
        b=YYqrP+N6Nifpgr/HxnzrSkEW2+xxljCCdzjzcfweZwOUgpaW3wnUS0oAI/P9Qz3PZv
         IZ66ZNy/lLtc/nd98M4LE/URKM6mr4OHM+/JeRJ4GISUJeecJRAnyqE6eUNK/vaa+sAm
         bROawRG0+OPvXB+zEsOYAO5WYXkRFjUhVCgGPcRgeI+uyUyr+EdzWETJDdLHWbKMMD9R
         0quIcCw6d079pjMY2fDEcShGViQTwRD74LNX5q3GIMoSnlqtfqPSOIHFerV+LBoB393H
         28+w7/p4m1WsdkPObaOxX7x1NFQyeEJfWo/BHCQIBSfTyILp7UGwI4Hn2Kx2U6QxBmI6
         KeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jW5VBJqbIKfc0TSTZ4BubhIyInqE5Fh+T6DH/lX3Eug=;
        b=SEDMsn0MRjGzQaTvbcJhe5osYN7nD0cIPnOYhQSfXHXpe8io6Re7eRNhrA8aXB1MAL
         /w2UqrT/FI67rISXGucmtLjsdhtQzabALSTvljFhsriF/xdLgtD+92bpdinPoDFITnQi
         th68iMUHHeajsiwoa8FonHs2fO69rqDf55XFRu7tcdKuonzpOOZV6UoQW7WE/g0ysuT3
         +NWt3qh+9RxhP7reTO1kBcy2BsjQ6pw3IG2uqgyN2N2wDNSw7b9bxDpGQIJQR5beQ0Sf
         kchR2VlbFdDJn5MegFWb8j/a6moc2GKNtTTL14N5OfnIKELmwkJ45BUnd7TWvrppY1d+
         mYCw==
X-Gm-Message-State: APjAAAWvCHwdc58wzD4hR+8lsJDRrEoDgbXmHihHl/FJQHxDXfLNva1J
        EgQDFHUYptVp4X095xNe8/u7mR3EKLJxQlhCSnu9Lg==
X-Google-Smtp-Source: APXvYqxRy2+ZGoTsikdopdOC2eqH8gw2kW8P73kcyVRKSYXNjgRfKYX2dY6SYcwslJ688wp9ul7buSMGBxoMDWF4we0=
X-Received: by 2002:a1f:a293:: with SMTP id l141mr13126073vke.43.1571669353545;
 Mon, 21 Oct 2019 07:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <1571637541-119016-1-git-send-email-jianxin.pan@amlogic.com>
 <fc1f61e1-b156-11e6-3f21-c498d2f0a8c6@baylibre.com> <1jwocybgpw.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jwocybgpw.fsf@starbuckisacylon.baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 21 Oct 2019 16:48:37 +0200
Message-ID: <CAPDyKFq_YAB0tycE2ypdJp8gckfeiFRv=A120ZedyDDhu3K17w@mail.gmail.com>
Subject: Re: [PATCH] mmc: fix mmc dma operation
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Nan Li <nan.li@amlogic.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Victor Wan <victor.wan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 at 11:17, Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Mon 21 Oct 2019 at 09:57, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> > Hi,
> >
> > Thanks for the fix.
> >
> > First, you should add "mmc: meson-gx:" in the subject.
> >
> > On 21/10/2019 07:59, Jianxin Pan wrote:
> >> From: Nan Li <nan.li@amlogic.com>
> >>
> >> In MMC dma transfer, the region requested by dma_map_sg() may be released
> >> by dma_unmap_sg() before the transfer is completed.
> >>
> >> Put the unmap operation in front of mmc_request_done() to avoid this.
> >
>
> Since we have seen this problem (yet), could you briefly how you've
> triggered it ?
>
> >
> > You should add a "Fixes:" tag so it can be backported on stable kernels.
> >
> >>
> >> Signed-off-by: Nan Li <nan.li@amlogic.com>
> >> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> >> ---
> >>  drivers/mmc/host/meson-gx-mmc.c | 15 ++++++++-------
> >>  1 file changed, 8 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> >> index e712315..7667e8a 100644
> >> --- a/drivers/mmc/host/meson-gx-mmc.c
> >> +++ b/drivers/mmc/host/meson-gx-mmc.c
> >> @@ -173,6 +173,7 @@ struct meson_host {
> >>      int irq;
> >>
> >>      bool vqmmc_enabled;
> >> +    bool needs_pre_post_req;
> >>  };
> >>
> >>  #define CMD_CFG_LENGTH_MASK GENMASK(8, 0)
> >> @@ -654,6 +655,8 @@ static void meson_mmc_request_done(struct mmc_host *mmc,
> >>      struct meson_host *host = mmc_priv(mmc);
> >>
> >>      host->cmd = NULL;
> >> +    if (host->needs_pre_post_req)
> >> +            meson_mmc_post_req(mmc, mrq, 0);
> >>      mmc_request_done(host->mmc, mrq);
> >>  }
> >>
> >> @@ -803,25 +806,23 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
> >>  static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >>  {
> >>      struct meson_host *host = mmc_priv(mmc);
> >> -    bool needs_pre_post_req = mrq->data &&
> >> +
> >> +    host->needs_pre_post_req = mrq->data &&
> >>                      !(mrq->data->host_cookie & SD_EMMC_PRE_REQ_DONE);
> >>
> >> -    if (needs_pre_post_req) {
> >> +    if (host->needs_pre_post_req) {
> >>              meson_mmc_get_transfer_mode(mmc, mrq);
> >>              if (!meson_mmc_desc_chain_mode(mrq->data))
> >> -                    needs_pre_post_req = false;
> >> +                    host->needs_pre_post_req = false;
> >>      }
> >>
> >> -    if (needs_pre_post_req)
> >> +    if (host->needs_pre_post_req)
> >>              meson_mmc_pre_req(mmc, mrq);
> >>
> >>      /* Stop execution */
> >>      writel(0, host->regs + SD_EMMC_START);
> >>
> >>      meson_mmc_start_cmd(mmc, mrq->sbc ?: mrq->cmd);
> >> -
> >> -    if (needs_pre_post_req)
> >> -            meson_mmc_post_req(mmc, mrq, 0);
> >>  }
>
> The code around all this is getting quite difficult to follow eventhough
> it does not actually do much
>
> The root of the problem seems be that meson_mmc_pre_req() and
> meson_mmc_post_req() are passed to framework but also called manually
> from meson_mmc_request().
>
> Because of this, some code is added to make sure we don't do things twice.
> Maybe I'm missing something but it look weird ? Ulf, could you give us
> your view ?

This is tricky, unfortunately.

The main problem boils done to that, there is no guarantee that the
->pre|post_request() host callbacks is called at all, as that depends
on if the mmc block layer has more than one requests in the pipe to
send. Additionally, that of course varies dynamically on a running
system.

>
> As far as I can tell:
>  * pre_req : determine if we use CHAIN_MODE or not AND
>              dma_map_sg() if we do
>  * post_req : dma_unmap_sg() if previously allocated
>
> Do we really need to do all this meson_mmc_request() ? Shouldn't we let the
> framework do the calls to pre/post_req for us ?

Whether we theoretically could simplify the path, by for example
always calling the ->pre|post_request() callbacks if those exists, is
probably too late to change. Well, unless we can change all host
drivers implementing them as well... so it's probably just easier to
accept this as is.

One thing though, make sure you have a nice self descriptive naming of
variables and functions, to deal with this. That helps a lot.

Kind regards
Uffe
