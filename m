Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B299BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E79020700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dlink.ru header.i=@dlink.ru header.b="YLYeLf9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfC1L4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:56:33 -0400
Received: from fd.dlink.ru ([178.170.168.18]:32912 "EHLO fd.dlink.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfC1L4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:56:33 -0400
Received: by fd.dlink.ru (Postfix, from userid 5000)
        id D9CA71B2128B; Thu, 28 Mar 2019 14:56:30 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru D9CA71B2128B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlink.ru; s=mail;
        t=1553774190; bh=04ToiUKlDK6KJwamSHJFMGypQWUxvQb5DLIi0XauHyU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=YLYeLf9C2ZqXQjJ1eW8XWpLdx271D32aZKz4bbeynXvjKmjNNosTac3Gmso5bK5M4
         BAppa004ssa8R+xiHnDk96rXeusFhQdOBU4sNQgxMvc9xMHyJ2ZRga7ubW3qJXO18h
         Un3ZBQCmsMek5QW7U8+HxzAJWAgWHnqXzIo0x4mw=
Received: from mail.rzn.dlink.ru (mail.rzn.dlink.ru [178.170.168.13])
        by fd.dlink.ru (Postfix) with ESMTP id 16DF91B211ED;
        Thu, 28 Mar 2019 14:56:28 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 16DF91B211ED
Received: by mail.rzn.dlink.ru (Postfix, from userid 5000)
        id E08111B2015C; Thu, 28 Mar 2019 14:56:27 +0300 (MSK)
Received: from mail.rzn.dlink.ru (localhost [127.0.0.1])
        by mail.rzn.dlink.ru (Postfix) with ESMTPA id 7E90E1B203C6;
        Thu, 28 Mar 2019 14:56:22 +0300 (MSK)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 28 Mar 2019 14:56:22 +0300
From:   Alexander Lobakin <alobakin@dlink.ru>
To:     Edward Cree <ecree@solarflare.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Petr Machata <petrm@mellanox.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Li RongQing <lirongqing@baidu.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] net: core: netif_receive_skb_list() crash on non-standard
 ptypes forwarding
In-Reply-To: <61211987-2c8b-12b2-54cc-5ee23e2d0da9@solarflare.com>
References: <1553767399.1271.1@dlink.ru>
 <61211987-2c8b-12b2-54cc-5ee23e2d0da9@solarflare.com>
Message-ID: <5b3ef488e40c31dfa2e8d62b94e4df55@dlink.ru>
X-Sender: alobakin@dlink.ru
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Edward Cree wrote 28.03.2019 14:37:
> On 28/03/2019 10:03, Alexander Lobakin wrote:
>> Here's a working possible fix for that, not sure if it can break 
>> anything
>> though.
>> 
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 2b67f2aa59dd..fdcff29df915 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -5014,8 +5014,10 @@ static inline void 
>> __netif_receive_skb_list_ptype(struct list_head *head,
>>     if (pt_prev->list_func != NULL)
>>         pt_prev->list_func(head, pt_prev, orig_dev);
>>     else
>> -        list_for_each_entry_safe(skb, next, head, list)
>> +        list_for_each_entry_safe(skb, next, head, list) {
>> +            skb_list_del_init(skb);
>>             pt_prev->func(skb, skb->dev, pt_prev, orig_dev);
>> +        }
>> }
>> 
>> static void __netif_receive_skb_list_core(struct list_head *head, bool 
>> pfmemalloc)
>> 
>> Maybe you could look into this and find another/better solution (or I 
>> could
>> submit this one if that's pretty enough).
> That looks like the correct fix to me, go ahead and have a
> Reviewed-by: Edward Cree <ecree@solarflare.com>

Cool!
Do we need a "stable" mark in this case to propose it to LTS backports 
(4.20+, I suppose)?

>> BTW, great work with netif_receive_skb_list() -- I've got 70 Mbps gain 
>> (~15%)
>> on my setup in comparsion to napi_gro_receive().
> Nice!
> 
> -Ed

Regards,
ᚷ ᛖ ᚢ ᚦ ᚠ ᚱ
