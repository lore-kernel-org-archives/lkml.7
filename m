Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3440CC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE03B20B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PDmNZgbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbfITWGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 18:06:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38795 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfITWGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 18:06:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id x10so4588669pgi.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 15:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=keJKsM9t+Xigd272OZzAyt226ZPdGo/jAWLvUfQ5wNg=;
        b=PDmNZgbiTd6S/mK/lf1xKNhWO0cvcN5mV/7OrKAcwgswsVjtZO/yP5Rxa4WR8ULprf
         9LYMu/N7i83y68aLVXTkYKt6FWU+ZXTvxSkjGQiOuG84tTbEugIBbmhdeGSBXJZl8Ln2
         /AGFgzojhIFiHJ98HXwuAteqHhtnP4WJiKFZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=keJKsM9t+Xigd272OZzAyt226ZPdGo/jAWLvUfQ5wNg=;
        b=s57+MwIrPGuferEjZRaGOI3Qju/9mFl2Xnq4iTDY7ZiteFoDnE9mg6CFWpN8aFD1Cp
         54RltHErgEh8qx+tPxx3HhsUgFtH400Uouz7daVqkIr5DG1qIFTVeTNlvr+oWYEJSM0C
         sYBuDgKlKPlewqrQOKoZ0yXa/U8PqUpYusZleZWxDE0tcj/Dxg1ufNSJUL/72PB61D8v
         aGm6aVQ/NMlIOkKeSGQtsSCLCpHMV3cYb9CssPjHm3hnqKUQFX0cFhmKakUXhCyyCGHj
         LhoEougSqQjyNx+h5WtA6Mbms68S2ixJWjpCuSs7L3w1XWjFKJJIn6x+VfRR2FCVvzD8
         6+PA==
X-Gm-Message-State: APjAAAWD7tGoYAr7NbLW9pIHrGBEFuo2l0tV+psODpRAPydjW1yAJ2bG
        6HU9UBg54N6tUABz3QVNhGE1AA==
X-Google-Smtp-Source: APXvYqzqp81x+edwioSnkLtQmLPvjwAP5YqR7sWHghyWn8edm5LRXIdWACjo8diBzbx3My46M/XTdw==
X-Received: by 2002:a17:90a:3d08:: with SMTP id h8mr7295943pjc.12.1569017212156;
        Fri, 20 Sep 2019 15:06:52 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w65sm3624680pfb.106.2019.09.20.15.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 15:06:51 -0700 (PDT)
Message-ID: <5d854d7b.1c69fb81.8a4b3.9784@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <bab194b89c269f4ab47fecf8292455476fdef604.1569015835.git.amit.kucheria@linaro.org>
References: <cover.1569015835.git.amit.kucheria@linaro.org> <bab194b89c269f4ab47fecf8292455476fdef604.1569015835.git.amit.kucheria@linaro.org>
Cc:     linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        masneyb@onstation.org
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v4 15/15] drivers: thermal: tsens: Add interrupt support
User-Agent: alot/0.8.1
Date:   Fri, 20 Sep 2019 15:06:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-09-20 14:52:30)
> Depending on the IP version, TSENS supports upper, lower and critical
> threshold interrupts. We only add support for upper and lower threshold
> interrupts for now.
>=20
> TSENSv2 has an irq [status|clear|mask] bit tuple for each sensor while
> earlier versions only have a single bit per sensor to denote status and
> clear. These differences are handled transparently by the interrupt
> handler. At each interrupt, we reprogram the new upper and lower threshold
> in the .set_trip callback.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

