Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387E9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F7C2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfC2AQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:16:42 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59274 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbfC2AQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:16:42 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4F82314D68F8F;
        Thu, 28 Mar 2019 17:16:41 -0700 (PDT)
Date:   Thu, 28 Mar 2019 17:16:40 -0700 (PDT)
Message-Id: <20190328.171640.1161931383487396254.davem@davemloft.net>
To:     andrea.righi@canonical.com
Cc:     pshelar@ovn.org, netdev@vger.kernel.org, dev@openvswitch.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] openvswitch: fix flow actions reallocation
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190328063600.GC16096@xps-13>
References: <20190328063600.GC16096@xps-13>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 28 Mar 2019 17:16:41 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Righi <andrea.righi@canonical.com>
Date: Thu, 28 Mar 2019 07:36:00 +0100

> The flow action buffer can be resized if it's not big enough to contain
> all the requested flow actions. However, this resize doesn't take into
> account the new requested size, the buffer is only increased by a factor
> of 2x. This might be not enough to contain the new data, causing a
> buffer overflow, for example:
> 
> [   42.044472] =============================================================================
> [   42.045608] BUG kmalloc-96 (Not tainted): Redzone overwritten
> [   42.046415] -----------------------------------------------------------------------------
> 
> [   42.047715] Disabling lock debugging due to kernel taint
> [   42.047716] INFO: 0x8bf2c4a5-0x720c0928. First byte 0x0 instead of 0xcc
> [   42.048677] INFO: Slab 0xbc6d2040 objects=29 used=18 fp=0xdc07dec4 flags=0x2808101
> [   42.049743] INFO: Object 0xd53a3464 @offset=2528 fp=0xccdcdebb
> 
> [   42.050747] Redzone 76f1b237: cc cc cc cc cc cc cc cc                          ........
> [   42.051839] Object d53a3464: 6b 6b 6b 6b 6b 6b 6b 6b 0c 00 00 00 6c 00 00 00  kkkkkkkk....l...
> [   42.053015] Object f49a30cc: 6c 00 0c 00 00 00 00 00 00 00 00 03 78 a3 15 f6  l...........x...
> [   42.054203] Object acfe4220: 20 00 02 00 ff ff ff ff 00 00 00 00 00 00 00 00   ...............
> [   42.055370] Object 21024e91: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [   42.056541] Object 070e04c3: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [   42.057797] Object 948a777a: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [   42.059061] Redzone 8bf2c4a5: 00 00 00 00                                      ....
> [   42.060189] Padding a681b46e: 5a 5a 5a 5a 5a 5a 5a 5a                          ZZZZZZZZ
> 
> Fix by making sure the new buffer is properly resized to contain all the
> requested data.
> 
> BugLink: https://bugs.launchpad.net/bugs/1813244
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>

Applied and queued up for -stable.

Althought next time I want to see a proper Fixes: tag.
