Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8C4C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4883821841
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmr5qsvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfGQQtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 12:49:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38860 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfGQQtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 12:49:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id r9so24320868ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 09:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BDlsCAAxYDTqGk6smEj2bdvvQqQCL67MYibGQ7s4YIY=;
        b=cmr5qsvNgH9jNT0/oafd9XXAwmpTCFGAjK4jbC9RTNsdmQT0/IDz14HhR1PWraPKV/
         Jyfd6UrLeWgzeC8o4hz7LUVjIihsl40hteM5daXR7lLMZImbqbSWSUpY9n90SqzXBV55
         3keJzjhMSe1TVO1kIWTYnaigdx9oKgWn952/s5A8HkrdvmK3ndk4pje+nxXTaoykDUHl
         TPeTbWkWM/8NrSjqsDdOE9bGSVPVjyPoCbQVsIdEl/tHn6Fzy36dMp2REZLMnbOOIk+g
         uHIS84R63cLEHa8V96pAqlY2DVvI/d8U+aSt873GnR3HJk9jbz77ptXbN4hd3eZlV0GV
         BEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BDlsCAAxYDTqGk6smEj2bdvvQqQCL67MYibGQ7s4YIY=;
        b=jNCrS3shhm+mE3DIrHPA6TtJm/Bs1WxH0GuqBxLZyS+daZBTR4+phLKW9qNvgy1EwA
         DY5AZmHJtaz788oqlqNQkIMGYGUNpMC5uEMUOEi+LQCdvzX1wqBAteiWQrpj/cJyFJ+l
         +e1Ogg3plZ30ce4aQ+A4XRMJuqP2q/xhWmNMr5dy/W/Ogp8MyZwzmRRA1wIgWsTUpvGD
         ITvAYn0ILAZ8R1pZ4cA9EjqYABrV+LgSGYmsl3cL8uocY4WNAFhoBt5vp7az+bo1Lw5l
         nkchiQfBOrJUD1prH53Gx4wAEwZesiL0Cs+bCl2d3HnSMOMmBperzBi2aShZqB7fqHet
         DDaw==
X-Gm-Message-State: APjAAAWhVXAbSpzXFaldDDw47fCoQ+ykGWcPgKrvCX4ucHIOK6AvyhjQ
        w+xW7JSRnVX//8Whl89KjFJ9gBpSCear032pXxE=
X-Google-Smtp-Source: APXvYqxs9oTcqPbzk6CtmwWgc1tWfVsOPZfObW1cz1BRNfRjM0krifJEapOQopLnP9JxBbQE+0venO9BkgTifAnfxwk=
X-Received: by 2002:a2e:2c07:: with SMTP id s7mr21676419ljs.44.1563382169269;
 Wed, 17 Jul 2019 09:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190717163014.429-1-oleksandr.suvorov@toradex.com> <20190717163014.429-5-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190717163014.429-5-oleksandr.suvorov@toradex.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 17 Jul 2019 13:49:18 -0300
Message-ID: <CAOMZO5BurienB8eFMKbvbxbJ9zCDFT2nTz1ME=roL=i8vnk28g@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] ASoC: sgtl5000: add ADC mute control
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 1:30 PM Oleksandr Suvorov
<oleksandr.suvorov@toradex.com> wrote:
>
> This control mute/unmute the ADC input of SGTL5000
> using its CHIP_ANA_CTRL register.
>
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@toradex.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
