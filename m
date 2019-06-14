Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE4CC31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9492073F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfFNDVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 23:21:48 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33823 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfFNDVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 23:21:47 -0400
Received: by mail-ed1-f67.google.com with SMTP id s49so1363168edb.1;
        Thu, 13 Jun 2019 20:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gVoHYq0itV3pYTA3eOtXIMDIVkYyR0cLDLEAE/xIlME=;
        b=na5ACTLh8CSai9HbLnWU3JCtt5CYZksnbeM/LBhz2GeXeHFDsYVxD9HBo88YaX0l4C
         8pgNw66lNo6cCObfxFj35yvLiiO4LWcQFj5/NqzGKFk64OcZLtFPmsF0xvsifVWwh4nx
         qiPnB9W8pCZGcO6PMQkOe1yXW7pQ8VK66UDVoFerIczdS92D7jR0fa0Hi66JpyJmX0jR
         P4BgBHp3fRWSnFkNBUNjURquIjgrInXd2iqw+YL2DD5l2247pYrvtqdOQEbyFlDXinLq
         oxzJCVLjrY5UtKkxIF2Z1WoQWxUMxkNMY4fIvMPNugjsT1rE1LHn8BygG6eaQ2QzApFh
         KGeg==
X-Gm-Message-State: APjAAAU5QieKSyFLps/XanalSqgZ/mLitkM0jrwLsBtGM4nHAaXR7MWT
        mC/wu1CVVgBaaxBf1JpuD12hwMoXl5g=
X-Google-Smtp-Source: APXvYqxhXPRmaY/QWCO4cReLgQ18G4pZYfjt4CEKiNBxezI9zxxQlCtRqKtE+L/qULv1wWKa5IIzCQ==
X-Received: by 2002:a50:8465:: with SMTP id 92mr21961568edp.151.1560482505822;
        Thu, 13 Jun 2019 20:21:45 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id a9sm486824edc.44.2019.06.13.20.21.45
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 20:21:45 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id p11so874915wre.7;
        Thu, 13 Jun 2019 20:21:45 -0700 (PDT)
X-Received: by 2002:adf:dc43:: with SMTP id m3mr3389739wrj.279.1560482505069;
 Thu, 13 Jun 2019 20:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190613185241.22800-1-jagan@amarulasolutions.com> <20190613185241.22800-4-jagan@amarulasolutions.com>
In-Reply-To: <20190613185241.22800-4-jagan@amarulasolutions.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 14 Jun 2019 11:21:32 +0800
X-Gmail-Original-Message-ID: <CAGb2v65mR0DwAuf_YvDS-dwx2RpEdBeV-5R44zgWn83GNEgp6w@mail.gmail.com>
Message-ID: <CAGb2v65mR0DwAuf_YvDS-dwx2RpEdBeV-5R44zgWn83GNEgp6w@mail.gmail.com>
Subject: Re: [PATCH 3/9] ARM: dts: sun8i: r40: Use tcon top clock index macros
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 2:54 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> tcon_tv0, tcon_tv1 nodes have a clock names of tcon-ch0,
> tcon-ch1 which are referring tcon_top clocks via index
> numbers like 0, 1 with CLK_TCON_TV0 and CLK_TCON_TV1
> respectively.
>
> Use the macro in place of index numbers, for more code
> readability.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
