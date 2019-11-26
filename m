Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10E9C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC6B52071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6ZsU9CA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfKZR1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 12:27:32 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33505 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbfKZR1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 12:27:31 -0500
Received: by mail-pj1-f65.google.com with SMTP id r67so833681pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 09:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tOXJgjcejk9fVTesqHUY5e9L13PR1v6iQKZu4fMIxHA=;
        b=Z6ZsU9CAY0l1UnoY/wS5uOsMrRqycDJHL10BBxhJe0MxfZ+Q1ZM3sUh5AhxzH6OMBE
         mz/wxuZQfMjv90AZlATeM6UbL2y1E5CuEwxG4cPt06OZYpJXBpwJR3uJxmJILq+1tARj
         igaUHxBiGliS6uodnwmkJRIO60TeJdabpisA6kS6DD8UXN3qYHPRWUIiZDEUrY/QeFC0
         lBUicyL1PRVsGl22rewWL1NKqRZAcgp7u2mYqZOehhMNm12x9RK6O7r9mxNFftjHJgsF
         CdT+hKUq/IzBlE6fHIT+p9o/HZwEgR813e5eGR5D25xZlvQCyAYQjW3l556aOEC713wD
         lQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tOXJgjcejk9fVTesqHUY5e9L13PR1v6iQKZu4fMIxHA=;
        b=OL59RMMO1fzP8qBKQkNJkcbO4G84Nlk5L+JtlfwhOR9y2f51V/r5zhp9bxLi1KKf3J
         U3vBB6it7dJNmFpeeD0sD7d9pjzwqjmtFevekFc3IOMzMR1ldisxlLML37aCEOlNvJv4
         +vktAz1YL1YEuJehbKAK9PhZ9aRSEGeUCRI75j1Zd3lpHIUPaTbjXjtwWeJD7yTyiUhb
         0FUXkpzyRbjRUHtIFdpyvIb1IRCesxEhnyxYAsHAz0aPINEhaV8x/Y1UEp0vJ4a26lXd
         OzUp9lc7dGt3PJkQWqKYXjbBAw+SRi+1lCc/AXlnNEw+ubfM7h9kLtJE1n0xR2kLpc/2
         kShQ==
X-Gm-Message-State: APjAAAUzdgzwDrxn0smS+kdLou6tGpQyBDQRnCC6Rpa05gzoXyytuvkZ
        vLyEKT950sV+rBM/JF86FTo=
X-Google-Smtp-Source: APXvYqy294hAiGU/NMZ0qdJaYL71YbrTPvTU3AZuPnoS++e3Vo0p8JS0WkyAlMUcZqOfV0dV1+asZw==
X-Received: by 2002:a17:902:a60f:: with SMTP id u15mr36003211plq.64.1574789249342;
        Tue, 26 Nov 2019 09:27:29 -0800 (PST)
Received: from workstation-kernel-dev ([139.5.252.125])
        by smtp.gmail.com with ESMTPSA id 16sm13356097pfc.21.2019.11.26.09.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 09:27:28 -0800 (PST)
Date:   Tue, 26 Nov 2019 22:57:23 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel: audit.c: Add __rcu notation to RCU pointer
Message-ID: <20191126172723.GA12759@workstation-kernel-dev>
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
 kernel/audit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index da8dc0db5bd3..30e7fc9b8da2 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -102,12 +102,14 @@ struct audit_net {
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
+RCU_INIT_POINTER(auditd_conn);
 static DEFINE_SPINLOCK(auditd_conn_lock);
 
 /* If audit_rate_limit is non-zero, limit the rate of sending audit records
-- 
2.24.0

