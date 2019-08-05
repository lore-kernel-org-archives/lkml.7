Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74C2C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714C72147A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c2BoZNgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbfHEUo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 16:44:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37955 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbfHEUo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 16:44:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id z14so3095557pga.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 13:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=bj7zS+5ESvLmxF+hCSb0WholmGBt02Cbj+QBiyCHnHw=;
        b=c2BoZNgMELvlieKdVEySODuXt4f0sLFkBtG+dz/EtVG3CdMYbFMu3PKPPVEkgn+TMc
         iye7plm3xdGzqUMeMP3i2x1DrNDSXOOIfCNZmjL+qod0Ggjo6dE4E1zqOhjaMGHp3I6P
         qnj+JsiyjvMUC5/Z+HWMIsXIzIO+PJw8GMfds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=bj7zS+5ESvLmxF+hCSb0WholmGBt02Cbj+QBiyCHnHw=;
        b=KA0wEZblgWZpy8jSjWz7xplK+ydouaHHKXWrvOBw5bSLsJNZbX/BMlllhFja7W8cD4
         3pwmGw8bwIvJ/QFFmd6p9YYpet3DHuhwh2GsiJ6eUPH0Ctj1TiSQ9DOwf21sel7rvsIi
         yfvb6kbRpqHcsKOujmjNHDydNO9Aj/lYhifk67KdjqvLxkVZYS0qDDLk/RLgLnszZoCR
         K44BrcntU/Q4ISaSgIcVi5hTYAzL2p8qMz3PWbVNW2TLq7eNgHOvKlbO93Mn47BWwf6D
         QeCAAC9s1WpXNzH/ThvcPomWPk8bVp8P5Qms6lchoHuZLLsoNcDg8gXgZinmvP1urxxU
         XRbQ==
X-Gm-Message-State: APjAAAWMplTy8514vEzdibPNCzuq4VjOpBW5EhTAxJ2jUbNsAmr/Vjzm
        IOWSVqelWjrB+Txnz85VyGGo4lMFCyI=
X-Google-Smtp-Source: APXvYqyfNFuU/i8eXH0YuogTqa8x2Q+WsEmJ0KM8xNtPnb3wcODFnnR8cpj7X6ynze03uoJe3Yd2nw==
X-Received: by 2002:a63:510e:: with SMTP id f14mr58334344pgb.422.1565037897061;
        Mon, 05 Aug 2019 13:44:57 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j12sm76563725pff.4.2019.08.05.13.44.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 13:44:56 -0700 (PDT)
Message-ID: <5d489548.1c69fb81.44fd6.ab81@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAGb2v65njFXzLM_BvkDsZEzxEfkp_FFmFrS+1Ww9ZVen3iwy9g@mail.gmail.com>
References: <20190730181557.90391-1-swboyd@chromium.org> <20190730181557.90391-3-swboyd@chromium.org> <CAGb2v65njFXzLM_BvkDsZEzxEfkp_FFmFrS+1Ww9ZVen3iwy9g@mail.gmail.com>
Subject: Re: [PATCH v6 02/57] bus: sunxi-rsb: Remove dev_err() usage after platform_get_irq()
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
User-Agent: alot/0.8.1
Date:   Mon, 05 Aug 2019 13:44:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2019-08-04 20:35:05)
> On Wed, Jul 31, 2019 at 2:16 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> >
> > Please apply directly to subsystem trees
>=20
> I didn't follow this series. Is this for -fixes or -next?
>=20

It's for -next. Sorry for not including a link to the patch that
introduces the platform_get_irq() changes. You can see it here:

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/comm=
it/?h=3Ddriver-core-next&id=3D7723f4c5ecdb8d832f049f8483beb0d1081cedf6

