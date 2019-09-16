Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3288AC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08EC221670
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0IZ2qlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732620AbfIPOqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 10:46:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45957 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732374AbfIPOqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 10:46:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so10087pfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jCVsoiANbO0A0rAsPONqC8CmNnKvwITi8BzVSSbb6XQ=;
        b=l0IZ2qlWNiFhcK1qlGvKwC1wuMV95H42NFba70/jxZptHT9Rbemzw5VlpIuap1kS+d
         BX18/2l1ApbcJoKmv7zOkvQWoHljxRBunQDUfccRw5l0+ZqMcxOpjERJlc9byEy5VUuq
         MWOBQ0M7hMpOYmGcR2h8EG7yBUrQq0nQg6fHWj+QbiUV5M0fE6m3/t+dKCJuaMg/9k2r
         bqJTJSajXVA6+5QTIUssK8713gmQXTyFyEr7269syveyZwN1RGjO9pj6xW/eYT+/OpxV
         hGVhx+/ZSgzb+S+Qm6Gvj8RJ/X5TPS6XSU4KeA2bI8MZOvJw62IsUUx1+lSiKCDVfpTG
         5F8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jCVsoiANbO0A0rAsPONqC8CmNnKvwITi8BzVSSbb6XQ=;
        b=IqTz7TxQLMNdVGTgcITTxUwaHaOvDN1syLZ0om1VeM1uzIDbCBIIyTaNUpXOR0tR4o
         BosxNmIbmFpw1aNol69fhDjxeHZkxDu7Wv0T7FOdzny08sGqATvaiUUw+8S1aR8RDiIA
         ccmAcwssCnIXbvRjmZdHV189esUXmrfxsKz3J7uOV5ne1i/LLOVRfsHb4306zZo/1os0
         zqp4K8RVH80yknEgM75EVNamzoNUTVaQ54ezfn8gHAu8bsfwvQZ9LqAx5ipEI7LxSSRV
         t55ms3l3g4HSeSshHhYRmEHYLG+6b/TlduzTdsxKjKXYXC9ehTMo3wg/Oo9EKT7tfaj4
         DinQ==
X-Gm-Message-State: APjAAAUYSnfa+e7e7nXY3KWwZiPAyePm17D5mDPjpnPGo8OsYtGaRs+w
        OpUHmdMoes496VMU0afkKl0=
X-Google-Smtp-Source: APXvYqyyA+wz35DCND9zfqzqpU24YpmTLwayeIV3v5e/r0L7Cl3JOR/qARquRdKD/5+zmkGiT5juiw==
X-Received: by 2002:a17:90a:ca0e:: with SMTP id x14mr108909pjt.70.1568645214399;
        Mon, 16 Sep 2019 07:46:54 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:160:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id d190sm15036004pgc.25.2019.09.16.07.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 07:46:53 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v5 3/7] mm, slab_common: Use enum kmalloc_cache_type to iterate over kmalloc caches
Date:   Mon, 16 Sep 2019 22:45:54 +0800
Message-Id: <20190916144558.27282-4-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916144558.27282-1-lpf.vector@gmail.com>
References: <20190916144558.27282-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type of local variable *type* of new_kmalloc_cache() should
be enum kmalloc_cache_type instead of int, so correct it.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 mm/slab_common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index df030cf9f44f..23054b8b75b6 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1192,7 +1192,7 @@ void __init setup_kmalloc_cache_index_table(void)
 }
 
 static void __init
-new_kmalloc_cache(int idx, int type, slab_flags_t flags)
+new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
 {
 	if (type == KMALLOC_RECLAIM)
 		flags |= SLAB_RECLAIM_ACCOUNT;
@@ -1210,7 +1210,8 @@ new_kmalloc_cache(int idx, int type, slab_flags_t flags)
  */
 void __init create_kmalloc_caches(slab_flags_t flags)
 {
-	int i, type;
+	int i;
+	enum kmalloc_cache_type type;
 
 	for (type = KMALLOC_NORMAL; type <= KMALLOC_RECLAIM; type++) {
 		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
-- 
2.21.0

