Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075D4C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27CB2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="ausNJ9qP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbfFXN3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:29:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33878 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728926AbfFXN3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:29:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so13953985wrl.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 06:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=11Pv9Z5s19Zp78uuJj22ZvE45uxJPM0y1Jwb+Rtnf2Q=;
        b=ausNJ9qPVHfSlWc7AO4tZT1/2mqSZc363wbHLhcQa6Es6sK4HPxresxuh408Hmpwws
         g4vz6DueaV+gB6ChXtQVP1MhOXU0Gdev5xoAnv/WX9D9OaRPrqUJwNFu6GP+56ED8pDQ
         loqJo9A+XXlslbd0e55r6dDkR+4ELqDBmNU7sZgTdxzyV+FvQZ4K/xJJKOWNbm/x7FRb
         m73JbfKtM2JYF3VnU2UPdiQ3ao+AgGURf1knJiY64ooM99lDq5EMKZLKWDt8sW9KduEv
         /X/siXujC2KFB5yoEBwkcMTvJjHDrWMkrwPfGQC4Elmnv+7ZQZ1stwmYsvdh1qpypipy
         c5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=11Pv9Z5s19Zp78uuJj22ZvE45uxJPM0y1Jwb+Rtnf2Q=;
        b=uRR+wqg9iCH3EDuPYC7fbzkrVUwfaf9isdN2sV10AgOc2/w6fXdBYbkxirGxFAQFyu
         50vnZDzLt6VYul4BssYQ2nGwNXSBiF7CdyDjJcYvf8rADj5Lzdvh/4aoqy+9Ds26oZTv
         AYrsuB+UlJx9B5tsoN7rCFZyjZEDOh4jQXr82zNvbX0fe1derYAm+2Ne5N5lOADZtSUd
         myZiyamxcNyOxb7fB1f1nPcAwNfTOAMof1FZG/jlD3QIVf+lqMbwDA/6f82m1W1pcoOo
         3I1IvhYzP61L9hJ82gOfoxX9EZkMOzDYpuvQIqXpUrldPge3RsiEAivw53rW8L6Z/v0w
         o9tw==
X-Gm-Message-State: APjAAAVr8v/tHObNLiHu2lCByS2XE51QWvke/ShCS27NqC/XlovgNlnK
        IFMpYNKvLXwPsRj/IDWnEEhflg==
X-Google-Smtp-Source: APXvYqzfbC+Y53cjWnbaVA0/kzG+I9yhSNyZvY7bcKLozH3pD5SObocC0xd9C0soFuVVaehhsBksEg==
X-Received: by 2002:a5d:5448:: with SMTP id w8mr77224907wrv.180.1561382968454;
        Mon, 24 Jun 2019 06:29:28 -0700 (PDT)
Received: from localhost.localdomain ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id s63sm7842418wme.17.2019.06.24.06.29.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 06:29:27 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH net-next] ipv4: enable route flushing in network namespaces
Date:   Mon, 24 Jun 2019 15:29:23 +0200
Message-Id: <20190624132923.16792-1-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tools such as vpnc try to flush routes when run inside network
namespaces by writing 1 into /proc/sys/net/ipv4/route/flush. This
currently does not work because flush is not enabled in non-initial
network namespaces.
Since routes are per network namespace it is safe to enable
/proc/sys/net/ipv4/route/flush in there.

Link: https://github.com/lxc/lxd/issues/4257
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 net/ipv4/route.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 6cb7cff22db9..41726e26cd5f 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3197,9 +3197,11 @@ static struct ctl_table ipv4_route_table[] = {
 	{ }
 };
 
+static const char ipv4_route_flush_procname[] = "flush";
+
 static struct ctl_table ipv4_route_flush_table[] = {
 	{
-		.procname	= "flush",
+		.procname	= ipv4_route_flush_procname,
 		.maxlen		= sizeof(int),
 		.mode		= 0200,
 		.proc_handler	= ipv4_sysctl_rtcache_flush,
@@ -3217,9 +3219,11 @@ static __net_init int sysctl_route_net_init(struct net *net)
 		if (!tbl)
 			goto err_dup;
 
-		/* Don't export sysctls to unprivileged users */
-		if (net->user_ns != &init_user_ns)
-			tbl[0].procname = NULL;
+		/* Don't export non-whitelisted sysctls to unprivileged users */
+		if (net->user_ns != &init_user_ns) {
+			if (tbl[0].procname != ipv4_route_flush_procname)
+				tbl[0].procname = NULL;
+		}
 	}
 	tbl[0].extra1 = net;
 
-- 
2.22.0

