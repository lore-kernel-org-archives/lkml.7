Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C52C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 06:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D602089D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 06:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfKUGU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 01:20:59 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37110 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfKUGU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 01:20:58 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0B20B14DDE4E5;
        Wed, 20 Nov 2019 22:20:57 -0800 (PST)
Date:   Wed, 20 Nov 2019 22:20:57 -0800 (PST)
Message-Id: <20191120.222057.2167261859714910483.davem@davemloft.net>
To:     andrea.mayer@uniroma2.it
Cc:     sergei.shtylyov@cogentembedded.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, dav.lebrun@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next, v2] seg6: allow local packet processing for SRv6
 End.DT6 behavior
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191118222558.2973-1-andrea.mayer@uniroma2.it>
References: <20191118222558.2973-1-andrea.mayer@uniroma2.it>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 20 Nov 2019 22:20:58 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Mayer <andrea.mayer@uniroma2.it>
Date: Mon, 18 Nov 2019 23:25:58 +0100

> @@ -199,6 +207,12 @@ int seg6_lookup_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
>  	return dst->error;
>  }
>  
> +inline int seg6_lookup_nexthop(struct sk_buff *skb,
> +			       struct in6_addr *nhaddr, u32 tbl_id)

Do not use the inline keyword in foo.c files, let the compiler decide.
