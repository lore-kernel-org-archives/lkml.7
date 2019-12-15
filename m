Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C900C2D0CB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 06:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02862206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 06:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XC4ph8XT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfLOGwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 01:52:54 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40124 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfLOGwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 01:52:54 -0500
Received: by mail-qk1-f195.google.com with SMTP id c17so1906991qkg.7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 22:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tPZKrwWHh4ylX/L5NKvv2t0yL6XxsGTIa4rI25XVHaU=;
        b=XC4ph8XTKEbCfmSYn/0bCW3gJdKJo42LALdj6mKZTw9GF31Pba4nVWGInUNIvg3l25
         XJsX4Kr4mcnahIdFkpNu1mOB5aPMly2+tDXaFLlfLdjPH/bhFQhZVXEZX5ap7HxtlUBl
         IZAoi3qM0uru+a3wK22RNfRtkU3gpYSSOqtD2P9I/QWgeLn4+upDMlvx6ae9MyOmbYpN
         9jxBbBvxZ5ICa4p6gD28hxa5/vmiHB9ezgCsdJl6Bdi7H9w5kjJ5oXpP5x/FzaEGdWAv
         yEeEqXTKq0eD1c2jr2dtDDExsgB9L4j2sREDbDLaCqxj1Osg8Vde2jck49SPQiHUPcBM
         /cTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tPZKrwWHh4ylX/L5NKvv2t0yL6XxsGTIa4rI25XVHaU=;
        b=BDKfcQ2FKho71UJkd8IBjAF7CnIhj+5I0rzShQVzlaRZA0ZZ1ybWYXSY68tDEkRTpM
         HgL8Q5MQTwXy6eCxbZv8vt03eBhECTl3YfUWe45M1E6D3hVwDQBZqChz4fOSm42toptB
         B5PNchCAqr9q5V/+x54FGGVL3ug7g5y06Dbyi4bXcDBR8uLAj0XJJX+irKcChO3BvIo6
         XDVSYk6OjjC2G2uHXczoebbsI48y8jOsdzpVGJvNF6/6MYpJuMn1RT2Ae0w0aFtdlleu
         AM1zZwK7jdLywGTq1pmtycz9OiyQC0tso6h2fYVW5Ld1JNZIaGLHxtuiOeLdxK2rel5s
         0Fgw==
X-Gm-Message-State: APjAAAXDvobHlqnFUbpIr/rMe+8nGHYXLOrHL5L2JrIb3LuHnOLUWILT
        YWKJqWGyKlaDPKh9tQ5ZJH0Vzw==
X-Google-Smtp-Source: APXvYqyBNHZtkp97vbhaklM9nVSAW53TxbaeO/7EbAa7s+W01/7BYobNAM/sj4a0tjj5Mq4BtdBkbg==
X-Received: by 2002:a05:620a:1424:: with SMTP id k4mr21108980qkj.61.1576392773357;
        Sat, 14 Dec 2019 22:52:53 -0800 (PST)
Received: from ovpn-123-96.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c16sm4623042qka.18.2019.12.14.22.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Dec 2019 22:52:52 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     paulmck@kernel.org, josh@joshtriplett.org
Cc:     rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org, tj@kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] rcu: fix an infinite loop in rcu_gp_cleanup()
Date:   Sun, 15 Dec 2019 01:52:42 -0500
Message-Id: <20191215065242.7155-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 82150cb53dcb ("rcu: React to callback overload by
aggressively seeking quiescent states") introduced an infinite loop
during boot here,

// Reset overload indication for CPUs no longer overloaded
for_each_leaf_node_cpu_mask(rnp, cpu, rnp->cbovldmask) {
	rdp = per_cpu_ptr(&rcu_data, cpu);
	check_cb_ovld_locked(rdp, rnp);
}

because on an affected machine,

rnp->cbovldmask = 0
rnp->grphi = 127
rnp->grplo = 0

It ends up with "cpu" is always 64 and never be able to get out of the
loop due to "cpu <= rnp->grphi". It is pointless to enter the loop when
the cpumask is 0 as there is no CPU would be able to match it.

Fixes: 82150cb53dcb ("rcu: React to callback overload by aggressively seeking quiescent states")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/rcu/rcu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index ab504fbc76ca..fb691ec86df4 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -363,7 +363,7 @@ static inline void rcu_init_levelspread(int *levelspread, const int *levelcnt)
 	((rnp)->grplo + find_next_bit(&(mask), BITS_PER_LONG, (cpu)))
 #define for_each_leaf_node_cpu_mask(rnp, cpu, mask) \
 	for ((cpu) = rcu_find_next_bit((rnp), 0, (mask)); \
-	     (cpu) <= rnp->grphi; \
+	     (cpu) <= rnp->grphi && (mask); \
 	     (cpu) = rcu_find_next_bit((rnp), (cpu) + 1 - (rnp->grplo), (mask)))
 
 /*
-- 
2.21.0 (Apple Git-122.2)

