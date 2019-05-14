Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DC7C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5237B20879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hz3x2Hx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfENNIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 09:08:39 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46599 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfENNIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:08:39 -0400
Received: by mail-lj1-f193.google.com with SMTP id h21so12486250ljk.13;
        Tue, 14 May 2019 06:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jGnWaeTdAGYVob1R/TxXevTDDOUSFKjgVCqNbbE/1nI=;
        b=hz3x2Hx3tvoY4x19hxjgKQPiNUhxFg13owl7/k6Ky6dO4KK2ca5+M2T/ZQAHHSZThe
         xIwgSLc13QESbL3hNX+o5utV03dRJChs7nOKk6wkDO5elb16VMgToE05vxVoHrSD0yoL
         wABAYKND66EjSnJljB/B9NcK7jayPwmR0lvS/EA3rYOLZ0RgNQDRysBwK/VkBtP/rZDu
         fpeYAXJCvJ/wpkfEqBrurLrugaGUcJWi5Gg5sSe+sTbPk7iJLXpCd0hDsQ77PQ5vCPhL
         Bn/CBBeO0ID0BLatVCRMm/lGrg5qSdZa628QsHlslnMeW58ygsZykh2ii05BeCZeaFJi
         gQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jGnWaeTdAGYVob1R/TxXevTDDOUSFKjgVCqNbbE/1nI=;
        b=BWR0nYQH05fktCcFwntfwVLMF9UUsEMrP1uiAp9k7etusazA+UH64M7ao3MfsRomgx
         Yf4Zt8NIwptxv3IzinHOo1CCsB3VlRc/cz8Qt7MnN8WH+K4h0lmmvarlOS1hK836qCpd
         23NMtXjpgeEDaSw8Xp/EanWnMWwgpNtwBmyIxGbtQkzyu0nmTZSpLcXc5Fw/h0OBWLT3
         7y8v1weo8c2+08f9FXl++FMAzq0n4mLtxdl4EzFrB4nQUriPzz+I3GpD+Fac1IeMWhZE
         BiYcqoYVAs11GWNyvwLZIQCEQP8vlOIN/EHMUB16AVDHJtle6EUaVIcFKBqQi1D9p2tQ
         mj4Q==
X-Gm-Message-State: APjAAAVmIAtCRNuCoru7KAA3S/T27L9Vk8HJheASRfUdMqCp5tqkeAFn
        Z3isVjx8RfZf5F5U9j34fLvv6/meSXqGvQwBgFY=
X-Google-Smtp-Source: APXvYqwGecBzbpfdMXAIjdCxJTDl5Ws8nyl0nWjhHtCf7epuYAKPy0fZvIPVELRzmMR4xkE3iE/POW6O04b/VHIW07o=
X-Received: by 2002:a2e:2b81:: with SMTP id r1mr15614143ljr.138.1557839316690;
 Tue, 14 May 2019 06:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190513202258.30949-1-angus@akkea.ca> <20190513202258.30949-2-angus@akkea.ca>
In-Reply-To: <20190513202258.30949-2-angus@akkea.ca>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 14 May 2019 10:08:33 -0300
Message-ID: <CAOMZO5Dn4sVJx3UPo-WXMen9N36CiBvq3i+GosJ_4FGZ7jnTqA@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] MAINTAINERS: add an entry for for arm63 imx devicetrees
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 5:23 PM Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> Add an explicit reference to imx* devicetrees
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>

There is a typo in the Subject: "arm63" --> "arm64".

Reviewed-by: Fabio Estevam <festevam@gmail.com>
