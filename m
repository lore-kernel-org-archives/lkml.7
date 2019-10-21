Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5134CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBD820B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vZKXjgAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfJUPgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:36:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37260 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfJUPgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:36:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id e11so5823124wrv.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 08:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=dNJmxPlS7rbEDbw9OFNpKCFj/rI6Bli5TiuJbGODHi8=;
        b=vZKXjgAWvlCbcUUcFgP8yRK42f19FhF4eEf1VRRhpKIxcRYDA6jrVTwLTEP6rYKCaO
         1Koqa9mHjiS50ZYqzUqkUXkUj7+7pEkYU5RIMggBBa2u0aXJEpT9n6cvYCPCRq+595pS
         SPn6Hf5KI88ypFdzo0lQ2fRYQnY9MPeLaj8+MzkStoJLdauMhUq0VmA42tbaTw7wGv4k
         owh8sTI8FqRG9m4BqRxcF5ili3/EMUK4AeO7gAEcWG51kAd7+IE4gPPC6beqjxWFSXIU
         /XLny2nmQ47n6ntcP57ifMvXpE8jH6qt5mo3RRiA0nnRU+PKXbN8ElY0KG2TEiH2pmO4
         pM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=dNJmxPlS7rbEDbw9OFNpKCFj/rI6Bli5TiuJbGODHi8=;
        b=oufpypgqPoDnsND2ubFjMXpMjRLCwixNyWJQRJZWb5LDqpcSH2+co7C2gCkTcOY+0J
         g83zJL9pXAB16G/6CmBKtrepGrdMb/9r0M0rPMQjQH8VDByTw6MPHbNLLojRJVgOUdEr
         Z2XMpiQY06l72qwnsYqIpMPBgALp1R6rqafWzx6SOai2snOFwHxHJINpHQ43ZH9daoLQ
         LByLGexI6HnOF9M6O9dscPxCpsAjVuhp0aDJVcwmzWdkY9WJG0xrdEvfxW8QwZDccY1y
         meLnlkq0Zw+RTLNPNKtEmYC1IT9hFCyl2zq3Q2PT+S6SWS8uYyZX2Y+feB+1wzHVP3Jr
         v2rQ==
X-Gm-Message-State: APjAAAULTG4x0hIri0komykeeaWfhEB/0/EMioLaUqadVyMAopXrJcwp
        y8SBkRr42Usd5VhqS4D4vI/nmCmWQOo=
X-Google-Smtp-Source: APXvYqykqfD7nlSlbiHzaBMYXj1CdZefUvx3QG0SGzaxiJ37fYY/PtPcmN0GFNuQBCaoudhb5VhSpw==
X-Received: by 2002:adf:f74e:: with SMTP id z14mr5601740wrp.84.1571672195495;
        Mon, 21 Oct 2019 08:36:35 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d199sm5937609wmd.35.2019.10.21.08.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 08:36:34 -0700 (PDT)
References: <1571637541-119016-1-git-send-email-jianxin.pan@amlogic.com> <fc1f61e1-b156-11e6-3f21-c498d2f0a8c6@baylibre.com> <1jwocybgpw.fsf@starbuckisacylon.baylibre.com> <CAPDyKFq_YAB0tycE2ypdJp8gckfeiFRv=A120ZedyDDhu3K17w@mail.gmail.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Nan Li <nan.li@amlogic.com>,
        "open list\:ARM\/Amlogic Meson..." 
        <linux-amlogic@lists.infradead.org>,
        "linux-mmc\@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Victor Wan <victor.wan@amlogic.com>
Subject: Re: [PATCH] mmc: fix mmc dma operation
In-reply-to: <CAPDyKFq_YAB0tycE2ypdJp8gckfeiFRv=A120ZedyDDhu3K17w@mail.gmail.com>
Date:   Mon, 21 Oct 2019 17:36:33 +0200
Message-ID: <1jr236az5q.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 21 Oct 2019 at 16:48, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On Mon, 21 Oct 2019 at 11:17, Jerome Brunet <jbrunet@baylibre.com> wrote:
>>
>>
>> On Mon 21 Oct 2019 at 09:57, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> > Hi,
>> >
>> > Thanks for the fix.
>> >
>> > First, you should add "mmc: meson-gx:" in the subject.
>> >
>> > On 21/10/2019 07:59, Jianxin Pan wrote:
>> >> From: Nan Li <nan.li@amlogic.com>
>> >>
>> >> In MMC dma transfer, the region requested by dma_map_sg() may be released
>> >> by dma_unmap_sg() before the transfer is completed.
>> >>
>> >> Put the unmap operation in front of mmc_request_done() to avoid this.
>> >
>>
>> Since we have seen this problem (yet), could you briefly how you've
>> triggered it ?
>>
>> >
>> > You should add a "Fixes:" tag so it can be backported on stable kernels.
>> >
>> >>
>> >> Signed-off-by: Nan Li <nan.li@amlogic.com>
>> >> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> >> ---
>> >>  drivers/mmc/host/meson-gx-mmc.c | 15 ++++++++-------
>> >>  1 file changed, 8 insertions(+), 7 deletions(-)
>> >>
>> >> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> >> index e712315..7667e8a 100644
>> >> --- a/drivers/mmc/host/meson-gx-mmc.c
>> >> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> >> @@ -173,6 +173,7 @@ struct meson_host {
>> >>      int irq;
>> >>
>> >>      bool vqmmc_enabled;
>> >> +    bool needs_pre_post_req;
>> >>  };
>> >>
>> >>  #define CMD_CFG_LENGTH_MASK GENMASK(8, 0)
>> >> @@ -654,6 +655,8 @@ static void meson_mmc_request_done(struct mmc_host *mmc,
>> >>      struct meson_host *host = mmc_priv(mmc);
>> >>
>> >>      host->cmd = NULL;
>> >> +    if (host->needs_pre_post_req)
>> >> +            meson_mmc_post_req(mmc, mrq, 0);
>> >>      mmc_request_done(host->mmc, mrq);
>> >>  }
>> >>
>> >> @@ -803,25 +806,23 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>> >>  static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>> >>  {
>> >>      struct meson_host *host = mmc_priv(mmc);
>> >> -    bool needs_pre_post_req = mrq->data &&
>> >> +
>> >> +    host->needs_pre_post_req = mrq->data &&
>> >>                      !(mrq->data->host_cookie & SD_EMMC_PRE_REQ_DONE);
>> >>
>> >> -    if (needs_pre_post_req) {
>> >> +    if (host->needs_pre_post_req) {
>> >>              meson_mmc_get_transfer_mode(mmc, mrq);
>> >>              if (!meson_mmc_desc_chain_mode(mrq->data))
>> >> -                    needs_pre_post_req = false;
>> >> +                    host->needs_pre_post_req = false;
>> >>      }
>> >>
>> >> -    if (needs_pre_post_req)
>> >> +    if (host->needs_pre_post_req)
>> >>              meson_mmc_pre_req(mmc, mrq);
>> >>
>> >>      /* Stop execution */
>> >>      writel(0, host->regs + SD_EMMC_START);
>> >>
>> >>      meson_mmc_start_cmd(mmc, mrq->sbc ?: mrq->cmd);
>> >> -
>> >> -    if (needs_pre_post_req)
>> >> -            meson_mmc_post_req(mmc, mrq, 0);
>> >>  }
>>
>> The code around all this is getting quite difficult to follow eventhough
>> it does not actually do much
>>
>> The root of the problem seems be that meson_mmc_pre_req() and
>> meson_mmc_post_req() are passed to framework but also called manually
>> from meson_mmc_request().
>>
>> Because of this, some code is added to make sure we don't do things twice.
>> Maybe I'm missing something but it look weird ? Ulf, could you give us
>> your view ?
>
> This is tricky, unfortunately.
>
> The main problem boils done to that, there is no guarantee that the
> ->pre|post_request() host callbacks is called at all, as that depends
> on if the mmc block layer has more than one requests in the pipe to
> send. Additionally, that of course varies dynamically on a running
> system.
>
>>
>> As far as I can tell:
>>  * pre_req : determine if we use CHAIN_MODE or not AND
>>              dma_map_sg() if we do
>>  * post_req : dma_unmap_sg() if previously allocated
>>
>> Do we really need to do all this meson_mmc_request() ? Shouldn't we let the
>> framework do the calls to pre/post_req for us ?
>
> Whether we theoretically could simplify the path, by for example
> always calling the ->pre|post_request() callbacks if those exists, is
> probably too late to change. Well, unless we can change all host
> drivers implementing them as well... so it's probably just easier to
> accept this as is.

Don't worry, I was not suggesting to change the framework. I was
questionning our driver implementation.

If I understand, the framework will call pre/post_req only if it has
more than one request ?

Our driver only enable "chained mode" (and the related dma mapping) in
these callback. I don't think it worth enabling "chained mode" if there
is only one request (nothing to chain)

According to you:

* Is it a good idea to enable chained mode only when framework calls
  pre/post req ? (AFAICT, this is what the dw_mmc.c driver is doing)

There is a pretty interresting comment in jz4740_mmc.c about that:

/*
 * The MMC core allows to prepare a mmc_request while another mmc_request
 * is in-flight. This is used via the pre_req/post_req hooks.
 * This driver uses the pre_req/post_req hooks to map/unmap the mmc_request.
 * Following what other drivers do (sdhci, dw_mmc) we use the following cookie
 * flags to keep track of the mmc_request mapping state.
 *
 * COOKIE_UNMAPPED: the request is not mapped.
 * COOKIE_PREMAPPED: the request was mapped in pre_req,
 * and should be unmapped in post_req.
 * COOKIE_MAPPED: the request was mapped in the irq handler,
 * and should be unmapped before mmc_request_done is called..
 */

 Should we try to follow that ?

* OR, we should keep enabling it whenever we can ? In this case, it is
  probably better to not provide pre/post_req to the framework and
  manage things directly in the .request() callback ?

At the moment, we are doing both so it is difficult to figure out what
is doing what ...

>
> One thing though, make sure you have a nice self descriptive naming of
> variables and functions, to deal with this. That helps a lot.
>
> Kind regards
> Uffe

