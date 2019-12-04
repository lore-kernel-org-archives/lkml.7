Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2F1C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F54020863
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482774;
	bh=cvFZvCXWVi56kGin9wBixbYsa4vDrv6sQdpsJCuvV0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IBtlE5AgydCyUQP1K54jjRvNjjh+WZsXPqtke8T8dr1P6uNtBUJcfALZe6Sop5/yh
	 uVsaDwHe5iyG2WmGVduCB+gTYZsGZeNd36YT9M1rJ9H3/HHm/bbrVriOvF8evgay98
	 eSU1prsMhWHs0jX/vSsdOmUd/IVT4rTMNo5U4ZZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfLDSGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:06:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:53790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730495AbfLDSGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:06:06 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB03E2081B;
        Wed,  4 Dec 2019 18:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482766;
        bh=cvFZvCXWVi56kGin9wBixbYsa4vDrv6sQdpsJCuvV0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MyTA0fVhOQuflOBBTZOlyyJnbxCXb6/I6ePS00chuMVMLATqTX2eFTjiGRW9q+LUn
         GXBuOH+/zHEoYtOXvMrWeyU3KABHweyyWcVS0yY2xrOuYKm319r3W53cX6ei9LkWN5
         epohRcyuBcX4tRECFP9GGRvA6Peh+RtQlksflUU0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huang Shijie <sjhuang@iluvatar.ai>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Skidanov <alexey.skidanov@intel.com>,
        Olof Johansson <olof@lixom.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 125/209] lib/genalloc.c: include vmalloc.h
Date:   Wed,  4 Dec 2019 18:55:37 +0100
Message-Id: <20191204175331.680647044@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



