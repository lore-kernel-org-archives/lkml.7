Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E26C00306
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 00:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFB620828
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 00:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h1SJ6VKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391291AbfIFAL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 20:11:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40208 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389563AbfIFAL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 20:11:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id x127so3021917pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 17:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:to:from:cc:subject:user-agent:date;
        bh=EG+/MUED2UsQmYwWnl+m4YuOSd+iLXFMVT1+SFmuY6c=;
        b=h1SJ6VKq8ziz5RC8etjR71RJ2+HMI7S05F2FIAd7599+cB/Mu/hr9Kxmr5ObJQEysF
         tP1VrtlZsu8SVBbc7DfKxTvbsJiV+dsJCVpAhxy9MrNEsfk23LnNZAqiH4/AhRv1hARF
         oDPuwAv77pmBKFQZs31UH2NVp7+GP1g+mAV8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:to:from:cc:subject
         :user-agent:date;
        bh=EG+/MUED2UsQmYwWnl+m4YuOSd+iLXFMVT1+SFmuY6c=;
        b=cmaltY9+inW91RvAtw2XIz2mSl0vCrMHKSB6L9toUSVkGnLvwuzeNhpdubo4hJfFEZ
         vWKCApz3Q/GCIPz9TayDQkWmuuuOu/GT8vHOwIiXbHwvQFODdilTSiJ861ic6tj0Jsiu
         7tptTcRTCXRlH4XSrqc3faBJewQDGdmM05SHwPy5OAduSmOxvSu8ItUxyiWc0KuGl64e
         njMa5C1Levnt52XWYmE1nkg22c7SzJwX1RV1NPpftWmSsnLnQlAoLSsCsw2M7GSkCgzg
         oC2f+LND6x3PIsfVUPp0rx8Npk00MnibGffgnViF7HRLx18otbQggy21mfykUj1l0smM
         8ySQ==
X-Gm-Message-State: APjAAAWYBhMq64W/hbF2AiiHBt/KcdvP3H8TUCGc2d7buAkHHfDW9QD2
        dfa5UF5Z9TAGTmMo3Uc5Q4gHJg==
X-Google-Smtp-Source: APXvYqwLhj+gPLsunu19pmG77d0/jojdsmDQ/S673OcY6GTlSwQiF/q78gZDnO+Xepr37qc8Kslp7g==
X-Received: by 2002:a62:1d8a:: with SMTP id d132mr7213725pfd.187.1567728686428;
        Thu, 05 Sep 2019 17:11:26 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u9sm3106745pjb.4.2019.09.05.17.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 17:11:26 -0700 (PDT)
Message-ID: <5d71a42e.1c69fb81.b56a6.852e@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190829181203.2660-10-ilina@codeaurora.org>
References: <20190829181203.2660-1-ilina@codeaurora.org> <20190829181203.2660-10-ilina@codeaurora.org>
To:     Lina Iyer <ilina@codeaurora.org>, evgreen@chromium.org,
        linus.walleij@linaro.org, marc.zyngier@arm.com
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, mkshah@codeaurora.org,
        linux-gpio@vger.kernel.org, rnayak@codeaurora.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH RFC 09/14] drivers: pinctrl: msm: fix use of deprecated gpiolib APIs
User-Agent: alot/0.8.1
Date:   Thu, 05 Sep 2019 17:11:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject is misleading. It's not fixing anything, just moving away
from deprecated to "supported" APIs.

Quoting Lina Iyer (2019-08-29 11:11:58)
> Replace gpiochip_irqchip_add() and gpiochip_set_chained_irqchip() calls
> by populating the gpio_irq_chip data structures instead.
>=20
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
