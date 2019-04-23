Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51444C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9EB214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E1GQaR/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfDWKch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:32:37 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35732 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDWKcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:32:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id j20so11331556lfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 03:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UvIukkNSb0qztkumJSNQE63cuxgr9qdt1+lxZ4UfKQg=;
        b=E1GQaR/h38SLwy0Ima9h7U3RYMPCzDk/J90O1DCEDSMrmQy/YVVniX/ti97X2Ju3lb
         2T8l6JpryWR1QJ0+8XLFhk/5hbOqln/SD6jJ83gyqLIBb9XJNK9Vjfq58VJYIpSdeeg+
         7704G0+426Nw6rqS9SWUzz8RBFSB54xFyZ1yhYMEV0e88Lg0abbxJp1zf/czCENfDD2M
         vGA5obAJxRl0FvFZ9jf5xRyvYEpyKHaEvYxaxUOhsabtW1Vh7h22bLatbu/npPwoeh3M
         0jjeLsG2ODG/vugE94qaAC/aPn46+NIBjK7JUTn0ywDK3L404xlNeEE/xVDFOHiiJmJF
         MHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UvIukkNSb0qztkumJSNQE63cuxgr9qdt1+lxZ4UfKQg=;
        b=UWgKWmuxQNjXR+UsbeG3+hi94+rlTg49UYJWPe+hfCurRokQrComFW5+KUvdc4GpMv
         crD1Zr7qOhLEDhoJPdDPMjeoMx752EM/4bNoP0+gE5A5LEMPoai/y/9TkCUF3IO0SBlN
         Od6QqkXSBEKR4LewSdTv3GhJg1UICeY+aQ2QU4oaaz8KSbMFYIHy2gZih5IZgCy9dUz5
         3xuI6ipageB+aJImcPV3bYwESkVfNrL3LBMB+NL84o6Lr23x+I9fbmfm99/aaB+k0s3m
         bPDNkE6prBonRUVLmIHVxlCMbzI7flqqIXPbbWUeEWqfwpMYbkMNm1l+oxSB2vHx5WzY
         HGWQ==
X-Gm-Message-State: APjAAAWwNfFHaVYs6P5pPL0QIfeo+0q9aTrQdrzJPvpYtSWc/SMwAkzO
        /B0Q7OjbPsNnq5elnthAfgCD05AayWEvFGhNbBsLZw==
X-Google-Smtp-Source: APXvYqxAYtzZwHLQqQjDTTLSAO8+FYiFSNKxiPSKsuCm3EJJVaxMKQbozC6bIPcMOTpT0fqwYHmW1MQCbgxMCpTuI6U=
X-Received: by 2002:a19:c301:: with SMTP id t1mr12944577lff.167.1556015554439;
 Tue, 23 Apr 2019 03:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190413165418.27880-1-megous@megous.com> <20190413165418.27880-5-megous@megous.com>
In-Reply-To: <20190413165418.27880-5-megous@megous.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 12:32:22 +0200
Message-ID: <CACRpkdZH2GLLNnubO8C3S1STbLJ+HJswfz0Uc8kc1VvafQTuWw@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] pinctrl: sunxi: Support I/O bias voltage setting
 on H6
To:     megous@megous.com
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 6:54 PM <megous@megous.com> wrote:

> From: Ondrej Jirman <megous@megous.com>
>
> H6 SoC has a "pio group withstand voltage mode" register (datasheet
> description), that needs to be used to select either 1.8V or 3.3V I/O mode,
> based on what voltage is powering the respective pin banks and is thus used
> for I/O signals.
>
> Add support for configuring this register according to the voltage of the
> pin bank regulator (if enabled).
>
> This is similar to the support for I/O bias voltage setting patch for A80
> and the same concerns apply. See:
>
>   commit 402bfb3c1352 ("Support I/O bias voltage setting on A80")
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

This patch applied to the pinctrl tree for v5.2.

Yours,
Linus Walleij
