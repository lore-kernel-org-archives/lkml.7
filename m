Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57281C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AAF2133F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552056878;
	bh=4aboBRavMPzk24ub+4zG7EAt7vahfO4a4nnF/qW4njE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=X6+2Nn1UK/EhmYVsx6GeanPucWQZ41lq27GVU5HOM74YIQ8aY4RbHlgIU/sE8v0iL
	 EzA0Yb8yC4OHJSg/cf6oA7awqS/H+UZYZLqsiqDvV7dujdLqaiLe5tOmSHa14SwiRO
	 6xp6uJF/zn7GT44jO20LgkJqmPIWPfa/4Pgu7JgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfCHOyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 09:54:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:43638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfCHOyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 09:54:36 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAD212146E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2019 14:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552056875;
        bh=4aboBRavMPzk24ub+4zG7EAt7vahfO4a4nnF/qW4njE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JrtZS4hJE9qP/CD1btG871lfsSxoOqdTnJLVwTcj3iYSb34kivRoz1tcAijpUDBNB
         kAuUfYBggounFFCQciRAb9MK+5llIEWMIobrFK7z0DC9VpRutF2YPwO7HvIlSvOU4C
         equays8Z3r2zyhvLxvBOV6mIKt9dweyGPBowMrcs=
Received: by mail-qt1-f179.google.com with SMTP id d18so21437270qtg.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 06:54:34 -0800 (PST)
X-Gm-Message-State: APjAAAV0hrOAfs21n67AnXk/GiSgMlbWz4bMR0+iVacu4MBW0iHh7jg1
        z8IJFkdsFK5O75xAafvxuce7KMAxS/5G4vKszQ==
X-Google-Smtp-Source: APXvYqwHBa9l0tLCztQbL2/xiRTLGHfjE2CpSkVzPplCHB3+Uo7iEpRpw28U6Z1Kc3Dvv2m3LdDzYjMWLwz5sxUeMqw=
X-Received: by 2002:ac8:3015:: with SMTP id f21mr2248856qte.144.1552056874013;
 Fri, 08 Mar 2019 06:54:34 -0800 (PST)
MIME-Version: 1.0
References: <1549022873-40549-1-git-send-email-narmstrong@baylibre.com>
 <1549022873-40549-2-git-send-email-narmstrong@baylibre.com>
 <CAL_JsqLa1QNYTo+Yj-5fC4k8C1bd+V8qi5LiHgLA_qZY+Gy5cg@mail.gmail.com> <36800d4e-0bb7-378c-e512-5ae02406865b@baylibre.com>
In-Reply-To: <36800d4e-0bb7-378c-e512-5ae02406865b@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 8 Mar 2019 08:54:22 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+-q3+PtU6zS-dLSy3Gx+xOzquLyuW3n3ey6iRT3tw9KA@mail.gmail.com>
Message-ID: <CAL_Jsq+-q3+PtU6zS-dLSy3Gx+xOzquLyuW3n3ey6iRT3tw9KA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sandy Huang <hjc@rock-chips.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        linux-amlogic@lists.infradead.org, Huicong Xu <xhc@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 2:05 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi Rob,
>
> On 08/03/2019 00:13, Rob Herring wrote:
> > On Fri, Feb 1, 2019 at 6:08 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >> Add support for SCDC Setup for TMDS Clock > 3.4GHz and enable TMDS
> >> Scrambling when supported or mandatory.
> >>
> >> This patch also adds an helper to setup the control bit to support
> >> the high TMDS Bit Period/TMDS Clock-Period Ratio as required with
> >> TMDS Clock > 3.4GHz for HDMI2.0 3840x2160@60/50 modes.
> >>
> >> These changes were based on work done by Huicong Xu <xhc@rock-chips.com>
> >> and Nickey Yang <nickey.yang@rock-chips.com> to support HDMI2.0 modes
> >> on the Rockchip 4.4 BSP kernel at [1]
> >>
> >> [1] https://github.com/rockchip-linux/kernel/tree/release-4.4
> >>
> >> Cc: Nickey Yang <nickey.yang@rock-chips.com>
> >> Cc: Huicong Xu <xhc@rock-chips.com>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> Tested-by: Heiko Stuebner <heiko@sntech.de>
> >> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> >> ---
> >>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 85 ++++++++++++++++++++++++++++++-
> >>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |  1 +
> >>  include/drm/bridge/dw_hdmi.h              |  1 +
> >>  3 files changed, 85 insertions(+), 2 deletions(-)
> >
> > This commit in drm-misc-next is breaking booting on the Rock960. I
> > have FB and fbcon enabled. The boot hangs after this message:
> >
> > [    3.012334] [drm:rockchip_drm_fbdev_create] FB [1920x1080]-24
> > kvaddr=(____ptrval____) offset=0 size=8294400
>
> Could you give more details on the tree used ? did you bisect to find this commit ?

As I said above, drm-misc-next (from drm-misc tree) is the branch. I
bisected between it and v5.0. Reverting it fixes booting.

Rob
