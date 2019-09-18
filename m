Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C767C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC5821E6F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568832963;
	bh=P8LV0ClyeyDYXd3s1VNazCQwVHpKFvDdTotvV6S6ukY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=paJpGW888RNXMwg+j3r0k++K0wKX7F6hLl4ZKPwIvwfWKnqpFFCT74hUrrHtY0Gso
	 OGEw7PkjtTxw3OX7NXxG/bZKQW4f/pwD/PFeaAaCC7+Mo249QIrunB5a8JUyimnji+
	 oSdjD3nJ+gko8IOWYF9S9JNCFO7Kp0xgRe5wannc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388851AbfIRS4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 14:56:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37035 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387703AbfIRS4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:56:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id f16so1213982wmb.2;
        Wed, 18 Sep 2019 11:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tfT2AOp9XkBHFWXzhz2KzyhrRjcPTDUsnhtNXKMxF1U=;
        b=KV8GL+08FblSaTlA3XXYX4ayTl+lCqp5jPNCAR7abZnckhBEGVLwkapOe5qFxyhzGG
         +Kiq2m0IuRsUTIRwHii7ssISwvnEBi+4jPBNb4slHQPjAE35eHC7+Rze9VsEYDA9Etin
         e6dNkw2BBCWFjh66qFRSAv5VF42+Uo2CdSn9XpywMQa7lvwq493RkWL6L2EGARubq8YL
         F+bKFzR5dy74LeEo7DNOw/IIrQtN7T5mD13lHUQzg3BoKp9Sp14M2GGKxI5B/KW9ua++
         IynuDxRR4aO043kWhR0HDlw/UxroNlzTROco0bLk787Uv2QoR9brFwho4j78ZvH50V4z
         cJfw==
X-Gm-Message-State: APjAAAV8b6FArQ6PaBBAWSX8TDQQ5VwTsWF9OT/p5L4ob3+wItuaaXdh
        qt5zUw83+KomEixj69JClL0=
X-Google-Smtp-Source: APXvYqzoOxgzNfe1MMgxbMeIhmDgLusjChb0lhIUYpRKTA8VU3VOhp/mJwuQwF9eTyd/n24PXKFiWQ==
X-Received: by 2002:a1c:8097:: with SMTP id b145mr4120985wmd.29.1568832959771;
        Wed, 18 Sep 2019 11:55:59 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id l10sm9883571wrh.20.2019.09.18.11.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Sep 2019 11:55:58 -0700 (PDT)
Date:   Wed, 18 Sep 2019 20:55:55 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        kgene@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v2 2/3] ARM: dts: exynos: fix too long line in memory
 device
Message-ID: <20190918185555.GB8463@kozik-lap>
References: <20190916100704.26692-1-l.luba@partner.samsung.com>
 <CGME20190916100718eucas1p1efcbabdf9dbe17a062ae83b8c19ac256@eucas1p1.samsung.com>
 <20190916100704.26692-3-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190916100704.26692-3-l.luba@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 12:07:03PM +0200, Lukasz Luba wrote:
> Small fix moving the comment to line above making sure the lines do not
> exceed 80 characters.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 3 ++-

Thanks, applied (squashed with previous).

Best regards,
Krzysztof

