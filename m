Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892FBC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF43218BA
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sPuMl6U2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfKTPXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:23:10 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40457 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbfKTPXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:23:09 -0500
Received: by mail-lj1-f193.google.com with SMTP id q2so27997408ljg.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 07:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QixIkQoOQSQ7LFqcqXjzuSKbALdm9LSDFACPeBd6EXc=;
        b=sPuMl6U2vWAMp58080YHiVtXKSPpB2k0OmXi2sz6iOF4t/cdroQZrF51AtOTnbUSYG
         pYK6hLsSXx+0RFCsG376aH1ZQKf7vFr/XAzd2VvuDrkdjf24hjGgcj1/PRAYsCYniKxm
         GnO15KtZyhIPLjUAgBj1QeaebzutRyYAPvLOXQz9YYpNaQ/lzYclQRc/pOLBpjQ00uid
         jfuTNqU/2Q+176VmWMBUwj+pOZxtzTlkjR6bi1saF3ZWl02zo1x9gadO/nUnPAa5UtNu
         4/XEszWOOOLgYMm6gvicUG+HHxntTEypzokSrsydV0+890/gSuICeWs+abtF8IHeqFL+
         hwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QixIkQoOQSQ7LFqcqXjzuSKbALdm9LSDFACPeBd6EXc=;
        b=PecYpzARCze+TqO20DlrHMHa9qrDEG1RH8kNkN/O5XtAaaEK3ln9ekhCGtsAc2G9Ul
         DTS+Km9hEZBs/xXssINIKxtc5VxdKyiHdJK7t/dN8eqgohDVDSit34VDZRAnBbxE5Bki
         OqlQfD3366NHAjmnEvCYE44+TTzVnee6fCgjRWdVSmsksQo7sg15oIgn42UNCVdfitm5
         AWJ0jmvmAXPS5IX6+uHkjqS3hLX583l9+qBDsTIjkkQ2b+4LfLVeNw+bxc6I0111hOAv
         fWd3VfQG8OWKRWteSrLUXs4wH++O8QaPxuqAebktrNFsWYmeDo+2UH8rkxjkd4EbdThf
         U7Ag==
X-Gm-Message-State: APjAAAUk6WmsWd+/tAE8cXF6bVEmMKEx5eR5AaQlyoTwv5Siby75MOjA
        s9pS0l0eDDAUVm9uOWl5qjOFYA==
X-Google-Smtp-Source: APXvYqyGjNXHTonbtNg1dfXimDQe5NKZOl2POKoQN8VAcpEX31hSxy3gtb2+CODvDnzSAD2AFKXjrw==
X-Received: by 2002:a2e:8188:: with SMTP id e8mr3266242ljg.152.1574263387287;
        Wed, 20 Nov 2019 07:23:07 -0800 (PST)
Received: from localhost (c-413e70d5.07-21-73746f28.bbcust.telenor.se. [213.112.62.65])
        by smtp.gmail.com with ESMTPSA id e11sm5574688lfc.27.2019.11.20.07.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 07:23:06 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Cc:     paulmck@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] net: ipmr: fix suspicious RCU warning
Date:   Wed, 20 Nov 2019 16:22:55 +0100
Message-Id: <20191120152255.18928-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting an arm64 allmodconfig kernel on linux-next next-20191115
The following "suspicious RCU usage" warning shows up.  This bug seems
to have been introduced by commit f0ad0860d01e ("ipv4: ipmr: support
multiple tables") in 2010, but the warning was added only in this past
year by commit 28875945ba98 ("rcu: Add support for consolidated-RCU
reader checking").

[   32.496021][    T1] =============================
[   32.497616][    T1] WARNING: suspicious RCU usage
[   32.499614][    T1] 5.4.0-rc6-next-20191108-00003-gf74bac957b5c-dirty #2 Not tainted
[   32.502018][    T1] -----------------------------
[   32.503976][    T1] net/ipv4/ipmr.c:136 RCU-list traversed in non-reader section!!
[   32.506746][    T1]
[   32.506746][    T1] other info that might help us debug this:
[   32.506746][    T1]
[   32.509794][    T1]
[   32.509794][    T1] rcu_scheduler_active = 2, debug_locks = 1
[   32.512661][    T1] 1 lock held by swapper/0/1:
[   32.514169][    T1]  #0: ffffa000150dd678 (pernet_ops_rwsem){+.+.}, at: register_pernet_subsys+0x24/0x50
[   32.517621][    T1]
[   32.517621][    T1] stack backtrace:
[   32.519930][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc6-next-20191108-00003-gf74bac957b5c-dirty #2
[   32.523063][    T1] Hardware name: linux,dummy-virt (DT)
[   32.524787][    T1] Call trace:
[   32.525946][    T1]  dump_backtrace+0x0/0x2d0
[   32.527433][    T1]  show_stack+0x20/0x30
[   32.528811][    T1]  dump_stack+0x204/0x2ac
[   32.530258][    T1]  lockdep_rcu_suspicious+0xf4/0x108
[   32.531993][    T1]  ipmr_get_table+0xc8/0x170
[   32.533496][    T1]  ipmr_new_table+0x48/0xa0
[   32.535002][    T1]  ipmr_net_init+0xe8/0x258
[   32.536465][    T1]  ops_init+0x280/0x2d8
[   32.537876][    T1]  register_pernet_operations+0x210/0x420
[   32.539707][    T1]  register_pernet_subsys+0x30/0x50
[   32.541372][    T1]  ip_mr_init+0x54/0x180
[   32.542785][    T1]  inet_init+0x25c/0x3e8
[   32.544186][    T1]  do_one_initcall+0x4c0/0xad8
[   32.545757][    T1]  kernel_init_freeable+0x3e0/0x500
[   32.547443][    T1]  kernel_init+0x14/0x1f0
[   32.548875][    T1]  ret_from_fork+0x10/0x18

This commit therefore holds RTNL mutex around the problematic code path,
which is function ipmr_rules_init() in ipmr_net_init().  This commit
also adds a lockdep_rtnl_is_held() check to the ipmr_for_each_table()
macro.

Suggested-by: David Miller <davem@davemloft.net>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 net/ipv4/ipmr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 6e68def66822..53dff9a0e60a 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -110,7 +110,8 @@ static void ipmr_expire_process(struct timer_list *t);
 
 #ifdef CONFIG_IP_MROUTE_MULTIPLE_TABLES
 #define ipmr_for_each_table(mrt, net) \
-	list_for_each_entry_rcu(mrt, &net->ipv4.mr_tables, list)
+	list_for_each_entry_rcu(mrt, &net->ipv4.mr_tables, list, \
+				lockdep_rtnl_is_held())
 
 static struct mr_table *ipmr_mr_table_iter(struct net *net,
 					   struct mr_table *mrt)
@@ -3086,7 +3087,9 @@ static int __net_init ipmr_net_init(struct net *net)
 	if (err)
 		goto ipmr_notifier_fail;
 
+	rtnl_lock();
 	err = ipmr_rules_init(net);
+	rtnl_unlock();
 	if (err < 0)
 		goto ipmr_rules_fail;
 
-- 
2.20.1

