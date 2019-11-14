Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997C9C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808C7206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 07:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfKNHkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 02:40:24 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6662 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbfKNHkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 02:40:24 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BB7169B37EB07AFF63AA;
        Thu, 14 Nov 2019 15:40:21 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 14 Nov 2019
 15:40:15 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <borisp@mellanox.com>, <aviadye@mellanox.com>,
        <john.fastabend@gmail.com>, <daniel@iogearbox.net>,
        <jakub.kicinski@netronome.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net/tls: Fix unused function warning
Date:   Thu, 14 Nov 2019 15:39:46 +0800
Message-ID: <20191114073946.46340-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If PROC_FS is not set, gcc warning this:

net/tls/tls_proc.c:23:12: warning:
 'tls_statistics_seq_show' defined but not used [-Wunused-function]

Use #ifdef to guard this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/tls/tls_proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tls/tls_proc.c b/net/tls/tls_proc.c
index 83d9c80..3a5dd1e 100644
--- a/net/tls/tls_proc.c
+++ b/net/tls/tls_proc.c
@@ -6,6 +6,7 @@
 #include <net/snmp.h>
 #include <net/tls.h>
 
+#ifdef CONFIG_PROC_FS
 static const struct snmp_mib tls_mib_list[] = {
 	SNMP_MIB_ITEM("TlsCurrTxSw", LINUX_MIB_TLSCURRTXSW),
 	SNMP_MIB_ITEM("TlsCurrRxSw", LINUX_MIB_TLSCURRRXSW),
@@ -32,6 +33,7 @@ static int tls_statistics_seq_show(struct seq_file *seq, void *v)
 
 	return 0;
 }
+#endif
 
 int __net_init tls_proc_init(struct net *net)
 {
-- 
2.7.4


