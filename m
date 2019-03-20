Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2952DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C892184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U92vhStm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfCTNLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:11:19 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:47077 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfCTNLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:11:19 -0400
Received: by mail-wr1-f44.google.com with SMTP id o1so2667895wrs.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6tf1wTzSIXlJeGRVIG2wXoLRG/xIF0PpDlp69YcY3EU=;
        b=U92vhStmXMxiBxLkRoGENdsJLTvY4kbtg2GYeDFaJpQt4Mm/BS3BskVlJ052c1axab
         80kv71slsOpI7ERzsWqhmtkMmfEGRJlDT8PTgrTPw1nwa6YSPYZYclE4Um7MmCwFp3ea
         BUK65avspKYuMgoPoDRdhxRIUAVJtxELc/27YFPsxYxy0U0thV6BhdhEQgyIOtIDB5tY
         HCqE6xI6xY1hg1tOd/QaO5qoN1WmYLpXq7a4YImaqvdOUo7Ot9wbm6tDnzz4mYOjnae0
         TmPLrXHSRZrjpBJqoA/zG56mdAVSFqw/pVhdaucVZZVPtuNs1IYnC7g3wpDzngETy30Y
         U0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6tf1wTzSIXlJeGRVIG2wXoLRG/xIF0PpDlp69YcY3EU=;
        b=hARwJEiT9ShRKNSLDKSmtkwSwFjmmkCUeTz0iEm0C2/yDbNKb7F9BIzQhhUH/G701p
         0YzuDnbg3XN0pKNNyokzOqori/ztCThm582aUnWuZWcub0Jy7k2wDlMDJUA2MQsX9YHo
         7e87wqOzl1un2FCd7LP2yWmC15JLMn6DEGmxjaSN9vwGw9sg59UotBlsa51NQBCkT7gA
         XlJHrPY1UN/XjesiBj8VMckmIGKwr2eTKBPBAVOPyvCIc0YNNj6xHaT2Jd/Xw2fH8bgL
         nSbwrafhmSbRvOVlOg3utpc6PEUrfo+QuDeQewxPp6dk57B3xLEbEaC44gMhH1Bhik+p
         kdLQ==
X-Gm-Message-State: APjAAAXRjjJZvRoP/lPIJZ8epJMaA06X/gyyyQkmNIfMrZUB/nTga1aA
        Yfo5TQ8tE2ubSDmQAKmKgkgIeg==
X-Google-Smtp-Source: APXvYqzzzK8ROP8dawupPjgqRQHLBtVR/Ev29X6SBjWqbBCmtldnBBbef6yfkVHwN46DUnY2v56AFw==
X-Received: by 2002:adf:eac9:: with SMTP id o9mr10598101wrn.85.1553087476973;
        Wed, 20 Mar 2019 06:11:16 -0700 (PDT)
Received: from dell ([2.31.167.140])
        by smtp.gmail.com with ESMTPSA id r63sm3011859wmr.32.2019.03.20.06.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:11:16 -0700 (PDT)
Date:   Wed, 20 Mar 2019 13:11:14 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Florian Vaussard <florian.vaussard@epfl.ch>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCHv2] mfd: twl6040: Fix device init errors for ACCCTL
 register
Message-ID: <20190320131114.GQ4731@dell>
References: <20190214160345.353-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190214160345.353-1-tony@atomide.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019, Tony Lindgren wrote:

> I noticed that we can get a -EREMOTEIO errors on at least omap4 duovero:
> 
> twl6040 0-004b: Failed to write 2d = 19: -121
> 
> And then any following register access will produce errors.
> 
> There 2d offset above is register ACCCTL that gets written on twl6040
> powerup. With error checking added to the related regcache_sync() call,
> the -EREMOTEIO error is reproducable on twl6040 powerup at least
> duovero.
> 
> To fix the error, we need to wait until twl6040 is accessible after the
> powerup. Based on tests on omap4 duovero, we need to wait over 8ms after
> powerup before register write will complete without failures. Let's also
> make sure we warn about possible errors too.
> 
> Note that we have twl6040_patch[] reg_sequence with the ACCCTL register
> configuration and regcache_sync() will write the new value to ACCCTL.
> 
> Cc: Florian Vaussard <florian.vaussard@epfl.ch>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes since v1:
> 
> - Cosmetic change to improve error message as suggested by Lee
> 
> ---
>  drivers/mfd/twl6040.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
