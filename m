Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0B5C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085B22133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKy5Gysl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfDJCC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:02:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36918 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfDJCC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 22:02:57 -0400
Received: by mail-lf1-f65.google.com with SMTP id o19so480957lfl.4;
        Tue, 09 Apr 2019 19:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YV8Mlc2v0CT7hgH39GMdtVl5rwpSagYbzPjb0y8T6A0=;
        b=gKy5GyslK/ZGRe30ric6CSBcK53o5BGLv0nfsgZ07VZlT9bzCEL/DDeVvfp9zvbwRx
         n+TG6WE172WXMogZM2YHLyMwPx/Dq1wOl9ouhLtfCdIi7C4J3fxQPOEe7u+LQsMN3+6N
         JOn7a/ekOGeZJjJ6FVvRalCaiDOVT2Vz/n6SqX8s/WHVdCETPJFJzYrDERfYhnP/kt+s
         8bFs8ik7XPAIQvDMlN4Hm02A7IjVBqF5YT5qObWeu5PdQgVVq5p0RshVj8s6CP7N7PX3
         L7Uh77HhQbar6+jLY03cpJeVayHQDcs+cbcB9zE892vnHVP0d8jpl4/PzsFd7iTGhG3f
         SmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YV8Mlc2v0CT7hgH39GMdtVl5rwpSagYbzPjb0y8T6A0=;
        b=b3V5ENWrdg8jec2X6wNG5FkvlArSFQDyzKHJLrStpU/y34XIQ+vWCwQKlrs+zBUypG
         4YknkYEd2TWgIffv1MPwqYzH8SYRSieKok15L/WeNFb2dwUXzy1vQEfPed4Qbw85pJdv
         OscRmkvO5aKoLUH65wx+tUGPRM/FPyRBd/ZnXZG9HpZUGsW00vlC+gZEbfgsilLTc4GQ
         Ivmdf4dscIwLaclzEOYPKolWCLQPfRZwiY9hMFBaxE03ZWceRuoM8ZwhVe5kjMikR73c
         KJY1eTGy2t9GK2kGqJUon0FFdVloUO9zteB1CZsyeBCUJBSnLcb0KFc22AMIgrPnKRVp
         cfMA==
X-Gm-Message-State: APjAAAURAlEeFNPvxOq2XsTqCyVaCp3Y1n3+Tz2/9vlSoG/4qB4+3ewP
        +tE9yb/6sxMlHl7FeoVuaLeBJUQjJ5tHQOeLdgw=
X-Google-Smtp-Source: APXvYqxZwl5UnoQW6yk/WyEozqR4khQHpVihQQ60tO7OvSDo0ShJtneoBK2XUqbXMk6I9lv3zXIVQXcGNvOu9lWeGuY=
X-Received: by 2002:a19:c51a:: with SMTP id w26mr20668408lfe.59.1554861775076;
 Tue, 09 Apr 2019 19:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <1554860547-18237-1-git-send-email-Anson.Huang@nxp.com> <1554860547-18237-6-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1554860547-18237-6-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 9 Apr 2019 23:02:48 -0300
Message-ID: <CAOMZO5C0oTaaFFVKC=72+5UGMRwvoxJAsBJNsAp5H_16gsXhVA@mail.gmail.com>
Subject: Re: [PATCH V11 5/5] ARM: dts: imx7ulp-evk: Add backlight support
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 10:47 PM Anson Huang <anson.huang@nxp.com> wrote:

>  #include "imx7ulp.dtsi"
> +#include <dt-bindings/pwm/pwm.h>

This inclusion is not needed here as PWM_POLARITY_INVERTED is not used
in this dts.
