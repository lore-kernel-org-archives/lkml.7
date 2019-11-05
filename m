Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8590CC5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AA321929
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DfYf1tIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKETtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 14:49:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33208 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfKETtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 14:49:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id 6so654336wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 11:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UxXl5CJZIoFnMZL6/cL403hkZBabWwNFlZGMcKNv9CI=;
        b=DfYf1tIrKNQZt5fdgVqLgqi9HccpFBFoGh8ZAIkWq7pZT4qlZBAGSwp0X/aWi9iSvF
         jdNUkLVEFALgwFaBiECrIdp8xyCC63qPPxyOhzLyGFAprniDgrisk5yOz3hXvx6aw7+2
         mznBwKqa7nyBfAp3+8t/VOThwm5XgrDCzgLRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UxXl5CJZIoFnMZL6/cL403hkZBabWwNFlZGMcKNv9CI=;
        b=cu8Eqr3Wa71XfyEXCbYyxOgmfSc08R89npfrYdOXDLBiwjyGl5amjuHr+JYLeM8Uob
         ukN+Eux2HmHbB6R7is7qy6sT2b9K5hVgc24BiMfJqt2mYU5jV0h447Z1FfO10gQ/xHWz
         Y1ruZCP8l6wCgkdAVoRpeSOmbuMe72oXSak06VtLwvo/5eKov4ghhUTUUKRKS7JOCbaU
         kTqVanf5RxrN/WBC7uTo97wzKbN8bbghjIdxqNCv4UoN71oz+0gYhpozCByZyA5nKNGQ
         VyLPqFC6MKazigbIOfun22REQoJQWQibkvbnQICLklX+G4/GUvZmrGI5hOB9k2e0zZOh
         4SCg==
X-Gm-Message-State: APjAAAVlRCaqIgHBe70pRDImPuUKbZ6l82jexgWpfrrOSOf0k65W0vk1
        BzJGockTPgOYQqV01ZEpDY8aAuoTlc8QmZRvMPi8f0FxCIeivxK4GQmIvRHPdV50pvQFSNY/yz5
        Y5+SnvbeyEi3qVfljOS5wgPqEohi3nvMjuXdM7fclV73BB4yB6I7Dhzj/NhtHFD9wY9UPOT56nR
        P2N0cCuSNB6Vo=
X-Google-Smtp-Source: APXvYqyqM7nhSS0Pe5eOQG7YdtR1lL/CgciM3J4IhJLEhAxoOj9knLvPotj89JcFNr2D5TiCrkX38Q==
X-Received: by 2002:a1c:ed0e:: with SMTP id l14mr580961wmh.74.1572983341018;
        Tue, 05 Nov 2019 11:49:01 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id j22sm30194509wrd.41.2019.11.05.11.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 11:49:00 -0800 (PST)
Subject: Re: [PATCH net 1/3] net: bcmgenet: use RGMII loopback for MAC reset
To:     Doug Berger <opendmb@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1572980846-37707-1-git-send-email-opendmb@gmail.com>
 <1572980846-37707-2-git-send-email-opendmb@gmail.com>
 <8c5c8028-a897-bf70-95ba-a1ffc8b68264@broadcom.com>
 <5f68345e-c58d-3d99-189b-b4be39c4b899@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <6bc48252-952c-008d-f43d-b8093c021ba8@broadcom.com>
Date:   Tue, 5 Nov 2019 11:48:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5f68345e-c58d-3d99-189b-b4be39c4b899@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-11-05 11:27 a.m., Doug Berger wrote:
> On 11/5/19 11:14 AM, Scott Branden wrote:
>> Hi Doug,
>>
>> On 2019-11-05 11:07 a.m., Doug Berger wrote:
>>> As noted in commit 28c2d1a7a0bf ("net: bcmgenet: enable loopback
>>> during UniMAC sw_reset") the UniMAC must be clocked while sw_reset
>>> is asserted for its state machines to reset cleanly.
>>>
>>> The transmit and receive clocks used by the UniMAC are derived from
>>> the signals used on its PHY interface. The bcmgenet MAC can be
>>> configured to work with different PHY interfaces including MII,
>>> GMII, RGMII, and Reverse MII on internal and external interfaces.
>>> Unfortunately for the UniMAC, when configured for MII the Tx clock
>>> is always driven from the PHY which places it outside of the direct
>>> control of the MAC.
-- SNIP
>>> +        /* Switch MAC clocking to RGMII generated clock */
>>> +        bcmgenet_sys_writel(priv, PORT_MODE_EXT_GPHY, SYS_PORT_CTRL);
>>> +        /* Ensure 5 clks with Rx disabled
>>> +         * followed by 5 clks with Reset asserted
>>> +         */
>>> +        udelay(4);
>> How do these magic delays work, they are different values?
>> In one case you have a udelay(4) to ensure rx disabled for 5 clks.
>> Yet below you have a udelay(2) to ensure 4 more clocks?
> The delays are based on 2.5MHz clock cycles (the clock used for 10Mbps).
> 5 clocks is 2us.
>
> The udelay(4) is for 10 clocks: rx is disabled for 5 and then 5 more
> clocks with reset held. The requirement is poorly specified and this is
> a conservative interpretation.
>
> The udelay(2) allows at least 5 more clocks without reset before rx can
> be enabled.
>
Thanks, the part I was missing was "2.5MHz clock cycles (the clock used 
for 10Mbps)".
If that was added to the comment it would help those unfamiliar with in 
understanding.
>>> +        reg &= ~(CMD_SW_RESET | CMD_LCL_LOOP_EN);
>>> +        bcmgenet_umac_writel(priv, reg, UMAC_CMD);
>>> +        /* Ensure 5 more clocks before Rx is enabled */
>>> +        udelay(2);
>>> +    }
>>> +
>>>        priv->ext_phy = !priv->internal_phy &&
>>>                (priv->phy_interface != PHY_INTERFACE_MODE_MOCA);
>>>    @@ -254,6 +284,9 @@ int bcmgenet_mii_config(struct net_device *dev,
>>> bool init)
>>>            phy_set_max_speed(phydev, SPEED_100);
>>>            bcmgenet_sys_writel(priv,
>>>                        PORT_MODE_EXT_EPHY, SYS_PORT_CTRL);
>>> +        /* Restore the MII PHY after isolation */
>>> +        if (bmcr >= 0)
>>> +            phy_write(phydev, MII_BMCR, bmcr);
>>>            break;
>>>          case PHY_INTERFACE_MODE_REVMII:
> Regards,
>      Doug

