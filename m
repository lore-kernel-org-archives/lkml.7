Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E238EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 03:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FD520872
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 03:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="pR2fziD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbfDADAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 23:00:25 -0400
Received: from mail.synology.com ([211.23.38.101]:57893 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731593AbfDADAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 23:00:25 -0400
Received: from _ (localhost [127.0.0.1])
        by synology.com (Postfix) with ESMTPA id 5856311502FF2;
        Mon,  1 Apr 2019 11:00:22 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1554087622; bh=K7DWGZFKGdE7HtxErlkrqRqgBAq+rf1eDbUBOr9M0lY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=pR2fziD1BEEi9dqQU9rKfZBK5CRryjxRwEuBeATttyCqyzSoVv3zt+PPg8fEguOBu
         r6Z21l66lDGNqcK6R23Aw7+eVtoriJ5AXHIeS+oqxQ0HRDyJNrRqyIy4h4WP00qw+8
         oC+mXGApSkGa1GVYXg1TT3nGYJ/4rgfwZg7zzQWE=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 01 Apr 2019 11:00:22 +0800
From:   lifonghsu <lifonghsu@synology.com>
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: net: fix routing encapsulated packets when binding a socket to a
 tunnel interface
In-Reply-To: <20190329.104026.2135814725468775566.davem@davemloft.net>
References: <1553236198-5955-1-git-send-email-lifonghsu@synology.com>
 <20190327.134454.1623767882107215644.davem@davemloft.net>
 <6143cbeaab4f37bc2314caa3690063d4@synology.com>
 <20190329.104026.2135814725468775566.davem@davemloft.net>
Message-ID: <e87a85a8c91d96951c4fa923d1563dcd@synology.com>
X-Sender: lifonghsu@synology.com
User-Agent: Roundcube Webmail/1.1.2
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller 於 2019-03-30 01:40 寫到:
> From: lifonghsu <lifonghsu@synology.com>
> Date: Thu, 28 Mar 2019 16:30:37 +0800
> 
>> Indeed, skb_iif is used as receive site indication to present "device
>> the packet arrived on".
>> This commit keeps the previous arrived device (similar to the concept
>> of "device the packet arrived on") in skb_iif field to prevent kernel
>> from referring sk_bound_dev_if again. Otherwise, we might need to add
>> a new field to sk_buff structure for our purpose.
> 
> Therefore, you are deciding to arbitrarily repurpose an RX side piece
> of state for TX purposes.
> 
> Do not do this.
> 
> It confuses anyone trying to understand how skb_iif works.
> 
> You must use something with a different name, and clear semantics, to
> achieve this goal.
> 
> For example, you could use an anonymous union:
> 
> 	union {
> 		int	skb_iif;
> 		bool	bound_dev_already_applied;
> 	};
> 
> You never actually _USE_ the value of skb_iif, it is just merely a
> boolean indicating whether sk_bound_dev_if was applied already.

Since we are not sure whether there is any code referring to the value 
of
skb_iff in transmit site or not, it is risky to set an invalid interface
index to skb_iif in an anonymous union.
What if we add a bit (e.g., __u8 bound_dev_already_applied:1;) to 
sk_buff?

