Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DD8C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 23:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B26206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 23:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfFVXT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 19:19:56 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60772 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfFVXT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 19:19:56 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DD98B153E7EA2;
        Sat, 22 Jun 2019 16:19:55 -0700 (PDT)
Date:   Sat, 22 Jun 2019 16:19:55 -0700 (PDT)
Message-Id: <20190622.161955.2030310177158651781.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     sdf@google.com, jianbol@mellanox.com, jiri@mellanox.com,
        mirq-linux@rere.qmqm.pl, willemb@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] flow_dissector: Fix vlan header offset in
 __skb_flow_dissect
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190619160132.38416-1-yuehaibing@huawei.com>
References: <20190619160132.38416-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 22 Jun 2019 16:19:56 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 20 Jun 2019 00:01:32 +0800

> @@ -785,6 +785,9 @@ bool __skb_flow_dissect(const struct sk_buff *skb,
>  		    skb && skb_vlan_tag_present(skb)) {
>  			proto = skb->protocol;
>  		} else {
> +			if (dissector_vlan == FLOW_DISSECTOR_KEY_MAX)
> +				nhoff -=  sizeof(*vlan);

Even if this would have turned out to be the desired fix, you would need
to get rid of the extra spaces in that last statement.
