Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A9BC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B5D2053B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jyKQzz7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfEHIdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:33:10 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32778 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfEHIdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:33:09 -0400
Received: by mail-ed1-f66.google.com with SMTP id n17so21307788edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 01:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=pK6wVbjmnvB/fkRhlO06WndQQley/CLsWlKi7Lo/4rk=;
        b=jyKQzz7bipEyXQ6mMXMUmxM55YNMYTV09/uuB5zNRCY0/9ZBIP+Lfyi94AaxP8Hj0y
         hnYPMzZdHpSUNgX7RXjh+tdhhT8nVwCAOFUoj8mudlIsy8+E2rpAyby34PhbMF66SUe3
         RGDCf2Tg5xAYPjSK0ABIlA3ukX0dLv5ZwK9Bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=pK6wVbjmnvB/fkRhlO06WndQQley/CLsWlKi7Lo/4rk=;
        b=GA6GgPHJQlYt7tCvQ4kd+Rz+Fjd5HzRRqJ5A2b25J4GIRhTHGK4aC+cgdmGhcYwjAy
         lkU3kYSJqO4meGNxkbzG0asj4Ai9qk8y7rzI+ioSSLYIQnArDXVHqToo7EQo6fPMoATh
         FXCpZxucm9VQWk+Vqs4B3TH6d4ZS+9utgGUkzzWvYa/PchuFkj5nUmXoxwTPwU5qXkj3
         +3FCknV+i1/VtNpAwb5jyGEWBmIHonNXo2QT/8sO8tSRPIWn3+SBCWO9aF2uwqVuEt6l
         KK+DL5mHJHTB56uGQ95Jk74/x+FjKL49bdQnaIgVsZ6R5qNIJPgbsbnkQUWim7gASRO/
         G7NQ==
X-Gm-Message-State: APjAAAXlv+uxFYRbBJQWKkOvrLWlNf7MnrIOBbIeDG+rq/C7Ep5f5K+d
        3sHX/Jm6fOe62yDmY8ysyTBEoA==
X-Google-Smtp-Source: APXvYqwUkZlPgHY9vRwVHZGsHkyTtIbJaS1tfENj3GHg4lDVQYijjVoHXXBWgmsCGnRbNduUH4WMew==
X-Received: by 2002:a50:8927:: with SMTP id e36mr38416424ede.54.1557304387856;
        Wed, 08 May 2019 01:33:07 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id m27sm2593869eje.67.2019.05.08.01.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 01:33:06 -0700 (PDT)
Date:   Wed, 8 May 2019 10:33:03 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        stable <stable@vger.kernel.org>,
        =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RE-RESEND 1/2] drm/panel: Add support for Armadeus ST0700
 Adapt
Message-ID: <20190508083303.GR17751@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        stable <stable@vger.kernel.org>,
        =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <20190507152713.27494-1-sebastien.szymanski@armadeus.com>
 <CAOMZO5B2nMsVNO6O_D+YTSjux=-DjNPGxhkEi3AQquOZVODumA@mail.gmail.com>
 <20190507161950.GA24879@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190507161950.GA24879@ravnborg.org>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 06:19:50PM +0200, Sam Ravnborg wrote:
> Hi Fabio
> 
> On Tue, May 07, 2019 at 12:33:39PM -0300, Fabio Estevam wrote:
> > [Adding Sam, who is helping to review/collect panel-simple patches]
> > 
> > On Tue, May 7, 2019 at 12:27 PM Sébastien Szymanski
> > <sebastien.szymanski@armadeus.com> wrote:
> > >
> > > This patch adds support for the Armadeus ST0700 Adapt. It comes with a
> > > Santek ST0700I5Y-RBSLW 7.0" WVGA (800x480) TFT and an adapter board so
> > > that it can be connected on the TFT header of Armadeus Dev boards.
> > >
> > > Cc: stable@vger.kernel.org # v4.19
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> 
> If you wil lresend the patch I can apply it.
> I have lost the original mail.

Usually patchwork should have it already (and you can pipe the raw
patchwork mbox into dim apply), but somehow it's not there either.
Not sure why, sometimes this is because mails are stuck in moderation,
sometimes because people do interesting things with their mails (e.g. smtp
servers mangling formatting).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
