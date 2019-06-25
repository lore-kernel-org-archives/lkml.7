Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADA9C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D80920663
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbfFYP1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:27:21 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:19196 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732283AbfFYP1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 11:27:20 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x5PFQxge061457;
        Wed, 26 Jun 2019 00:26:59 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp);
 Wed, 26 Jun 2019 00:26:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp)
Received: from [192.168.1.2] (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x5PFQwPa061452
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 26 Jun 2019 00:26:59 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH net-next] net: stmmac: Fix the case when PHY handle is not
 present
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
References: <351cce38d1c572d8b171044f2856c7fae9f89cbc.1561450696.git.joabreu@synopsys.com>
 <78EB27739596EE489E55E81C33FEC33A0B9D78A2@DE02WEMBXB.internal.synopsys.com>
 <5859e2c5-112f-597c-3bd5-e30e96b86152@katsuster.net>
 <20190625145105.GA4722@lunn.ch>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <7a9ce546-7c13-a7ea-ff58-c3befe2fcf6a@katsuster.net>
Date:   Wed, 26 Jun 2019 00:26:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190625145105.GA4722@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On 2019/06/25 23:51, Andrew Lunn wrote:
> On Tue, Jun 25, 2019 at 11:40:00PM +0900, Katsuhiro Suzuki wrote:
>> Hello Jose,
>>
>> This patch works fine with my Tinker Board. Thanks a lot!
>>
>> Tested-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>>
>>
>> BTW, from network guys point of view, is it better to add a phy node
>> into device trees that have no phy node such as the Tinker Board?
> 
> Hi Katsuhiro
> 
> It makes it less ambiguous if there is a phy-handle. It is then very
> clear which PHY should be used. For a development board, which people
> can be tinkering around with, there is a chance they add a second PHY
> to the MDIO bus, or an Ethernet switch, etc. Without explicitly
> listing the PHY, it might get the wrong one. However this is generally
> a problem if phy_find_first() is used. I think in this case, something
> is setting priv->plat->phy_addr, so it is also clearly defined which
> PHY to use.
> 
> 	  Andrew
> 

Hmm, I see. This stmmac driver can choose PHY by the kernel module
parameter 'phyaddr' (if no one set this parameter, priv->plat->phy_addr
goes to 0). So there is no ambiguous in this case and need no changes
for device tree.

Thank you for your comment.

Best Regards,
Katsuhiro Suzuki
