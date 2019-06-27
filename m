Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2F7C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63ED92182B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfF0C25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:28:57 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45630 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfF0C24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 22:28:56 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8E26414DE6387;
        Wed, 26 Jun 2019 19:28:53 -0700 (PDT)
Date:   Wed, 26 Jun 2019 19:28:29 -0700 (PDT)
Message-Id: <20190626.192829.1694521513812984310.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     sdf@google.com, jianbol@mellanox.com, jiri@mellanox.com,
        mirq-linux@rere.qmqm.pl, willemb@google.com, sdf@fomichev.me,
        jiri@resnulli.us, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2] flow_dissector: Fix vlan header offset in
 __skb_flow_dissect
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190624034913.40328-1-yuehaibing@huawei.com>
References: <20190622.161955.2030310177158651781.davem@davemloft.net>
        <20190624034913.40328-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 26 Jun 2019 19:28:53 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 24 Jun 2019 11:49:13 +0800

> @@ -998,6 +998,9 @@ bool __skb_flow_dissect(const struct net *net,
>  		    skb && skb_vlan_tag_present(skb)) {
>  			proto = skb->protocol;
>  		} else {
> +			if (dissector_vlan == FLOW_DISSECTOR_KEY_MAX)
> +				nhoff -= sizeof(*vlan);
> +

But this is wrong when we are being called via eth_get_headlen(), in
that case nhoff will be sizeof(struct ethhdr).
