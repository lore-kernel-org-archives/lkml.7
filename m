Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A36C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 15:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6149920693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 15:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="D/eG7DaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387876AbfGPPnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 11:43:22 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38414 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfGPPnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 11:43:22 -0400
Received: by mail-qt1-f196.google.com with SMTP id n11so20044360qtl.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 08:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HUkhdlpY8O9DhVB5JjD9+mrau6suzYr7ThtC/VAQnfg=;
        b=D/eG7DaMz+K+X/j2e4WXXImKmoHdpLHwJgRufd9mo7TAVOPJir5pFKV7/huZQ3cD+l
         69OhEbK0K9h+jPTi+FAY5PphnqNRL969QOyninB1HYW5o1FxKM1BqA7khjuErrFk7fRN
         m8trnMFm/NTrZdjerq9StIgyik6D+SSxNCsPn5zOUoWIntQIvvad90mqBb6eaNKvRu1w
         sEwNlyVQyOk0qUchyMmTQamM41O5rifeNjCeu6Um1o3PK/OTscBo8afbogJNIYR1dIQc
         xB2ooykfuazI07UTNDjvMcF9iGJeJl+5trAy+RGQSR2KaubIMlwFGI/Co6RoLNKSxkFf
         Kb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HUkhdlpY8O9DhVB5JjD9+mrau6suzYr7ThtC/VAQnfg=;
        b=JSsf0Tg6QCLO/qj82EE0Gpu6RvFOqivTLtBAs+DvcgzCLduRUVzLQD9ZmlcKKf/owl
         4PnktJhlX08Er8OBWKFSH5xvMvhq2s8Xgh6gfGQ4Jv0CMnRqs3meo5dff2KrlmYzqr8X
         VrkVk22YH6SG7pXZoy4br+pGwsOqZ5ZnlsOUJpcUcMtNRlml84ed/Dg7Agscs/saS8Jv
         Rt+ijIEutsjAOLVtLJscVNGcVAT6du2S5fWa7yVmAuGtvWfpIOlQD9mrrE/kKs7wwRWW
         IWDx3N2s79nlqzqgo1TX2T6Z0QtjEUvlp2SCsdxydwqdpC22pL7mS2yowil+30IQnUnA
         xmYQ==
X-Gm-Message-State: APjAAAXfNSDLWrKq3qFka08LTk4HH5yhJd99vfAKuCXG5MBHb4y1X879
        yVmVbzRSjP+YbN6Ks9OA50Cluw==
X-Google-Smtp-Source: APXvYqziF0Am/gJ6agFPVgTLL02H3QfeTA1r0+V1RqZ52+RBXRqHc+yXcYhiMN300jLtsiqUyiaX/w==
X-Received: by 2002:ac8:275a:: with SMTP id h26mr23194639qth.345.1563291801305;
        Tue, 16 Jul 2019 08:43:21 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r5sm9623617qkc.42.2019.07.16.08.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 08:43:20 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     davem@davemloft.net
Cc:     willemb@google.com, joe@perches.com,
        clang-built-linux@googlegroups.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH net v2] skbuff: fix compilation warnings in skb_dump()
Date:   Tue, 16 Jul 2019 11:43:05 -0400
Message-Id: <1563291785-6545-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 6413139dfc64 ("skbuff: increase verbosity when dumping skb
data") introduced a few compilation warnings.

net/core/skbuff.c:766:32: warning: format specifies type 'unsigned
short' but the argument has type 'unsigned int' [-Wformat]
                       level, sk->sk_family, sk->sk_type,
sk->sk_protocol);
                                             ^~~~~~~~~~~
net/core/skbuff.c:766:45: warning: format specifies type 'unsigned
short' but the argument has type 'unsigned int' [-Wformat]
                       level, sk->sk_family, sk->sk_type,
sk->sk_protocol);
^~~~~~~~~~~~~~~

Fix them by using the proper types.

Fixes: 6413139dfc64 ("skbuff: increase verbosity when dumping skb data")
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: Drop the checkpatch fix as it seems a bit more involved that it does not
    even like passing a variable to it, i.e., printk(level "msg"). Also,
    print_hex_dump() seems need a fix to be complete which can probably be done
    later.

 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6f1e31f674a3..0338820ee0ec 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -762,7 +762,7 @@ void skb_dump(const char *level, const struct sk_buff *skb, bool full_pkt)
 		printk("%sdev name=%s feat=0x%pNF\n",
 		       level, dev->name, &dev->features);
 	if (sk)
-		printk("%ssk family=%hu type=%hu proto=%hu\n",
+		printk("%ssk family=%hu type=%u proto=%u\n",
 		       level, sk->sk_family, sk->sk_type, sk->sk_protocol);
 
 	if (full_pkt && headroom)
-- 
1.8.3.1

