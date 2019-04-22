Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4389DC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE98218FC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962314;
	bh=ayBwbVMY9vgfYN51KPq6lqqiETptuAceXX80LCYaM4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zXay9u6FUo65nu2BsoZyO9A1hCyEDAfWqIAgnlMXYzcNpWkEJU3Li4Mz/tz5SD5Qr
	 2W/Rl6kY5ug+dWT2Zq4+sKLZX2ZeY1HD5Vm2R8fHGLr7x+IZ0vVffuvHe8kHKeS9Cu
	 CHWqBw6kpw7SPmR0WQj4K3oX70kIHoVgZ3WlhEC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbfDVTpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:45:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729676AbfDVTpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:45:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9521218FC;
        Mon, 22 Apr 2019 19:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962309;
        bh=ayBwbVMY9vgfYN51KPq6lqqiETptuAceXX80LCYaM4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bGeZS1uwcI9daP4jNXauOuysr3JJkNmwGkycS3aQUU8YFud/ZfaV+145hai1yPyn8
         CYFyrclvlMk0E6s3KYbb/YucUwyWXgsTHOScAu6rmMgRyJO1CBgdi3QPRZWkOaT5ag
         SiNp6HpYvCExLoq3UuK8rDCVFBEjFVr6Ip8VPLaE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
Subject: [PATCH AUTOSEL 5.0 95/98] kasan: fix variable 'tag' set but not used warning
Date:   Mon, 22 Apr 2019 15:42:02 -0400
Message-Id: <20190422194205.10404-95-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>

[ Upstream commit c412a769d2452161e97f163c4c4f31efc6626f06 ]

set_tag() compiles away when CONFIG_KASAN_SW_TAGS=n, so make
arch_kasan_set_tag() a static inline function to fix warnings below.

  mm/kasan/common.c: In function '__kasan_kmalloc':
  mm/kasan/common.c:475:5: warning: variable 'tag' set but not used [-Wunused-but-set-variable]
    u8 tag;
       ^~~

Link: http://lkml.kernel.org/r/20190307185244.54648-1-cai@lca.pw
Signed-off-by: Qian Cai <cai@lca.pw>
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 mm/kasan/kasan.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index ea51b2d898ec..c980ce43e3ba 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -164,7 +164,10 @@ static inline u8 random_tag(void)
 #endif
 
 #ifndef arch_kasan_set_tag
-#define arch_kasan_set_tag(addr, tag)	((void *)(addr))
+static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
+{
+	return addr;
+}
 #endif
 #ifndef arch_kasan_reset_tag
 #define arch_kasan_reset_tag(addr)	((void *)(addr))
-- 
2.19.1

