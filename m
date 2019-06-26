Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1F4C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5553F20656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaqgAuFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfFZK6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 06:58:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38360 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfFZK6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:58:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id r9so1714973ljg.5;
        Wed, 26 Jun 2019 03:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vBnSNkpp1XS13FbQfXNNjthLGvaxRDnVZe4G6iUXAtU=;
        b=GaqgAuFEfvv3hBS0MaU6uk4aVJXr6o+2pG+er+XZSrXJmKaX1hSvGbNyogXUrcLE1F
         8uPyzO20cWhgn+6ogJWZGBUDgM/+hmdodS2rGfiJw+hYmHysEcAjmj6xP3Fee5JK8Emq
         loi84Jm74kjpfhji/XqX0xwnoCYYdgWSjGLQq8wzHtt2nSe0/KvZ6HHheCZpk8jL9kN5
         ePK310T6x5hfCUeiiB+CAwL2vR/E5Nd3/aRMdJydETRe0FPBo9xfRQRHMxYNWqCI5m8P
         pUZHLmizbJuiS5WGXpaGO86UWbuiqs23zbiILID8Ga3NGnYbkerHBO9gQa2OE40nmKrC
         g3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vBnSNkpp1XS13FbQfXNNjthLGvaxRDnVZe4G6iUXAtU=;
        b=cWX+3LE8slfiGr1ef79WOIbIA0KtK2eYL783MjmS4fKxc61YL5w9IG1nNWjNRgiEgp
         hMzz5xQa37pFSqD1G05ZF88viMe7OT7/1RoA/Cp+k0sq5ccV7hP1V3pCa/rOClvTNONM
         8ANK2Gcl/WkW5HAvNhU8seIvYeqbkb+FQ5ji5qZAbkM9y8oVIdleTngyPNaQcuNbLAV7
         E9vTqpSLwfVWlSRO0r6Mqmc0YusEqH3O1CtI/AUFPweGF3513dfBfSjCt9jh0BBA/gmm
         qqxr4/We5SEpZVlTSN7W+tsBd8XOsMfaXtA42VKdgAlXZQ3ah3I6wcKiWz+MTz2Dl1tz
         Jcvw==
X-Gm-Message-State: APjAAAV2vrQdKDSR2xNLb7yBcXQTkU+kSb7WOE2XQpbk1KGw2cR4Tt0c
        rZ18uF+R88dI0Rp9+tM5ve9NUZ8yIGXDxFqF5pc=
X-Google-Smtp-Source: APXvYqxgoOFc17kD7+phBGYs9B/nP1o8ns/3dGiVnoxKpmtsSjv06Im4LhGmDTJDnuu5JdispKhyHp6RMeFmjrm7eYo=
X-Received: by 2002:a2e:8650:: with SMTP id i16mr2529260ljj.178.1561546729355;
 Wed, 26 Jun 2019 03:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <1561544420-15572-1-git-send-email-robert.chiras@nxp.com> <1561544420-15572-2-git-send-email-robert.chiras@nxp.com>
In-Reply-To: <1561544420-15572-2-git-send-email-robert.chiras@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 26 Jun 2019 07:58:39 -0300
Message-ID: <CAOMZO5AKOgcRcyOyz71MyHY5VbGF2OCSdVfREwoNPrVk8rbVAA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: display: panel: Add support for
 Raydium RM67191 panel
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

On Wed, Jun 26, 2019 at 7:21 AM Robert Chiras <robert.chiras@nxp.com> wrote:
>
> Add dt-bindings documentation for Raydium RM67191 DSI panel.
>
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
