Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01B4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798DD2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="LA37jLTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbfCOGHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 02:07:48 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:44876 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfCOGHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 02:07:47 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 57009CA9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:07:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bjztpUsy6tTO for <linux-kernel@vger.kernel.org>;
        Fri, 15 Mar 2019 01:07:46 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 27C04A10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 01:07:46 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id v12so6843690itv.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 23:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Tx35QUGia3FusaCVI8xy2kdI7NujUqqw3ykVJkkEoIQ=;
        b=LA37jLTvTwv4Sm21XotKTWZkDCZF0hqeCjcF7EhzNuHdK0qoeQGwKf5e2VcJFjt0wd
         4tO5v+rpQsQUG6iAXfj0YMGuIDFTD8lZoZQfBdfg7CFd6FkTLlprOvL9tHQOYrtGTBGS
         PGyfRrGIaCh93445EVn8f2m6jxgM5+PXEMTh6Y29lFwxgLJblYFytHbIlMbtG01xD5uv
         GAxDcqkVHxiutV8wxZBpIIyUL8tEUre1WvN7kBSxh7utn7E2SYaG3U8vEn5JCL5COUAf
         hJYT5AFAZygeOlxXzRfvCsv5BkTFgut0jMasql7ZDZho/uhRnX5xud4PLXgOKTfql4V0
         A4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Tx35QUGia3FusaCVI8xy2kdI7NujUqqw3ykVJkkEoIQ=;
        b=h8NAfFnlr9FLiG+BsuwRk+tY2gH3+lqikgmBF6ZDklijZwXIXhJTeyF//Z8HIPVJ9Q
         DtbGTjnFbcE3/k3Lku+Q+PIP6y9UVLC/fwCXVqP8JRG0Mkitk8e6ZKXR1uM+nxs0yNRv
         EYpQdINolWlOnVlBRHGR4kgRMTa5vUUi08D6xqEgHPD8yEvygS6WZqJNOdLv953o+4Pq
         VwcNMheXuCViNZcd8bUVFdEXQSPEEghYlB4Mw2i7GTrTHRe3f654vaFTGRmIHszjPYCy
         ZJufN+39M0LWTac6RcCdHcS4U443ZN44gH0V/64zRXYuUbufWXJVf0JckkHAldLZgkj9
         qzJQ==
X-Gm-Message-State: APjAAAU7Q+Ya+L3mRAvAUIW855cjyn9WFpriW6Yu5bxgfla7FZP7EXjj
        JEMNIjD2d5EF4mz/E/lRs8TunnYamAifbYnyvcxoFayhJSL9ACcAm4cAN9BFQVpo8p2OpEQzlrA
        KMjSzzSXWPr6hf2/NA/UMp8HdPD8H
X-Received: by 2002:a6b:144b:: with SMTP id 72mr1086503iou.191.1552630065801;
        Thu, 14 Mar 2019 23:07:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyBf+9aZMAg1rDVA3mw958c4UcRLm6naAC8ITylmC/5s0TL3o6P5F3SA+arGKKJNEOC9vtvlg==
X-Received: by 2002:a6b:144b:: with SMTP id 72mr1086490iou.191.1552630065570;
        Thu, 14 Mar 2019 23:07:45 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id b16sm609787itb.26.2019.03.14.23.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 23:07:44 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] net: tipc: fix a missing check of nla_nest_start
Date:   Fri, 15 Mar 2019 01:07:39 -0500
Message-Id: <20190315060740.13920-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nla_nest_start could fail and requires a check. The fix returns
-EMSGSIZE if it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 net/tipc/group.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tipc/group.c b/net/tipc/group.c
index 06fee142f09f..117867e480ba 100644
--- a/net/tipc/group.c
+++ b/net/tipc/group.c
@@ -918,6 +918,8 @@ void tipc_group_member_evt(struct tipc_group *grp,
 int tipc_group_fill_sock_diag(struct tipc_group *grp, struct sk_buff *skb)
 {
 	struct nlattr *group = nla_nest_start(skb, TIPC_NLA_SOCK_GROUP);
+	if (!group)
+		return -EMSGSIZE;
 
 	if (nla_put_u32(skb, TIPC_NLA_SOCK_GROUP_ID,
 			grp->type) ||
-- 
2.17.1

