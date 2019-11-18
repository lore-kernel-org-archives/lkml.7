Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE16C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B54420679
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iS8KFNLd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKRJJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 04:09:39 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34050 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRJJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 04:09:39 -0500
Received: by mail-lf1-f68.google.com with SMTP id l28so3671207lfj.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 01:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vRHarKxs+FXQC17mDhZjcIM/UrEIpgau+60o1VUlLBU=;
        b=iS8KFNLdFLqOPrD6V35b7GfQj7gpMOzvVLNiAW93HgzmFuCocGe86U9tQYNhCtGH9/
         F+TqzaLdZyguwYLCf9PWnDeTQSehf9n/6irOMCHTjflBh4ewrMY9tvsUUQi667HjVvBj
         qsn6lw5EKap4TVlakLfnu9RWrYaWfH/ttogmmSmZerWzyIjIReYKU9FA/SocSUeORWsN
         dg51gG/X4xKZ+s1vRvnbBS+zx/5+df70kxZHFeyCBGnBZuHmasyIpzCflCQKRLyRcC+3
         rn0GA2jEV78MMCPZJuEBXII31EOjOH7eAlcshQaU5t0QTFxPwAev0MZ4NnfvB0Y3hX3d
         ydJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vRHarKxs+FXQC17mDhZjcIM/UrEIpgau+60o1VUlLBU=;
        b=SQZce5yW7+AXryD1TKwYNDK2HnqdJ+EZ51KbUYi+JyEKk/3wZt07gN1g4wbjhilT2V
         3MIzTGKtB2X17L715UaVFsOydiMNZyktjfNl3GJ3JdFUN8Ps3z9bTXwJQKURmpwrUiim
         Nwy1fhfBrFqlHEzzRPF8Jr84eG7G54wmpMbVwXIwpHmqJmob65Lb8vrbfftacPOEzlRG
         /34eepUelThsIfETmRJqJuKe85FjjDmE03oNU11yLR0vlhaLSBcw8gcr/sh60W7m0tnY
         uVD+y7FcrRwynq4JClIMyT/5wXGjyOFuYmqZv/dnK5eChhRRM0sB666JKWcqCI+YkJP7
         7N3A==
X-Gm-Message-State: APjAAAU2Mm/gHv5sGqOVpH5XzalOxsPKA5kA43u0u45PMa5LeL7qKokM
        MYeMs0SUL2e+PJzT5iaiXBFGOA==
X-Google-Smtp-Source: APXvYqyhYvfNiJx2V0NEwl3l8Xan6FmO3Iko3dR/CCQvpO4Av5UhD0iRNKaQv1xQYWN7JvWHllknjQ==
X-Received: by 2002:a19:6d19:: with SMTP id i25mr19733291lfc.178.1574068176629;
        Mon, 18 Nov 2019 01:09:36 -0800 (PST)
Received: from localhost (c-413e70d5.07-21-73746f28.bbcust.telenor.se. [213.112.62.65])
        by smtp.gmail.com with ESMTPSA id e10sm7997635ljp.23.2019.11.18.01.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 01:09:35 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Cc:     paulmck@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] net: ipmr: fix suspicious RCU warning
Date:   Mon, 18 Nov 2019 10:09:25 +0100
Message-Id: <20191118090925.2474-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting an arm64 allmodconfig kernel on linux-next (tag
next-20191115). The following "suspicious RCU usage" warning shows up.
This bug seems to have been introduced by commit f0ad0860d01e ("ipv4:
ipmr: support multiple tables") in 2010, but the warning was added only
in this past year by commit 28875945ba98 ("rcu: Add support for
consolidated-RCU reader checking").

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

This commit therefore introduces a lockdep-specific variable that
maintains initialization state.  It then passes this variable along with
the return value of lockdep_rtnl_is_held() to list_for_each_entry_rcu()
in order to correctly check for proper RCU/locking/initialization state.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 net/ipv4/ipmr.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 6e68def66822..93007c429dae 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -108,9 +108,18 @@ static void igmpmsg_netlink_event(struct mr_table *mrt, struct sk_buff *pkt);
 static void mroute_clean_tables(struct mr_table *mrt, int flags);
 static void ipmr_expire_process(struct timer_list *t);
 
+#ifdef CONFIG_PROVE_LOCKING
+int ip_mr_initialized;
+void ip_mr_now_initialized(void) { ip_mr_initialized = 1; }
+#else
+const int ip_mr_initialized = 1;
+void ip_mr_now_initialized(void) { }
+#endif
+
 #ifdef CONFIG_IP_MROUTE_MULTIPLE_TABLES
 #define ipmr_for_each_table(mrt, net) \
-	list_for_each_entry_rcu(mrt, &net->ipv4.mr_tables, list)
+	list_for_each_entry_rcu(mrt, &net->ipv4.mr_tables, list, \
+			(lockdep_rtnl_is_held() || !ip_mr_initialized))
 
 static struct mr_table *ipmr_mr_table_iter(struct net *net,
 					   struct mr_table *mrt)
@@ -3160,6 +3169,8 @@ int __init ip_mr_init(void)
 
 	rtnl_register(RTNL_FAMILY_IPMR, RTM_GETLINK,
 		      NULL, ipmr_rtm_dumplink, 0);
+
+	ip_mr_now_initialized();
 	return 0;
 
 #ifdef CONFIG_IP_PIMSM_V2
-- 
2.20.1

