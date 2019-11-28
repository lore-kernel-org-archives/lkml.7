Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9099CC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64693217BA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkjLgbwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfK1PcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 10:32:11 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36794 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfK1PcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:32:10 -0500
Received: by mail-pf1-f194.google.com with SMTP id b19so13320933pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 07:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PpHb3fvmg1wnxHHN6wZlT7oMOhT2IAI1cwgs8iwmgww=;
        b=lkjLgbwdRqukZGNpN1LfTOVPQlzYOcqS8Sib6QnsDCumdKzmyZq+1cenQrSvRjVr1V
         VxtfbnYVrHOgHkyVNtUofoVgXRx4rDds0sMvHQCe3tjF5A0/XPUIOu80OqTq8K5+TX05
         Pm8Wve1ChsV5w9QT+PFGuQJmLmRLwaDfMcWdysS/ly0l4BcIXyNw5v9oPgT9zH7pRUOa
         VyfMeWcFn9PWcurMvKxvy8xCLkirlRg2enDdLF1aFXsSq+BYio+R0/27n9tOjoVA7XiG
         ueFKCL5VC4xQ7VgTVsiYdKrVSJZd/074jQjwi8AyYzPAzm+CtYPPlhPeJ65B+TAVnQ3H
         8GoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PpHb3fvmg1wnxHHN6wZlT7oMOhT2IAI1cwgs8iwmgww=;
        b=dP/ewwkbeTdFCUFlXAI2yYJe9XO1LU/V/whZuH6qj6h7RbTOauF3mWFXMMfcmOA2lG
         cbFZg1bdI3+5xzJgHW2yOIQrmtVMi+vpEMXmzFseUNBH5/paJe7MrKU5c7PesrfmfkPi
         5OxcAA9fOuXMVO8L1S8bb+CnWrK4Ht+4DZqjypBAjaoh+cd0Hn4B1QEfA1sc9rDcCOu8
         Gp7uceb/VN4LgXZWeSrxB9BazIgE6utm77IP+ivFYeDh7PZz3pFtS+Vg+QxDBAfitb2s
         309IeCvVApwhChfjKLosFAXx3whW2AJIGQ7MxhDjDpsunxKozg8VnO8r28CbwXTjADmJ
         /DPg==
X-Gm-Message-State: APjAAAVLu5uacwlfYr2s8bbo0YKud72eVW1k0kWmBIf8/a4dgbGlSQxE
        bpwOQjMzckXNJwhDG7c13uw=
X-Google-Smtp-Source: APXvYqw0ZuqqCQ3bpYNoPpQ541irC88FBLvvfU7BPliB9p4YDB9wkq1pQ+suOYZqqdaXq2l1fot78A==
X-Received: by 2002:a63:d20f:: with SMTP id a15mr12262947pgg.268.1574955129913;
        Thu, 28 Nov 2019 07:32:09 -0800 (PST)
Received: from workstation-kernel-dev ([139.5.253.4])
        by smtp.gmail.com with ESMTPSA id j7sm7624426pgn.0.2019.11.28.07.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 07:32:09 -0800 (PST)
Date:   Thu, 28 Nov 2019 21:02:03 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v2] kernel: audit.c: Add __rcu notation to RCU pointer
Message-ID: <20191128153203.GA23803@workstation-kernel-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add __rcu notation to RCU protected global pointer auditd_conn

Fixes multiple instances of sparse error:
error: incompatible types in comparison expression
(different address spaces)

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
v2:
- fix erroneous RCU pointer initialization

 kernel/audit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index da8dc0db5bd3..ff7cfc61f53d 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -102,12 +102,13 @@ struct audit_net {
  * This struct is RCU protected; you must either hold the RCU lock for reading
  * or the associated spinlock for writing.
  */
-static struct auditd_connection {
+struct auditd_connection {
 	struct pid *pid;
 	u32 portid;
 	struct net *net;
 	struct rcu_head rcu;
-} *auditd_conn = NULL;
+};
+static struct auditd_connection __rcu *auditd_conn;
 static DEFINE_SPINLOCK(auditd_conn_lock);
 
 /* If audit_rate_limit is non-zero, limit the rate of sending audit records
-- 
2.24.0

