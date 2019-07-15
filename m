Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B210C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740E720651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="WUpb9JKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404473AbfGOOoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:44:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41932 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404704AbfGOOhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:37:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so8357587pls.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 07:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/gvD5L3W4khYlR/j02/LMhetLZkkRNPQ8EPkwaYb/Yo=;
        b=WUpb9JKsXzIHcxew1wAVQiWwZ+kaf0Ww3b9i/phqeK6eGSyIkMrGlEABg1JgP/N6a7
         XI3TNv1vdpFEoUyT+MAAdsh6eiTQV1SZjNnbyXSh4bYq6H3Gz7K8UhzDuVF/rfbp1RTm
         xNeitgRKD2kv4LjyEJgK6S9GJGZvS2JWmOhuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/gvD5L3W4khYlR/j02/LMhetLZkkRNPQ8EPkwaYb/Yo=;
        b=iOO3xw78VKc3997s5WbE6ofJohH0h01SrcgX/IgDXrFxIZrvlkZVGOhH6bDSnoQ957
         LsTSUd9JMte+8chXAxztyM+507j35sl0ifgahFT/9wPoa4iA4q9rSLeoCNqy7Rh3gRNh
         fZSYpvR2KoDWJFjEqJA0GH/QQXJc5rzur99h6VMOj7UrPX/vqnDBvgYvC4veEroP19DY
         DzP52okj3vz2nQGsQttzUAMzgyFZWw0iGSHHeU9HaHHvGxFyFIEoya0zCbmtMowZssck
         aJt6dJhvFpJq3RDGH6UXQTvyKXnDM4hHWxGi2NfpP8iuigsPRt1bFEmY+cOGlVqOxvOK
         BR7A==
X-Gm-Message-State: APjAAAUGe+70yEZg5QjOBeJfdI6lIEdp22ome2EPMFNVt26WWajBRIPf
        qk8ml8O2URkPenIFM75TWDJqzIc8
X-Google-Smtp-Source: APXvYqySJr0Y1QIzNUIj9NJwd+Rw22u3LGJjXHmBidac39lx3Xu00PxoUZgolCbZ3bk0iovIh+UXIw==
X-Received: by 2002:a17:902:1003:: with SMTP id b3mr29244590pla.172.1563201450419;
        Mon, 15 Jul 2019 07:37:30 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s66sm18381852pfs.8.2019.07.15.07.37.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 07:37:29 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>, c0d1n61at3@gmail.com,
        "David S. Miller" <davem@davemloft.net>, edumazet@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neilb@suse.com, netdev@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, peterz@infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH 4/9] ipv4: add lockdep condition to fix for_each_entry (v1)
Date:   Mon, 15 Jul 2019 10:37:00 -0400
Message-Id: <20190715143705.117908-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190715143705.117908-1-joel@joelfernandes.org>
References: <20190715143705.117908-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the previous support added, use it for adding lockdep conditions
to list usage here.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 net/ipv4/fib_frontend.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 317339cd7f03..26b0fb24e2c2 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -124,7 +124,8 @@ struct fib_table *fib_get_table(struct net *net, u32 id)
 	h = id & (FIB_TABLE_HASHSZ - 1);
 
 	head = &net->ipv4.fib_table_hash[h];
-	hlist_for_each_entry_rcu(tb, head, tb_hlist) {
+	hlist_for_each_entry_rcu(tb, head, tb_hlist,
+				 lockdep_rtnl_is_held()) {
 		if (tb->tb_id == id)
 			return tb;
 	}
-- 
2.22.0.510.g264f2c817a-goog

