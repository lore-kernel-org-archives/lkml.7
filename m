Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC16C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7647F2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iD/GEn5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfKOStO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:49:14 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33412 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfKOStO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:49:14 -0500
Received: by mail-pf1-f196.google.com with SMTP id c184so7114797pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 10:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=C9Cj36xd1lbZSQMwVwr0IaZNtwh3zNWL2afAmoYCPyY=;
        b=iD/GEn5Livuy+b4yiVVH6UhsUI2OG3nT1mwV4ZBVP6vi7ngBjR7d2kHSHVMPUPdcZD
         BBxzvZrjsmwPS6SIfQ8SVvnqtqlStH/zk0U3YzPY5QMNs3oxFmMN30axtfmucEvu/N+c
         6Id/dSsAKReBxANrXCegz5xpuqCHitVUF0c1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=C9Cj36xd1lbZSQMwVwr0IaZNtwh3zNWL2afAmoYCPyY=;
        b=gJykxjwm6c8wuTwznPhAaFW4fWJkyJLZLI0zeH/Yp8ph1WQ3gvy9Asq1gm1741aA8C
         rWpf6JxZNf15lHLdHUrs6mOUrgUuMtfs1RYsCPF7jFAovidVIzCtSLXksaV6bC8F5XXL
         TgLlC4E+rpQ0zTMFIHjpLM0z8mMaoojz1h6tAtbSkMKwYqi+NwqxvEw40peMxwMGwIo6
         2iaM93y4L4i/w5d2ukOa4eNgyTnOAAyqyo50mDAm6U4ujlroAuTFXCJjrVvzTi298Ajj
         rFrqxpFX6qbbRvQ/0epbEdv47zu2HPVgZhFvM56mGlm0syFxq94oi3vw2M6kbd22gHfx
         aZJg==
X-Gm-Message-State: APjAAAXnPFlbI3QYnqiKZyF70YzDrhwFqANnBtU+ePE2hwuG9VSYYLzX
        Tmow0q+q6yWvZlS+W9mhGTWTxJo1KoM=
X-Google-Smtp-Source: APXvYqyqijwaOITA/iznJcJleMeC0k4J/bj6fyRiHgrrpM366SlwmOJsBSNOg/33FiUTxUDXU3BlVA==
X-Received: by 2002:aa7:9f0e:: with SMTP id g14mr19827730pfr.202.1573843753287;
        Fri, 15 Nov 2019 10:49:13 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id v14sm10822561pfe.94.2019.11.15.10.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 10:49:12 -0800 (PST)
Message-ID: <5dcef328.1c69fb81.a1a73.f6cc@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573756521-27373-4-git-send-email-ilina@codeaurora.org>
References: <1573756521-27373-1-git-send-email-ilina@codeaurora.org> <1573756521-27373-4-git-send-email-ilina@codeaurora.org>
Cc:     evgreen@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mkshah@codeaurora.org,
        linux-gpio@vger.kernel.org, agross@kernel.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
To:     Lina Iyer <ilina@codeaurora.org>, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, maz@kernel.org
Subject: Re: [PATCH 03/12] drivers: irqchip: pdc: Do not toggle IRQ_ENABLE during mask/unmask
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 15 Nov 2019 10:49:11 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-11-14 10:35:12)
> When an interrupt is to be serviced, the convention is to mask the
> interrupt at the chip and unmask after servicing the interrupt. Enabling
> and disabling the interrupt at the PDC irqchip causes an interrupt storm
> due to the way dual edge interrupts are handled in hardware.
>=20
> Skip configuring the PDC when the IRQ is masked and unmasked, instead
> use the irq_enable/irq_disable callbacks to toggle the IRQ_ENABLE
> register at the PDC. The PDC's IRQ_ENABLE register is only used during
> the monitoring mode when the system is asleep and is not needed for
> active mode detection.
>=20
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

