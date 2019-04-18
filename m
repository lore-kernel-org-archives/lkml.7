Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E6DC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887EE20651
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="A+lf3Hyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389830AbfDRRj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:39:29 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:51464 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRRj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:39:28 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id B68236C0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 17:39:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id clIX48uwafPu for <linux-kernel@vger.kernel.org>;
        Thu, 18 Apr 2019 12:39:26 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 91F08255
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 12:39:26 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id m192so2916773ita.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 10:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oeFHUzAqKBcM7sdG/P3+juEhpgnMteWOUhmnJ8I+jVs=;
        b=A+lf3Hyb97cVq+JCb2Z0wGeJi4R/VlpBgSY+z4mCZUm8YG+Qfo2RAewVcbSgFENhdc
         E4zwEbT/oa/3LjJP37vTWvk+HelYA4Kytli/pmc4T6/kU/F2bVn+Nqf3MX3wSbucycei
         BrC53xnsGyhs0Lo1y9IlaSyrHohx4H4jJI/z3D6LUjOaHqmbAQl03jJcXexAotik168b
         sy42JeZj4mKENYinedCBtxxSetwqAZUXGSPmCXUdJzXOupBTc8Vq0xsp3mEj7sKe3rX0
         gt3b+ffao6yxhtnJ7ilFnMV8nJttFxg3FzEIp9rJ02wf78LAUuk4jw19SQHaO2zqF0SJ
         DDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oeFHUzAqKBcM7sdG/P3+juEhpgnMteWOUhmnJ8I+jVs=;
        b=mGEmZ6Ywj63csjBTOuimmaTryAGSGoWgaS0xNvrWOjXCaTpIkrSZIV4yYJ1BB0eio7
         BKIO1dXPDYUINXyRArc38n1OdTUJ4ictpTgthystIus/3Hi7Ktqpn4bYpimLqUTnT98T
         +BnIkxNhuBjoCeHr+oQklKAEQHVTSWR3pFmCCAfwk4e1+jh9r4ydFBhRjvROZ2GxPSq/
         guE9+EinJjzjuS/b2chmgR4TSGbzI3QmuDnm/mne6h7oR/iqytefdIl5E+hsHAqBCkks
         vNvFdHNKZ4B3QbGYAKGWDpTtM6hpLopi6/xE4tPQd+YOet8mLzI6fa/3g5v+4uSPztnX
         3mqg==
X-Gm-Message-State: APjAAAU6B/sNppgaudVoMAHn9KzW8hA3geFJ3zvC571ChXVrKYNwZ2aQ
        dDb2bfSBeQH8m7YIQna2eUZpSDFuj2PYzeIyKCUD/qlVePothTdxDrGG799QHvWble51aqeBJRu
        4yRjGdnixHZfreDaorJHneexZ0SSR
X-Received: by 2002:a5d:848d:: with SMTP id t13mr39211554iom.16.1555609166264;
        Thu, 18 Apr 2019 10:39:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyttkRDz67yMunIxgGZkP74Rkt36TkN61jR0f5rrXgVFtdRA5esSVVsQJ5RR3TvQmKS87Pyiw==
X-Received: by 2002:a5d:848d:: with SMTP id t13mr39211537iom.16.1555609166094;
        Thu, 18 Apr 2019 10:39:26 -0700 (PDT)
Received: from cs-u-cslp16.dtc.umn.edu (cs-u-cslp16.cs.umn.edu. [128.101.106.40])
        by smtp.gmail.com with ESMTPSA id y203sm1231138itb.22.2019.04.18.10.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Apr 2019 10:39:25 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        linux-audit@redhat.com (moderated list:AUDIT SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] audit: fix a memory leak bug
Date:   Thu, 18 Apr 2019 12:39:15 -0500
Message-Id: <1555609155-11934-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

To fix this issue, free the allocated tree in the default case.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 kernel/auditfilter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 63f8b3f..70a34db 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1128,6 +1128,8 @@ int audit_rule_change(int type, int seq, void *data, size_t datasz)
 		audit_log_rule_change("remove_rule", &entry->rule, !err);
 		break;
 	default:
+		if (entry->rule.tree)
+			audit_put_tree(entry->rule.tree);
 		err = -EINVAL;
 		WARN_ON(1);
 	}
-- 
2.7.4

