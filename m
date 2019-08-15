Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A66BC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C8F2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732810AbfHOTeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 15:34:31 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49046 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbfHOTeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 15:34:31 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9A4EA1400EDB8;
        Thu, 15 Aug 2019 12:34:30 -0700 (PDT)
Date:   Thu, 15 Aug 2019 12:34:30 -0700 (PDT)
Message-Id: <20190815.123430.831231953098536795.davem@davemloft.net>
To:     wenwen@cs.uga.edu
Cc:     rfontana@redhat.com, allison@lohutok.net, alexios.zavras@intel.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: pch_gbe: Fix memory leaks
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1565746427-5366-1-git-send-email-wenwen@cs.uga.edu>
References: <1565746427-5366-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 15 Aug 2019 12:34:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>
Date: Tue, 13 Aug 2019 20:33:45 -0500

> In pch_gbe_set_ringparam(), if netif_running() returns false, 'tx_old' and
> 'rx_old' are not deallocated, leading to memory leaks. To fix this issue,
> move the free statements after the if branch.
> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>

Why would they be "deallocated"?  They are still assigned to
adapter->tx_ring and adapter->rx_ring.
