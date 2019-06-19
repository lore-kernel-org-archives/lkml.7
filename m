Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66272C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A9B021743
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmkC7RYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbfFSN1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 09:27:55 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43812 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfFSN1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 09:27:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id j29so12114230lfk.10;
        Wed, 19 Jun 2019 06:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WLdN0ETsTns+dZs6DKliEgFh9OL/ylVkF+bq8ufBcyM=;
        b=GmkC7RYJkON0ALUMtKgH2gM5xUOoLg9yKMZPDrhQgh675JhIF5GiBOMPHn6FKGc2R1
         VA1L7FLv+M+owW5JSsAP+D2lbp9goB92wEiu2BeXPjIRbutyBjFbxSqGC7CIGftPRGz4
         N06BOYoWDuVwXxAhFgqscXMf7/wr67Cnd5kgh10xstwS1vaipNIzQJ4xi3Qa0XikISKS
         6kr9gsE0C+TvdR9EyCuGpdHOeWGCnF9NgAxBkTgnJ6+Z0LyyWBnFDdlN64ZM52YplIif
         3wxKSuC8rUqyOH87RNPyzM9OXapx5ym3eGFRZ/467U902446tetXoLxrdr8I9/KtPQgR
         zs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLdN0ETsTns+dZs6DKliEgFh9OL/ylVkF+bq8ufBcyM=;
        b=htOIRWS1Wvax4RNWK7rJmmQ/NG+MfYZCv+hDMUebFGc/DQqBjvs9T3PR6wsMGBFISL
         ZGpENGRGJP/qHgLvlbY8wUkurROMduZB252vW62a793/HQvKj6VSEDjh/gd1Lqo00Nc/
         UbmGxbBoGrllDrRidMC4imeLFYk8jTokbxb6jbW7E4fn0nrgVZAvh+v3VNxkhIJb3wE8
         xJy84jjWk47lE1D4SR/jdo/GzjnaNgDAqdWMLLE8DOCdqsQ3Hc1nFrSrADYuqzmBTeLr
         Cu+8wvwFv+wFxIMkEadzVhSnfGieerSCI8CtdQbLhgVqCXlfjIW0BMLcaLf6NBeiT7h7
         XvTA==
X-Gm-Message-State: APjAAAXNUrNmMU4pOniMx2oYbKqGJMPbtTD9SSTVJfdOCOzh08XeEUJU
        /V+l12s/sn0rSNWhgfhOTCYlZlQrnaDtwrtdR4w=
X-Google-Smtp-Source: APXvYqxut0jGXYnHUHWRv5exjD18glXwg/4LLtkINuNKm47kn0WiC3XuzDKL/3Rf31Idbf0hTMmRP8e2v6I90koglFw=
X-Received: by 2002:ac2:4303:: with SMTP id l3mr6008405lfh.107.1560950873078;
 Wed, 19 Jun 2019 06:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <1560864646-1468-1-git-send-email-robert.chiras@nxp.com> <1560864646-1468-3-git-send-email-robert.chiras@nxp.com>
In-Reply-To: <1560864646-1468-3-git-send-email-robert.chiras@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 19 Jun 2019 10:28:05 -0300
Message-ID: <CAOMZO5C_4QxioSx4JEAV+1dDxYJgdTCzmBLZyUCB4dWeRqLFng@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/panel: Add support for Raydium RM67191 panel driver
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Tue, Jun 18, 2019 at 10:31 AM Robert Chiras <robert.chiras@nxp.com> wrote:

> +static const struct display_timing rad_default_timing = {
> +       .pixelclock = { 66000000, 132000000, 132000000 },
> +       .hactive = { 1080, 1080, 1080 },
> +       .hfront_porch = { 20, 20, 20 },
> +       .hsync_len = { 2, 2, 2 },
> +       .hback_porch = { 34, 34, 34 },
> +       .vactive = { 1920, 1920, 1920 },
> +       .vfront_porch = { 10, 10, 10 },
> +       .vsync_len = { 2, 2, 2 },
> +       .vback_porch = { 4, 4, 4 },

Are you sure that the sync_len and porch parameters are the same for
both 66MHz and 132MHz?
