Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35393C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030BE2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PfeZNk7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKOTFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 14:05:36 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39764 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfKOTFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 14:05:35 -0500
Received: by mail-pg1-f194.google.com with SMTP id 29so6423028pgm.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 11:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=0Pnb0NA7Tx6DFC7PbIhovx3K0Sfnn+qJAuCVQTaXi9E=;
        b=PfeZNk7CeSmSNfnT9CHk6vAQBgtY5rGXBFZlP4L/f06RLPDYqNLo9u+vZ6mhxHVUK1
         NYRPiOvOXBluZ2yE9vJAIFstlLd0kSXJhmSR/KvFL2+PK61CjWZhEtTqiggZHLVfXRYH
         gEUcUCGvD/v79z5GC4uhQae132EfISMl3NHgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=0Pnb0NA7Tx6DFC7PbIhovx3K0Sfnn+qJAuCVQTaXi9E=;
        b=DWDCELx7funGQ41F6pabumO+GKHJt0CN4CQeM9L4ZQxK/FcLn5SNfWMLyRsvbScD7s
         E0aRW1d+ugKhpOHzz0pKEYo9+H8rcO5rJtAyB78zkNwmNHgZNp15XgR8PMaAOG9CQEde
         f5hYcldY9LBEbRl4pPc5FWD3VBAg0l5tCCR3P+fVkshD4GnIbj4uzx0UbMjDSATnXhnz
         qVwZLXSX+zt5+22B+PqWdykYm1aNifDdoniDSm2IXP7hzKQ7UzlfMu3GNuVdzJMH/Me/
         Yg6daleRWJ0DeBLbj6OZHn5zMQKnygpDzsA39mrwKxOqk82GG3NHzThpZ4ssXVgBKTgP
         6kfg==
X-Gm-Message-State: APjAAAWINS4HahRH5P2O8w/b0yH7lm0GLDIvZjZEcknYZ2MnDGyP/Ykz
        9ZXOpa/qGRr0+JEbjfltIJ9FqA==
X-Google-Smtp-Source: APXvYqy5atNmDpoOOLCF9LPSi3uw0uAw5QforyNzU4sX7IAFe9ofjoq19R5TNbvQFLHgD/rB84Otgw==
X-Received: by 2002:a62:7b09:: with SMTP id w9mr19431377pfc.8.1573844733401;
        Fri, 15 Nov 2019 11:05:33 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y3sm10938282pgl.78.2019.11.15.11.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 11:05:32 -0800 (PST)
Message-ID: <5dcef6fc.1c69fb81.27c1a.ee1e@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573756521-27373-8-git-send-email-ilina@codeaurora.org>
References: <1573756521-27373-1-git-send-email-ilina@codeaurora.org> <1573756521-27373-8-git-send-email-ilina@codeaurora.org>
Cc:     evgreen@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mkshah@codeaurora.org,
        linux-gpio@vger.kernel.org, agross@kernel.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
To:     Lina Iyer <ilina@codeaurora.org>, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, maz@kernel.org
Subject: Re: [PATCH 07/12] drivers: irqchip: pdc: Add irqchip set/get state calls
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 15 Nov 2019 11:05:31 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-11-14 10:35:16)
> From: Maulik Shah <mkshah@codeaurora.org>
>=20
> Add irqchip calls to set/get interrupt state from the parent interrupt
> controller. When GPIOs are renabled as interrupt lines, it is desirable
> to clear the interrupt state at the GIC. This avoids any unwanted
> interrupt as a result of stale pending state recorded when the line was
> used as a GPIO.
>=20
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> [updated commit text, rearranged code]
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

