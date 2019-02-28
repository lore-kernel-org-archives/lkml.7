Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC62C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FB4218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbfB1VCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:02:14 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38740 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfB1VCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:02:14 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C788C14BFD00D;
        Thu, 28 Feb 2019 13:02:13 -0800 (PST)
Date:   Thu, 28 Feb 2019 13:02:13 -0800 (PST)
Message-Id: <20190228.130213.1481374802407995712.davem@davemloft.net>
To:     fruggeri@arista.com
Cc:     yoshfuji@linux-ipv6.org, kuznet@ms2.inr.ac.ru, maxim@arista.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: ipv6: check net in ip6_call_ra_chain
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190228190146.802CD95C016B@us180.sjc.aristanetworks.com>
References: <20190228190146.802CD95C016B@us180.sjc.aristanetworks.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 28 Feb 2019 13:02:14 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: fruggeri@arista.com (Francesco Ruggeri)
Date: Thu, 28 Feb 2019 11:01:46 -0800

> ip6_call_ra_chain is called when IPv6 packet with Router Alert option
> is forwarded.
> It needs to check if the net of the socket is the same as the net of the
> input device, otherwise the packet gets delivered to every IPv6 socket
> listening for Router Alerts, no matter which network namespace it is in.
> 
> Suggested-by: Maxim Martynov <maxim@arista.com>
> Signed-off-by: Maxim Martynov <maxim@arista.com>
> Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>

Right now someone using such a tool does get all RAs in the system.

Your change not only breaks them, but also gives them no method by
which to keep obtaining the same behavior.

I don't know what to do or suggest in this situation, but right now
I'm putting this patch on hold.
