Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA438C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D996206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O7rGKw0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbfDBGaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:30:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45173 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbfDBGaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:30:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id e24so5812340pfi.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 23:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SOglYRPih9EpLa0LiX9DsS4FjH8isJrElh588t5zvOU=;
        b=O7rGKw0IHEywHPtomwd5hzuuR9JV3j07ljakH2zv2vuXkaWSxINio71rUSRm9pYuHE
         0UJtjcemLcHAclU5k5oeKrN8fkOC7x9aAHpJWiy5WPgr5klz+OfqGV1A7ko9Uqy4VDSm
         LyVA2p7EKG6Nkqx/HnoxZ2ig/6u1v/Vq434icc7k8o2iPDvO8rG6Hj3eDDzfHzlinnkO
         0doEjI6zw1Vul6xH0wHqSWjrQJTI8K0ZznYfOjAazFLGSTWnEjXZO0vRvdYKT2pqAv4s
         bZM1n1JBF+bcO+KujH+P8APuzsch+YMEESmi6AVzSUNkkXl/rofQ1EkE/5wlLfyxP9vc
         VPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SOglYRPih9EpLa0LiX9DsS4FjH8isJrElh588t5zvOU=;
        b=keb57/IW558QD9WIFS2wGCYr+xbXxdiX6Nq4JJEADkgnJgZaErY+xqzgMC4SxVHoIG
         Y6quSB0kA5PIbuaJ/XcLwFR8GIxv5NGS/J1Xo5JBocepTxmtDGkqg4zRuSXYMlHGJbid
         05Vn/phwK6BC0lqqAZYzaSbprbW1FGnWyxDG1p4q1TaKrmc6y3EmoIhDmGfIXqnL2xvi
         hii0DanZsozMb4wWpFzUtw9aGdz0rUfwIAtytO/wVK4o3aj612IGT7GH71xKOMDhScK6
         e/NqbqaXcma/5Y6nsT5HiMMGgiKrvXn78gsspUtu8g91FQSImsHvlQAD2OfqwTvrbu8u
         JOWQ==
X-Gm-Message-State: APjAAAWCJQkllZ67hIK4ONKaj9qnOBW9LkHAYq+qUCMpQ2AzKTgT2kU7
        QO1z0G+cmVk0XIL1ntMCVTYf/Q==
X-Google-Smtp-Source: APXvYqxZTEnzj8GMRHL+Muvlbh1nnrK7fezvHY68Hb4Xn6u7t9koLRHh4PxwSMJY9Welya3cF3J7pw==
X-Received: by 2002:a63:ad4b:: with SMTP id y11mr51716240pgo.405.1554186621868;
        Mon, 01 Apr 2019 23:30:21 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id z6sm20428029pgo.31.2019.04.01.23.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 23:30:20 -0700 (PDT)
Date:   Tue, 2 Apr 2019 07:30:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tony Xie <tony.xie@rock-chips.com>
Cc:     heiko@sntech.de, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v7 1/6] mfd: rk808: remove the id_table
Message-ID: <20190402063011.GY4187@dell>
References: <20190102102002.29245-1-tony.xie@rock-chips.com>
 <20190102102002.29245-2-tony.xie@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190102102002.29245-2-tony.xie@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jan 2019, Tony Xie wrote:

> Remove the id_table because it's not used.
> 
> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
> ---
>  drivers/mfd/rk808.c | 9 ---------
>  1 file changed, 9 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
