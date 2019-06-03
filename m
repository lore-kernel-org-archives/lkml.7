Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83745C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587D327C9D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JnySwxG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfFCHYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 03:24:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39851 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfFCHYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 03:24:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so10827967wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 00:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6ntfRdLCd+I6+09GVECx+yr8Tcx+Tf8xlZvw6c2Yxtw=;
        b=JnySwxG8AeComsjWCZPtzks1WfiiKMFfES+2KGsgVvDO7sBNEbujRxKnusEaaYU0uW
         z1KtHAi7P1RAMiKxpuWf4DjizGH/MTltg0NHvjsci8/kJHvGus13A4FCUnpkhSc7isOc
         Mvc1SJrlMwTbdGp43iH6V69MxdKhoZR20bfoGZ0VaHTZ5aooZhvfqJa65R3RjRbKwMHX
         ipA6fzS4frednIcJP+jMCH9DNKNv8rQmBKaExIvcsKQb2C/K94+W6XGakTJByGHYybDr
         8Yd+B6rNmdPB57o3sD8G5xZdtEYTYSjDAtybvxcTbR1P7UFjA18za29nlm+iedBEnEz0
         TPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6ntfRdLCd+I6+09GVECx+yr8Tcx+Tf8xlZvw6c2Yxtw=;
        b=tQI+EAWobzwA7g6s9eVR7XUzJkULhppKOsRkBMY7pno0OVE5qbjglSmlx3gDCZJ4nk
         fqFJiwc48xJmjs/on9QPcZYfYlHOmHQtAjO3Rs1y5O88SEV+GMJg8BTzHMeDf1AWeNm4
         9bKX432CQX8XEt5kxSt/7ZG6jHLY8J/iL0kHJtqsq/0tbjHihhhf+GdnUTmmY0auoFk2
         CFEA7/p4z1GYu5hOuaDuhXST/umP0ofblwsGdCk4JLbKD5ELjeb8VHVeXRof9/aHnxjp
         QLg7XF57MKrA/zUkHzkVeWsQxILROmuoEQL6jevNZ5TvgU+/Yk2qRYPG40GKfrjHpqAA
         AKhQ==
X-Gm-Message-State: APjAAAVy+AwT24lKbHruCnQg0+3xgrOujFsOeYvJYgNsw+h/kqGOFnIa
        m9pVKIINZGndC9uxq6DM2jxRnlfQCcs=
X-Google-Smtp-Source: APXvYqwijnyKnEcwiaeCD0oLtjzz+oLNnCC2NhUhgMuXI+uYCjlywrRH1gpkeQ+dhxoRNsufQtxniQ==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr1342400wrm.218.1559546642621;
        Mon, 03 Jun 2019 00:24:02 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id 3sm10046338wmj.21.2019.06.03.00.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 00:24:02 -0700 (PDT)
Date:   Mon, 3 Jun 2019 08:24:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        tony.xie@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v8 0/5] support a new rk80x pmic-variants (rk817 and
 rk809)
Message-ID: <20190603072400.GD4797@dell>
References: <20190508143713.27954-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190508143713.27954-1-heiko@sntech.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 May 2019, Heiko Stuebner wrote:

> I've picked up and rebased Tony's patch-series for rk809 and rk817.
> From the last iteration it looks like the regulator-portion did
> fall through the cracks, the other patches seem to be sufficiently
> reviewed/acked.
> 
> The regulator-patch could either just be picked alone to the regulator-
> tree or with an Ack go through the mfd tree with the other patches.
> 
> 
> Original cover-letter + changelog follows:
> 
> Most of functions and registers of the rk817 and rk808 are the same,
> so they can share allmost all codes.
> 
> Their specifications are as follows:
>   1) The RK809 and RK809 consist of 5 DCDCs, 9 LDOs and have the same
> registers
>      for these components except dcdc5.
>   2) The dcdc5 is a boost dcdc for RK817 and is a buck for RK809.
>   3) The RK817 has one switch but The Rk809 has two.

Looks like this set is still lacking a Regulator Ack.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
