Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C336C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568D72084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQj4Avdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387868AbfCAOgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:36:23 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46868 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfCAOgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:36:23 -0500
Received: by mail-lj1-f194.google.com with SMTP id v16so20554348ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 06:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iFuRM1e0ejwb6fpxvPreeV1M5e1Ea2ARe9z2xeG6Sfg=;
        b=gQj4AvdvQmYIo4Eyqly/iG+ajrdjfn6D7rwJcbtGLk6wsGUbcq6klMmRTJNokg/566
         /1LMYoH9rP0YlySTQd4pObIQ9+t1E7fpaDOStnUSRPYaZUT4B32+YnvQaUNaoDlP7GXT
         3agjZ+qe30Nq3dPFPCR86EwckrWwnqSpIGA3iGAHWV3+k6/nD4FPM0Z/sJQBG4DcxPBx
         DCMCm6/O6LhQcZiGZ+mU3WuL1LhHHR/09xN59Njv35hYEvSZAeqc0Qq2zaLxNT/5oAaW
         GduAhPsr+/nPVZs0sONvHVr4l+0Erv9Rs+rIbQ2MNxdHUXGI+TJ5NOibjAJUbK3IajRn
         JpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iFuRM1e0ejwb6fpxvPreeV1M5e1Ea2ARe9z2xeG6Sfg=;
        b=ow3Ba5NTJFSISX3uLEkODOl+Bof6y3OSvpNxBKiZ/jaeAj5ctO3hIExgH/9Nk6c2k9
         2V9H9rvWkc9cXL23uXGB5w8N5NRif/PvHtgzXBVGZJAfC9sdeCVbdRvweNnm5TErN/vx
         MKIWW8WJ5qKM6S+Ee2+dCD3d41RLwdjAz5jYbFdcF6KVjoIt53IDM5Z0e/GMBhssnzhK
         K1Yh10d92kscoGm6EsPVAEQZIuvciyp+xd9J9GGImeH0ow/0w4IqIkz7D/m/NQFvB28d
         GrUn3+38TZcUsJZXDqPP6llYICLIamfuqXdZeLUe4xq2crzk4qLXFGziAbvRYfBqvtOe
         YgbQ==
X-Gm-Message-State: APjAAAVPw+IJm+nYXtdGuNhdWMttYssb6V3g0DdV9G8o7yEltOedLtas
        dTqpAepnL4jf9fOGa6chfmBMf4MVZiTa4LxwZR5ukutbN9g=
X-Google-Smtp-Source: APXvYqwVTvuWxuk79fAeVTUWDv7BbtZWo4Vlcj6xb0bBpVKfTRp4bpq+5OS26vEHotMnwHW9A7B3R+VUNL1xptrRnbE=
X-Received: by 2002:a2e:90cd:: with SMTP id o13mr2868528ljg.153.1551450980891;
 Fri, 01 Mar 2019 06:36:20 -0800 (PST)
MIME-Version: 1.0
References: <20190301035852.26780-1-marek.behun@nic.cz> <20190301035852.26780-6-marek.behun@nic.cz>
In-Reply-To: <20190301035852.26780-6-marek.behun@nic.cz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 1 Mar 2019 15:36:09 +0100
Message-ID: <CACRpkdYpjjpVNUXRgT=XY758FGtDYow2fvwpah37T_GjTvLauQ@mail.gmail.com>
Subject: Re: [PATCH v3 bus+gpio 5/5] dt-bindings: gpio: Document GPIOs via
 Moxtet bus
To:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Cc:     Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 4:59 AM Marek Beh=C3=BAn <marek.behun@nic.cz> wrote:

> This patch adds documentation of the device tree bindings for GPIOs
> on the devices connected via Moxtet bus.
>
> Signed-off-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> +               compatible =3D "cznic,moxtet-gpio";

Is cznic registered in
Documentation/devicetree/bindings/vendor-prefixes.txt?

Yours,
Linus Walleij
