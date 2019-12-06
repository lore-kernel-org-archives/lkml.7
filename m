Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F40C2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F4A24670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHT26K87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfLFPGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:06:14 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41030 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfLFPGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:06:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id s18so3466541pfd.8;
        Fri, 06 Dec 2019 07:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NOYIo2oX0lmkpQ6gBhcLLsx1plLM1LrdnXjWaPnIOcs=;
        b=MHT26K87lCwEl81XNb2/7lgyyJ+HGDXqay2wHsbsZ8dRm00ATs1ZlFFyv15xZPFJk9
         nTFDr6hon+qm1IWzBdl2dwnu5BNv7BFEjw0SncsazwZgtHzfQfAFZ3GJgpPUu03DNPho
         qdLUwi860CeukpEZCkpGJeE9Feim2dUf5l8uHmHwIDqJlB5Fr9NH/yBlaP6XE1BYVG6x
         ACcn+2FDx82wMKJ4ZYOxKCxGHpg/Yt5CAOZSriNe6Eplo/gGLLAHWfyP1zfYcM7/q+y2
         h5w4febplE5KwP7zNw9449T5Z6facbpeD8dG5QTIRaC2bYtPP5GyHzgSMB8Xoq/DEVnU
         53aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NOYIo2oX0lmkpQ6gBhcLLsx1plLM1LrdnXjWaPnIOcs=;
        b=A+CY60Yx1Qe4WKYXMKjPPw+WAsX1uHsh772d/UFWJw9DgV0Yw+9VDJ4NK6uym6L+a3
         kR/mcUBvxJCwNoLUTubLLKhYO9FsVKHB501OmxWj5gtbXL0qa5AtTu41JYhPQbFuPrHa
         jaCebaJkNBW+OmJvPC5W72yWwCHXBguO0FKgNW/aPQx5z3DzfIN6Zil8ARC6ozrF7h0m
         bbHGOLy/GiXduwjnAX6uXQNLlBmZ8k9N6ewGsuKV4CRcRenj93sBcfQ2bWE3BqZG2c10
         YmPUdywsJuqEezoXak7DjRpiq3z+YQIm6Kguc2QTQZ+zZhP1uXKIEbqcF4Ftr05DGz7P
         /CPQ==
X-Gm-Message-State: APjAAAUvo/YZu6crFbWaWXCczxEM9R7S4975rLJnYm/gOS+ZOuOFlLuk
        V/TbcGo35+IpVZi9hi2xjeU=
X-Google-Smtp-Source: APXvYqy8tpPjWstvqzrovfQv2CmvACSWRIy2k1sQcTmQAbqG08s4QK1DYir2i89I4Ra0SG3Z6TPQYg==
X-Received: by 2002:a63:d54f:: with SMTP id v15mr4100489pgi.64.1575644772732;
        Fri, 06 Dec 2019 07:06:12 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:13a2:f129:b905:c312:4008:2416])
        by smtp.gmail.com with ESMTPSA id j28sm15861041pgb.36.2019.12.06.07.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 07:06:12 -0800 (PST)
From:   madhuparnabhowmik04@gmail.com
To:     paulmck@kernel.org, rostedt@goodmis.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH] rculist: Add macro list_prev_rcu
Date:   Fri,  6 Dec 2019 20:35:54 +0530
Message-Id: <20191206150554.10479-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

There are instances in the linux kernel where the prev pointer
of a list is accessed.
Unlike list_next_rcu, a similar macro for accessing the prev
pointer was not present.
Therefore, directly accessing the prev pointer was causing
sparse errors.
One such example is the sparse error in fs/nfs/dir.c

error:
fs/nfs/dir.c:2353:14: error: incompatible types in comparison expression (different address spaces):
fs/nfs/dir.c:2353:14:    struct list_head [noderef] <asn:4> *
fs/nfs/dir.c:2353:14:    struct list_head *

The error is caused due to the following line:

lh = rcu_dereference(nfsi->access_cache_entry_lru.prev);

After adding the macro, this error can be fixed as follows:

lh = rcu_dereference(list_prev_rcu(&nfsi->access_cache_entry_lru));

Therefore, we think there is a need to add this macro to rculist.h.

Suggested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 include/linux/rculist.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 4b7ae1bf50b3..49eef8437753 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -40,6 +40,12 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
  */
 #define list_next_rcu(list)	(*((struct list_head __rcu **)(&(list)->next)))
 
+/*
+ * return the prev pointer of a list_head in an rcu safe
+ * way, we must not access it directly
+ */
+#define list_prev_rcu(list)	(*((struct list_head __rcu **)(&(list)->prev)))
+
 /*
  * Check during list traversal that we are within an RCU reader
  */
-- 
2.17.1

