Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE168CA9EC7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11BA20818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1o+Vki9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387823AbfKEIQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 03:16:48 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37242 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387590AbfKEIQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 03:16:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id q130so18976792wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 00:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=yLYbU+ioLdHpduS2+SV48BMIdueyibxBfUOqQksqAmQ=;
        b=1o+Vki9bQnfd1f2oHu34q5CzWHjkTRQAFccbqny8oIrpTelg9WWnZFudkTt/tnvgPq
         9sZ5VZe/7UE2WjnchHGVzGOFtZ72BCfb70+i+b1g6naOxrWh8Jat8QrVaca0X5dDaKiI
         p8HERYToE5Jd6dgFUGdeQKIjHq296Pwco/HTpD3L7s6RT01PqN2NnFFkkEkz3PYsyV92
         ZgVayzSqYJFeWqfBStTf0XmosBpfwQyTtblXwExV8/O+SdgSVFyVqp+5uNPy230Fovmw
         CEIr9njwjcxp2aOTXx48/FyKZlyz18Y2gxNz2KgMMkCZaetUqJuNIV86erbdp4wpbiNl
         Vppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=yLYbU+ioLdHpduS2+SV48BMIdueyibxBfUOqQksqAmQ=;
        b=fNl3h2sy6O22bBWmXxxFp21LcCSsTdod78Tf0/VbZJjg9If3DmrNuoKFJdBaT0rAfT
         DO6LRM3MflwaOsgcbDmPfZOe67ondnj8jNpIQ8QJH5gxLDv+anUsAU97xPScUxsWObmj
         ijDlrVgJxP+S5fPDL7R2ifH5CUqURqkTtASnchl5i4P6Q0/vHdg8EFofVHHlvIvTmuuD
         LgUW0ZBzT3GpfmukBgG/t2OVLaKRJzLaeO0W3NEJq6l9/Zy0WBfJp6U6ovJeEEpoCJKh
         J+EH7XCSqGF/ESxPcwIdcaqQKlHizc8MPkIUOi3vTQuSw0SLankjbdkFOTx6nuRW6KCm
         FXLw==
X-Gm-Message-State: APjAAAWvwfgsuc8HXfTSJA9bK2dtToWUWmuoTbUmP+RuyA2s3lU2dDYh
        /6+sHjJkobAGBuBMke1o6R7ylA==
X-Google-Smtp-Source: APXvYqwBAJS3V1xnunLNc/diPAwAY4KZsGHDXElZbjOwCou2gipAdGTliK+daK8J64br4gsiAh5PFQ==
X-Received: by 2002:a1c:3c43:: with SMTP id j64mr2938924wma.13.1572941804913;
        Tue, 05 Nov 2019 00:16:44 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g5sm11278267wmf.37.2019.11.05.00.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 00:16:44 -0800 (PST)
References: <1572868495-84816-1-git-send-email-jianxin.pan@amlogic.com> <1ja79b4mje.fsf@starbuckisacylon.baylibre.com> <e80cb817-e58a-68ce-a3c6-d82636aaf7d3@amlogic.com>
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
In-reply-to: <e80cb817-e58a-68ce-a3c6-d82636aaf7d3@amlogic.com>
Date:   Tue, 05 Nov 2019 09:16:43 +0100
Message-ID: <1j8sou4u1g.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 05 Nov 2019 at 02:45, Nan Li <Nan.Li@amlogic.com> wrote:

> =E5=9C=A8 2019/11/5 0:46, Jerome Brunet =E5=86=99=E9=81=93:
>
>
> On Mon 04 Nov 2019 at 12:54, Jianxin Pan <jianxin.pan@amlogic.com><mailto=
:jianxin.pan@amlogic.com> wrote:
>
>
>
> From: Nan Li <nan.li@amlogic.com><mailto:nan.li@amlogic.com>
>
> In MMC dma transfer, the region requested by dma_map_sg() may be released
> by dma_unmap_sg() before the transfer is completed.
>
> Put the unmap operation in front of mmc_request_done() to avoid this.
>
>
>
> In the previous thread, you have described what was the issue you found.
> It would be nice to have this information here
>
>
>
>
> Fixes: 79ed05e329c3 ("mmc: meson-gx: add support for descriptor chain mod=
e")
> Signed-off-by: Nan Li <nan.li@amlogic.com><mailto:nan.li@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com><mailto:jianxin.pan@a=
mlogic.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
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

I strongly disagree.
As far as I understand from your description, the problem was with the
life cycle of the dma mapping. This is tighly related with pre/post req.
Just the variable names you have picked clearly show that.

> As you said, pre/post_req is called only when there is data to implement =
the chained mode,
>
> but it is also possible to cause memory consistency problems,
> resulting in incorrect data.

The life cycle of the mapping is also taken care of with patch,
since dma mapping is no longer handled in .request(). IOW the mapping,
if any, will be released after the request is done using .post_req()

If you think otherwise, please elaborate.

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

