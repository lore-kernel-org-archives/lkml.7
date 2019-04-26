Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C032CC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F63206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ThFeg9+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfDZHLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:11:14 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38903 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfDZHLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:11:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id p14so1944203ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 00:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NeYeNXiQHZAi5lbF4OrYrEU5AHV7RHK83sfErcveMd8=;
        b=ThFeg9+tZ2EoGJnQRyKkvSy/1GJtBSZW2yzyjhFbMW4hBlv5rYeL2pDSZCopL5IoKk
         90au01UwY5E0frNJr/mhrFynFT+L8vpuxMdxbRX6CxBHHSzfFEClA31Utljz8nsDMNf0
         vqWf6B+U153ScsfqNLrUAquGc5KPRDJClSHWtB60KtxuMWm/3pqdfsV0tPUXI31H3sDQ
         RA5D2nmH0ZC0slXftTdIoW83yK2Qc9QR3U8WuYFqjBlvfNS2lsockuIMB0ADQI1Rvprn
         lZJMx/zKTEDuA5CLy9naEUldEgSNbsibxv2sIbG5PZ+XSMl8u4FFmT8T2liS8rl0um9h
         vmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NeYeNXiQHZAi5lbF4OrYrEU5AHV7RHK83sfErcveMd8=;
        b=IGUpVlZqu5OYqVoIgZQtov/8VsuZhEWwUqbgT3Q2NClAMyhaTKtP1KJBQMWiyL3hPZ
         gtPTR5QeEARMsYfEBR+qrKhJUXLOuCC58JPEhRuNQ9ALRx3PKKZx7w7p61vWCk4mT1Va
         G1cESIn0tZSF1WWbMucxKODbcoZjefRoaypS1wqb9PUXu0KaMfaUqBmLl4OVqpH6YRm+
         LVOu24WohEFIFH58NhYusfrRbJcIvznxM3JFzkc2seAsmB5cgspr4cqrIBRpLV0ARpd8
         uCmfDvy6Ca20/iMvX5hWbNuEQ5aZ5jknvdr7yTyPZWFKmKyYgaengjS0xlHAHnjZkRcg
         vDJg==
X-Gm-Message-State: APjAAAVHYIogwuG//+UlqcZqvK6fzXAIb0Xje19KVtlC+9iKLAUzvv+i
        vxJSUicJpE4Lc39vhAZHtojdYMR6J43m62bcBRWCyw==
X-Google-Smtp-Source: APXvYqw3+6pTBKzyM8aKDGTGpIZDOG8t11b4X60RIp3iOuNoSAacPaE8eLFWb2NzvKOpQSzqT2a3WhMq1Seiw2ne3m8=
X-Received: by 2002:a2e:8703:: with SMTP id m3mr22735299lji.107.1556262671816;
 Fri, 26 Apr 2019 00:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <1556247378-3335-1-git-send-email-kyarlagadda@nvidia.com> <1556247378-3335-2-git-send-email-kyarlagadda@nvidia.com>
In-Reply-To: <1556247378-3335-2-git-send-email-kyarlagadda@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Apr 2019 09:11:00 +0200
Message-ID: <CACRpkdbnzB690mPncGGe2fKMBx3kDN+RPBEbowBsvsXO23gOGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: tegra: Add Tegra194 pinmux driver
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Stephen Warren <swarren@wwwdotorg.org>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>,
        Suresh Mangipudi <smangipudi@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>, vidyas@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 4:56 AM Krishna Yarlagadda
<kyarlagadda@nvidia.com> wrote:

> Tegra194 has PCIE L5 rst and clkreq pins which need to be controlled
> dynamically at runtime. This driver supports change pinmux for these
> pins. Pinmux for rest of the pins is set statically by bootloader and
> will not be changed by this driver
>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Signed-off-by: Suresh Mangipudi <smangipudi@nvidia.com>

Paging Stephen Warren about this patch, an ACK from Thierry would
be nice too.

Yours,
Linus Walleij
