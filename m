Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8884FC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 21:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5741C26CFA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 21:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMo4vAGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfFCVvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 17:51:17 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39341 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFCVvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 17:51:17 -0400
Received: by mail-it1-f195.google.com with SMTP id j204so23779657ite.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 14:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5D9P0SrXPjRFKraHRW7Zs4wFyot/fcU8CO5IjrNa/GI=;
        b=bMo4vAGLODEg81iVajx/tJG/KTkWtEAR0eZN5G7ArLFY52GB/ZIzcGxMIlI9OdUVBP
         lCu0hQvloh4pOW5Oir/6YTMCtH6isW3YkjeaJgAHYOuemZ34TX7UsK1lKrCFLMNBaP/8
         m9xx3fYz9yJtu2iPR9FhZmA6rSf7yEinFnUCMAa30qp7srn9I/YlhLSilOSjEpcJ3GRu
         VglUZ3M+VUhXMkKaEIED8pLFIMKs1Sl+J388eHT5u3WXl2CHoJ3BQBBaOitO1TPQer8r
         HoqOH00Zsw3t+XvbTCM2/GEUZDNIpFX77Pc0hMYS85MK8LpUjDAU5EUgEej9WneWJVJk
         hN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5D9P0SrXPjRFKraHRW7Zs4wFyot/fcU8CO5IjrNa/GI=;
        b=CD0rsTtt4pHxnnR2Tw3YsQMxUqos2n9EO8jl0rKj/s6flGloUVYqceMzmSMULauVnI
         JC3nL39SWxCd6WWko7KfSQLQKrTCvh1brb/02mPfBfogSWkzF3G8Z9RwWjCICMk87k+X
         dOQKnnK1FfrTxfSdwHRMjHyCZ6LwqB3smpDbw5aTIZfVKM3DVj/VGGoNHT7Ut8kDvU9p
         UlIB1hr0/mb6jbQ1vUQnNmzbWF5NMXBx+guGEPDlGVNsjj9z8pJ76M4zRLyaRCjP2zp/
         ibaBUCgI9viAfzIuzlgFZyqKQCPGLGK5h6ip+bs2RHJNYndCgcmDRKjjoUcnyMfFT1sc
         1LIQ==
X-Gm-Message-State: APjAAAVAukXIahkWRsXE2PebvtJuLuVkBnvdyhTP/xyA0qfRBCT0cJSu
        GpT6Dgsh2Ky15qTW2knwNDAXB8rGhl+pbRugWOk=
X-Google-Smtp-Source: APXvYqw8JaEzVB8T3Q8l0hX61qcXN5kM7MZRYMFZk5mAZjsetYlAYZReTeOejxH7UFyxInU7yIlgW9N4me7vsRl7lww=
X-Received: by 2002:a24:7f0d:: with SMTP id r13mr17628196itc.28.1559598676419;
 Mon, 03 Jun 2019 14:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190531143320.8895-1-sudeep.holla@arm.com> <20190531143320.8895-2-sudeep.holla@arm.com>
In-Reply-To: <20190531143320.8895-2-sudeep.holla@arm.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 3 Jun 2019 16:51:05 -0500
Message-ID: <CABb+yY2ON+etV_g+zBQUrV9x2_0QubUeEPuxs=EKw_JCt570BQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] mailbox: add support for doorbell/signal mode controllers
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 9:33 AM Sudeep Holla <sudeep.holla@arm.com> wrote:

> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index 38d9df3fb199..e26a079f8223 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -77,7 +77,10 @@ static void msg_submit(struct mbox_chan *chan)
>         if (chan->cl->tx_prepare)
>                 chan->cl->tx_prepare(chan->cl, data);
>         /* Try to submit a message to the MBOX controller */
> -       err = chan->mbox->ops->send_data(chan, data);
> +       if (chan->mbox->ops->send_data)
> +               err = chan->mbox->ops->send_data(chan, data);
> +       else
> +               err = chan->mbox->ops->send_signal(chan);
>         if (!err) {
>                 chan->active_req = data;
>                 chan->msg_count--;
>
The  'void *data'  parameter in send_data() is controller specific.
The doorbell controllers should simply ignore that.

So signal/doorbell controllers are already supported fine. See
drivers/mailbox/tegra-hsp.c for example.

Thanks.
