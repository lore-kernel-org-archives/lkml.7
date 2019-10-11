Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70744C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A45721D80
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="RvgE9Ld3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfJKN1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:27:18 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44934 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfJKN1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:27:17 -0400
Received: by mail-yw1-f68.google.com with SMTP id m13so3455334ywa.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 06:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gfuUfZlYZ9oJJ+/N0uMt9DhhQR0v6tIoqlaSGbKIW5Q=;
        b=RvgE9Ld3dkdeSZz8gPaqgtDS2qowzHQRexrjX4HVG+BcCfNR2BlabHALJqmY1Saxnc
         HE2pECbmda8Himuhffd/NA1tqR0k4XjDsOlSEKRUkwfRYV1jcg7dLhBqCsZqE0VOeJHb
         4iIJnwiS1A5mL54Igw1bUOiiglA20xIEKTF68jZ4BeiNpX1oNbVmvxoOP0RbsGVKTG02
         Lh9C9oacHynhu1RsLZBgMVUjBOkjjKbHUIcaU7LLVVidv9O9wVRz7TkwqJoORkrmduRr
         y7Np5zdZwOrk2IJfM9fIh0bw44es8W306LoVI3o+kn092f+LLQLQgK8g3eZYeG3U2Apj
         Qoow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gfuUfZlYZ9oJJ+/N0uMt9DhhQR0v6tIoqlaSGbKIW5Q=;
        b=Fs+LPhikFXRkuncL0eJIVM43uMoOeHLTnANBEI14j5NnXwjKYmEw9MXa/KyYcyAY6a
         5U7Du9rDGMgS82xEytyDXIFvv0z1WonL0uszT23myfltCDYKkBKYKNxBsaveiXC8SKP5
         leAbi3SFxxEaEocvquCX4B6kuf2FQAMIn7S22JDazB3Rlnw6Rh1BP0aZ9z8G0rI7FLQm
         qeWCzCyRZJFYBObPwro5eeP4aLgzkkkLepenmDrtQ6HQKudb54c2eWx1dnFD6zyNRS3e
         PHLuYFNvx5lIp8xaeMdcWdd5YplUkl596HUwEV4s56r6qUbahlICW3PZo/DpBFfTAKXS
         0ukQ==
X-Gm-Message-State: APjAAAU8TxBB+Ddsc/mnO6iENzI2pktsyZErH2rs7VuH5obF9z2aKZ1V
        XObG17D0ZKKi827X+vw+MszQWA==
X-Google-Smtp-Source: APXvYqxDF1UT0llbpAUs7tUd+8/Bo22/yMWIlZSCpGQIlSr+dT1MkqQR6ab3Q5CqDbLhAZxbBpAWoQ==
X-Received: by 2002:a81:a303:: with SMTP id a3mr2217302ywh.244.1570800436812;
        Fri, 11 Oct 2019 06:27:16 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id r193sm2177467ywg.38.2019.10.11.06.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 06:27:16 -0700 (PDT)
Date:   Fri, 11 Oct 2019 09:27:15 -0400
From:   Sean Paul <sean@poorly.run>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sean Paul <seanpaul@chromium.org>, kernel@collabora.com
Subject: Re: [PATCH v5 0/3] RK3288 Gamma LUT
Message-ID: <20191011132715.GO85762@art_vandelay>
References: <20191010194351.17940-1-ezequiel@collabora.com>
 <2314316.IrHOdPmtjk@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2314316.IrHOdPmtjk@diego>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 03:22:00PM +0200, Heiko Stübner wrote:
> Am Donnerstag, 10. Oktober 2019, 21:43:48 CEST schrieb Ezequiel Garcia:
> > New iteration, seems that we are finally converging.
> > 
> > For this v5, we are only doing some changes on
> > the gamma_set implementation. As a result, the code
> > is more readable. See the changelog in patch 2 for more
> > information.
> > 
> > Thanks!
> 
> on rk3288 (and rk3399+rk3328 to make sure nothing breaks)
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> 

Applied the first 2 patches to drm-misc-next for 5.5. I'll leave 3/3 for Heiko
and the rockchip tree.

Thanks to all for the reviews and testing, thanks to Ezequiel for sticking with
this to completion!

Sean

> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
