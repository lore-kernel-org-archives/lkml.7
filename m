Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0A4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8FC20850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUVK5Sia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfCVRZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:25:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38086 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbfCVRZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:25:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id a188so2929136wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 10:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=worEQNaoJLYeD7mblzWWmpJ8BvsIgSttCy+a9olDJxw=;
        b=dUVK5SiaSMke7aU5k6wJk+NOLiodivaeMMsV8g1Z/3w2CKHg8WNtCrQ25fQnXEXHgd
         kMAih97gsZbS+MXnMcEHFXeRkEfR9B88UBTRkPaIG+w8MQGYEFtu5oGr8F+WuYQFnihS
         DyoC0weVf94LbQDU9Kr4mCWkiz7ekQxkq25A2jDOjGRAXUJASzm5gnhjuEAnA1wCPYKu
         j8fHPwXkPco0WLzx0/3os854OLNoGvwrz7/skoz1srpXPwXEtfRz/TRkjinWqf3IKfXL
         VKv0rH7akZvymgzKO15Z6FZIIllzGO8H96N8wN7NrWgLeplN3193hXhfF2atNPI9Pgr+
         mkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=worEQNaoJLYeD7mblzWWmpJ8BvsIgSttCy+a9olDJxw=;
        b=E1GNurBjBvqukm2pttyrA3D74Ch/5Uqp39DkN5LZqGfQ9CNCdr8+jM21taw/DIEIwS
         f5nKPJS4opPfV77yFlS0pk7dJ/lV7gfzbo0oicxEK+LJhpNE4FAbw8NrDEd99J9xbUgR
         mFV8gJbQCrZnJZ3pVT9quXvpc/ve9zoq+IL6oyPzl/y7aFMzjLBIjLG8TEJghjxSdqIO
         1stvAZ6j+i6VIChwmZ1Le1lPzNtZs0udYlKuMioSn14UgmjGf7+FT0zRYvJ3TUQpuqd0
         CIORG14xaHh5l0UT++/hwQrq8CPN7MLPP8CnoV4aKurIxq78HEgDZmSt4JAARiO9f9iC
         LgRA==
X-Gm-Message-State: APjAAAWu7qRRN3KzUavhW2/8vh54wy6I827wVgvm36Gl9zUa2jjtFUpN
        FB7BR6u1wPSNBjnJS5H1OI7JGq/DZ6s/YZM+tTM=
X-Google-Smtp-Source: APXvYqyNCZha/ubxFy89tCu22AE619KcNJRZPj2DdwUfudMmRBJP5mtk8E29o6h6Hqccxf8RK0WsuGMYAM6/d+P30WE=
X-Received: by 2002:a05:600c:218:: with SMTP id 24mr3838767wmi.144.1553275533864;
 Fri, 22 Mar 2019 10:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190322032901.12045-1-andrew.smirnov@gmail.com>
 <20190322032901.12045-8-andrew.smirnov@gmail.com> <25d95ed0-4dba-09d5-87ec-57c5e763beb4@ti.com>
In-Reply-To: <25d95ed0-4dba-09d5-87ec-57c5e763beb4@ti.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 22 Mar 2019 10:25:22 -0700
Message-ID: <CAHQ1cqECy1CHxs0_dnMPqoQwwJMRWFVZ58Vf2J2tbEWmsU06dg@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] drm/bridge: tc358767: Simplify AUX data write
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 3:51 AM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
> On 22/03/2019 05:28, Andrey Smirnov wrote:
> > Simplify AUX data write by dropping index arithmetic and shifting and
> > replacing it with a call to a helper function that does three things:
> >
> >     1. Copies user-provided data into a write buffer
> >     2. Optionally fixes the endianness of the write buffer (not needed
> >        on LE hosts)
> >     3. Transfers contenst of the write buffer to up to 4 32-bit
> >        registers on the chip
> >
> > Note that separate data endianness fix:
> >
> >     tmp = (tmp << 8) | buf[i];
> >
> > that was reserved for DP_AUX_I2C_WRITE looks really strange, since it
> > will place data differently depending on the passed user-data
> > size. E.g. for a write of 1 byte, data transferred to the chip would
> > look like:
> >
> > [byte0] [dummy1] [dummy2] [dummy3]
> >
> > whereas for a write of 4 bytes we'd get:
> >
> > [byte3] [byte2] [byte1] [byte0]
> >
> > Since there's no indication in the datasheet that I2C write buffer
> > should be treated differently than AUX write buffer and no comment in
> > the original code explaining why it was done this way, that special
> > I2C write buffer transformation was dropped in this patch.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Archit Taneja <architt@codeaurora.org>
> > Cc: Andrzej Hajda <a.hajda@samsung.com>
> > Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/gpu/drm/bridge/tc358767.c | 58 +++++++++++++++++++------------
> >  1 file changed, 36 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> > index 81c10a5d8106..21374565585d 100644
> > --- a/drivers/gpu/drm/bridge/tc358767.c
> > +++ b/drivers/gpu/drm/bridge/tc358767.c
> > @@ -307,6 +307,31 @@ static int tc_aux_get_status(struct tc_data *tc, u8 *reply)
> >       return 0;
> >  }
> >
> > +static int tc_aux_write_data(struct tc_data *tc, const void *data,
> > +                          size_t size)
> > +{
> > +     u32 auxwdata[DP_AUX_MAX_PAYLOAD_BYTES / sizeof(u32)] = { 0 };
> > +     int ret, i, count = DIV_ROUND_UP(size, 4);
>
> Should 4 there be sizeof(u32)?

Yup, will replace.

>
> > +
> > +     memcpy(auxwdata, data, size);
> > +
> > +     for (i = 0; i < count; i++) {
> > +             ret = regmap_write(tc->regmap, DP0_AUXWDATA(i),
> > +                                /*
> > +                                 * Our regmap is configured as LE
> > +                                 * for register data, so we need
> > +                                 * undo any byte swapping that will
> > +                                 * happened to preserve original
> > +                                 * byte order.
> > +                                 */
> > +                                cpu_to_le32(auxwdata[i]));
>
> Can regmap_bulk_write or regmap_raw_write be used here?
>

Not sure, will give it a try.

Thanks,
Andrey Smirnov
