Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F24C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D734206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+cqBcIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfFFTxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:53:41 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50910 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfFFTxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:53:41 -0400
Received: by mail-it1-f194.google.com with SMTP id a186so1973993itg.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 12:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QvRzAt8oUa+QOs8oktnGNElZis2955KPPjFl8TJj1Sc=;
        b=N+cqBcIV8wCw3ILXUCLZHVe/s4oVuQ8zay6aGrYPCg/Q0/LfbnGZ3xrbjVNC2YrE+E
         gSa1nR+/Nq1cCJ7Jznj/Mh+Brk11hVeOkfmo7Mu9L8hig5pyoGV3hzJCKKy15b2Ux4YT
         zAAWOLCfUwPmGNGUKX5hvU8UhLJUAuxnsWIb0vjJMTLwE9WVVid8S/axVQwSWwX/zwPe
         y0b8JzAyRKGSbTtq2I4s4PrRaPLbKrmGieixcUCvQN3oCK9J8zhbUjhFim3HibPIkckH
         W6ktf0tSNKqYlGcNECmzAZgznIdXds66vzYJebSmZfwWa8gCf3MmmOyqUZ2k3M+KpybO
         +vOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QvRzAt8oUa+QOs8oktnGNElZis2955KPPjFl8TJj1Sc=;
        b=pp6YcxNZVaV+BE4ayY1rCFEW5rc6onGvuTSAfODd6VwcJSD9m/bRnShZKtKQ8PREtd
         5kFsAcioJggYnHTu1kP66z1LtyHawUEJ97YhO8dOo7KMSSlsfuZ+sLeiSGnPcyuwutdu
         1HE5bD81ZvuzcHLMQEphboBbc+hdVfXAFTL66ovgt7Reo1cCLSoUag3wUoP7gFZRV2pi
         gqg1WxEkPGzRkiFdhWatFshPiBLh1ZqYRBUlsbiGoiPlJaDcMFP3P6OBVD/38i0ludPN
         r1WQaUtzfq2XJVBgOiIFQUX0TKSLCcMVdsHi+9adbIFP1Sa2WD29xtDrmirVVCXyNb8+
         a56w==
X-Gm-Message-State: APjAAAUwWkNjbcwQVfN2pVgrEBHyI/q74k494hqdcPUjryNRN1M5FuPg
        zuZDIia3l7cShObn9EPrcfXgEzM+i11LQ3IbSQg=
X-Google-Smtp-Source: APXvYqy7pWNl4Q+X7LS21yrTMp4Kqd7zvq75fu/BksKKF+n8OdJGBkq6cgEp1ESBftQ0uehnGbsNv9eC+vjhoHPBetU=
X-Received: by 2002:a24:97d2:: with SMTP id k201mr1379721ite.151.1559850820180;
 Thu, 06 Jun 2019 12:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190605070507.11417-1-andrew.smirnov@gmail.com>
 <CGME20190605070535epcas2p36fee13315966e45d425c073162aa1aae@epcas2p3.samsung.com>
 <20190605070507.11417-7-andrew.smirnov@gmail.com> <28ddfb42-db9a-f095-9230-d324db5ee483@samsung.com>
In-Reply-To: <28ddfb42-db9a-f095-9230-d324db5ee483@samsung.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 6 Jun 2019 12:53:28 -0700
Message-ID: <CAHQ1cqGEe9cT18UNtjkRDACrwYr8YRJ3Ec6eGaR8Qp+-QgqTdQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/15] drm/bridge: tc358767: Simplify AUX data read
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 6, 2019 at 3:59 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> On 05.06.2019 09:04, Andrey Smirnov wrote:
> > Simplify AUX data read by removing index arithmetic and shifting with
> > a helper functions that does three things:
> >
> >     1. Fetch data from up to 4 32-bit registers from the chip
> >     2. Optionally fix data endianness (not needed on LE hosts)
> >     3. Copy read data into user provided array.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Archit Taneja <architt@codeaurora.org>
> > Cc: Andrzej Hajda <a.hajda@samsung.com>
> > Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: Cory Tusar <cory.tusar@zii.aero>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/gpu/drm/bridge/tc358767.c | 40 +++++++++++++++++++++----------
> >  1 file changed, 27 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> > index e197ce0fb166..da47d81e7109 100644
> > --- a/drivers/gpu/drm/bridge/tc358767.c
> > +++ b/drivers/gpu/drm/bridge/tc358767.c
> > @@ -321,6 +321,29 @@ static int tc_aux_get_status(struct tc_data *tc, u8 *reply)
> >       return 0;
> >  }
> >
> > +static int tc_aux_read_data(struct tc_data *tc, void *data, size_t size)
> > +{
> > +     u32 auxrdata[DP_AUX_MAX_PAYLOAD_BYTES / sizeof(u32)];
> > +     int ret, i, count = DIV_ROUND_UP(size, sizeof(u32));
> > +
> > +     ret = regmap_bulk_read(tc->regmap, DP0_AUXRDATA(0), auxrdata, count);
> > +     if (ret)
> > +             return ret;
> > +
> > +     for (i = 0; i < count; i++) {
> > +             /*
> > +              * Our regmap is configured as LE for register data,
> > +              * so we need undo any byte swapping that might have
> > +              * happened to preserve original byte order.
> > +              */
> > +             le32_to_cpus(&auxrdata[i]);
> > +     }
> > +
> > +     memcpy(data, auxrdata, size);
> > +
> > +     return size;
> > +}
> > +
>
>
> Hmm, cannot we just use regmap_raw_read?

I'll give it a try in v4.

Thanks,
Andrey Smirnov
