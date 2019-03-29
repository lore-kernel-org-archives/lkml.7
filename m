Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67861C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318A7206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="tF7VCVvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbfC2OGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:06:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42935 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbfC2OGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:06:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so1272301pgh.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 07:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FapvRZyYiTZFWw/6Cc7PifpPyHkEerUXRp6Ch6YJf0A=;
        b=tF7VCVvcWTY29ojQUUysyh/P0Pgj4R/Zotjh4Q1WjuimdiGBtpx1TJ3gVaBeoLEYCY
         snyfunBcuZcYbOakoS02/9E/VpDV3bLqlW0lnWCacW76Q2auhlX534a2JAG9JQZf1Jt4
         mDwdLGhp8cOC5ln3kKwubQUUDNtDecD8LByd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FapvRZyYiTZFWw/6Cc7PifpPyHkEerUXRp6Ch6YJf0A=;
        b=Vh2EFJ8bNnp9zqhub4FKsGS/ZYROirw6bVZmlTeAYXSOd2vgPP+mxt6uxnSy0EpTb5
         M5TkAc8LRct+HHA1n1SiT8fRsuBED/MudunZz5SOmz+XF/++X2qMh8AFqWwslp+zdTKU
         qiNQddKmfydkfyXhAj57sJH3UXgABr14h37RlMKWWRr6fe2+7YTLeTHoYOsYC66NAdR3
         p/8THHN2NV00jo0/hr4Oxfkw5X+1V+5PbrLjfoXeWAoHGlIE0JAuloCUhYAm/zWHjAG7
         bU088T5iiMdYFmHfikXHRwqvOnHStRD0nL7Vl7P0DlqeMP8a5NMOlZgBJT4iPjT1rWqX
         cPqw==
X-Gm-Message-State: APjAAAWCAHELgMdT/maSxVH17cO2lVmDSJ9V/knLo2EGzR0yHc/Fh2G6
        3GrPY6JFjQrw4O+LM2j9uit/lxE+tNU=
X-Google-Smtp-Source: APXvYqzfoifDNvO+AAJ31IC+65JGwHTduv8nIYZJs+T39N4diMjz3GScgCgQIpc49zYbNE0Vq9aQmQ==
X-Received: by 2002:a63:5405:: with SMTP id i5mr41461290pgb.212.1553868362899;
        Fri, 29 Mar 2019 07:06:02 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id i64sm3178896pfb.112.2019.03.29.07.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 07:06:01 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        oleg@redhat.com, jannh@google.com,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2] doc/rcuref: Document real world examples in kernel
Date:   Fri, 29 Mar 2019 10:05:55 -0400
Message-Id: <20190329140555.118463-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document similar real world examples in the kernel corresponding to the
second and third code snippets. Also correct an issue in
release_referenced() in the code snippet example.

Cc: oleg@redhat.com
Cc: jannh@google.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

v1->v2:
 - minor fixups, label code listings.

 Documentation/RCU/rcuref.txt | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/RCU/rcuref.txt b/Documentation/RCU/rcuref.txt
index 613033ff2b9b..a49d525ce975 100644
--- a/Documentation/RCU/rcuref.txt
+++ b/Documentation/RCU/rcuref.txt
@@ -12,6 +12,7 @@ please read on.
 Reference counting on elements of lists which are protected by traditional
 reader/writer spinlocks or semaphores are straightforward:
 
+CODE LISTING A:
 1.				2.
 add()				search_and_reference()
 {				{
@@ -28,7 +29,8 @@ add()				search_and_reference()
 release_referenced()			delete()
 {					{
     ...					    write_lock(&list_lock);
-    atomic_dec(&el->rc, relfunc)	    ...
+    if(atomic_dec_and_test(&el->rc))	    ...
+	kfree(el);
     ...					    remove_element
 }					    write_unlock(&list_lock);
  					    ...
@@ -44,6 +46,7 @@ search_and_reference() could potentially hold reference to an element which
 has already been deleted from the list/array.  Use atomic_inc_not_zero()
 in this scenario as follows:
 
+CODE LISTING B:
 1.					2.
 add()					search_and_reference()
 {					{
@@ -79,6 +82,7 @@ search_and_reference() code path.  In such cases, the
 atomic_dec_and_test() may be moved from delete() to el_free()
 as follows:
 
+CODE LISTING C:
 1.					2.
 add()					search_and_reference()
 {					{
@@ -114,6 +118,13 @@ element can therefore safely be freed.  This in turn guarantees that if
 any reader finds the element, that reader may safely acquire a reference
 without checking the value of the reference counter.
 
+As can be seen, a clear advantage of the pattern in listing C is, if there are
+several calls to search_and_reference() in parallel to the delete(), then all
+of those will succeed in obtaining a reference to the object if the object
+could be found in the list before it was deleted in delete(), unlike the
+pattern in listing B which would fail to acquire references in such a situation
+even though the object is still in memory.
+
 In cases where delete() can sleep, synchronize_rcu() can be called from
 delete(), so that el_free() can be subsumed into delete as follows:
 
@@ -130,3 +141,7 @@ delete()
     	kfree(el);
     ...
 }
+
+As additional examples in the kernel, the pattern in listing C is used by
+reference counting of struct pid, while the pattern in listing B is used by
+struct posix_acl.
-- 
2.21.0.392.gf8f6787159e-goog
