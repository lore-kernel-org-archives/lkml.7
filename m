Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8DFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604892082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfC1M3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:29:43 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:47726 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbfC1M3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:29:43 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us1.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id 80028B00055;
        Thu, 28 Mar 2019 12:29:41 +0000 (UTC)
Received: from [10.17.20.203] (10.17.20.203) by ocex03.SolarFlarecom.com
 (10.20.40.36) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 28 Mar
 2019 05:29:37 -0700
Subject: Re: [BUG] net: core: netif_receive_skb_list() crash on non-standard
 ptypes forwarding
To:     Alexander Lobakin <alobakin@dlink.ru>
CC:     "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Petr Machata <petrm@mellanox.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Li RongQing <lirongqing@baidu.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1553767399.1271.1@dlink.ru>
 <61211987-2c8b-12b2-54cc-5ee23e2d0da9@solarflare.com>
 <5b3ef488e40c31dfa2e8d62b94e4df55@dlink.ru>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <3a31d5c9-6995-7078-1644-d170f70992f9@solarflare.com>
Date:   Thu, 28 Mar 2019 12:29:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <5b3ef488e40c31dfa2e8d62b94e4df55@dlink.ru>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.203]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24516.005
X-TM-AS-Result: No-7.652800-4.000000-10
X-TMASE-MatchedRID: 9zTThWtzImuHYS4ybQtcOomfV7NNMGm+jLOy13Cgb4+qvcIF1TcLYJRd
        g7qd4xaLUxPAM3J2QaqUTQ2JYQzY25Coy9iDotiwyeVujmXuYYUDA8I31/g84Czt4/lw8JZDmwL
        9o7cpIibzDqcOHl/aXP74ahE4RFG/gvdOIIvof4WGwT67eecJ8DGZtPrBBPZr6wNbW/ZPIpajxY
        yRBa/qJaEwgORH8p/AjaPj0W1qn0TKayT/BQTiGi5XugTHEKPIQTGl7iBS7rPokz8zPX1xdRLjL
        UfOAB1X3YCZb7+S6KLaBU4batuyZJoZgT9wVmImMNlWeujyFPyNFGuedayP99hfbAbxt7eKBsRA
        h8WmTAcG2WAWHb2qekrMHC7kmmSWc5S6hNczuvhDDKa3G4nrLQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.652800-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24516.005
X-MDID: 1553776182-IztxQh_lm4Dx
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2019 11:56, Alexander Lobakin wrote:
> Edward Cree wrote 28.03.2019 14:37:
>> On 28/03/2019 10:03, Alexander Lobakin wrote:
>>> Here's a working possible fix for that, not sure if it can break anything
>>> though.
>>>
>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>> index 2b67f2aa59dd..fdcff29df915 100644
>>> --- a/net/core/dev.c
>>> +++ b/net/core/dev.c
>>> @@ -5014,8 +5014,10 @@ static inline void __netif_receive_skb_list_ptype(struct list_head *head,
>>>     if (pt_prev->list_func != NULL)
>>>         pt_prev->list_func(head, pt_prev, orig_dev);
>>>     else
>>> -        list_for_each_entry_safe(skb, next, head, list)
>>> +        list_for_each_entry_safe(skb, next, head, list) {
>>> +            skb_list_del_init(skb);
>>>             pt_prev->func(skb, skb->dev, pt_prev, orig_dev);
>>> +        }
>>> }
>>>
>>> static void __netif_receive_skb_list_core(struct list_head *head, bool pfmemalloc)
>>>
>>> Maybe you could look into this and find another/better solution (or I could
>>> submit this one if that's pretty enough).
>> That looks like the correct fix to me, go ahead and have a
>> Reviewed-by: Edward Cree <ecree@solarflare.com>
>
> Cool!
> Do we need a "stable" mark in this case to propose it to LTS backports (4.20+, I suppose)?
Probably add a
Fixes: 88eb1944e18c ("net: core: propagate SKB lists through packet_type lookup")
(then Dave will take care of sending it to -stable.)

-Ed
