Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E28AC2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 01:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF312075B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 01:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pix1lhPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfLXBvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 20:51:12 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40508 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfLXBvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 20:51:12 -0500
Received: by mail-lf1-f68.google.com with SMTP id i23so13984452lfo.7;
        Mon, 23 Dec 2019 17:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+zzZW9C2gvFiTdhaS90LTZiz7GaVSNQiHEc9bjcauWA=;
        b=pix1lhPd6xmGCLfnzJR0LLpnNF77nOSmKK7Ho9Wy5BLeM2lnzWhA/i7XocKz1lMOyi
         bqCmCdc0Hh9sYTFBMGWc2a8Ti3WqACB8W8RV+kQbZxBgaX3xcMSHN1Ncn1M1df7t+54l
         u0HVu0N2eA7JnVf99+2aD6WAA15VIAML4sC+dGqmeGiCL5zi1IbM21h7PjtNIdgExkLC
         lAjvdtV5IbcQHox6ETPoNcRMRH0qFYFj35b/9uswSgIiFqaJtNn/8RBxA3qJIzOVvFAP
         qu2JfmwHPUuLtBcF7bytScnDy1G5YTtRE/PTaNqNGuWurHb2znuFknc7xFCcrzg5sVGb
         vUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+zzZW9C2gvFiTdhaS90LTZiz7GaVSNQiHEc9bjcauWA=;
        b=UErWLbyUhfRL+eH8WbrFH9Dak9/Cy3xmTpZfTpKFb6/T4Yt5Za+p8Kw19g9wgfZsS3
         COAHEWEqc4lVUFmJt2ByPKNB5JNDd9wWe3tUS+CgqeGkRDTXIIXpD0wpqqQOzwSURF4X
         LL1TcS1inLN+ADbI6Cj+2w//02XpFcz4VH1DqVEI+t/pMjkfFwQoZGOHCwf2eewMjxRV
         hD39LL8PGy2wqPGKJw5z5xt31NOCPhzxvEf7I+wE3MHAc7AGusAQLukWS7+mFVtcwAHw
         2akSnB4UUn++1fxuzhnOJgBW86Kz4pc0SX5Hpf5y8KP6qScZIwF66EAGGIiQqpafia6N
         lXcg==
X-Gm-Message-State: APjAAAVIlW1NftXH3OigvwCM8h0dbpMCLY1f063YtRn8TZ3MXrg3qZ87
        6M2vktSoOvbNf5EranHmy2ezGrDU+SHBkhlAI1E=
X-Google-Smtp-Source: APXvYqxmJhbEhjtuyN8MSRNzv+M402lsv/DixBtC62/FDtYoJGTAVkjPwYHdcNzAsb8Gx0pPuX8e5saKlrb95arptAo=
X-Received: by 2002:ac2:4194:: with SMTP id z20mr18731670lfh.20.1577152270133;
 Mon, 23 Dec 2019 17:51:10 -0800 (PST)
MIME-Version: 1.0
References: <20191223214412.12259-1-rjones@gateworks.com> <20191223214412.12259-2-rjones@gateworks.com>
 <CAOMZO5CLfyZjuz3c+Xr9v0D5h+r83PGgi8BrMnQZOOZSM-iGGw@mail.gmail.com> <CALAE=UAok8dazxPj16TAV7rQ_6EZvLBp3t5J2CjweMyECkZAHA@mail.gmail.com>
In-Reply-To: <CALAE=UAok8dazxPj16TAV7rQ_6EZvLBp3t5J2CjweMyECkZAHA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 23 Dec 2019 22:50:57 -0300
Message-ID: <CAOMZO5AG+bPd+3h6VanBfJcGxVhVC=RkvpD1FzZ4tfgLYkiz0g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] ARM: dts: imx: Add GW5907 board support
To:     Bobby Jones <rjones@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Tim Harvey <tharvey@gateworks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 7:55 PM Bobby Jones <rjones@gateworks.com> wrote:

> Original author for all but the GW5910 patch was myself. It's probably
> not clear here but Tim reviewed the patches prior to submission and
> had me add him as a Signed-off-by.

You can add Tim's Reviewed-by tag below your Signed-off-by tag in this case.

> So I was planning on just adding an enum line for "gw,ventana" under
> the i.MX6DL and i.MX6Q based Boards sections. Would that be
> sufficient?
>
> We have a lot of individual custom boards and it doesn't seem correct
> to add individual strings for every one in both sections.

You should add all Ventana dtbs into fsl.yaml.
