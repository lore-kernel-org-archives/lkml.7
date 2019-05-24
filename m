Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3F3C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 23:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A225F217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 23:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="h1Yfyhrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfEXXuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 19:50:02 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32769 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfEXXuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 19:50:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id g21so4772741plq.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 16:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T411oidtPZE/SyBXnA5xe/v4182CyfqCsIw7xcrtw7w=;
        b=h1Yfyhrm1FED0jxfY2I/NspMxRT5TIJwzEmWWjpN49QToxU9ZGZbpFbhec3ZLORRCd
         jpV/RHW2DQVuQ6REsHLluVgcp8J/8f7MfNBg8yuFJKeM4vTFRi3l37IN4VY1lkR3I9qd
         ZWKxvmGD+ntgFm02ZtggbTrE3nvbMGZd9Jwq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T411oidtPZE/SyBXnA5xe/v4182CyfqCsIw7xcrtw7w=;
        b=MSWMyW6alG9SbhB8/Swgtwro1nCWfn97ssvBPtPC/g2Zr4aGaPiId21gVgLWrauwCL
         djvvIiv8fgPXnf9XCOP01WyXPZz+Y9A/BIfUsS8KvueDegDzux3lTisoxNba9+2L6PUF
         iiHvZPJ12lz+V7TY0DW4qt9Ns5TFNDBXMCwTPZP6lN0BllE0DcviZdNund5y3vGvhRgC
         QoUlFtN/1HEeBFmMgsUBcKxi26FMkMnO0XX1Ub5CGVv4migGUK0VLHyHA/B1FZfo+R76
         VZ6/cgzWjCc0A/Zcd1v3l8A4QkX+QqeHl6Wp02LnI8nDr/B37pKcTcvTihn4pCzv76uy
         sDRw==
X-Gm-Message-State: APjAAAVqFqMJp1IQPVFhp0lFIiKUBX+WhM0HP36ooeGss3i7p0I/XCey
        DKLQ2oU/sYXuSipYAavzdU7LFGuDKKgQwQ==
X-Google-Smtp-Source: APXvYqxwZl/5ewT5nmPHvDNF3PVcRdSTyjHQUf1i/UtDMZkPW0EhWp82Y0t5mSMFBjTrA/fFj21Rqg==
X-Received: by 2002:a17:902:4181:: with SMTP id f1mr87153377pld.22.1558741799771;
        Fri, 24 May 2019 16:49:59 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q4sm3297595pgb.39.2019.05.24.16.49.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 24 May 2019 16:49:59 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, kvm-ppc@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RFC 3/5] hashtable: Use the regular hlist_for_each_entry_rcu API
Date:   Fri, 24 May 2019 19:49:31 -0400
Message-Id: <20190524234933.5133-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
In-Reply-To: <20190524234933.5133-1-joel@joelfernandes.org>
References: <20190524234933.5133-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hlist_for_each_entry_rcu already does not do any tracing. This series
removes the notrace variant of it, so let us just use the regular API.

In a future patch, we can also remove the
hash_for_each_possible_rcu_notrace API that this patch touches.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/hashtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hashtable.h b/include/linux/hashtable.h
index 417d2c4bc60d..47fa7b673c1b 100644
--- a/include/linux/hashtable.h
+++ b/include/linux/hashtable.h
@@ -189,7 +189,7 @@ static inline void hash_del_rcu(struct hlist_node *node)
  * not do any RCU debugging or tracing.
  */
 #define hash_for_each_possible_rcu_notrace(name, obj, member, key) \
-	hlist_for_each_entry_rcu_notrace(obj, \
+	hlist_for_each_entry_rcu(obj, \
 		&name[hash_min(key, HASH_BITS(name))], member)
 
 /**
-- 
2.22.0.rc1.257.g3120a18244-goog

