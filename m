Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7D9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA002084F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfCRX7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:59:03 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40614 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCRX7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:59:02 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 09DEA1411CCD3;
        Mon, 18 Mar 2019 16:59:01 -0700 (PDT)
Date:   Mon, 18 Mar 2019 16:59:01 -0700 (PDT)
Message-Id: <20190318.165901.946985780536286451.davem@davemloft.net>
To:     fthain@telegraphics.com.au
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] mac8390: Fix mmio access size probe
From:   David Miller <davem@davemloft.net>
In-Reply-To: <c45c87fd0c966243ac9065ae219a265cade69a83.1552706479.git.fthain@telegraphics.com.au>
References: <c45c87fd0c966243ac9065ae219a265cade69a83.1552706479.git.fthain@telegraphics.com.au>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 18 Mar 2019 16:59:02 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>
Date: Sat, 16 Mar 2019 14:21:19 +1100

> The bug that Stan reported is as follows. After a restart, a 16-bit NIC
> may be incorrectly identified as a 32-bit NIC and stop working.
> 
> mac8390 slot.E: Memory length resource not found, probing
> mac8390 slot.E: Farallon EtherMac II-C (type farallon)
> mac8390 slot.E: MAC 00:00:c5:30:c2:99, IRQ 61, 32 KB shared memory at 0xfeed0000, 32-bit access.
> 
> The bug never arises after a cold start and only intermittently after a
> warm start. (I didn't investigate why the bug is intermittent.)
> 
> It turns out that memcpy_toio() is deprecated and memcmp_withio() also
> has issues. Replacing these calls with mmio accessors fixes the problem.
> 
> Reported-and-tested-by: Stan Johnson <userm57@yahoo.com>
> Fixes: 2964db0f5904 ("m68k: Mac DP8390 update")
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Applied and queued up for -stable, thanks.
