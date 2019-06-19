Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12B1C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 04:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C736820B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 04:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaWBShTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfFSEdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 00:33:47 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44388 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfFSEdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 00:33:47 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so35008500iob.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 21:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8r8ZWpOUsPGwi3ewR/uZDqYnd+4gRdP70o2Ut3enZJg=;
        b=UaWBShTrnYRsceDDBA363Lc64o0CaKQi+IpRCeWxVUAMHn+rsf9Y49HflQ4pogw8JV
         p4KbowerxNYdpuDV/r8hx0nMpySOiQK1ZhlSeD9rnXyP+6ZWzznl3soHOCa29wRPCkYz
         +enC0VXBGqv2+7HP99/L/ymzjlqHph50BdfuPSb82+OcqVTCwjYJdMdgNmE90DjYweoh
         +2xREyWppruclvZC7UTEW8skfjqAtSSv13g/5WmosUzrdBdA06Er1sZ/3OqrCSgGbxC1
         b4KUnHPhpK9sl4Rq+m5G5MpalDdSEr4b9MnIR7usJP0VX9edYDcD4l4EUjTMHkwPdKbj
         14uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8r8ZWpOUsPGwi3ewR/uZDqYnd+4gRdP70o2Ut3enZJg=;
        b=ao2UvoO/8kn/N9PJXsJCLeQ6imY6WYsFMDsVb3SKE0OAYWt8dqk6YaVCWEb+30/7cw
         z6f9quaNXJfL+V0vJp0K3ItC/+AVFnzmVxOkqN1PVL6DudLjCQWlf93WUulqMSIKaii9
         iIPutphQCEGtg9o1rJq26jZic9cdCRGVGhwCHzuv3Cmx55yTpVG+7+jJbUdPRirH1ksE
         PuuVGM9ynwozvkolUaWHw1lHhSLBKGqGm71sicX6x5NqslMQT3FogISYqnJPi1sifHEc
         +iwPqOxJYVGWzC67vGMEmVshzhT87co8WMxx2eYJdLwXXTEG62hT3PLCOO5HfZbzYfU9
         WwPg==
X-Gm-Message-State: APjAAAVEFGG0Xkw1wm2x8Jpu81ACUBhmFbuGXZVqBoFe797JvDsFRfVl
        JYMKFt6yfhF1kK3vvh3s5VxPaeejYXlJ9UF42IU=
X-Google-Smtp-Source: APXvYqx6xw2EDD9sCd3KCvYIrcjzDch4J14Pw2Z3x8SzAI62kqWkXMh+hm66heZf/sm4Fj9RMl5vuOayteOlsoAfMZU=
X-Received: by 2002:a6b:4107:: with SMTP id n7mr26327566ioa.12.1560918826241;
 Tue, 18 Jun 2019 21:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190612083252.15321-1-andrew.smirnov@gmail.com>
 <20190612083252.15321-11-andrew.smirnov@gmail.com> <a1c125d2-1c7a-c190-8b7e-845a2ec1d2ea@ti.com>
 <CAHQ1cqG7dPFarphmBWSSqYAuO=6Kev4eFsBM09zUDJFek3UaOg@mail.gmail.com>
In-Reply-To: <CAHQ1cqG7dPFarphmBWSSqYAuO=6Kev4eFsBM09zUDJFek3UaOg@mail.gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 18 Jun 2019 21:33:34 -0700
Message-ID: <CAHQ1cqEG=Y+PKTV8it-qXzhmGskY2Uy=72VA8rKZu_ho9+4LcA@mail.gmail.com>
Subject: Re: [PATCH v5 10/15] drm/bridge: tc358767: Add support for
 address-only I2C transfers
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
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

On Wed, Jun 12, 2019 at 9:22 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> On Wed, Jun 12, 2019 at 5:48 AM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >
> > Hi,
> >
> > On 12/06/2019 11:32, Andrey Smirnov wrote:
> > > Transfer size of zero means a request to do an address-only
> > > transfer. Since the HW support this, we probably shouldn't be just
> > > ignoring such requests. While at it allow DP_AUX_I2C_MOT flag to pass
> > > through, since it is supported by the HW as well.
> >
> > I bisected the EDID read issue to this patch...
> >
>
> I don't think I've had any problems on my end with this. I'll double
> check. It might be the case that yours is the only setup where the
> problem can be repro'd, though. We can drop this patch if you don't
> have time/would rather not dig into this.
>

Turns out I do have this problem. Just didn't pay enough attention to
notice. Will fix in v6.

Thanks,
Andrey Smirnov
