Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7ABC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528CC20652
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Dk6mIzlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfCDPHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:07:49 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:35118 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfCDPHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:07:49 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id E0CAB24E251F;
        Mon,  4 Mar 2019 07:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1551712068; bh=TCIHeh5qcSyq4IjxVhNRi/L3FLnwsgpWyCIGlFBb1Cs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=Dk6mIzlf24ZPRJ0HLrLJD3vScuLegusEZJ5mM7S8cL89yeot1MMkMjDl/exAsNXVK
         u0RfM4lUarqZmB1XtdsJm8BuBKRE7N8w3/aYwJALdIwDToIbYswemSff0VFdGQaMd4
         hzUs5CFpL/KoZ1t6gWDLZP+WUgTJ804iMnINfIDiMhfyER6bFD4tG+cfabmUhMH02P
         KBRGwep2u86GCHPzwo/VhpKh5zLGdUPju9btf2u/nQk+FqKn8T7EZLYJgJOqt0uKfi
         OdCEUCthXeVAN79Q/4jAfb6LuHsKrTG07FXaFDWRqKMNbAETB3mN3S500rexv/CswZ
         kKj1rCIp3pPaA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 32248A0066;
        Mon,  4 Mar 2019 15:07:47 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 4 Mar 2019 07:07:46 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 4 Mar 2019 16:07:45 +0100
Received: from [10.107.19.176] (10.107.19.176) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 4 Mar 2019 16:07:44 +0100
Subject: Re: [PATCH net 2/2] net: phy: Use C45 Helpers in PHY_FORCING state
To:     Andrew Lunn <andrew@lunn.ch>, Jose Abreu <jose.abreu@synopsys.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <cover.1551437561.git.joabreu@synopsys.com>
 <8480c38d6f3bc5c4f6c332a788bc82999266aab7.1551437561.git.joabreu@synopsys.com>
 <20190301135302.GB19813@lunn.ch>
From:   Jose Abreu <jose.abreu@synopsys.com>
Message-ID: <97425bd9-3ea5-b2c3-abc1-e5285a3e677e@synopsys.com>
Date:   Mon, 4 Mar 2019 15:07:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190301135302.GB19813@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.176]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 3/1/2019 1:53 PM, Andrew Lunn wrote:
> On Fri, Mar 01, 2019 at 11:54:24AM +0100, Jose Abreu wrote:
>> +static inline int phy_update_link(struct phy_device *phydev)
>> +{
>> +	if (!phydev->drv)
>> +		return -EIO;
>> +
>> +	if (phydev->drv->read_status)
>> +		return phydev->drv->read_status(phydev);
>> +	else if (phydev->is_c45)
>> +		return gen10g_read_status(phydev);
>> +	else
>> +		return genphy_update_link(phydev);
>> +}
> 
> Hi Jose
> 
> The asymmetry here could be an issue.  We might fall into the trap
> that a c45 PHY has the full state in phydev updated, were as a c22
> only has the link updated. Somebody testing on C45 might miss a bug
> for a C22 device.

Notice that this phy_update_link() is called from PHY_FORCING
state which in my case happens when autoneg is not enabled / is
not supported.

I think it makes sense, in this case, to only update link status,
no ?

Thanks,
Jose Miguel Abreu

> 
> Maybe this should be called phy_read_state(), and calls
> genphy_read_status() not genphy_update_link().
> 
>      Andrew
> 
