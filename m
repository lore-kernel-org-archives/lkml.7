Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852CDC4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D8C20665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561416472;
	bh=CNuguc/P7Uhwo23QdZ0+FEJG6Sl7bZvkg9koDHGRBwE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1UtCG/TgSmR3D53HdSyZneR8qdC1ZdXhn7E7NiPSXg6QE16KritZ0dRAlHzSX4YDv
	 9XivR8lt7GVEdcoMWyXAQkh6nb++fyghiV8pf5ZvL2Q8GUJ6Kxikm+vWNkY8PqG/+C
	 AB6Q11yLwoyOifZLA8HDCbgtUeZbYFEPAQgFH9gQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfFXWrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 18:47:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbfFXWru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 18:47:50 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0B1C208C3;
        Mon, 24 Jun 2019 22:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561416469;
        bh=CNuguc/P7Uhwo23QdZ0+FEJG6Sl7bZvkg9koDHGRBwE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Npq7eKyUPEHt7I0J0hKuLIpspweayj0V9QS0gOnqL+j7TtXzRTL62cNwJJWzLJQm/
         wtD4cfbz+c2rML7Gi3PZOPjORFr0bf5+kyE+2SDqYw/jE23WjzE9AfP0+1cbAHCTxk
         zqOTv+XxbniKpHhtuni4sq2Vx/pDwgKkw9JAeIFs=
Received: by mail-qt1-f173.google.com with SMTP id p15so16359943qtl.3;
        Mon, 24 Jun 2019 15:47:49 -0700 (PDT)
X-Gm-Message-State: APjAAAU6L5C+UGumzUL/wIMcDBUpRqPD04CJfe0R5TfK9OIMwj7PXVNi
        NbtuevqWtOc3DxHFGjg0uYeYFjXwt5aRctMMAg==
X-Google-Smtp-Source: APXvYqxlIjRIh2l+yvudNPwYZZU47VyJImJvI4DwxJA9a0YvEE16V980+qj+PoVEKQNRejw/RKwcphoC4/c2U6xGudE=
X-Received: by 2002:aed:3fb0:: with SMTP id s45mr79951733qth.136.1561416468915;
 Mon, 24 Jun 2019 15:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190624215649.8939-1-robh@kernel.org> <20190624215649.8939-11-robh@kernel.org>
 <CACRpkdYKE=zLJhmTeTWYGRCQNt3K8+rNNqsp5UDa2d31GG6Y2g@mail.gmail.com>
In-Reply-To: <CACRpkdYKE=zLJhmTeTWYGRCQNt3K8+rNNqsp5UDa2d31GG6Y2g@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 24 Jun 2019 16:47:36 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+uCMKhUFgCCK3uUetL9OwokQPaq74GJHQS2VS=UjVH8w@mail.gmail.com>
Message-ID: <CAL_Jsq+uCMKhUFgCCK3uUetL9OwokQPaq74GJHQS2VS=UjVH8w@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] dt-bindings: display: Convert tpo,tpg110 panel
 to DT schema
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 4:13 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Jun 24, 2019 at 11:59 PM Rob Herring <robh@kernel.org> wrote:
>
> > Convert the tpo,tpg110 panel binding to DT schema.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Awesome, fixed up the MAINATINERS entry and applied and
> pushed for DRM next with my Reviewed-by.

You shouldn't have because this is dependent on patch 2 and
panel-common.yaml. So now 'make dt_binding_check' is broken.

Rob
