Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD1EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C809721473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXrJysin"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfDCFKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 01:10:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53445 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbfDCFKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 01:10:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so5833687wmj.3;
        Tue, 02 Apr 2019 22:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6GMQslZH/OAsvrXdPJGxlz4UQkKx7t9OUtpVJ+EeBnk=;
        b=cXrJysinNRAb+fXTqUBbItOJIss5KArD1C0Bw13P8Es/euiFBxrAtWeWFWlhTI5AJS
         EenxbUSCj+lO0haxdUNpJ3+oZHxlAzH4S2AHZPLqVuL9JbBTgFELz0epv1T0YuPRLSjF
         5ZUA1P6/zMpHLYgVl+ohBVaK0CrqFYV8fto2sGLNQaqDftYzc0WqMpP9TSjvyzt6jFrd
         fwEc6XVEiuI3z2qJlFXJE+qsMST3Zs4njC3ci2u7LrlddlXtXsVxbFoXQqu6Dfk/o4Ve
         76kTkMLYNVG0iAGdyVq4LJfGz7AwRTRmgcPcLy5fNlCI4vO5jjTYuMu7DjuKRgHXov8V
         4Fsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6GMQslZH/OAsvrXdPJGxlz4UQkKx7t9OUtpVJ+EeBnk=;
        b=HV+2pYUcx9Q3oyqHyWa0gce4/LvyG9fMx/Fu/5IEs1ZSPCSC3bHgzzBUen6Uj4jE7y
         XaZJbSqgrwBc2YmgatX2n+3cw6T/mtSb+Es+wwpLRMhhc2UVyeDFZe+25LtTNXLCgk10
         E3oVFzCDHv5yxozPQcxVJkdXP1qCn6HBA6XvBJKXhKHAYm1cjDgI7yz2hdWolQpF+gT+
         yjSVHAkRUKJa5KQ6Dhz+d3DPoff0IlGjgTSqDpwr68zhTt3XYMn1RAk/uUjiNfdwEumS
         Fx0A5ysd22AGeOtYh5Rv2MJxtWQKOKbq+A6aZrIH9h7LawilmFU5/i+hn0g3xcNSOd/F
         9Hxg==
X-Gm-Message-State: APjAAAWyUDIiVSqr1tGDFrn3l3AXX/GbD0m5IUm0l8uYdOYTPRXNTfLb
        xsTDj/YVXZpGiA1LMCbFCu7lq9/u
X-Google-Smtp-Source: APXvYqzqp9PREox4od7pigg3a9HUgTRamiixCIyBNK3RR1m3a8qSLxeg0+ZIou6h/FLQMQnoGdLtUQ==
X-Received: by 2002:a7b:c848:: with SMTP id c8mr505751wml.110.1554268203439;
        Tue, 02 Apr 2019 22:10:03 -0700 (PDT)
Received: from ?IPv6:2003:ea:8be1:dd00:a1d8:cecd:ef87:100d? (p200300EA8BE1DD00A1D8CECDEF87100D.dip0.t-ipconnect.de. [2003:ea:8be1:dd00:a1d8:cecd:ef87:100d])
        by smtp.googlemail.com with ESMTPSA id t17sm11954947wrr.26.2019.04.02.22.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 22:10:02 -0700 (PDT)
Subject: Re: [PATCH net-next v4 1/2] net: phy: marvell10g: implement
 suspend/resume callbacks
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
References: <20190402131029.26880-1-antoine.tenart@bootlin.com>
 <20190402131029.26880-2-antoine.tenart@bootlin.com>
 <762a34e2-e89b-9a96-938f-5c85709c8760@gmail.com>
 <20190402221048.fpdqfeuzscthn6qd@shell.armlinux.org.uk>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <af550dd9-1374-621d-a37a-8e32314be01c@gmail.com>
Date:   Wed, 3 Apr 2019 07:09:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402221048.fpdqfeuzscthn6qd@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.04.2019 00:10, Russell King - ARM Linux admin wrote:
> On Tue, Apr 02, 2019 at 08:17:16PM +0200, Heiner Kallweit wrote:
>> On 02.04.2019 15:10, Antoine Tenart wrote:
>>> This patch adds the suspend/resume callbacks for Marvell 10G PHYs. The
>>> three PCS (base-t, base-r and 1000base-x) are set in low power (the PCS
>>> are powered down) when the PHY isn't used.
>>>
>>> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
>>> ---
>>>  drivers/net/phy/marvell10g.c | 12 +++++++++++-
>>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
>>> index 80678919641d..9ee033c8a12b 100644
>>> --- a/drivers/net/phy/marvell10g.c
>>> +++ b/drivers/net/phy/marvell10g.c
>>> @@ -51,6 +51,8 @@ enum {
>>>  	MV_AN_STAT1000		= 0x8001, /* 1000base-T status register */
>>>  
>>>  	/* Vendor2 MMD registers */
>>> +	MV_V2_PORT_CTRL		= 0xf001,
>>> +	MV_V2_PORT_CTRL_PWRDOWN = 0x0800,
>>
>> If this driver is touched again I think it would be good to change all
>> such constants to BIT() and GENMASK(), ideally combined with the macros
>> from bitfields.h. This makes it much easier to check the code against the
>> datasheet. Apart from that:
> 
> Specifically, which constants are you talking about?
> 
> I think there's only MV_PCS_PAIRSWAP_MASK and MV_V2_TEMP_CTRL_MASK,
> which would be confusing to change given that the following definitions
> are values for the masked field.
> 
Exactly, MV_V2_TEMP_CTRL_MASK is a good example. My personal preference is
to define the mask as GENMASK(15, 14) and the field values as 0 and 3.
Then it's aligned with the datasheet that says:
15:14 Temperature Sense Enable, 11 = Disable
Macros FIELD_GET and FIELD_PREP are perfect to deal with such fields.

> However, MV_V2_PORT_CTRL_PWRDOWN should be defined using BIT() in any
> case.
> 

