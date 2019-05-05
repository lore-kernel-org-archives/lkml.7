Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158CEC04AAA
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 02:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D923520675
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 02:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VF97BCjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfEECEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 22:04:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45677 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfEECED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 22:04:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so4853098pfi.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 19:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZFhA4rpBi4Ho6CrUxobqyCCZrYULhg304dSUdvW7O94=;
        b=VF97BCjYFHEAQLpYYbW91gr3FQIXdhnksyX+tLBpQCq6IOPLNoGKQ1xLm4n+GoZEK1
         ZrMI9jRmv92rcu4yERa1vUnvkrYoiSlvlVDtuk58zcMFywKQjMNULJqXEPROjvk2LhoS
         3IZ2EhwORtG6UrMA7SYMD7RU/CopH/XHCGLFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZFhA4rpBi4Ho6CrUxobqyCCZrYULhg304dSUdvW7O94=;
        b=MhUy4QCP1zApKnUUVaUucHGi2ehr71t0E9iOeaf2YeH3sN8jzxWT6oVxBL9V+FeGQt
         bDpQUwy7rhae70G+yNxWO3MzmzImVLYHHwcihthgAs3aa7L91Vqb9/eaxaiOkcWcBJF5
         95xGMGS7gFneI38S/CyQNZZLf4nQtPnlhJEbTL5LJyma/WUTW6IUzSVvHFh4XqadYLiT
         qd6aOGqI20XN0Hg05lccaoTP0Ejx8XdcOQTwDDenUep1I7Kj941Ziei1o1EmCOLMhuAV
         sk0onk4FMOtTZ/gZM0LcnujPqwhaILN80D66Pu6620J4oIhxwwFIibrRa6pOuKwWdcow
         Ca/w==
X-Gm-Message-State: APjAAAWoVBDlUIXk9ssBcu30cDT82OuIcTCDOa1uzbQfy8p2ZUPiBT1p
        0jYSd5K2y9umBAwuy7liv326DBtKzZs=
X-Google-Smtp-Source: APXvYqxVp6IA/vCCGuS3+eK5MQzvCZdy0r4p5IJ9nTyEy86IgB/c5iImNtANV5yxYN8IFPwA87P+VQ==
X-Received: by 2002:aa7:91c8:: with SMTP id z8mr23430186pfa.110.1557021842475;
        Sat, 04 May 2019 19:04:02 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 5sm2632829pfs.17.2019.05.04.19.03.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 04 May 2019 19:04:00 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] doc/rcu: Correct field_count field naming in examples
Date:   Sat,  4 May 2019 22:03:10 -0400
Message-Id: <20190505020328.165839-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I believe this field should be called field_count instead of file_count.
Correct the doc with the same.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/RCU/listRCU.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/listRCU.txt b/Documentation/RCU/listRCU.txt
index adb5a3782846..190e666fc359 100644
--- a/Documentation/RCU/listRCU.txt
+++ b/Documentation/RCU/listRCU.txt
@@ -175,7 +175,7 @@ otherwise, the added fields would need to be filled in):
 		list_for_each_entry(e, list, list) {
 			if (!audit_compare_rule(rule, &e->rule)) {
 				e->rule.action = newaction;
-				e->rule.file_count = newfield_count;
+				e->rule.field_count = newfield_count;
 				write_unlock(&auditsc_lock);
 				return 0;
 			}
@@ -204,7 +204,7 @@ RCU ("read-copy update") its name.  The RCU code is as follows:
 					return -ENOMEM;
 				audit_copy_rule(&ne->rule, &e->rule);
 				ne->rule.action = newaction;
-				ne->rule.file_count = newfield_count;
+				ne->rule.field_count = newfield_count;
 				list_replace_rcu(&e->list, &ne->list);
 				call_rcu(&e->rcu, audit_free_rule);
 				return 0;
-- 
2.21.0.1020.gf2820cf01a-goog

