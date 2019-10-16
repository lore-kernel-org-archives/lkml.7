Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BFDC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25A42168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dlink.ru header.i=@dlink.ru header.b="g7PDsHJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389012AbfJPHbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:31:49 -0400
Received: from fd.dlink.ru ([178.170.168.18]:54236 "EHLO fd.dlink.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388796AbfJPHbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:31:46 -0400
Received: by fd.dlink.ru (Postfix, from userid 5000)
        id 6D2261B21812; Wed, 16 Oct 2019 10:31:43 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 6D2261B21812
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlink.ru; s=mail;
        t=1571211103; bh=xFLFibTQoIb+YvdLb5GPC6ZC1BWeQiRmlnaav7Szqqg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=g7PDsHJ9fO/u0SpmNbkptVpQALtm3AHRvyU86JI4v0jUiJo+Zq9blb93QknWKLtfP
         x0tj0dBJD/QrakA4XdpIewYjjcy9/FMzImUi+buBA+9oqsFneheY8NjjpE0TG9IJHY
         vxCCum716ULe1R13m6HFC29JJjkwq1ckBb7mForE=
Received: from mail.rzn.dlink.ru (mail.rzn.dlink.ru [178.170.168.13])
        by fd.dlink.ru (Postfix) with ESMTP id B40F91B217F7;
        Wed, 16 Oct 2019 10:31:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru B40F91B217F7
Received: by mail.rzn.dlink.ru (Postfix, from userid 5000)
        id 51C7A1B20416; Wed, 16 Oct 2019 10:31:39 +0300 (MSK)
Received: from mail.rzn.dlink.ru (localhost [127.0.0.1])
        by mail.rzn.dlink.ru (Postfix) with ESMTPA id 899581B20416;
        Wed, 16 Oct 2019 10:31:31 +0300 (MSK)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 16 Oct 2019 10:31:31 +0300
From:   Alexander Lobakin <alobakin@dlink.ru>
To:     David Miller <davem@davemloft.net>
Cc:     ecree@solarflare.com, jiri@mellanox.com, edumazet@google.com,
        idosch@mellanox.com, pabeni@redhat.com, petrm@mellanox.com,
        sd@queasysnail.net, f.fainelli@gmail.com,
        jaswinder.singh@linaro.org, ilias.apalodimas@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net: core: use listified Rx for GRO_NORMAL in
 napi_gro_receive()
In-Reply-To: <20191015.181649.949805234862708186.davem@davemloft.net>
References: <20191014080033.12407-1-alobakin@dlink.ru>
 <20191015.181649.949805234862708186.davem@davemloft.net>
Message-ID: <7e68da00d7c129a8ce290229743beb3d@dlink.ru>
X-Sender: alobakin@dlink.ru
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote 16.10.2019 04:16:
> From: Alexander Lobakin <alobakin@dlink.ru>
> Date: Mon, 14 Oct 2019 11:00:33 +0300
> 
>> Commit 323ebb61e32b4 ("net: use listified RX for handling GRO_NORMAL
>> skbs") made use of listified skb processing for the users of
>> napi_gro_frags().
>> The same technique can be used in a way more common napi_gro_receive()
>> to speed up non-merged (GRO_NORMAL) skbs for a wide range of drivers
>> including gro_cells and mac80211 users.
>> This slightly changes the return value in cases where skb is being
>> dropped by the core stack, but it seems to have no impact on related
>> drivers' functionality.
>> gro_normal_batch is left untouched as it's very individual for every
>> single system configuration and might be tuned in manual order to
>> achieve an optimal performance.
>> 
>> Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
>> Acked-by: Edward Cree <ecree@solarflare.com>
> 
> Applied, thank you.

David, Edward, Eric, Ilias,
thank you for your time.

Regards,
ᚷ ᛖ ᚢ ᚦ ᚠ ᚱ
