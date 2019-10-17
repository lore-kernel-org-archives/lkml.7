Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39930C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 03:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4412082C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 03:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9D62/X6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407431AbfJQDx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 23:53:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34954 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbfJQDx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 23:53:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so727999pfw.2;
        Wed, 16 Oct 2019 20:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QItfKQq2XPwc0AsXYWpmXFDLMmDCVDLYtMpQNN+hFHg=;
        b=K9D62/X6yJcleMO6/fyXNcXiFAraQ0fpcbHPzGkb6S7sWANZW3Yf1d8/UHa8bNOUAt
         4la/atl/lVodIOnVfL2SB+XFYsqAsVY77dT1LA+eVV4rJZebtDOkBiMkw8NmA2fFDn0D
         9EyaBysL7p9ihrY2EOZAZcespm+TYDoGak2jELQ6GSOC0Twt3bDlODT4CdNVn1jr17DN
         6PlP3r36A2Mrw80249GpgGpaYf2dqNXk/I3LXmZ3tFw/Y++SZvLdZaWcKMzYzmS843ji
         XdQ7XvOHCBTcHTak2PkpcniHdx+HVNc0SzRA0ASDlZ9f9BViCv8rdRWlBVd6c/sKywjO
         JmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QItfKQq2XPwc0AsXYWpmXFDLMmDCVDLYtMpQNN+hFHg=;
        b=f4H7mR+C/RZ2GFF4USBj/quf/W1r83sGSTyl6QW86ojFE5VcJgGtUxoVaWDyGij+qD
         H3rXsn958H+nMWfdHXCH28JnFYoiCvXAC0LN0XXzYZkptqDmlkz2xoGB7GfEgrdTKgq4
         wszWHUtkuKBAyAp7jog0ZlrzKFvrypjx37fur/SRlTRNIjrjNxVyWet8UsGNJNUJqQBG
         ejxPq8cUUxM7trZWCeWxqJcKGZ3NOewkMVnULQB53FbxjCn0oEIhbIezS6EIyjHJhUmW
         k/CwYeAqOVOBtm40l8Z6Exic9pI1x6+mP+W9aNERd+AuRGYl+SqBdc4vGD33ZqWmGsD4
         j7rg==
X-Gm-Message-State: APjAAAUtSnbFArbDE6QRntlGo3+ZkJFhTrEqhNc8nac5tn4JTXo6iG8U
        FCbtm+uwGjI2uzEuy1d4RCN4yOWx
X-Google-Smtp-Source: APXvYqyfN3apeFamxGcCM7YLGW6BAsxb7bvpGNGNPZscZuCAbrfF1Y+47hzVTzD9bvBjnH7ubzapQg==
X-Received: by 2002:a63:b5b:: with SMTP id a27mr1809836pgl.262.1571284436837;
        Wed, 16 Oct 2019 20:53:56 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id q33sm565448pgm.50.2019.10.16.20.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 20:53:55 -0700 (PDT)
Subject: Re: [PATCH net 3/4] net: bcmgenet: soft reset 40nm EPHYs before MAC
 init
To:     Doug Berger <opendmb@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1571267192-16720-1-git-send-email-opendmb@gmail.com>
 <1571267192-16720-4-git-send-email-opendmb@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <3dbd4dbd-2ea5-e234-0cdc-81f0f3126173@gmail.com>
Date:   Wed, 16 Oct 2019 20:53:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1571267192-16720-4-git-send-email-opendmb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/2019 4:06 PM, Doug Berger wrote:
> It turns out that the "Workaround for putting the PHY in IDDQ mode"
> used by the internal EPHYs on 40nm Set-Top Box chips when powering
> down puts the interface to the GENET MAC in a state that can cause
> subsequent MAC resets to be incomplete.
> 
> Rather than restore the forced soft reset when powering up internal
> PHYs, this commit moves the invocation of phy_init_hw earlier in
> the MAC initialization sequence to just before the MAC reset in the
> open and resume functions. This allows the interface to be stable
> and allows the MAC resets to be successful.
> 
> The bcmgenet_mii_probe() function is split in two to accommodate
> this. The new function bcmgenet_mii_connect() handles the first
> half of the functionality before the MAC initialization, and the
> bcmgenet_mii_config() function is extended to provide the remaining
> PHY configuration following the MAC initialization.
> 
> Fixes: 484bfa1507bf ("Revert "net: bcmgenet: Software reset EPHY after power on"")
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

We will have to see how difficult it might be to back port towards
stable trees of interest, hopefully not too difficult.
-- 
Florian
