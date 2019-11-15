Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD913C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E7520732
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CUSxb6sB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKOTE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 14:04:57 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42295 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfKOTE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 14:04:57 -0500
Received: by mail-pl1-f193.google.com with SMTP id j12so5277525plt.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 11:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=chB2lQnb1vKf6uRpoFg4TNMaaJ55sC12hmBK3aLqszk=;
        b=CUSxb6sBP0tmM7Gz09I+t2pSkfmXJJ5uYumzrQWDVLlGUYjIVifbUzC5RHb10KDmfi
         DwX59hSZ6iHXfAX0ex2CuQCpUCVOjzdjGPDPWg0aqAu4DJhSPmY1C1PjtzJPAj0fsVti
         otIJXEuw3oRwmbk4WtqJcwQWAVhrvdO5wkShA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=chB2lQnb1vKf6uRpoFg4TNMaaJ55sC12hmBK3aLqszk=;
        b=ZK5z2KJrFHck+aQcAHkXphlPRPzaEVaAsY+Yot0aXZk/F2kTpG2SBGRETkW7lTIopp
         sUm99fJenZsu2DUy94gdvyAo0XvKt9qLliqIDtXZRHhzmERYrerBbp4Gy8/a9IdNGTpU
         MHSXgUMnhxZCkaDtcje7ZPpjOMV2gk+juHOCang5CZKKalQUabMN53riVcjEzrMlQalH
         191oN4Px+7sACNWmeTrTC6NQrmWz1n6o1SCvZZx7siS06XTupe6y2y0Y+KTbtOrje6aM
         qwUKHtwDkaOvKTUZPg2GdatHCDtK6+Kqhjhc+CScrtgoD2rIunldDDNMI82atWcTewBv
         ZYNA==
X-Gm-Message-State: APjAAAXxPpZ3bc3Wo775cwSZ6sepb+YmIBSpbTjFVS0uR7ilHu+E0Rqe
        uUiAV4Ft7V/XA0X4uwH2lsMXWg==
X-Google-Smtp-Source: APXvYqwwiiczI4GFg2Zuzkg82xa0Gdo+f0li8XiYNhq16d/H3SafeKg+SOMzc7wQ6fyn3LNnUKVnEg==
X-Received: by 2002:a17:90a:f0c8:: with SMTP id fa8mr10937962pjb.90.1573844696718;
        Fri, 15 Nov 2019 11:04:56 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id v23sm10902782pfm.175.2019.11.15.11.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 11:04:56 -0800 (PST)
Message-ID: <5dcef6d8.1c69fb81.c72c8.050f@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573756521-27373-7-git-send-email-ilina@codeaurora.org>
References: <1573756521-27373-1-git-send-email-ilina@codeaurora.org> <1573756521-27373-7-git-send-email-ilina@codeaurora.org>
Cc:     evgreen@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mkshah@codeaurora.org,
        linux-gpio@vger.kernel.org, agross@kernel.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
To:     Lina Iyer <ilina@codeaurora.org>, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, maz@kernel.org
Subject: Re: [PATCH 06/12] genirq: Introduce irq_chip_get/set_parent_state calls
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 15 Nov 2019 11:04:55 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-11-14 10:35:15)
> From: Maulik Shah <mkshah@codeaurora.org>
>=20
> On certain QTI chipsets some GPIOs are direct-connect interrupts to the
> GIC to be used as regular interrupt lines. When the GPIOs are not used
> for interrupt generation the interrupt line is disabled. But disabling
> the interrupt at GIC does not prevent the interrupt to be reported as
> pending at GIC_ISPEND. Later, when drivers call enable_irq() on the
> interrupt, an unwanted interrupt occurs.
>=20
> Introduce get and set methods for irqchip's parent to clear it's pending
> irq state. This then can be invoked by the GPIO interrupt controller on
> the parents in it hierarchy to clear the interrupt before enabling the
> interrupt.
>=20
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> [updated commit text and minor code fixes]
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

