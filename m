Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE2DC10F06
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16301218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfC2A2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:28:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59478 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbfC2A23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:28:29 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E2CB514D69449;
        Thu, 28 Mar 2019 17:28:28 -0700 (PDT)
Date:   Thu, 28 Mar 2019 17:28:28 -0700 (PDT)
Message-Id: <20190328.172828.880898031515380835.davem@davemloft.net>
To:     alobakin@dlink.ru
Cc:     ecree@solarflare.com, jiri@mellanox.com, idosch@mellanox.com,
        petrm@mellanox.com, alexander.h.duyck@intel.com,
        amritha.nambiar@intel.com, lirongqing@baidu.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: core: netif_receive_skb_list: unlist skb before
 passing to pt->func
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190328152304.8297-1-alobakin@dlink.ru>
References: <20190328152304.8297-1-alobakin@dlink.ru>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 28 Mar 2019 17:28:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <alobakin@dlink.ru>
Date: Thu, 28 Mar 2019 18:23:04 +0300

> __netif_receive_skb_list_ptype() leaves skb->next poisoned before passing
> it to pt_prev->func handler, what may produce (in certain cases, e.g. DSA
> setup) crashes like:
 ...
> Fix this by pulling skb off the sublist and zeroing skb->next pointer
> before calling ptype callback.
> 
> Fixes: 88eb1944e18c ("net: core: propagate SKB lists through packet_type lookup")
> Reviewed-by: Edward Cree <ecree@solarflare.com>
> Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>

Applied and queued up for -stable, thanks.
