Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5130DC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 20:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2331B218B8
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 20:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GGeXaV2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbfGVUyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 16:54:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38638 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbfGVUyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 16:54:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id f5so9406738pgu.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 13:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aHUdEX2ULV+TDjjhsxnkJoyyNmoo7KbS8aN0PdtSzBA=;
        b=GGeXaV2UIdvQLIYZetuz+R47tXFQa2bSV4X/3q7FX28x5V7fMw1Zf0JaF+D3OcoujM
         VoZ8HXGilcEUvYhpUDnJWW6U7SNJ4bf6O6iuULjnhWMB0kJx4c5spqUUgPN5D5q3czIz
         1Z/WCCz0fXtchf4xoANXGVOI+rcG1Jz0phIiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aHUdEX2ULV+TDjjhsxnkJoyyNmoo7KbS8aN0PdtSzBA=;
        b=igocKC47Xoww7J5a4ZFXxs48oXsBt0jM+KX4QQbYEjTtZrpxqQ2BQ1xnkFPDsKt/09
         8fxptQYALKqBd+JMzHwBySIa4wZTYRphtz1e8OLxyCqyp5BOQJZLq2d4ZsD8XGdzypvP
         Rn7htE/URk6JHH7JXjatfH3g9MuCl3dA72cvQj0/ipFbX44kixm0tmXdKFBCZMOXpCqu
         EOe9FMGnfwAgQ0WaXqzQXNUNYAOiFtsmlRZLyqMPYBDuGtnKJY6GetgQqkprBncCkIMy
         6FAGB9S9qdNDTUoArRA1URSspEesLgo7nWk5j4opLuz0evEjq+Hm/d49Osqv+eT5kdgA
         2lYA==
X-Gm-Message-State: APjAAAUGyz8GJCNBru9H32Y4ODhx3XQj5oxogprCsgLSUneTCJK9B/9o
        tCOI8rsi0Dhi2jCp3hfh1kp6zg==
X-Google-Smtp-Source: APXvYqzCFNwpofDCIDkf3fwqg29xodZS2cLtFiiYiDDdohkscENChmgwkkiOnJjfaFyz/OroSmmFeg==
X-Received: by 2002:a65:5c02:: with SMTP id u2mr3592167pgr.367.1563828861466;
        Mon, 22 Jul 2019 13:54:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id c8sm45616120pjq.2.2019.07.22.13.54.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 13:54:20 -0700 (PDT)
Date:   Mon, 22 Jul 2019 13:54:19 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Adam Jackson <ajax@redhat.com>
Subject: Re: [PATCH v2] drm/bridge: dw-hdmi: Refuse DDC/CI transfers on the
 internal I2C controller
Message-ID: <20190722205419.GY250418@google.com>
References: <20190722181945.244395-1-mka@chromium.org>
 <CAD=FV=XP=3z9GWPU+K15jmzHeOWT9uzqgaC6zL3M+Wm7b4jOhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=XP=3z9GWPU+K15jmzHeOWT9uzqgaC6zL3M+Wm7b4jOhQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 01:12:40PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jul 22, 2019 at 11:19 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > The DDC/CI protocol involves sending a multi-byte request to the
> > display via I2C, which is typically followed by a multi-byte
> > response. The internal I2C controller only allows single byte
> > reads/writes or reads of 8 sequential bytes, hence DDC/CI is not
> > supported when the internal I2C controller is used. The I2C
> > transfers complete without errors, however the data in the response
> > is garbage. Abort transfers to/from slave address 0x37 (DDC) with
> > -EOPNOTSUPP, to make it evident that the communication is failing.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Changes in v2:
> > - changed DDC_I2C_ADDR to DDC_CI_ADDR
> > ---
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > index 045b1b13fd0e..28933629f3c7 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > @@ -35,6 +35,7 @@
> >
> >  #include <media/cec-notifier.h>
> >
> > +#define DDC_CI_ADDR            0x37
> >  #define DDC_SEGMENT_ADDR       0x30
> >
> >  #define HDMI_EDID_LEN          512
> > @@ -322,6 +323,13 @@ static int dw_hdmi_i2c_xfer(struct i2c_adapter *adap,
> >         u8 addr = msgs[0].addr;
> >         int i, ret = 0;
> >
> > +       if (addr == DDC_CI_ADDR)
> > +               /*
> > +                * The internal I2C controller does not support the multi-byte
> > +                * read and write operations needed for DDC/CI.
> > +                */
> > +               return -EOPNOTSUPP;
> > +
> 
> In theory we could also solve this by detecting (in other parts of the
> function) the bad multi-byte read/write operations.  That would maybe
> be more generic (AKA it would more properly handle random userspace
> tools fiddling with i2c-dev) but add complexity to the code.

But how do you know it's an unsupported operation, and not the driver
knowing the wacky limitations doing something valid.

E.g. you get the sequence:

0x01 0x0a 0x0b 0x0c 0x0d

This could be interpreted as "send the above bytes to the slave" or
as "send 0x0a to address 0x01, 0x0b to 0x02, 0x0c to 0x03 and 0x0d to
0x04" (at least by this driver ;-) . The latter could be intended.

> ...possibly a better long-term solution is to just totally stop
> emulating a regular i2c adapter when the hardware just doesn't support
> that.  In theory we could remove the "drm_get_edid()" call in
> dw_hdmi_connector_get_modes() and replace it with a direct call to
> drm_do_get_edid() if we're using the built-in adapter.  Possibly
> "tda998x_drv.c" would be a good reference.  If we did that, we could
> remove all the weird / hacky i2c code in this driver.

yes, that would be another and probably better option than trying to
detect unsupported transaction.

> Since the bigger cleanup seems like a bit much to ask, I'm OK with
> this as a stopgap to at least prevent userspace tools from getting
> confused.  Thus:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks!
