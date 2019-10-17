Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08097ECE599
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 03:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D389C20869
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 03:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xk17Q0Cj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406920AbfJQDvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 23:51:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46856 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390324AbfJQDvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 23:51:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id q24so428084plr.13;
        Wed, 16 Oct 2019 20:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1sJGZl67xoD/c56nEO23+QgN9PG/yBQl891toQm7QEw=;
        b=Xk17Q0CjeICUalfyJN5Wl6pBKli0lso0Zb9dlNhi0QP6onkV03LC3vGChCQtR4YgQV
         T0OW0HhC7zo1v5UTXFimie9z919pRNGbJZsTXgxxpxw7eVdb2F0Z3MpG2p/TgBHfF20B
         NQsRrv/4lUwdXhWn1BZEYtiLvCIZJ4Yg9qDUw0LGmkvP6MalvjTS6jWe4yZlGR26TL/e
         9A1eXmAotn4lMdwnVZ8V90dralSgsowmtNV9DL2W31KFRCYfyoFQUBAFg5qgcGrtwDKx
         uogaozmKOiI03UMrvDkhjaVOMLLGMkI/kLMVtPWFI/93VmTrBoPFqmwQ6u9ksEhN809K
         qEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1sJGZl67xoD/c56nEO23+QgN9PG/yBQl891toQm7QEw=;
        b=QTszjWJkAHue99JKamEsIvjD7b8IepQ0521lizyrWX8gXib1izz/rnRPaPK0XxpMZ8
         7u0LdimhwqHoyk2krWEa9dvDaSe1nOQXkWrlY4P7DZ7QWlSQuBNeOR3xLcwPNqBLXs4L
         FPzOzCF4/KWMteJ1c0PsMKI7fPy7B24QSt+6zHH1ey3QTT4bI/Xl8237X04icsB5kX+5
         5IUi8MZK9XXJcRRn7fnpoxH20S6a5mWRLf9oc1hr7chqdtpFXS+Bxxe5p7FTInuJuoV8
         h25fmJX+cFvvxHc7fMaVXYg5MAHSnl13Pxl9KJFCira9rfdg39HJVmpbyrGuowF32+Xc
         5A0w==
X-Gm-Message-State: APjAAAVDbn+ea3GC8SsVcMM3xxC0pAoN8wUPyb9WVOYDsHWSgpnL+eQN
        nrnLk4bBP0qz+8jFx0SCY5WcWve2
X-Google-Smtp-Source: APXvYqxXfe84OkcGaS+7EVAZ+fI63gvNDxIIWA4/ii7MEb81+jNRp7RaU2ss+kKW+cqrMGiPa20JdA==
X-Received: by 2002:a17:902:6943:: with SMTP id k3mr1764011plt.158.1571284258766;
        Wed, 16 Oct 2019 20:50:58 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id b20sm629858pff.158.2019.10.16.20.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 20:50:58 -0700 (PDT)
Subject: Re: [PATCH net 1/4] net: bcmgenet: don't set phydev->link from MAC
To:     Doug Berger <opendmb@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1571267192-16720-1-git-send-email-opendmb@gmail.com>
 <1571267192-16720-2-git-send-email-opendmb@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <886d48c2-7e21-1d53-ee75-60b6ddedc96f@gmail.com>
Date:   Wed, 16 Oct 2019 20:50:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1571267192-16720-2-git-send-email-opendmb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/2019 4:06 PM, Doug Berger wrote:
> When commit 28b2e0d2cd13 ("net: phy: remove parameter new_link from
> phy_mac_interrupt()") removed the new_link parameter it set the
> phydev->link state from the MAC before invoking phy_mac_interrupt().
> 
> However, once commit 88d6272acaaa ("net: phy: avoid unneeded MDIO
> reads in genphy_read_status") was added this initialization prevents
> the proper determination of the connection parameters by the function
> genphy_read_status().
> 
> This commit removes that initialization to restore the proper
> functionality.
> 
> Fixes: 88d6272acaaa ("net: phy: avoid unneeded MDIO reads in genphy_read_status")
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
