Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAD7C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6E920882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIBpICZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439388AbfIWM2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:28:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33335 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730038AbfIWM2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:28:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so9080006pfl.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 05:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=03so5hEuCjEkXpyCihuO2zHclFe8bmVrBB9FSkG22OM=;
        b=RIBpICZ4WLYndiQAE/IeijNc44sypCjrVq2F/rtq1yhPQ9NZdaMvkepKWSx9IP+RCB
         VFgjBp41CN+U9SOM0z6zKmt2QD22vjncJ7DcgkvzjrIgKLGWiZ59TOV1pmvXTajfB2v+
         8C2m5MIcepSUwgIgo7UOpat5TfvNTXJl9BJ97PPautknwyPRVnE4s8WlOoCX0IJR3z3D
         ddQ1fA7SpVR5TSO8ISPsNqvbkry3cG0OgZXgfIWc8JwnbZv9lyjwJX2mDvCwagFQnnJG
         0dD0vLABMjcW5GMPo584H81m68SLOdI28aHSQutaU3ff5sNvLQm9oqfjutjX/U52RiZX
         OYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=03so5hEuCjEkXpyCihuO2zHclFe8bmVrBB9FSkG22OM=;
        b=QB4XHQvye5r1IW/uDZQUV+yJDcC6g14+oNE7fRMWI1YYLXcrfxu8bi0SfxaUeux+7/
         svwERoYzXQj7vKOT2btiZPEKbaK6VUj/o7B9sF6BA8KYDzELAwW9gHU6sQPA5aFWDdI/
         0Iw0RQ0ZXaXz27NzQdulPjh8CDwHrzhZw0A92QS2SEyuE8CeKsLEHbdYCpR4W28UrfAK
         s6gGlcQ5lEKiy2qz/mYyTieAU1hVav6PER2xc4tl9kyfzbKpL+iJn50v48CZ1Evd053c
         s7mVIK+YBs/P7aJ+NmsitX9VNTc66QH7mPvyP2XoxPnAfA7iZkqLe0YodIKH059BEJVz
         r/Lw==
X-Gm-Message-State: APjAAAV6/MBObzvaadubRhvZK9Jq8/t5+erjn1w1ye2FUaE0WlAbswm7
        G7D1pVkNeFrLvYyYV6BmCfA=
X-Google-Smtp-Source: APXvYqwZpb6ItWRvmMq63og4S7YIN/I1CMf6hXcfAa2rmtxx+hoZIsoJ8oCvQonRMDJxofpuhC+u8Q==
X-Received: by 2002:a63:504b:: with SMTP id q11mr28835160pgl.188.1569241684556;
        Mon, 23 Sep 2019 05:28:04 -0700 (PDT)
Received: from mi-OptiPlex-7050.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id 202sm9692016pfu.161.2019.09.23.05.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Sep 2019 05:28:04 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, guro@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v6 3/3] mm, slab_common: Use enum kmalloc_cache_type to iterate over kmalloc caches
Date:   Mon, 23 Sep 2019 20:27:28 +0800
Message-Id: <1569241648-26908-4-git-send-email-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569241648-26908-1-git-send-email-lpf.vector@gmail.com>
References: <1569241648-26908-1-git-send-email-lpf.vector@gmail.com>
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
index df030cf..23054b8 100644
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
2.7.4

