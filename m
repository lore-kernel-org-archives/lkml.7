Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF88ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5312222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mgZQm0sR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634117AbfJROdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:33:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44345 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729584AbfJROdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:33:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id q21so4002197pfn.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 07:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=9FdeX//RORLUFpjlpqzmkWcuma9KNw3Y4e/bxxikMGs=;
        b=mgZQm0sR8WKQrmUO/Ec704rT1C8wtIciVL2b+nWpl29cgS7J33UQ+t7jNOVMR6jF+U
         HWGLTBl6M8wNDuU43rK33SZdn5y+IWVauGkxXFYBzcNcsiN5dQzXV/G31uWt17CosPZZ
         0eGrFDR6iOrxg05bdnB8FmUzVEDvTXB2AZ19c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=9FdeX//RORLUFpjlpqzmkWcuma9KNw3Y4e/bxxikMGs=;
        b=OowDFJVcQuumpUlDooWDjIDjw5SCyra9HGJ38G1m9uQjEpz9OoD1LJAcY5c1UaV4Gw
         YuZaIi9IAzUXUxF4WS/195AQKHPLhRIkSrDgQCqSdwH0g2ws/pEka6+F15Rc4NW67HiM
         l+85/IxYkrWnd8Pc4TyGMh2zvUFtrJZVau9WBaDsLhTlySpNr9XyftLil/8BwuMaSkMZ
         dQs8oe2qR0ns3Y3PEnVN8q1oJXK2gDQDlI3keyQhbWck9Y5ESbDLA8ut0WZOkjBB17Rt
         h6T+/RP0x8J/PwxMebVgiJNAdyrAzyico2q27JRaHFi9XlAEbSPCnP1qeeEVieXaomSC
         HYFg==
X-Gm-Message-State: APjAAAWlMTW7x2eHrqV5tUAfiz1dEpFiVKXMaF4d+hyojaofrFSSnF8J
        Z9IpwxBlvm045h1E4MFsxZK7mQ==
X-Google-Smtp-Source: APXvYqxSlXq4d41beIN21IYEkdivZabzNQu+TLotvUAaXFaTv2YNZH6ZxASkgzaeHk7uRZoKe62kbQ==
X-Received: by 2002:a62:685:: with SMTP id 127mr7241020pfg.227.1571409211238;
        Fri, 18 Oct 2019 07:33:31 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y22sm5468041pjn.12.2019.10.18.07.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 07:33:30 -0700 (PDT)
Message-ID: <5da9cd3a.1c69fb81.95e9.e5e2@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c9285391dbbe936d3f242bdd0d226b93@www.loen.fr>
References: <b3606e76af42f7ecf65b1bfc2a5ed30a@codeaurora.org> <20191011105010.GA29364@lakrids.cambridge.arm.com> <7910f428bd96834c15fb56262f3c10f8@codeaurora.org> <20191011143442.515659f4@why> <ac7599b30461d6a814e4f36d68bba6c2@codeaurora.org> <5da8c868.1c69fb81.ae709.97ff@mx.google.com> <c9285391dbbe936d3f242bdd0d226b93@www.loen.fr>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>, rnayak@codeaurora.org,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org>,
        linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        andrew.murray@arm.com, will@kernel.org, dave.martin@arm.com,
        linux-arm-kernel@lists.infradead.org, marc.w.gonzalez@free.fr
Subject: Re: Relax CPU features sanity checking on heterogeneous architectures
User-Agent: alot/0.8.1
Date:   Fri, 18 Oct 2019 07:33:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marc Zyngier (2019-10-18 00:20:56)
>=20
> If this SoC is anythinig like SM8150, 32bit guests will be hit and=20
> miss,
> depending on the CPU your guest runs on, or is migrated to. We need to
> either drop capabilities from the 32bit-capable CPU, or prevent the
> non-32bit capable CPU from booting if a 32bit guest has been started.
>=20
> You just have to hope that the kernel is entered at EL2, and that QC's
> "value add" has been moved somewhere else...
>=20

Ok that's good.

