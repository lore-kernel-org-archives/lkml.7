Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB385C17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937C821655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAOdIV0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKKSM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:12:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42046 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfKKSM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:12:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id s5so11170409pfh.9;
        Mon, 11 Nov 2019 10:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nVbr8MtQ7ZO4CacZdX8JXbKAIcqSlSq2oEAfHRt0wK4=;
        b=rAOdIV0cCiN/zHYvwhWIVgXx6j5+Wf+Kltc5JVcq3LZqB2idl67vTbao209IAhsOJO
         980kByl8h8gzi5u9MoLkuIMU+J1tK13rnVQSpcIfxDynST3M8SY3mbwuUZmQnRjCzSVU
         xjyNPeWM+AOJWH8eAgXI0u7hoqLP+LFGs+D7Tgg3EYKvTEJy0i8MBPtSwU7LEQwNZIVC
         oFXqEEX2LUkWS48LTsa4ZCJarmvwhpV9sovnHsrGelEG2OW8+UQ9vhX82MdJCZcg2CIJ
         1l/iM03xHSUoVRcAr6zMMoTmIgNdySjl/H3XT9ofIHmTIeZWMdMox2/3Jq1KZWnRIovv
         +E5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nVbr8MtQ7ZO4CacZdX8JXbKAIcqSlSq2oEAfHRt0wK4=;
        b=gl2NmYtWsgSKU1FBdfEoSbr5PGoKbBMKnPB1tsdXVXOIsKUoWwRvLQtXlcy4oVVbse
         K1j1SakYm2df3UXp6RVbuWLSvbnJqCiFdzUHao762f98z5/nhF46hcMSxQoaXz10yQxW
         XKkdg+OWXuquToNlhJLIWMmZWfOcyM7/EhcOA5RU+lnyEa1+armVF968ervgaxLz+5jL
         rWTpS5H+Pn8iy9GzEjUPhQ/luLTbg1zirfq1MH9cOMxQyb6fi1qnrC4iTeHqdydbGFsS
         KEmVbTUmpEoiAfE6Ch6x0AxiLkt08qqih3+YtFRKZb0KogxMVzv/jDwIEOFh3SlzVlfZ
         VNMg==
X-Gm-Message-State: APjAAAXmtCbnrZPGfHo4NBAWsiHRInVkkG2U1LIA2EP8IYMUWgbkGOJi
        Y4vWUIzkrilQ1V+Hf3uf//g=
X-Google-Smtp-Source: APXvYqzqab4rU4p2tyKosUenhapYrI0ueVPZGyWP01XeA+pX8HJKu1zEfgSHrqmDQY9JAg6YU5WFvA==
X-Received: by 2002:a65:6843:: with SMTP id q3mr24328556pgt.361.1573495945788;
        Mon, 11 Nov 2019 10:12:25 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:533:7f79:a8e9:b74c:7d75:d0c])
        by smtp.gmail.com with ESMTPSA id c12sm18301057pfp.67.2019.11.11.10.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 10:12:25 -0800 (PST)
From:   madhuparnabhowmik04@gmail.com
To:     paulmck@kernel.org, joel@joelfernandes.org, corbet@lwn.net,
        mchehab@kernel.org
Cc:     rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH] Documentation: RCU: whatisRCU: Updated full list of RCU API
Date:   Mon, 11 Nov 2019 23:41:22 +0530
Message-Id: <20191111181122.28083-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patch updates the list of RCU API in whatisRCU.rst.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 Documentation/RCU/whatisRCU.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 2f6f6ebbc8b0..c7f147b8034f 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -884,11 +884,14 @@ in docbook.  Here is the list, by category.
 RCU list traversal::
 
 	list_entry_rcu
+	list_entry_lockless
 	list_first_entry_rcu
 	list_next_rcu
 	list_for_each_entry_rcu
 	list_for_each_entry_continue_rcu
 	list_for_each_entry_from_rcu
+	list_first_or_null_rcu
+	list_next_or_null_rcu
 	hlist_first_rcu
 	hlist_next_rcu
 	hlist_pprev_rcu
@@ -902,7 +905,7 @@ RCU list traversal::
 	hlist_bl_first_rcu
 	hlist_bl_for_each_entry_rcu
 
-RCU pointer/list udate::
+RCU pointer/list update::
 
 	rcu_assign_pointer
 	list_add_rcu
@@ -912,10 +915,12 @@ RCU pointer/list udate::
 	hlist_add_behind_rcu
 	hlist_add_before_rcu
 	hlist_add_head_rcu
+	hlist_add_tail_rcu
 	hlist_del_rcu
 	hlist_del_init_rcu
 	hlist_replace_rcu
-	list_splice_init_rcu()
+	list_splice_init_rcu
+	list_splice_tail_init_rcu
 	hlist_nulls_del_init_rcu
 	hlist_nulls_del_rcu
 	hlist_nulls_add_head_rcu
-- 
2.17.1

