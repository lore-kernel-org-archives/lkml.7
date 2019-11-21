Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189A5C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47F420692
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKUXEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:04:05 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55036 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfKUXEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:04:04 -0500
Received: from localhost (c-73-35-209-67.hsd1.wa.comcast.net [73.35.209.67])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3722C150ABF39;
        Thu, 21 Nov 2019 15:04:04 -0800 (PST)
Date:   Thu, 21 Nov 2019 15:04:03 -0800 (PST)
Message-Id: <20191121.150403.2184487688856616276.davem@davemloft.net>
To:     fw@strlen.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        pabeni@redhat.com, gandalf@winds.org
Subject: Re: [PATCH net] udp: drop skb extensions before marking skb
 stateless
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191121055623.20952-1-fw@strlen.de>
References: <20191121053031.GI20235@breakpoint.cc>
        <20191121055623.20952-1-fw@strlen.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 21 Nov 2019 15:04:04 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>
Date: Thu, 21 Nov 2019 06:56:23 +0100

> Once udp stack has set the UDP_SKB_IS_STATELESS flag, later skb free
> assumes all skb head state has been dropped already.
> 
> This will leak the extension memory in case the skb has extensions other
> than the ipsec secpath, e.g. bridge nf data.
> 
> To fix this, set the UDP_SKB_IS_STATELESS flag only if we don't have
> extensions or if the extension space can be free'd.
> 
> Fixes: 895b5c9f206eb7d25dc1360a ("netfilter: drop bridge nf reset from nf_reset")
> Cc: Paolo Abeni <pabeni@redhat.com>
> Reported-by: Byron Stanoszek <gandalf@winds.org>
> Signed-off-by: Florian Westphal <fw@strlen.de>

Applied, thanks Florian.
