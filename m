Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151CEC2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDA0214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X76wqWSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbfLKQ6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:58:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42722 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729524AbfLKQ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:58:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id x13so1642348plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 08:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc:user-agent:date;
        bh=nO1/D6YzLDQJru2EbIZiTMpHKIQ1x4Kj5OM8Yf3k2jA=;
        b=X76wqWSKPn8j7rqfA4HXB8cSCWi8CSmRC2ja0st603SooTirVgKPZJ5HCqmZe8CDSV
         mU2wKAJi6RWyXkcs/9dh2qYRY7CK4dak4+yAAJavfhkyihZrz2CuccNTmvgdskUIeHGD
         Vkol4s7L21nmcjHhaqOc8TUCS6R1jbOAg9czI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc
         :user-agent:date;
        bh=nO1/D6YzLDQJru2EbIZiTMpHKIQ1x4Kj5OM8Yf3k2jA=;
        b=XKPwuKVts+cfHD3nkhRdR+/Zv/+U9eDGSj2gz3ilSLaxs8qRSMfc6J8JaELRQwo/Iy
         y8m+GSI1xWE0NymDjIC5DwCvFicdSR6rVaipmyciL8ODpkXHWqd5TIKrQZ+W+hRmpXex
         XclCv8nlDU6Ngp6zBq7Aj2A6GO5/EXn0XL5K85pOSUM4hY6SWm3LKX40qF8BIxXtQkeW
         nHqcslTX2UdY90n0LUCgEnWQs/ou1pE+KfTRfvTbrXzBO/V5c9Fi4QJZZJoYiFniuwpb
         6PxGtHu83ThafySDHhtDT1R6olJHXv4Gv+ZovyUKC5SpHI3wLvJJ/EpST48UUduUpra2
         gkJA==
X-Gm-Message-State: APjAAAXDobg4S03MQ7nYHbqJOA8XJgSAuX+oh0WJ+kKfGMg8gH9Y9IQx
        cwrmiuxl7Y4G9xI8Bqs5MPOcOp0I+KY=
X-Google-Smtp-Source: APXvYqzJgsV3DYCq9QJ4kxgM5GvK71kUpfoKmzn7rSTO7KmV71ONqmrQjqh3AE2WNpSbFEXBobEjig==
X-Received: by 2002:a17:902:a615:: with SMTP id u21mr4467398plq.44.1576083510879;
        Wed, 11 Dec 2019 08:58:30 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u5sm3612263pfm.115.2019.12.11.08.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 08:58:30 -0800 (PST)
Message-ID: <5df12036.1c69fb81.bdb18.8c4f@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0101016ef3cdac32-1353f7d8-b973-4881-86ec-589d50849765-000000@us-west-2.amazonses.com>
References: <0101016ef3cdac32-1353f7d8-b973-4881-86ec-589d50849765-000000@us-west-2.amazonses.com>
Subject: Re: [PATCH 1/2] arm64: dts: sc7180: Remove additional spi chip select muxes
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Wed, 11 Dec 2019 08:58:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2019-12-10 23:12:52)
> remove the additional CS muxes that were added by default for
> spi so every board using sc7180 does not have to override it.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

