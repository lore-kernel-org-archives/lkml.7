Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F255C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABDA20663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iTBJsSUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfCEWm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:42:29 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37995 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfCEWm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:42:28 -0500
Received: by mail-qk1-f195.google.com with SMTP id p15so5723130qkl.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 14:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EKjd7OhS7e9M95fqLwxjqgQSz1dUrCbHUUeLgyZCb+o=;
        b=iTBJsSUULf4O/oo2E4kaZ70EHvaZcdTGfAxWd8Jgn8nddZrFJWEmwy69Jsu7Td73Be
         jKdh6m7tDANOXKD8+SR1gelpV4VokU5J0wjZ6jIDaMu92gcDSRwya8IvQ13+em+j64V4
         +aau9Ck/+/VtBuAk6cfB+TPMOJ1+6pGuC2/0AZpcjuozaLDP2HnlhJwAfloxW6aAwkI3
         O/y0fXPyW0gpVibDn4Ea9i4Pu2lKVM7MEBd5cT4MR+Xs1JoFwJ0/2gVOGk657lZO4mj6
         KI4urs03hJwA9VPCCDV/cIrGylhtOPsic8A8LhNvK1AmBuk3uHbI1sMgqPw4MHj6v4BO
         H0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EKjd7OhS7e9M95fqLwxjqgQSz1dUrCbHUUeLgyZCb+o=;
        b=W0quWOxXPSxAX1IGHBfseoIGTXrsnF8nNrwksUZJ/rfkgahWnQaZW8srUyHVS9I+Af
         2J0aIgboqEs8Gcz3fBuNsDOAuQM0HR0Mci3g9XX516YYcV+SDihzEGSi26guScn9Izso
         RPUhJ4nund8euKmTLoIjTAECf5cNjxlSUfem9Ab1Iw3YYOd/bN6ulAhmmEExIZVNQkxA
         6pJH7bPUESia0aWust92CyD2GNq9bVcBAqtFEaJNiqLn2oHsdc0jY10KqzOxoHW1dMfp
         pag1/wEjxJYZYKZo6ILVmTLNDsJjL1mfxUAw5zRtqJJfKgk6RdUMzM9TjxO2ppuRE4LR
         DrXg==
X-Gm-Message-State: APjAAAUX8sP+oocaJHGN08L5KOm94e0g2F+P5sguCAUB0LnKLrhK32gc
        XjzdtCHIULGfIoGRcJ4pxIdr5G+7Ywvdx8o+ZbHp+A==
X-Google-Smtp-Source: APXvYqzyP1gADuGrdX1JRi8jPmT6Zznpp7hQ7mlKenD9SWzAc//EG2xzWVn7GYEj6mgDf+VuHK8PaHx4y+hrimxoCHg=
X-Received: by 2002:a37:7885:: with SMTP id t127mr3377515qkc.109.1551825747787;
 Tue, 05 Mar 2019 14:42:27 -0800 (PST)
MIME-Version: 1.0
References: <20181124200628.24393-1-masneyb@onstation.org>
In-Reply-To: <20181124200628.24393-1-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Mar 2019 23:42:15 +0100
Message-ID: <CACRpkdYqxUJKZGHGX0qPVaSVW4vzHYBMp-FARA2uP85W9AX5wA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: drm/panel: simple: add lg,acx467akm-7 panel
To:     Brian Masney <masneyb@onstation.org>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 9:06 PM Brian Masney <masneyb@onstation.org> wrote:

> Add binding for the LG ACX467AKM-7 4.95" 1080=C3=971920 LCD panel that is
> found on the LG Nexus 5 (hammerhead) phone. This appears to be a JDI
> panel based on some Internet searches, however a specific model number
> could not be found. I disassembled an old Nexus 5 with a broken
> screen and the LG part number is the only model number present on the
> back of the panel, so I think that is probably the best ID to use.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Tell me if you need me to merge this to the DRM misc tree.

Yours,
Linus Walleij
