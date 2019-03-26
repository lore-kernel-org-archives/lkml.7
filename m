Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF89C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8572F20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732505AbfCZTuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:50:54 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49750 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732176AbfCZTux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 15:50:53 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EBF3014C66CFA;
        Tue, 26 Mar 2019 12:50:51 -0700 (PDT)
Date:   Tue, 26 Mar 2019 12:50:51 -0700 (PDT)
Message-Id: <20190326.125051.1865224055641059773.davem@davemloft.net>
To:     mojha@codeaurora.org
Cc:     kjlu@umn.edu, alexandre.torgue@st.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, pakki001@umn.edu,
        peppe.cavallaro@st.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] net: stmmac: fix a potential NULL pointer dereference
From:   David Miller <davem@davemloft.net>
In-Reply-To: <0f518f7a-ff1f-b8d9-8468-a1f7648ada46@codeaurora.org>
References: <20190323033942.21796-1-kjlu@umn.edu>
        <0f518f7a-ff1f-b8d9-8468-a1f7648ada46@codeaurora.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 26 Mar 2019 12:50:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mukesh Ojha <mojha@codeaurora.org>
Date: Tue, 26 Mar 2019 15:27:03 +0530

> 
> On 3/23/2019 9:09 AM, Kangjie Lu wrote:
>> In case of_device_get_match_data fails, the fix return -EINVAL
>> to avoid the NULL pointer dereference.
>>
>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
>> b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
>> index 3256e5cbad27..344ead5949b1 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
>> @@ -485,6 +485,8 @@ static int dwc_eth_dwmac_remove(struct
>> platform_device *pdev)
>>   	int err;
>>     	data = of_device_get_match_data(&pdev->dev);
>> +	if (!data)
>> +		return -EINVAL;
> 
> Although, it is false alarm for this driver as of_match_table is not
> NULL, but it would be good to add the check.

I disagree.

This is adding a check just for the sake of adding the check and
shutting up a static analysis tool.

Now, if the tool looked at the table entries being fed into this
function, and found such a posibility then we would fix the bug
and still not add the check.
