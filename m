Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC218C5DF65
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF282075C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E/P1CSJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbfKFTLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:11:32 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38474 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732069AbfKFTLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:11:32 -0500
Received: by mail-pl1-f194.google.com with SMTP id w8so11879533plq.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 11:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:to:cc:user-agent:date;
        bh=YlU+OdXhIDKR9PfiNtBOmR4FsFlmFK64CTpMfZrq0VY=;
        b=E/P1CSJdk2lLsncbqPfDsdBx4I9NOufECjSiBJC3YmzB2mz5Yl9JXuNp0/3T3p6Qp5
         RIUD/n4denMRlG+BEjCyFRKWgPKQRQLhqC6nfhtMsWhnmetQ9oyRzufviMqaCb0ni2Gh
         Go3wWa12aWExYewJLEb/kZE3i2r8d0jrI+OZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:to:cc
         :user-agent:date;
        bh=YlU+OdXhIDKR9PfiNtBOmR4FsFlmFK64CTpMfZrq0VY=;
        b=PlcdTwqGk4MShO2TpXtdyuQ2ElcNiw9k0qYB9s+3UaREeBkHeQitefvzW6plBZs3XD
         /On75Gkxi+vd9XKhm1bm5eZxlBRz16OJuTGcxBphyvtzpR+aLH+JrOB7nQpAYfFftp1p
         t4g4t1TXDQ/JbKmMoobGCosT2Pps3DgMChUCYo+mnc+pU04PK2hkUQBHuq2udubPLtKb
         X4VUXcPFo3YkF+cdD6HGUEXPTO0UMSpRzVurX5UAdaAWoLbvFu3NcKphEjANfFJMRrS6
         ati5dhnvcYiGpsilrDV9PJ5gDhkVxLv40sGbKR2b5yb4Oe0uWFPSERcHPiewbN2cwGBz
         ZJGA==
X-Gm-Message-State: APjAAAWLM/ST27MP4t+pUEzPmi5ZhEFFWN7zm0GzoU3rs/I2cWsWv4k/
        78PTj+m72JPM7u4c/u2+OeHvkQ==
X-Google-Smtp-Source: APXvYqxZvLIwgE1Gk+D3mymUUFiEatllcgMoJq/0gW6A92R+2Jee9wMM3IxWeYZ4gYl8FQ35QpbH+g==
X-Received: by 2002:a17:902:aa02:: with SMTP id be2mr4333753plb.326.1573067491450;
        Wed, 06 Nov 2019 11:11:31 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id f35sm3739655pje.32.2019.11.06.11.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 11:11:30 -0800 (PST)
Message-ID: <5dc31ae2.1c69fb81.a3cd7.b5cd@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191106065017.22144-10-rnayak@codeaurora.org>
References: <20191106065017.22144-1-rnayak@codeaurora.org> <20191106065017.22144-10-rnayak@codeaurora.org>
Subject: Re: [PATCH v4 09/14] arm64: dts: qcom: sc7180: Add pdc interrupt controller
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        Maulik Shah <mkshah@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Wed, 06 Nov 2019 11:11:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2019-11-05 22:50:12)
> From: Maulik Shah <mkshah@codeaurora.org>
>=20
> Add pdc interrupt controller for sc7180
>=20
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

