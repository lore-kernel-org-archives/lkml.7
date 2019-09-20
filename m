Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9F8C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD68208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iUIHUA5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfITWWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 18:22:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35798 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbfITWWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 18:22:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so5465736pfw.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 15:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=zMEVwMQIjSge+4CoDp11o2H/9Xe/s7giDkUmmKdDia8=;
        b=iUIHUA5tCSNLMsbTR636d6++V6Ldfb4Kw4P9wBs3jkwZTfEQef56SWC4G5SKAuFzHj
         WxHLyQYE3Ez/+Jl96Uu8C5D/ehXscbnN7ziH+C2xQH4Sv5GTPoTbqmzDyTnbI8kIxeKP
         Fwfy+0N6QSVH1g+Nq0XLjUVIiC/fM03MsdOWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=zMEVwMQIjSge+4CoDp11o2H/9Xe/s7giDkUmmKdDia8=;
        b=VYec38aA5oWZqYReGcj9ZtZt6eN43rOahkJ0nTurfwZHLGYpRZ8zQlU29FuMMq3inc
         sTgbGvjMuGZBDOftSdzyHkMvpuZnick0r2nD5XyOXpATyFPwpB7ReUvtLPTUMSCuvoJv
         ltaS4bcQaa0l/jtGcQnG30DIWcMymrKQO/qO4X402vcvxSxrf9dj8Djmxyi5ElhBuzF/
         81Ypd/hINIckbHAUmttW4KXQMKNptQBbSkrzCxKh4Q4VlWXzIjQ51zvhSGeni6o8agme
         RG3MAc4cB50m84Jaymlrg7npT2c61cHCVHJyUDPTVq/yriQfyC8mZQSEjJmTy0k997kq
         yykw==
X-Gm-Message-State: APjAAAXQLewxKyMzU880A8hbgypAZKYb1jMX/TcLr7OC3lIWgUJiX2te
        CJ4hGJcDYDvNtVsHbiCeYhG8vg==
X-Google-Smtp-Source: APXvYqyVfXVWJHnAHlJ5Y45KPNtzDmS/OfzNKZXzACW95xGdq6YGER5ozME+PFQesuZquwasEHzsOw==
X-Received: by 2002:a63:550a:: with SMTP id j10mr17304975pgb.369.1569018143065;
        Fri, 20 Sep 2019 15:22:23 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j128sm5987930pfg.51.2019.09.20.15.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 15:22:22 -0700 (PDT)
Message-ID: <5d85511e.1c69fb81.98f62.dae0@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190911161557.GB30053@codeaurora.org>
References: <20190829181203.2660-1-ilina@codeaurora.org> <20190829181203.2660-3-ilina@codeaurora.org> <5d71aad9.1c69fb81.f469e.262f@mx.google.com> <20190911161557.GB30053@codeaurora.org>
Cc:     evgreen@chromium.org, linus.walleij@linaro.org,
        marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        mkshah@codeaurora.org, linux-gpio@vger.kernel.org,
        rnayak@codeaurora.org
To:     Lina Iyer <ilina@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH RFC 02/14] drivers: irqchip: pdc: Do not toggle IRQ_ENABLE during mask/unmask
User-Agent: alot/0.8.1
Date:   Fri, 20 Sep 2019 15:22:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-09-11 09:15:57)
> On Thu, Sep 05 2019 at 18:39 -0600, Stephen Boyd wrote:
> >Quoting Lina Iyer (2019-08-29 11:11:51)
> >> When an interrupt is to be serviced, the convention is to mask the
> >> interrupt at the chip and unmask after servicing the interrupt. Enabli=
ng
> >> and disabling the interrupt at the PDC irqchip causes an interrupt sto=
rm
> >> due to the way dual edge interrupts are handled in hardware.
> >>
> >> Skip configuring the PDC when the IRQ is masked and unmasked, instead
> >> use the irq_enable/irq_disable callbacks to toggle the IRQ_ENABLE
> >> register at the PDC. The PDC's IRQ_ENABLE register is only used during
> >> the monitoring mode when the system is asleep and is not needed for
> >> active mode detection.
> >
> >I think this is saying that we want to always let the line be sent
> >through the PDC to the parent irqchip, in this case GIC, so that we
> >don't get an interrupt storm for dual edge interrupts? Why does dual
> >edge interrupts cause a problem?
> >
> I am not sure about the hardware details, but the PDC designers did not
> expect enable and disable to be called whenever the interrupt is
> handled. This specially becomes a problem for dual edge interrupts which
> seems to generate a interrupt storm when enabled/disabled while handling
> the interrupt.
>=20

Ok. I just wanted to confirm that masking "doesn't matter" to the PDC
because it assumes the irqchip closer to the CPU will be able to mask it
anyway. Is that right?

