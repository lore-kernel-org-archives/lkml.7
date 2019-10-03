Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFC7C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811F420815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TPFD+Yd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfJCGut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 02:50:49 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35386 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfJCGut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 02:50:49 -0400
Received: by mail-io1-f65.google.com with SMTP id q10so3095181iop.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 23:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZHYvlpN03aN9XlL85X95NOUwb+VywcBIMog6JdvU8/E=;
        b=TPFD+Yd6CfTdFITa1ngVIu7bhHHpMGlesUhtu9MDTLyuP4HMgvy5WMD6yyY9KoFNW3
         ULlEEjL/G+DiRVPDmI16XEM5gcI+L9El120dH3U1ZMT0cm1lcBnN6D4y2tXwllLYtcPN
         nc2TkrkJ2eYpF/SLjZO42qi/FTcx1ZBzS8t0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZHYvlpN03aN9XlL85X95NOUwb+VywcBIMog6JdvU8/E=;
        b=hDu8Atb5XOrshq4GIaTgHoyib5B9IUu/rojhiezWkOXxGSxo3JY+YOTSBlnIcqOXyz
         Zu6W+o6uX3uLdd+mpvuSflf8CZxwjOGsbtMIq53hwAVTfP3WyqLTuFMaLEpjnLdJSr7m
         eNjdF0WPe2CX/+h35Yxpmfwrt50Fyv9kxKCto36OQnrQdFqbG4yrKrnzKqrjuR6b1t4g
         lIh+2RWsRukhnEQDJbc5wMD9y5l2N2sIvPkMYwiHyzs1iSu0r1dKDVKAk87SMkd9ldXz
         f7OFwlYHQ0DnNmqp1fzLk8yFXM+uyD61gTJmX0FXP7XKLLcEEdpcGmTzswWwu3mNoFnA
         C8ug==
X-Gm-Message-State: APjAAAUrtjLMg+x6dyP8JpcAPDPxHZHZZrxPj799Dv2paKhQmH6N6m/K
        N42I8m5UxXxbujW+2wStiw6etGE3obsCcppdG19g8w==
X-Google-Smtp-Source: APXvYqxidNtZbs0x8HYndi+juRNw13gBCSF4Pfuk3ENR73KLAzRF4+IeuTb4FHlPvke2H95mbMi4Mwo+TGNlA/lh/QE=
X-Received: by 2002:a6b:2b07:: with SMTP id r7mr7235777ior.173.1570085448370;
 Wed, 02 Oct 2019 23:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191003064527.15128-1-jagan@amarulasolutions.com> <20191003064527.15128-8-jagan@amarulasolutions.com>
In-Reply-To: <20191003064527.15128-8-jagan@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 3 Oct 2019 12:20:37 +0530
Message-ID: <CAMty3ZAHPWOn=h04AjGLf33uGhW4MxqpU4z1izGp0BgUmyOiLQ@mail.gmail.com>
Subject: Re: [PATCH v11 7/7] ARM: dts: sun8i: bananapi-m2m: Enable Bananapi
 S070WV20-CT16 DSI panel
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 12:16 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> This patch add support for Bananapi S070WV20-CT16 DSI panel to
> BPI-M2M board.
>
> DSI panel connected via board DSI port with,
> - DCDC1 as VCC-DSI supply
> - DLDO1 as VDD supply
> - PL5 gpio for lcd reset gpio pin
> - PB7 gpio for lcd enable gpio pin
> - PL4 gpio for backlight enable pin
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---

This would be an overlay patch, which doesn't need to mege. please
correct the same.
