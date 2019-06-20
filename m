Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2CAC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37C22084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCS/nz0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732056AbfFTQI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 12:08:28 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43596 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731511AbfFTQI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:08:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id w17so3701208qto.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 09:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZRLTstn1uH4xoAiOrvyBM/9FFvAo+8BIlcktIv+nkjc=;
        b=CCS/nz0hku8hGuhkjK6KYWjdMpaGphU8wH+TZBBIxWr/1ytT908qf1jGJmv50EUhid
         cCpSZE7w14Dz7/3e/Aec9rzY381NRnLSowrPG1josN80sE6k3/A4lHcde1d3MIib86ur
         ohblVxNSesRF2PSufua7wr2grW3EkYbDrYavkYg8WOt0krt90YqiMMSQswxjhHqoy5Je
         kp81zHJNTw88zKOCPlap6NwUr6MMRZxkCAvrD2QVm+IcriRMWt+Vm6E4skL3tDYG0QTG
         57UR5XfLCaCa1b7dq0eDLTbNmn70CklbJHSBczdlMycBQPZhLGCyL7ZKRQjgLTxqr0e6
         opeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZRLTstn1uH4xoAiOrvyBM/9FFvAo+8BIlcktIv+nkjc=;
        b=DCuWNEP9JZX+o3lGDsbTxVAsat7QWM/NqpTwD+XMd5F/CV8cvSHoM8jk2MN3XeVs3z
         nHRbhMG/43R0Gr9z8sII41TBK1UdalfpRgY16jtwKANZE0uSzi11A0YhhwGRUH0phNK1
         4MkaPJoUB7tcf2EUWVBJKkLG21/s3AWUHhOkhHnXF5yipZMVeYm93wAh/wbgYFTfm92y
         kJSU3NHEvmkJSJZYtq6R76NIZX/OdMyXevB0NGvVD0nbgcYdy533PUArEg6e4Kcu6XJa
         kk6nv+lKfC3w+PVXpKySfCn3G0SP0iYmxnf62JIHeJhCrRLds2cHyjnY1yX3JK0guXgm
         r1Mg==
X-Gm-Message-State: APjAAAVfNyP7eOCYEnTakDfkizxA4GRssjoGXemQzqGhLXs2BWpCc7w5
        6Vfn01h3CtnIrPmwK5Su3rubWEFSbM/n4aYuMStIQ2wNJQ4=
X-Google-Smtp-Source: APXvYqxHBeodrFoAFIOXLEADpgqqMN5M0vUe2+Ac9VSRt+mgyN8DSm5aKvJf8irOp9uottIdu+z7UBTkzQVBY5AJPbU=
X-Received: by 2002:ac8:2439:: with SMTP id c54mr80219281qtc.160.1561046906007;
 Thu, 20 Jun 2019 09:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190620134708.28311-1-enric.balletbo@collabora.com> <20190620154150.GE5316@sirena.org.uk>
In-Reply-To: <20190620154150.GE5316@sirena.org.uk>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 20 Jun 2019 18:08:14 +0200
Message-ID: <CAFqH_50RN0xXfzMDNRjQpk8egCEcxH7NEXr8KVYsh04mSLQEiQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: rk3399_gru_sound: Support 32, 44.1 and 88.2 kHz
 sample rates
To:     Mark Brown <broonie@kernel.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>,
        Xing Zheng <zhengxing@rock-chips.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Missatge de Mark Brown <broonie@kernel.org> del dia dj., 20 de juny
2019 a les 17:42:
>
> On Thu, Jun 20, 2019 at 03:47:08PM +0200, Enric Balletbo i Serra wrote:
> > According to the datasheet the max98357a also supports 32, 44.1 and
> > 88.2 kHz sample rate. This support was also introduced recently by
> > commit fdf34366d324 ("ASoC: max98357a: add missing supported rates").
> > This patch adds support for these rates also for the machine driver so
> > we get rid of the errors like the below and we are able to play files
> > using these sample rates.
>
> Does the machine actually need to validate this at all?  The component
> drivers can all apply whatever constraints are needed and do their own
> validation, the machine driver is just getting in the way here.

I think you have reason, I'll test by removing these validation and
respin the patch.

Thanks,
~ Enric

> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
