Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F81EC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBA32072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MJ2Vf728"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKOSsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:48:51 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45285 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfKOSsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:48:50 -0500
Received: by mail-pg1-f195.google.com with SMTP id k1so5093212pgg.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 10:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=fmszmsa19doMDiKVkd5JyjEU2EGslIacVXAuEqSrae8=;
        b=MJ2Vf728p+IDQNuwMyN+qBbVI4AXW+zK1iJOm+FRbwoS7HdhDVqUq9ABoFNp9GHfv1
         +w6YXWJM4nwTjAD7AuZ6fu5mqIU+7o5jh9j+jy/TQduvLgQeHCwDgSeMfTxXlq79hKWH
         vlfF83jP9VXR0ao9aRPL6TBrqTLUtSrSX9izA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=fmszmsa19doMDiKVkd5JyjEU2EGslIacVXAuEqSrae8=;
        b=AMuEU9FceSVqr6I2s/ye4mUXsSVvLrLbdal2QzmI07bnJztjrUY55+NCk81YU2dS7W
         GSOHCbih/rLP8gdekIchRb2gquerXHHkhY8HoYYKwo38m3IfN/zanNfLD30gWgDQqN33
         HgN2wJgTImA28QxWJiQxZQQwH8N9plH3xNwmF0v98bW6KwN6P6dTiNP7AMzoZCyvc45P
         L8Cq+VpD7mVbcLEZju2Ajsscg/u6m/JbrFUqUjxogMiAIbbpdsl8KawNePWuOtI+jbom
         5QC6imf3MTHD5CEtgLiy9Kyhn5vdT0uWfZTktMwNHvvtUl/n85Ng49IGcJ8cUanmmxv0
         pl9w==
X-Gm-Message-State: APjAAAWo51GYkWoD1NddlxSs0Qzq/3qCxxx6IitMsNsPmyZjXoJI7os3
        HTO+PVuPlhbCeFXG/1pkJ1rT0w==
X-Google-Smtp-Source: APXvYqw6HSHHsj7mgPXycNxOL2uo40yDdeVwbGg5kQPzgO7awllnUIimHBetpe8MbKVK5Gxm3+WLjQ==
X-Received: by 2002:a63:5508:: with SMTP id j8mr17243237pgb.97.1573843729530;
        Fri, 15 Nov 2019 10:48:49 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k6sm8741468pfi.119.2019.11.15.10.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 10:48:49 -0800 (PST)
Message-ID: <5dcef311.1c69fb81.f78a4.b0ee@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573756521-27373-3-git-send-email-ilina@codeaurora.org>
References: <1573756521-27373-1-git-send-email-ilina@codeaurora.org> <1573756521-27373-3-git-send-email-ilina@codeaurora.org>
Cc:     evgreen@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mkshah@codeaurora.org,
        linux-gpio@vger.kernel.org, agross@kernel.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
To:     Lina Iyer <ilina@codeaurora.org>, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, maz@kernel.org
Subject: Re: [PATCH 02/12] drivers: irqchip: qcom-pdc: update max PDC interrupts
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 15 Nov 2019 10:48:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-11-14 10:35:11)
> Newer SoCs have increased the number of interrupts routed to the PDC
> interrupt controller. Update the definition of max PDC interrupts.
>=20
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

