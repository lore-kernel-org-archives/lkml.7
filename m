Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DF3C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649D4217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9amOKGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388257AbfDRSzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:55:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42718 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfDRSzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:55:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id p6so1591905pgh.9;
        Thu, 18 Apr 2019 11:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CL7YPgtpATg65qwjLk5h6Xiz5vMP2lObV+iUgz87oJw=;
        b=k9amOKGzKtxdIhjKvnMl0Y7bGvyhx9WH4Cv2/w5orp1X2UUzBEEDZh01vlLvpKJHOF
         8iCtopgnmvTSKaz0rce8TWtJL5E6jVrx2m0kNlaTENlw3oM3nwb3tHGjglp7Gq0ipxoV
         Jhdz7cHpUEdCqINahBAI+xYi/U26zSLJaZsCdon/8f2/EjjSLY8HzD9xapKWy/ZbqAUV
         cHCbWrYpKQYtD8DZEAmpDYYTezYKFQwgr+JzW69w7Rm+Ofg1fdzHApiG2y3fju8XPX5R
         xZ3MqYw0QNqHlKkXvnK0gab21Z5A4gkbN4DebB09xyb3oqX5I7xD2WSTPc4ifqpNF441
         jFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CL7YPgtpATg65qwjLk5h6Xiz5vMP2lObV+iUgz87oJw=;
        b=StL9UbFJUah0a7F2mhzAEsP/MGZ3Sm1J207g4G07fhoqHa1lWwFGQPW9HkbjkcSlQ6
         aPkTKz7GEUQ1N1u13EJOAvc4HJ5oQ/6jx8hr1ZgWdJ9a7REce0M7MCZm+Pe42Cv+P0he
         jaoVsHanIoCrCH0tv47CsvJzR2xOWiWwKpRmPy5XDEEm9jHroreXOMJncG5eq36Vc1vZ
         ONNvXBdLvhrrn80X5J6N6K9fL5iIgKiW9zujlBBkE2Y16Qcj9YdDlpBMQbrp3PDkKI2k
         /Oldad4q1kaTdG79pyZR8ER28jsAaxYLD1FzLEl365PhJ/6hcknynzJ6mKx1bh46mXKn
         Yxpg==
X-Gm-Message-State: APjAAAW22brX1XDQGOgFUfogibeYL6EkKm3NUkEeh/ATXZCh7zFLygGK
        XJJqBImZUkCVV0ehy8KiDseowhWa
X-Google-Smtp-Source: APXvYqx2LiUujMW0JT3ozCpQXk2cYC4kEA4OhG9hYs7bH9UHNU4HfTg3zXFRf+Y/4xlciqK6xYkRGQ==
X-Received: by 2002:a65:64cf:: with SMTP id t15mr87820579pgv.322.1555613719036;
        Thu, 18 Apr 2019 11:55:19 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id j16sm3730481pfi.58.2019.04.18.11.55.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 11:55:17 -0700 (PDT)
Subject: Re: [PATCH 1/4] net/skbuff: don't waste memory reserves
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Willem de Bruijn <willemb@google.com>,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20190418180524.23489-1-aryabinin@virtuozzo.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <791f4f23-d931-4ac8-4e60-3ffe46c4ece2@gmail.com>
Date:   Thu, 18 Apr 2019 11:55:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190418180524.23489-1-aryabinin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/18/2019 11:05 AM, Andrey Ryabinin wrote:
> In some workloads we have noticed packets being dropped by
> sk_filter_trim_cap() because the 'skb' was allocated from pfmemalloc
> reserves:
> 
> 	/*
> 	 * If the skb was allocated from pfmemalloc reserves, only
> 	 * allow SOCK_MEMALLOC sockets to use it as this socket is
> 	 * helping free memory
> 	 */
> 	if (skb_pfmemalloc(skb) && !sock_flag(sk, SOCK_MEMALLOC)) {
> 		NET_INC_STATS(sock_net(sk), LINUX_MIB_PFMEMALLOCDROP);
> 		return -ENOMEM;
> 	}
> 
> Memalloc sockets are used for stuff like swap over NBD or NFS
> and only memalloc sockets can process memalloc skbs. Since we
> don't have any memalloc sockets in our setups we shouldn't have
> memalloc skbs either. It simply doesn't make any sense to waste
> memory reserves on skb which will be dropped anyway.
> 
> It appears that __dev_alloc_pages() unconditionally uses
> __GFP_MEMALLOC, so unless caller added __GFP_NOMEMALLOC, the
> __dev_alloc_pages() may dive into memory reserves.
> Later build_skb() or __skb_fill_page_desc() sets skb->pfmemalloc = 1
> so this skb always dropped by sk_filter_trim_cap().
> 
> Instead of wasting memory reserves we simply shouldn't use them in the
> case of absence memalloc sockets in the system. Do this by adding
> the  __GFP_MEMALLOC only when such socket is present in the system.
> 
> Fixes: 0614002bb5f7 ("netvm: propagate page->pfmemalloc from skb_alloc_page to skb")
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> ---
>  include/linux/skbuff.h | 17 ++++++++++++++++-
>  include/net/sock.h     | 15 ---------------
>  2 files changed, 16 insertions(+), 16 deletions(-)
>

Hi Andrey

Are you targeting net or net-next tree ?

AFAIK, drivers allocate skbs way before a frame is actually received,
(at RX ring buffer initialization or refill)

So sk_memalloc_socks() might be false at that time, but true later.

