Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57EEC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EBD2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dkh0ed21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfH2IcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:32:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34126 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfH2IcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:32:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id b24so1593244pfp.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7MyrQaL9JAAqi8vdEmgGGlj6Ip8OGrwjRsugR/2wAFs=;
        b=Dkh0ed21iLKNBCJcGswd36RAWp0TgMICjRreErhA6ldQ9cyErWk2QI24SJ7dCGn7Ue
         /K+Qumg84PYZy73CSaeju3Bty0QIgfhQ9+qvD3PmYVes+GSzuKSrNIw7ns0xAjkg52Mt
         kFHIqMObd3jPTtAPXvT3EExHP40QPE00JpNMIRQw9B5SYT1Odo4yi3sGYPtxmPCYh8sX
         iCkI6r1OwsvY+1Gj2lvn5sxhamnBLQhw0Jl4azxrgGF+G72FcPa4Od2vAIU5XVaLztue
         dwMrMhQjBjJBSRo1miqzPLNT5ufpKGOWdZWm+ruyySMtvSyh1wBNds+ry4qyFItt1vSa
         CR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7MyrQaL9JAAqi8vdEmgGGlj6Ip8OGrwjRsugR/2wAFs=;
        b=W45z59+majiEcbLgapB1kHGI945tmLQP8Xiq6MGITBB6AjmCGP33jyPwXO+NSaEjw0
         4CRW8PpQIe1cd8OTv6FghFB9oxtD8xOM8wAB3FWnaRcr1bfT95Los24qgJT48V8A1xpY
         2g3gha+I4Zy0MZ5CAF1YIC9GHRbpxVhhPzxeGx4yOx55Z8jt5sSRbgxCuSQbEUOY4vub
         VIQAGCghtKBfZAuZyROFjOYPea/d0bVnzeMrtsaSZrJ0ZLktsmesVdHcs1X2dONjqXuM
         7vWwFNqA3BAJn2sKYZuytWoiAyj1UZ6Oc7QAyVm+FVMjQnxP35WsVYyqyMFParBPpQog
         L7CQ==
X-Gm-Message-State: APjAAAW+E6Kr4cW2KX3u80codNrU0i9Pir7Lhy65q9owxRUYiq/KMSE2
        y7Usv1ZTAUcDZNW+ohzQiqc=
X-Google-Smtp-Source: APXvYqzfbmGlmHGKYulaRdUhrY9tQ0I/zGuSCcDqq4AHr1XUxs0tKKWIu9KwKyYZXbL/ieFAAak+sA==
X-Received: by 2002:a17:90b:911:: with SMTP id bo17mr8180537pjb.40.1567067525623;
        Thu, 29 Aug 2019 01:32:05 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:32:05 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 05/30] locking/lockdep: Add lock chain list_head field in struct lock_list and lock_chain
Date:   Thu, 29 Aug 2019 16:31:07 +0800
Message-Id: <20190829083132.22394-6-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A direct lock dependency, such as L1 -> L2, can be in different lock chains
having that lock dependency. In order for us to associate lock chains to
lock dependencies, we add some new fields in struct lock_list and
lock_chain.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index b8a835f..d7bec61 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -188,6 +188,7 @@ static inline void lockdep_copy_map(struct lockdep_map *to,
  */
 struct lock_list {
 	struct list_head		entry;
+	struct list_head		chains;
 	struct lock_class		*class;
 	struct lock_class		*links_to;
 	const struct lock_trace		*trace;
@@ -207,6 +208,7 @@ struct lock_list {
  * @depth:       the number of held locks in this chain
  * @base:        the index in chain_hlocks for this chain
  * @entry:       the collided lock chains in lock_chain hash list
+ * @chain_entry: the link to the next lock_chain in the same dependency
  * @chain_key:   the hash key of this lock_chain
  */
 struct lock_chain {
@@ -216,6 +218,7 @@ struct lock_chain {
 					base	    : 24;
 	/* 4 byte hole */
 	struct hlist_node		entry;
+	struct list_head		chain_entry;
 	u64				chain_key;
 };
 
-- 
1.8.3.1

