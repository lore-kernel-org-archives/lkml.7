Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D04C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 03:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2EF20873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 03:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Re+YlSEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfFRDzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 23:55:40 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34488 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFRDzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 23:55:40 -0400
Received: by mail-ua1-f68.google.com with SMTP id c4so4478885uad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 20:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hbfLnulmtVwAqcwjBVQHbsEOQQi7C7z9WxtDTCZnrSI=;
        b=Re+YlSEGCfJ1SB3VhHEwCwAT+I6ygr7MjUUslXWdDU+dVyBdMjbbUUINT+gn0f95Gt
         gg9fFMRoUhdyB6aOwVFzTZ3x9HpJzIfrsQQmJYlKO1ckg+tr2CWBpsvsicjNlcfcOZPh
         Jjo2Ollxxgw1eq8cCXM6IblE9BTSEwKlx+gLpDFZZml6K9kj5sixbtZvglbkm5NeO1FJ
         pn3L7N/EWqLXNXzMgN2GKO0YoOCHfJV7awJALwiImDvE42Anq00vY7lL2mf79V5hV7EE
         WHb1h4xgcSiq4zEuMJvXyznw1cgR1HYOomy/E98TBj9AOe7bTOU1woffrfzuLkYRRzhz
         SzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hbfLnulmtVwAqcwjBVQHbsEOQQi7C7z9WxtDTCZnrSI=;
        b=Ih+y9uRRAS0L/1Wmh7WbisOjEyZMneWqhMd2tncZElDc0u+yhocTlUj/gRnVF1TdB0
         WDRvYg+OqMfsW/cJBqW9Q2HAo7zRNLAIe2TaHaf8xJLnT0H5k8Rk1hKb0kHirwlYM6B2
         Yb6ZsoZbIGmDlgWujJO8gFKExBj+vi0isHEycD/+jpr+fAT2Y1h5cqFrGid4jGi6R9hr
         OA0QGP1wScjpLeiDd8oUw/WVGbuIGNDJfccsZQvYin0wyMxlBbqyGZf8hOc8ipPM4dd+
         neY3c6e7HXdWD4YgK6IMSkHLcTbcY3yidQWXH8jpo1LwvwpaXZHs50g6cSvCEsqLmDuM
         RayA==
X-Gm-Message-State: APjAAAVNzQdZKcP5JH8UmBlaFVFo2iC79Yo6QUnHYs1Clb5KKOiWnJIb
        QNmIvm2xtyiPtCD9ENOdZ2P4/mxEBmysa9nwaF8tGQ==
X-Google-Smtp-Source: APXvYqy1BIINnP7iB/p/G3CX4qFC0WhpHRsPDZZFp+sb3Ovjpawek1cuOI5hDkFHe03zqioI/wdd62UnpITKNKUex9w=
X-Received: by 2002:a67:c84:: with SMTP id 126mr54621301vsm.178.1560830139405;
 Mon, 17 Jun 2019 20:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <1560336476-31763-1-git-send-email-sagar.kadam@sifive.com>
 <1560336476-31763-3-git-send-email-sagar.kadam@sifive.com>
 <70732c8e-111f-7c46-9e93-11894d944a1d@ti.com> <CAARK3HmFg=v+cMGAykPPpwxDGaSKk5k+Gz4fSHQPQmg-rCjPhQ@mail.gmail.com>
 <547e251d87e307fa4d1e31dfc61b496c152f0905.camel@perches.com>
In-Reply-To: <547e251d87e307fa4d1e31dfc61b496c152f0905.camel@perches.com>
From:   Sagar Kadam <sagar.kadam@sifive.com>
Date:   Tue, 18 Jun 2019 09:25:27 +0530
Message-ID: <CAARK3H=4QjWr3D7GpNbw9YbFm9C+t5CDcMU=o6_O7rb1ofHuMA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] mtd: spi-nor: add support to unlock flash device
To:     Joe Perches <joe@perches.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>, marek.vasut@gmail.com,
        tudor.ambarus@microchip.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, miquel.raynal@bootlin.com,
        richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joe,

Thanks for reviewing the patch.

On Tue, Jun 18, 2019 at 5:55 AM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2019-06-17 at 21:10 +0530, Sagar Kadam wrote:
> > On Sun, Jun 16, 2019 at 6:35 PM Vignesh Raghavendra <vigneshr@ti.com> wrote:
> []
> > > > +static int issi_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
> > > > +{
> []
> > > > +     if (ret > 0 && !(ret & mask)) {
> > > > +             dev_info(nor->dev,
> > > > +                     "ISSI Block Protection Bits cleared SR=0x%x", ret);
>
> Please use '\n' terminations on formats
>
I will include this in v6.

> > > > +             ret = 0;
> > > > +     } else {
> > > > +             dev_err(nor->dev, "ISSI Block Protection Bits not cleared\n");
>
> like this one
>
> > > > +             ret = -EINVAL;
> > > > +     }
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +/**
> > > >   * spansion_quad_enable() - set QE bit in Configuraiton Register.
>
> s/Configuraiton/Configuration/
>
>
Thanks & BR,
Sagar Kadam
