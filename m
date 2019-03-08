Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FD6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20067206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fSfpD4mb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfCHWXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:23:47 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43826 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfCHWXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 17:23:46 -0500
Received: by mail-lj1-f196.google.com with SMTP id z20so18705873ljj.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 14:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lO7SZ2brTDoO1a0egWwhDfNQfKSc2gBmtdk6iWrE7tY=;
        b=fSfpD4mbl3+RT47Jlb31fJMiwcm3HsDrnCYrZPcX+15p8qAN7YW4SFZ4wRhoEvat45
         v8OQlu3+OexHqSEh1wSL7oTnvW7HUaWUtbBd1O39QxCbATDIzgJXZvPutZ2c2kwmgyBv
         6zo6wE1hS2+QRKcTo8asfrLSQ7X5pD3XgUAl5IWbUGz35/udsuHPxxT9mz779rsxttGs
         sjqiBEG916F1FkkOvPxHejyGoFTOpx9YMPqnrA0N8yQPM/uEmFhBX31XkpfW8FUJJgmi
         K3wM1TROc30Dwh+vIc2DDyJkvrPMdL6QnDFahJaCeyBkTMp2M4QhJbotNxGGVptyWi6r
         V/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lO7SZ2brTDoO1a0egWwhDfNQfKSc2gBmtdk6iWrE7tY=;
        b=UnWRgfwQMtenk3fdjgi/GR4QyI8SxRWbr1RQzwZGTNlZ8Cfl4ulPzGAlxdLcbm0m/i
         wk9akXF7HfdiZZLTv/f/2qFFFFczvMgTYFO5bCDjzLqT7EbrddX3T3zSt3uf5gMLKHBH
         DmaWhdZ4lrsyigu7A1k6mSlN2IUR4P2Vi5w2EupAcEIS5tTxyPcNkBq3qrM60Lm8LTSy
         wQ5OPtWdov/tTYe+/jTGRqn+ED9QVtbi0hKyZuKPQySoVKzGP9fJ+VBpJYjvcexMyCS/
         CCLBfqi/x4v1wHPpwDn2EwvjfWp0eTtRzxtOU6dkbF5cPGBXdlJWNc7ZQuNlzfM225T7
         KL4Q==
X-Gm-Message-State: APjAAAUm9leYdrrNdoiAze/FUJLcxfBCzRGNfHnGsJh8JecxBp0II/d8
        +8SL+3brMwH34G5etV2XKRngC4z7/kimb8zBdFugNg==
X-Google-Smtp-Source: APXvYqz6acVE0S1CBvA7fh1Gfw4lcA41lkfcJ54ZuL2G+Xh6ke/d7K5NF00aDkGTm8s6kyOjh05ejSFz7rnUrVBPfNA=
X-Received: by 2002:a2e:90cd:: with SMTP id o13mr10317613ljg.153.1552083825496;
 Fri, 08 Mar 2019 14:23:45 -0800 (PST)
MIME-Version: 1.0
References: <20190228220756.20262-1-paul@crapouillou.net> <20190228220756.20262-2-paul@crapouillou.net>
 <20190301201624.GA22317@ravnborg.org> <1551480042.1526.0@crapouillou.net>
In-Reply-To: <1551480042.1526.0@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Mar 2019 23:23:33 +0100
Message-ID: <CACRpkdbtnuHC6Ob-soewxKbH_AR+ijg-zkc_w2ZTBg8qBPkoZw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: Add doc for the ingenic-drm driver
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-mips@vger.kernel.org,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 11:41 PM Paul Cercueil <paul@crapouillou.net> wrote:

> I also have a board with a "smart" panel (ili9331)
> that needs a special configuration in the IP. There is nothing in
> the drm_panel interface that tells me what mode I should use for what
> panel...

Is the ILI9331 anything similar to ILI9322 that I have a driver
for in drivers/gpu/drm/panel/panel-ilitek-ili9322.c?
I was hoping they would be similar and we =E1=BA=83ould be able
to just reuse that driver for more of them but I might be
mistaken.

Yours,
Linus Walleij
