Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF2AC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 17:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E851320679
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 17:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733235AbfHARIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 13:08:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57262 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbfHARIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 13:08:49 -0400
Received: from localhost (c-24-22-75-21.hsd1.or.comcast.net [24.22.75.21])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 887B6153F2276;
        Thu,  1 Aug 2019 10:08:48 -0700 (PDT)
Date:   Thu, 01 Aug 2019 13:08:47 -0400 (EDT)
Message-Id: <20190801.130847.1845352143685364558.davem@davemloft.net>
To:     mcroce@redhat.com
Cc:     netdev@vger.kernel.org, miquel.raynal@free-electrons.com,
        linux-kernel@vger.kernel.org, lorenzo@kernel.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        mw@semihalf.com, stefanc@marvell.com
Subject: Re: [PATCH net v2] mvpp2: fix panic on module removal
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190801121330.30823-1-mcroce@redhat.com>
References: <20190801121330.30823-1-mcroce@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 01 Aug 2019 10:08:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@redhat.com>
Date: Thu,  1 Aug 2019 14:13:30 +0200

> mvpp2 uses a delayed workqueue to gather traffic statistics.
> On module removal the workqueue can be destroyed before calling
> cancel_delayed_work_sync() on its works.
> Fix it by moving the destroy_workqueue() call after mvpp2_port_remove().
> Also remove an unneeded call to flush_workqueue()
 ...
> Fixes: 118d6298f6f0 ("net: mvpp2: add ethtool GOP statistics")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Matteo Croce <mcroce@redhat.com>

Applied and queued up for -stable, thanks.
