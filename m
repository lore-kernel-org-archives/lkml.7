Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EC0C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16E420659
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402437;
	bh=cvFZvCXWVi56kGin9wBixbYsa4vDrv6sQdpsJCuvV0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qYu4UDaKoHGqECuJtTdu8zW1u4LDoBZ0gcktukeFdfF/XodafTwI6WOo+p0g04jnk
	 MFxJMUycvwx/ZwpVICyuCNbD2ZWEi7l4+GtXPNa/C7grZZ0yd7twQ3Rbk4aBJyXYSm
	 ZGvgQBGZWA/8K3VTtN08IshXvg8CHqdVGiieQQjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfKVGAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:00:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbfKVF5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:57:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DEAA20721;
        Fri, 22 Nov 2019 05:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402255;
        bh=cvFZvCXWVi56kGin9wBixbYsa4vDrv6sQdpsJCuvV0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rkeOXIy5CMQNACZi+RZM/3z5sELXrbWvbv64xXi3j5jYNHR+NYbY3/X++ZEGBuWlk
         Sz7sfdif79+Ybib86p2WJR/+oiXBE0RkMHvFWQFUoxFz3fhmMdQiFZpHT0yJPyc/u5
         BGwGdogthMaDTs+pzUTGueeiUVkEnTMIiFNPrcU8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Olof Johansson <olof@lixom.net>,
        Huang Shijie <sjhuang@iluvatar.ai>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Skidanov <alexey.skidanov@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 097/127] lib/genalloc.c: include vmalloc.h
Date:   Fri, 22 Nov 2019 00:55:15 -0500
Message-Id: <20191122055544.3299-96-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122055544.3299-1-sashal@kernel.org>
References: <20191122055544.3299-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olof Johansson <olof@lixom.net>

[ Upstream commit 35004f2e55807a1a1491db24ab512dd2f770a130 ]

Fixes build break on most ARM/ARM64 defconfigs:

  lib/genalloc.c: In function 'gen_pool_add_virt':
  lib/genalloc.c:190:10: error: implicit declaration of function 'vzalloc_node'; did you mean 'kzalloc_node'?
  lib/genalloc.c:190:8: warning: assignment to 'struct gen_pool_chunk *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
  lib/genalloc.c: In function 'gen_pool_destroy':
  lib/genalloc.c:254:3: error: implicit declaration of function 'vfree'; did you mean 'kfree'?

Fixes: 6862d2fc8185 ('lib/genalloc.c: use vzalloc_node() to allocate the bitmap')
Cc: Huang Shijie <sjhuang@iluvatar.ai>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexey Skidanov <alexey.skidanov@intel.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/genalloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/genalloc.c b/lib/genalloc.c
index f365d71cdc774..7e85d1e37a6ea 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -35,6 +35,7 @@
 #include <linux/interrupt.h>
 #include <linux/genalloc.h>
 #include <linux/of_device.h>
+#include <linux/vmalloc.h>
 
 static inline size_t chunk_size(const struct gen_pool_chunk *chunk)
 {
-- 
2.20.1

