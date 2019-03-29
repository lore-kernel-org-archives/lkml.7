Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45B7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA062184E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="j1z/T9KR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfC2Ck4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 22:40:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45522 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbfC2Ckz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 22:40:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id e24so293905pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 19:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+gwMIrF62iuFmSJNw1irXpe2wwHmb9eWrbcY7GGBGg=;
        b=j1z/T9KRGvNP4kRktgBPUbBLSE0RizoWJaqLij6jVD71xse63YLbc6mvcjjw9sQQvo
         4E7ADtjbGra6yOaqajRodZ9mwcc4i7MGShi1O6QWpnjOWDNdx8Le01FMGZcVVvAO5ng6
         6I8HPKo7uzKYx883QFlcfY8eElALAwWJx/4rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q+gwMIrF62iuFmSJNw1irXpe2wwHmb9eWrbcY7GGBGg=;
        b=NplsL/023RZP7n0WQH6XvxGBecAWdJbdil+6o6iwn15cIUJeOoicUpc+/CmptMX0pN
         HCko8oq6j9+lfb/AgM8FukY5pmaJs/XUdQ6UKAG+S/CJs4W5tgUQcbvSq9x23mUnj2EJ
         5s1FNR9oTGqh5oRX5F9Ss0JtsyDcsc6AjAaQks/d7OTJv3FzRyMBgNBE2I0NHAfaTYt4
         AwmBHpMG6gyox1KhqNX201WB7Xgo8giGPeuW6/vr1Si0HqHWkeOFP33HrxaoptsbhhVH
         ZVTLZI5/YneI+HGgJYCy+TUnpZPzPif8HUBTqERWBdcCSyzKZTS+fYQ5qM0wWJljRUSS
         vpNQ==
X-Gm-Message-State: APjAAAVHeJQRZ6Mek9vY0R2tACGS4orpnwTGdXF58tdBIjQwwwZ1YhPq
        WbFQn1gvooBO3SXT4yS17O2N1JbZWSA=
X-Google-Smtp-Source: APXvYqzUqjyigNDgK+xrv0ddZN4JiAiDNMbB9ZNkOD7swLClVoBSsfCtQxRwt0fxRMoEbkAbfyvK4A==
X-Received: by 2002:aa7:8096:: with SMTP id v22mr5536035pff.94.1553827254547;
        Thu, 28 Mar 2019 19:40:54 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l74sm656822pfi.174.2019.03.28.19.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 19:40:53 -0700 (PDT)
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
Subject: [PATCH] doc/rcuref: Document real world examples in kernel
Date:   Thu, 28 Mar 2019 22:40:47 -0400
Message-Id: <20190329024047.206989-1-joel@joelfernandes.org>
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

---
 Documentation/RCU/rcuref.txt | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/RCU/rcuref.txt b/Documentation/RCU/rcuref.txt
index 613033ff2b9b..e5f4a49f886a 100644
--- a/Documentation/RCU/rcuref.txt
+++ b/Documentation/RCU/rcuref.txt
@@ -28,7 +28,8 @@ add()				search_and_reference()
 release_referenced()			delete()
 {					{
     ...					    write_lock(&list_lock);
-    atomic_dec(&el->rc, relfunc)	    ...
+    if(atomic_dec_and_test(&el->rc))	    ...
+	kfree(el);
     ...					    remove_element
 }					    write_unlock(&list_lock);
  					    ...
@@ -114,6 +115,11 @@ element can therefore safely be freed.  This in turn guarantees that if
 any reader finds the element, that reader may safely acquire a reference
 without checking the value of the reference counter.
 
+The other advantage of the last pattern is, if there are several calls to
+search_and_reference() in parallel to the delete(), then all of those will
+succeed in obtaining a reference to the object if the object could be found in
+the list before it was deleted in delete().
+
 In cases where delete() can sleep, synchronize_rcu() can be called from
 delete(), so that el_free() can be subsumed into delete as follows:
 
@@ -130,3 +136,7 @@ delete()
     	kfree(el);
     ...
 }
+
+As additional examples in the kernel, This last pattern is also followed by
+reference counting of 'struct pid' while the prior pattern where
+atomic_inc_not_zero() is used is used by struct posix_acl.
-- 
2.21.0.392.gf8f6787159e-goog

