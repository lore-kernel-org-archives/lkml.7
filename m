Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6E2C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D513208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561053663;
	bh=a/1GfeBAV+OW7g05LGfi9Pc5yqXULZUr//lb0XNGTPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MWxWl8B48KSA8rcN4PQm19pQfchVfEtlCwwQeeFVoh2JAsNJ6F9mQxH5ljCAtEAPQ
	 QzI/MYr3Co+N/Abn8zFnXYy5RunwRDRlSNUbPhWsPn21/506coDPWDnq6clNV3W6Ht
	 /x1ueJGcmUaMcqWdlfhgeWQoE6Y2fuJH4921crTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfFTSBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbfFTSA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:00:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EE802089C;
        Thu, 20 Jun 2019 18:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053659;
        bh=a/1GfeBAV+OW7g05LGfi9Pc5yqXULZUr//lb0XNGTPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6ro1axeO8grHxJZHnKZrKKJD79Pf/zKUDAKc34GsERF7K5g5rpcjBmPNdANT5bMT
         EvITjWljVWWJlpnf1M2SyYPRlyaTTBsJodS8zClgYPyPjnjjsGF31Lpx5HOc6pEk4d
         2+PoztdpV0Mg0DQxpL4GGQ48uLxcvd7nggdT3dkk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, ZhangXiaoxu <zhangxiaoxu5@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.4 38/84] futex: Fix futex lock the wrong page
Date:   Thu, 20 Jun 2019 19:56:35 +0200
Message-Id: <20190620174343.863170360@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174337.538228162@linuxfoundation.org>
References: <20190620174337.538228162@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangXiaoxu <zhangxiaoxu5@huawei.com>

The upstram commit 65d8fc777f6d ("futex: Remove requirement
for lock_page() in get_futex_key()") use variable 'page' as
the page head, when merge it to stable branch, the variable
`page_head` is page head.

In the stable branch, the variable `page` not means the page
head, when lock the page head, we should lock 'page_head',
rather than 'page'.

It maybe lead a hung task problem.

Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
Cc: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/futex.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -593,8 +593,8 @@ again:
 		 * applies. If this is really a shmem page then the page lock
 		 * will prevent unexpected transitions.
 		 */
-		lock_page(page);
-		shmem_swizzled = PageSwapCache(page) || page->mapping;
+		lock_page(page_head);
+		shmem_swizzled = PageSwapCache(page_head) || page_head->mapping;
 		unlock_page(page_head);
 		put_page(page_head);
 


