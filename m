Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB06C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C7820811
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GEuVKSBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfCRMqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:46:16 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:43688 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfCRMqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:46:15 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 7A4E624E2DD1;
        Mon, 18 Mar 2019 05:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1552913175; bh=/1tWVc5bZIXSiC0Pfe5YWqhw8dedYvs+49S2hCu8IXM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=GEuVKSBE8XWtK3Otr3DrJuAJSOkakOuF7uP/XuK4SjWNM8EtACHYhLZuJ5E7TNshb
         JsbKuCken5bA2lzLLwf6XoSuvQacTpGWbq2/Kts391V08Uzn7NYlKpwhUxbVhBkWnW
         JRrZkNFK3ZZOlPN+6wajgCgkBn0qkg0R7VsLOUtgxvp8KALMzKp2UojjAsj85LuLhD
         aRLiXv/nsHeuIL1eKZ3POjvN734eAHJAmwdwS9oBmTc8wF8/Wr8D0ESGpVqsmujsCH
         xmHlfnlOuCPEq5G+ub8P/8aIX1Yw5RlXkmmsjoV1+k/NLjTjxwcXDN0OEQlKOMcEq5
         dkV70R4UEfOQw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id CA89AA0091;
        Mon, 18 Mar 2019 12:46:12 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 18 Mar 2019 05:46:12 -0700
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 18 Mar 2019 13:46:10 +0100
Received: from [10.107.19.176] (10.107.19.176) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 18 Mar 2019 13:46:10 +0100
Subject: Re: [PATCH net] net: phy: Don't assume loopback is supported
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Jose Abreu <jose.abreu@synopsys.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Joao Pinto <joao.pinto@synopsys.com>
References: <eeea080649153eefafef8ff93274733fe8f25b01.1552559796.git.joabreu@synopsys.com>
 <19c8d2b3-bffe-b3b2-6e91-e878f89e5247@gmail.com>
 <20190317183843.GE22226@lunn.ch>
From:   Jose Abreu <jose.abreu@synopsys.com>
Message-ID: <07dd8427-4779-1706-3c0a-17ae58939c41@synopsys.com>
Date:   Mon, 18 Mar 2019 12:46:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190317183843.GE22226@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.176]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew and Heiner,

On 3/17/2019 6:38 PM, Andrew Lunn wrote:
> On Fri, Mar 15, 2019 at 03:48:41PM -0700, Florian Fainelli wrote:
>> On 3/14/19 3:37 AM, Jose Abreu wrote:
>>> Some PHYs may not support loopback mode so we need to check if register
>>> is read-only.
>>>
>>
>> In that case it may be appropriate to have a specific PHY driver that
>> implements a set_loopback() method returning -EOPNOTSUPP instead of
>> changing the generic PHY implementation.
> 
> Hi Jose
> 
> Since Heiner says this is a mandatory feature, we should not really
> penalise conformant PHYs just because there is one broken PHY.

We provide PHYs to our customers and in the documentation I have
this can be an optional feature that HW team can choose to have
or not, making the bit read-only or r/w.

Heiner, can you please confirm there is no Clause 22 "pitfalls" /
"hidden comments" that allow this bitfield to be read-only ?

Thanks,
Jose Miguel Abreu
