Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F229C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 14:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525A220836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 14:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DboMPvuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfCBOxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 09:53:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43875 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfCBOxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 09:53:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id d17so851240wre.10;
        Sat, 02 Mar 2019 06:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O3Gbk1u2XmhlMxl5eOQe/1921//CsP6eAQVixSctLJE=;
        b=DboMPvuBa78b6mrY0vHhxuK9uJP8odK3SWrtBZ8BLeMuPmU0uzBNZJrHHN40CxXicM
         aN26wsAG0dmER5gBiPlw7MtPGlkOpIBRQNnqy+goX7iuB2DOQ6LJBbshLmDAFWu4H0Io
         +ywoPQYXdxcOdflpPRe6ZrjNWV1PC4tuaJACWMjwfk29kBDyOGmIPuhN6/zyB8uCoZnY
         3JqdcifX9l3rzF0xZAuq0MBqBYdboB4ofX2kfthdNg4i4nRNsvXPY/fal824DDEmJO7E
         Lvvy4/RW09BMNzVvsUc7MYjjMiita++y8s25Csr/6+CJEhosAo1yrN1aiiFhn4C73m51
         /WTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O3Gbk1u2XmhlMxl5eOQe/1921//CsP6eAQVixSctLJE=;
        b=S8X1yunUa1V09RtXC4PQBKpOcv3LitpmIBo0kLKdwkRcXIjLYXc+i5pMPZaBaqmnDl
         AetqiYgQsJE5hvdEtkbIefiz0qPMwkLb0stUl7GrBfJTv+3VeksN60Uvn7O4PpaboSQ+
         wTv96p6DdvIt1xHw/ctBzuqs+tCyxkk+BR9q++fQTFUSs0SmDdpKLm0zjM/pGXopPJRS
         GKjpEm25D2gVLmpXpRhvdJeD1wbcffvvTw/5tV9+CQmhfvtbHHxi4aIHphmrYVH02y1K
         bm3zlKFp9zO9pASMFqI6/ds5kg5OHJ1WYsgyC58eYvgzjo1PXzWdW3IZks4sna3Xb1p1
         dwVQ==
X-Gm-Message-State: APjAAAUwpI/q+qzYZh7eZtoVgbTzRlf89UK+jnLWGia69+PpwZYPtlZ1
        kpFJoeSradmDvHo/sy90zXI=
X-Google-Smtp-Source: APXvYqy/uL6pLNXbZkFZNcp5HH68qLdZffputeV26mdg5xHtTrot9nM+Z9HNlejuQo3T52EHBBnBcg==
X-Received: by 2002:adf:e385:: with SMTP id e5mr7218106wrm.267.1551538380130;
        Sat, 02 Mar 2019 06:53:00 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:ed04:ce8:ead3:a1ec? (p200300EA8BF1E200ED040CE8EAD3A1EC.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:ed04:ce8:ead3:a1ec])
        by smtp.googlemail.com with ESMTPSA id t8sm816912wmi.21.2019.03.02.06.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 06:52:59 -0800 (PST)
Subject: Re: [PATCH net 1/2] net: phy: Use C45 Helpers in phy_read_status()
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jose Abreu <jose.abreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Joao Pinto <joao.pinto@synopsys.com>
References: <cover.1551437561.git.joabreu@synopsys.com>
 <27b3e9f2318c87aac928165b8dfe7d98e272f3d1.1551437561.git.joabreu@synopsys.com>
 <237f5214-c49e-53f9-65f0-479951f62d4a@gmail.com>
 <20190302141156.GG19813@lunn.ch>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <6dc7b38f-c27a-e9f7-da32-3f58dae2e707@gmail.com>
Date:   Sat, 2 Mar 2019 15:52:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190302141156.GG19813@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.03.2019 15:11, Andrew Lunn wrote:
> On Fri, Mar 01, 2019 at 07:14:20PM -0800, Florian Fainelli wrote:
>>
>>
>> On 3/1/2019 2:54 AM, Jose Abreu wrote:
>>> Currently phy_read_status() considers that either the PHY driver has the
>>> read_status() callback or uses the generic callback.
>>>
>>> For C45 PHYs we need to use the gen10g_read_status() callback.
>>
The gen10g_ functions are deprecated and shouldn't be used in new code.
Consider the (partially brand-new) genphy_c45_ functions instead.
This should be ok because I think the two changes are material for
net-next.

The gen10g functions belong to the old gen10g driver which knows about
10G only. I think sooner or later we'll replace it with a genc45
driver or similar.

>> Right, so we could expect your C45 PHY driver to assign the read_status
>> callback to gen10g_read_status() if it is appropriate. So far most of
>> the 10g PHY drivers (cortina, marvell10g, aquantia) have to define their
>> own read_status() callback to be feature complete. Unlike C22 PHYs that
>> can really be driven with a simple generic PHY driver model for standard
>> features, C45 PHYs seem to be quirky enough this does not work anymore.
> 
> Hi Jose
> 
> Does your PHY support 1000Base-T? If so you need read_status() because
> the registers for that link mode don't appear to be standardized.
> 
>     Andrew
> 
Heiner
