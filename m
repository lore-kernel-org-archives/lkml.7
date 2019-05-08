Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65565C04AAD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311D2214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="P9wByt6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfEHAjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 20:39:06 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35022 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfEHAjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 20:39:05 -0400
Received: by mail-qk1-f196.google.com with SMTP id c15so2195041qkl.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 17:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v9eQGAXN/pUrwyhsEw4eGQ0SnWi81FsI3CN7zGHdMUY=;
        b=P9wByt6X7/7EYnOVIL+L4niq5xhOsA7fNdy5JhqzkC2EDOnh6kD8+oRsJPsdP6yTAn
         hLOOu+3ZGncE0jEbvAgByRNnn70mDcYt296iT4kYbIIRgE08hQwnom7YGmfQFAlW7PuJ
         AVzyFOjo2yMMctzMlPy4UQ2Fmb9VpcnsvuYK+LZq8s+L4PYPPbPbnkUHyECTP0kIK0dp
         QEKXyP6+DptIl+Lf3PfBMTTdDKxsia6+spQ8TnQAz+BbJ3V3To/mQEbKLRPX/n61dog3
         aLGMxm+ZD71/nRb/gNTB/S1yrclRU6Q4FfuaDiG8F82F17ceo/iPfDSsqiOwQ5uC/C6P
         iKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v9eQGAXN/pUrwyhsEw4eGQ0SnWi81FsI3CN7zGHdMUY=;
        b=oQ7p6/3a1U7nX95u+R0SeMyYNouQ3C458U4vy6FHbKbPHdbMjPvIIbgjZXpZJ8ftmM
         kVrpWeTlBaMb9mvJfwF0TTuII2OKrWJnCWzvnFR4x+BcKgDPE9Rgm3nCZIt219Nt/Bsd
         yY3X0XFQX4aTQzZj4ANxjnv/Z6Txp4ExKu8D4QVOQp90DNpyG1BCOpEICn8Wyw2iZ1NZ
         mPyVKifIROivM/X7F+EjQXH/2crA7FUpelIHdP7UMVCnADM9Y96emZQt1GteBs2HfLZ9
         ILxTK8YVAfwGhSZMOoKzM4CvjQa5cfICCKWZ/i88kruaiXkV04KKFldt/fe6DEVh+Be1
         7xOg==
X-Gm-Message-State: APjAAAWI+yBLYijlh/5WuFe+bH/3R5r3ZqUekP+9lJLfqNrWfpIbXIEM
        r26vMBEbAnrqZjIIyOXSBSBwWA==
X-Google-Smtp-Source: APXvYqx3wh7S/VSM6RE3kBIPQ5Eso3w/I/f0YhknfHS271wzjV4Ff5Ktu4I1WFAP3qSFDXkbyyk1vw==
X-Received: by 2002:ae9:d844:: with SMTP id u65mr25749828qkf.310.1557275944782;
        Tue, 07 May 2019 17:39:04 -0700 (PDT)
Received: from ovpn-121-162.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o37sm8153984qte.55.2019.05.07.17.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 17:39:03 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, catalin.marinas@arm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] slab: skip kmemleak_object in leaks_show()
Date:   Tue,  7 May 2019 20:38:38 -0400
Message-Id: <20190508003838.62264-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running tests on a debug kernel will usually generate a large number of
kmemleak objects.

  # grep kmemleak /proc/slabinfo
  kmemleak_object   2243606 3436210 ...

As the result, reading /proc/slab_allocators could easily loop forever
while processing the kmemleak_object cache and any additional freeing or
allocating objects will trigger a reprocessing. To make a situation
worse, soft-lockups could easily happen in this sitatuion which will
call printk() to allocate more kmemleak objects to guarantee a livelock.

Since kmemleak_object has a single call site (create_object()), there
isn't much new information compared with slabinfo. Just skip it.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/slab.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/slab.c b/mm/slab.c
index 20f318f4f56e..85d1d223f879 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -4285,6 +4285,15 @@ static int leaks_show(struct seq_file *m, void *p)
 	if (!(cachep->flags & SLAB_RED_ZONE))
 		return 0;
 
+	/*
+	 * /proc/slabinfo has the same information, so skip kmemleak here due to
+	 * a high volume and its RCU free could make cachep->store_user_clean
+	 * dirty all the time.
+	 */
+	if (IS_ENABLED(CONFIG_DEBUG_KMEMLEAK) &&
+	    !strcmp("kmemleak_object", cachep->name))
+		return 0;
+
 	/*
 	 * Set store_user_clean and start to grab stored user information
 	 * for all objects on this cache. If some alloc/free requests comes
-- 
2.20.1 (Apple Git-117)

