Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D31CC17461
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DDF2190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gxr0AMfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389218AbfKENak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 08:30:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38504 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389053AbfKENaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 08:30:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id z19so15967152wmk.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 05:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=7bY4KphWSIiQfsBHhvP2l5N05pChZGN4x1skVb4keco=;
        b=gxr0AMfyg8FLU288ML4cbLVIRbmkjpN07ap2/D6WbJgkFQRNcX52D8AVY/3jh5W/91
         z5NUmfNUSHBixXXAso6ts4ep3eR1lr3lDLkvDUBG0Ztw5BAm8GYmJNVr2LE5dpMem3oS
         SkZM1SxUu7tbZJWf49j1044PMtpXeZ+V7aWzqYuU2U8KXCO2UTLXYPbxQBFyRhKWyANR
         19zO8BwrCS4HlFOolJbs+HXtYy8dRf0TKC87iX1UETUeRydD1yhrjuBohyfEHdzoOgeb
         Qh/p27SpabPJ+vbQMjMtaSsmaIkCH878Fm3ojtfQyIBolibRi3UaaEuChTZl5IxGJbmM
         8YmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=7bY4KphWSIiQfsBHhvP2l5N05pChZGN4x1skVb4keco=;
        b=YLqbwwnvSZbXgcuko8wEAoyReVftnoUVo28xee0HtWZ0isdVj0uvRJH6Fa7uDgIG02
         sbaAC+bq3obJfPEDPnkKCjf2X6Y2l7C+Eik8Z9S7rmFEw3tl0FpqjOeDMzDbctbgP0Uh
         m2KlkohxWqqDRqoP+MOQERO1BJY3JsM4bDFz2am6IWjY2IsHZw4ytoXwpbFFsl3qNi+g
         CuP3GzRKgyp4uCstit4UD0pX3QM4dOuz9f2vilWKqr9K6DXY8O72BQ57f7CIBlLLUAmV
         ePy5jr76zKQJAD0r2NkYXFFdUMTudBAaGFpV4hpN/hauGWlafcC8n9ACIHUGobpmPzzM
         w25w==
X-Gm-Message-State: APjAAAUgdb7xoc691pcm+Fso1ZFqiyL/p44l5IeBGaleuzmzNx1E0v1y
        1SitbiNbKbqAdlLXGptiBz1ZnA==
X-Google-Smtp-Source: APXvYqwiK8qiVvqMWU1Nuzw13cCoMSODLVCQe3/syYFV/mdZArg/Y4Tmn3AV+FE1y+VvW+sTJd0F/Q==
X-Received: by 2002:a1c:62c5:: with SMTP id w188mr2302432wmb.77.1572960634860;
        Tue, 05 Nov 2019 05:30:34 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m9sm21158502wro.66.2019.11.05.05.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 05:30:33 -0800 (PST)
References: <1572868495-84816-1-git-send-email-jianxin.pan@amlogic.com> <1ja79b4mje.fsf@starbuckisacylon.baylibre.com> <e80cb817-e58a-68ce-a3c6-d82636aaf7d3@amlogic.com> <1j8sou4u1g.fsf@starbuckisacylon.baylibre.com> <7ec2e682-cfec-395e-cf38-58f050440c40@amlogic.com> <1j7e4e4sab.fsf@starbuckisacylon.baylibre.com> <dee789ae-6825-3f4c-16e7-227e064562d6@amlogic.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Nan Li <Nan.Li@amlogic.com>, Jianxin Pan <Jianxin.Pan@amlogic.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        "linux-amlogic\@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-mmc\@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Victor Wan <victor.wan@amlogic.com>
Subject: Re: [PATCH v2] mmc: meson-gx: fix mmc dma operation
In-reply-to: <dee789ae-6825-3f4c-16e7-227e064562d6@amlogic.com>
Date:   Tue, 05 Nov 2019 14:30:32 +0100
Message-ID: <1j5zjy4fif.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 05 Nov 2019 at 10:05, Nan Li <Nan.Li@amlogic.com> wrote:

Nan Li, please fix your mailer to use plain text properly, your reply
are near impossible to read

> =E5=9C=A8 2019/11/5 16:54, Jerome Brunet =E5=86=99=E9=81=93:
>
>
> On Tue 05 Nov 2019 at 09:30, Nan Li <Nan.Li@amlogic.com><mailto:Nan.Li@am=
logic.com> wrote:
>
>
>
>
>
> Based on Uffe comment I tried something else.
>
> Basically, it enables chained mode in the driver only when the framework
> calls pre/post_req callback. As far as understood, the framework calls
> this when there is more than one request pending ... which seems to be
> when chained mode actually make sense
>
> Jerome, what you are talking about is the system framework problem when y=
ou call pre/post_req,
>
> which is not related to the patch I submitted.
>
>
>
> I strongly disagree.
> As far as I understand from your description, the problem was with the
> life cycle of the dma mapping. This is tighly related with pre/post req.
> Just the variable names you have picked clearly show that.
>
>
>
> As you said, pre/post_req is called only when there is data to implement =
the chained mode,
>
> but it is also possible to cause memory consistency problems,
> resulting in incorrect data.
>
>
>
> The life cycle of the mapping is also taken care of with patch,
> since dma mapping is no longer handled in .request(). IOW the mapping,
> if any, will be released after the request is done using .post_req()
>
> If you think otherwise, please elaborate.
>
>
> I see what you mean. You want to pull the pre/post_req operation out of t=
he request interface and invoke it at the top.
>
> I didn't notice the following modification of patch in your last email an=
d reply in time. I'm really sorry.
>
> The following patch removes all pre/post_req operations,
>
>
>
> No it does not. Callbacks are still provided to the MMC framework.
>
>
>
> but you do not send out the operation patch added to the upper layer
> together.
>
>
>
> There is no modification needed in the upper layer
>
>
>
>
> Then the patch is incomplete, which will affect the dma data transfer fun=
ction in start_cmd function and affect the multi-block write operation.
>
>
>
>
> No it is not incomplete. pre and post request are correctly called. You
> can check that with ftrace if you want.
>
> Maybe you could try it ?
>
>
> I'm sorry, I didn't catch your meaning.How do I use pre/post_req
> properly?

Those callbacks are provided to the framework as well. If you have
trouble following, please apply the patch and look at the driver

Have a look at "meson_mmc_ops"

>
> Do you mean I need to add a call to pre/post_req on top of the changes
> you provided below?

No, you should not

>
> If not, your changes have deleted all pre/post_req calls.

No, it does not. It relies on the framework to activate the chained mode
or not. Again, if you have trouble following you can try to enable
ftrace and trace the mmc functions.

>
>
>
>
> Please send your complete patch, including core layer modification,
> thank you.
>
>
>
>
>
> Therefore, this patch is added to make memory consistent and obtain real =
effective information.
>
>
>
> ----8<-----
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-=
mmc.c
> index e712315c7e8d..399604b4124d 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -126,8 +126,7 @@
>  #define SD_EMMC_CFG_CMD_GAP 16 /* in clock cycles */
>  #define SD_EMMC_DESC_BUF_LEN PAGE_SIZE
>
> -#define SD_EMMC_PRE_REQ_DONE BIT(0)
> -#define SD_EMMC_DESC_CHAIN_MODE BIT(1)
> +#define SD_EMMC_DESC_CHAIN_MODE BIT(0)
>
>  #define MUX_CLK_NUM_PARENTS 2
>
> @@ -228,7 +227,6 @@ static void meson_mmc_get_transfer_mode(struct mmc_ho=
st *mmc,
>         struct mmc_data *data =3D mrq->data;
>         struct scatterlist *sg;
>         int i;
> -       bool use_desc_chain_mode =3D true;
>
>         /*
>          * When Controller DMA cannot directly access DDR memory, disable
> @@ -251,12 +249,11 @@ static void meson_mmc_get_transfer_mode(struct mmc_=
host *mmc,
>                 /* check for 8 byte alignment */
>                 if (sg->offset & 7) {
>                         WARN_ONCE(1, "unaligned scatterlist buffer\n");
> -                       use_desc_chain_mode =3D false;
> -                       break;
> +                       return;
>                 }
>
> -       if (use_desc_chain_mode)
> -               data->host_cookie |=3D SD_EMMC_DESC_CHAIN_MODE;
> +       /* The planets are aligned, let's chain them up */
> +       data->host_cookie |=3D SD_EMMC_DESC_CHAIN_MODE;
>  }
>
>  static inline bool meson_mmc_desc_chain_mode(const struct mmc_data *data)
> @@ -278,7 +275,6 @@ static void meson_mmc_pre_req(struct mmc_host *mmc, s=
truct mmc_request *mrq)
>                 return;
>
>         meson_mmc_get_transfer_mode(mmc, mrq);
> -       data->host_cookie |=3D SD_EMMC_PRE_REQ_DONE;
>
>         if (!meson_mmc_desc_chain_mode(data))
>                 return;
> @@ -803,25 +799,11 @@ static void meson_mmc_start_cmd(struct mmc_host *mm=
c, struct mmc_command *cmd)
>  static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *=
mrq)
>  {
>         struct meson_host *host =3D mmc_priv(mmc);
> -       bool needs_pre_post_req =3D mrq->data &&
> -                       !(mrq->data->host_cookie & SD_EMMC_PRE_REQ_DONE);
> -
> -       if (needs_pre_post_req) {
> -               meson_mmc_get_transfer_mode(mmc, mrq);
> -               if (!meson_mmc_desc_chain_mode(mrq->data))
> -                       needs_pre_post_req =3D false;
> -       }
> -
> -       if (needs_pre_post_req)
> -               meson_mmc_pre_req(mmc, mrq);
>
>         /* Stop execution */
>         writel(0, host->regs + SD_EMMC_START);
>
>         meson_mmc_start_cmd(mmc, mrq->sbc ?: mrq->cmd);
> -
> -       if (needs_pre_post_req)
> -               meson_mmc_post_req(mmc, mrq, 0);
>  }
>
>  static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command=
 *cmd)
> ---->8-----
>
> No performance hit AFAICT.
> From your description, it should address your problem too.
>
>
>
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-=
mmc.c
> index e712315..7667e8a 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -173,6 +173,7 @@ struct meson_host {
>         int irq;
>
>         bool vqmmc_enabled;
> +       bool needs_pre_post_req;
>  };
>
>  #define CMD_CFG_LENGTH_MASK GENMASK(8, 0)
> @@ -654,6 +655,8 @@ static void meson_mmc_request_done(struct mmc_host *m=
mc,
>         struct meson_host *host =3D mmc_priv(mmc);
>
>         host->cmd =3D NULL;
> +       if (host->needs_pre_post_req)
> +               meson_mmc_post_req(mmc, mrq, 0);
>         mmc_request_done(host->mmc, mrq);
>  }
>
> @@ -803,25 +806,23 @@ static void meson_mmc_start_cmd(struct mmc_host *mm=
c, struct mmc_command *cmd)
>  static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *=
mrq)
>  {
>         struct meson_host *host =3D mmc_priv(mmc);
> -       bool needs_pre_post_req =3D mrq->data &&
> +
> +       host->needs_pre_post_req =3D mrq->data &&
>                         !(mrq->data->host_cookie & SD_EMMC_PRE_REQ_DONE);
>
> -       if (needs_pre_post_req) {
> +       if (host->needs_pre_post_req) {
>                 meson_mmc_get_transfer_mode(mmc, mrq);
>                 if (!meson_mmc_desc_chain_mode(mrq->data))
> -                       needs_pre_post_req =3D false;
> +                       host->needs_pre_post_req =3D false;
>         }
>
> -       if (needs_pre_post_req)
> +       if (host->needs_pre_post_req)
>                 meson_mmc_pre_req(mmc, mrq);
>
>         /* Stop execution */
>         writel(0, host->regs + SD_EMMC_START);
>
>         meson_mmc_start_cmd(mmc, mrq->sbc ?: mrq->cmd);
> -
> -       if (needs_pre_post_req)
> -               meson_mmc_post_req(mmc, mrq, 0);
>  }
>
>  static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command=
 *cmd)

