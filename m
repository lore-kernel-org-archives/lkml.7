Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2D1C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 08:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088562173E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 08:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dlink.ru header.i=@dlink.ru header.b="btS2l1nM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfLGILS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 03:11:18 -0500
Received: from fd.dlink.ru ([178.170.168.18]:56400 "EHLO fd.dlink.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfLGILR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 03:11:17 -0500
Received: by fd.dlink.ru (Postfix, from userid 5000)
        id 2847D1B20271; Sat,  7 Dec 2019 11:11:14 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 2847D1B20271
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlink.ru; s=mail;
        t=1575706274; bh=MwiVH3xMX5haMC7XNC4MSDAegTxuMS0AOkP8FjLDZuw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=btS2l1nMTqfftVIMfPv2mIMOy2CCtx4Vg5aeHm2i9IGPAiK/dYAc5xCbz+Kh6m4lB
         i3IM+0Zqa6HysRzYwiNZbOAGDcdFfwLLrXpXiuoKOK6UquPv/SGDxfITrKfilKMvcN
         pktCHSBAY7q7U7dexqYIh98R9w5twe5UfdZjRsVA=
Received: from mail.rzn.dlink.ru (mail.rzn.dlink.ru [178.170.168.13])
        by fd.dlink.ru (Postfix) with ESMTP id 520AF1B20271;
        Sat,  7 Dec 2019 11:10:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 520AF1B20271
Received: from mail.rzn.dlink.ru (localhost [127.0.0.1])
        by mail.rzn.dlink.ru (Postfix) with ESMTP id C372F1B203C6;
        Sat,  7 Dec 2019 11:10:58 +0300 (MSK)
Received: from mail.rzn.dlink.ru (localhost [127.0.0.1])
        by mail.rzn.dlink.ru (Postfix) with ESMTPA;
        Sat,  7 Dec 2019 11:10:58 +0300 (MSK)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sat, 07 Dec 2019 11:10:58 +0300
From:   Alexander Lobakin <alobakin@dlink.ru>
To:     David Miller <davem@davemloft.net>
Cc:     rainersickinger.official@gmail.com,
        shashidhar.lakkavalli@openmesh.com, john@phrozen.org,
        andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        sdf@google.com, daniel@iogearbox.net, songliubraving@fb.com,
        ast@kernel.org, mcroce@redhat.com, jakub@cloudflare.com,
        edumazet@google.com, paulb@mellanox.com, komachi.yoshiki@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: fix flow dissection on Tx path
In-Reply-To: <20191206.201950.100960973648804142.davem@davemloft.net>
References: <20191205100235.14195-1-alobakin@dlink.ru>
 <20191206.201950.100960973648804142.davem@davemloft.net>
User-Agent: Roundcube Webmail/1.4.0
Message-ID: <ad7dd3a7a1e864939a18343e2e57c50e@dlink.ru>
X-Sender: alobakin@dlink.ru
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote 07.12.2019 07:19:
> From: Alexander Lobakin <alobakin@dlink.ru>
> Date: Thu,  5 Dec 2019 13:02:35 +0300
> 
>> Commit 43e665287f93 ("net-next: dsa: fix flow dissection") added an
>> ability to override protocol and network offset during flow dissection
>> for DSA-enabled devices (i.e. controllers shipped as switch CPU ports)
>> in order to fix skb hashing for RPS on Rx path.
>> 
>> However, skb_hash() and added part of code can be invoked not only on
>> Rx, but also on Tx path if we have a multi-queued device and:
>>  - kernel is running on UP system or
>>  - XPS is not configured.
>> 
>> The call stack in this two cases will be like: dev_queue_xmit() ->
>> __dev_queue_xmit() -> netdev_core_pick_tx() -> netdev_pick_tx() ->
>> skb_tx_hash() -> skb_get_hash().
>> 
>> The problem is that skbs queued for Tx have both network offset and
>> correct protocol already set up even after inserting a CPU tag by DSA
>> tagger, so calling tag_ops->flow_dissect() on this path actually only
>> breaks flow dissection and hashing.
>> 
>> This can be observed by adding debug prints just before and right 
>> after
>> tag_ops->flow_dissect() call to the related block of code:
>   ...
>> In order to fix that we can add the check 'proto == htons(ETH_P_XDSA)'
>> to prevent code from calling tag_ops->flow_dissect() on Tx.
>> I also decided to initialize 'offset' variable so tagger callbacks can
>> now safely leave it untouched without provoking a chaos.
>> 
>> Fixes: 43e665287f93 ("net-next: dsa: fix flow dissection")
>> Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
> 
> Applied and queued up for -stable.

David, Andrew, Florian, Rainer,
Thank you!

Regards,
ᚷ ᛖ ᚢ ᚦ ᚠ ᚱ
