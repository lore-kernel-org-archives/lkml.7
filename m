Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34201C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0939D205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100292;
	bh=Zh9Ib6q1fkjdlDPzgJM3ddYpib0FoseOxufu74M886w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wb2yLBgHHcu34mxFr7l6B81HJ8X2V6l3o0MFuytD+0bvxtQRNrU0MemrZ2V7kRsj5
	 3YT4gOmlMFF+btOM4xhyz9C32CAgXgrkbpfx6OM33Jgf5H2VwZUUuhcbBIFj3x3Fz+
	 IvutMv2kaF8YNQF1B2SNyeBqBOGfRWfwAhz3LPfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbfFIRBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387977AbfFIRBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:01:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 735B2204EC;
        Sun,  9 Jun 2019 17:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099669;
        bh=Zh9Ib6q1fkjdlDPzgJM3ddYpib0FoseOxufu74M886w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TAdMk/FBxJihBsZuTDzZkAXD36q6ltde8tVEzfZmbUttzspMm3+O3ovFoHCCsK1EN
         ABMgbU1sL3ITZAh9e1L1K18kTwxGZMLDBUggX11EpBJzx9nePGMjvGLLrbyrbJymrS
         os/qtNS9G1uVirRFtOVtm4NYDV/agB25+PMzqTf0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Richard Guy Briggs <rgb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 122/241] audit: fix a memory leak bug
Date:   Sun,  9 Jun 2019 18:41:04 +0200
Message-Id: <20190609164151.322383379@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 70c4cf17e445264453bc5323db3e50aa0ac9e81f ]

In audit_rule_change(), audit_data_to_entry() is firstly invoked to
translate the payload data to the kernel's rule representation. In
audit_data_to_entry(), depending on the audit field type, an audit tree may
be created in audit_make_tree(), which eventually invokes kmalloc() to
allocate the tree.  Since this tree is a temporary tree, it will be then
freed in the following execution, e.g., audit_add_rule() if the message
type is AUDIT_ADD_RULE or audit_del_rule() if the message type is
AUDIT_DEL_RULE. However, if the message type is neither AUDIT_ADD_RULE nor
AUDIT_DEL_RULE, i.e., the default case of the switch statement, this
temporary tree is not freed.

To fix this issue, only allocate the tree when the type is AUDIT_ADD_RULE
or AUDIT_DEL_RULE.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/auditfilter.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index b57f929f1b468..cf7aa656b308b 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1095,22 +1095,24 @@ int audit_rule_change(int type, __u32 portid, int seq, void *data,
 	int err = 0;
 	struct audit_entry *entry;
 
-	entry = audit_data_to_entry(data, datasz);
-	if (IS_ERR(entry))
-		return PTR_ERR(entry);
-
 	switch (type) {
 	case AUDIT_ADD_RULE:
+		entry = audit_data_to_entry(data, datasz);
+		if (IS_ERR(entry))
+			return PTR_ERR(entry);
 		err = audit_add_rule(entry);
 		audit_log_rule_change("add_rule", &entry->rule, !err);
 		break;
 	case AUDIT_DEL_RULE:
+		entry = audit_data_to_entry(data, datasz);
+		if (IS_ERR(entry))
+			return PTR_ERR(entry);
 		err = audit_del_rule(entry);
 		audit_log_rule_change("remove_rule", &entry->rule, !err);
 		break;
 	default:
-		err = -EINVAL;
 		WARN_ON(1);
+		return -EINVAL;
 	}
 
 	if (err || type == AUDIT_DEL_RULE) {
-- 
2.20.1



