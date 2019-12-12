Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41BAC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34D62073B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfLLTAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:00:24 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42672 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbfLLTAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 14:00:20 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B7C16153DFA42;
        Thu, 12 Dec 2019 11:00:19 -0800 (PST)
Date:   Thu, 12 Dec 2019 11:00:19 -0800 (PST)
Message-Id: <20191212.110019.462290546870002203.davem@davemloft.net>
To:     pdurrant@amazon.com
Cc:     netdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, jgross@suse.com,
        jakub.kicinski@netronome.com, wei.liu@kernel.org
Subject: Re: [PATCH net] xen-netback: avoid race that can lead to NULL
 pointer dereference
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191212123723.21548-1-pdurrant@amazon.com>
References: <20191212123723.21548-1-pdurrant@amazon.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 12 Dec 2019 11:00:20 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Durrant <pdurrant@amazon.com>
Date: Thu, 12 Dec 2019 12:37:23 +0000

> Commit 2ac061ce97f4 ("xen/netback: cleanup init and deinit code")
> introduced a problem. In function xenvif_disconnect_queue(), the value of
> queue->rx_irq is zeroed *before* queue->task is stopped. Unfortunately that
> task may call notify_remote_via_irq(queue->rx_irq) and calling that
> function with a zero value results in a NULL pointer dereference in
> evtchn_from_irq().
> 
> This patch simply re-orders things, stopping all tasks before zero-ing the
> irq values, thereby avoiding the possibility of the race.
> 
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>

Please repost this with an appropriate Fixes: tag.

And then you can removed the explicit commit reference from the log message
and simply say "The commit mentioned in the Fixes tag introduced a problen ..."
