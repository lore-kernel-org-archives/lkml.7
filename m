Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CD3C46460
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 22:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC32277D6
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 22:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="gHAEz0W9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfFAW2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 18:28:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44250 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfFAW1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 18:27:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id x3so2825174pff.11
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 15:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D3sdCrSta+1LinDxkJqXRJ9YdXWa10ctUItDBKvA25M=;
        b=gHAEz0W9Uu6qrM4ChuzLYGhD2n+4olfOU6qtJoOTBMe07a7Pc4Kg4feW7OCrB0FNOD
         pQJX/g4h2kdJiFQw/ZIM4s5GiPaQM2j5/cGGfHCrCR2g/GZ5h0YzW+8SpyH7GWKKIGYX
         JsyoEKMQELkCHYwUEweS6UvTXF7q7XQ+nsWJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3sdCrSta+1LinDxkJqXRJ9YdXWa10ctUItDBKvA25M=;
        b=t6sz8ZxHFHGeJ2nWstO2Q2A38Z0/sUKGYpZjrWVp1j5PFinyE7BNOfRBT36YPUbYbN
         ve9vWDyOKelma4Q75ZWQl6eOrvZrVjXyLahAyx10j+y2mun1hv/ue8vhZPrDJsf7i/tN
         jBefZ6Ab/AyNamfnzdGtFOzbDhbsLZ2Esys04NK1jpdmx5DtLmkZoaIFELzlStxGi/6Y
         v+ESktYBFoB0gG88yZC2XGtO+BxWOasg717pgcsA59eIeh+vh+l2Q6EATsn2J23+FwEM
         qr6pz5o1ZCDSXxncMK/jFuQgAPulFeQ19sHia650IP4XNsl01T+fDWchCfkrP+lr0XjA
         ESpQ==
X-Gm-Message-State: APjAAAWcptFJMe+xQIi5f5Nov2TXmU71Z576ezWEkn2PRQ8HUmd11fgt
        +w1g8sx/qXT0NBYBnsi5nJvyTyCxzsqh3w==
X-Google-Smtp-Source: APXvYqyzFAgWiq9Zmv6qgFmEjp82uhykmH3iEDVhVPdvKHGIbsKdjW+zFeDMBpdGsYU3yEg7JY6LEQ==
X-Received: by 2002:a62:a511:: with SMTP id v17mr19913167pfm.129.1559428073227;
        Sat, 01 Jun 2019 15:27:53 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t33sm9908018pjb.1.2019.06.01.15.27.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 01 Jun 2019 15:27:52 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>, edumazet@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neilb@suse.com, netdev@vger.kernel.org, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, peterz@infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [RFC 2/6] ipv4: add lockdep condition to fix for_each_entry
Date:   Sat,  1 Jun 2019 18:27:34 -0400
Message-Id: <20190601222738.6856-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190601222738.6856-1-joel@joelfernandes.org>
References: <20190601222738.6856-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 net/ipv4/fib_frontend.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index b298255f6fdb..ef7c9f8e8682 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -127,7 +127,8 @@ struct fib_table *fib_get_table(struct net *net, u32 id)
 	h = id & (FIB_TABLE_HASHSZ - 1);
 
 	head = &net->ipv4.fib_table_hash[h];
-	hlist_for_each_entry_rcu(tb, head, tb_hlist) {
+	hlist_for_each_entry_rcu(tb, head, tb_hlist,
+				 lockdep_rtnl_is_held()) {
 		if (tb->tb_id == id)
 			return tb;
 	}
-- 
2.22.0.rc1.311.g5d7573a151-goog

