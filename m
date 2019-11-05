Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DD7FA3736
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907DF20717
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3HPrMC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387914AbfKEHdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 02:33:49 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37974 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387484AbfKEHdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 02:33:49 -0500
Received: by mail-pf1-f193.google.com with SMTP id c13so14520229pfp.5;
        Mon, 04 Nov 2019 23:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=EkRYu0Ekf5R2bAPpf2M/JWgiEhUz2V6dE5+p9ovzqsg=;
        b=d3HPrMC75mRX351XBI/x/rQuJGxRTDxpBbKEGhWDBVyK2zxOn0eoqWVxyUqmcbr+9C
         73Skipj6XHhgaJTp/Vy4rVRAE7U5Z6WnHenkPSZQqMox5hjC4DxlxEHkjiFWnlyA/xWW
         UH9+G+C3+ytczurXKdx+v6DHkfKk4mQ2IX2up1xcBo/q5eDV+LuHmMXKTAfGcflTiyKg
         AVKtdDrleO1ZGJTb8OhAXVeN4XhZcp8FaxFJqL/oDfRdn7mhrBywU60UdftPFiU5q6Fe
         BN9HcIAhxug2GRnXwoz3vDSrBKyvl9KcQmJOredL1QikFFPG/P+lb539ip7YvwqZA9Ay
         Smwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=EkRYu0Ekf5R2bAPpf2M/JWgiEhUz2V6dE5+p9ovzqsg=;
        b=regL58PhW2oy0HhsE+S/INpo7jcVqOUMaxTRnmqfSmL+V35bpG+5L8zQy6QSUkgr1Q
         mAIyfTNyMAM+9JNyGi+pZmgZwpjIi5EGcTsC30mOt7CbxPy9ktQIp2Z6AgiMier24/wk
         PjfOP50m7GsRq4QZLJS06t5IqzB/v3a3gvb9lDDii08N/QyAtTyNNmX6ThRgSODR30Ja
         gnHAo32ZQo9Rdf55s3FoLGzhD7phbHesR0t9hL8iAm/slm1zVr0BC0chXWaeN73XU+sB
         XejPq7ZGxBh2AU5tQIg8vDW5UnpJ7zyZ59y/OklMOJ3rHwCtr1EkpsJH7pn8h5aEUe02
         iVIw==
X-Gm-Message-State: APjAAAXppaMyO4WgWIrDybi5tFxxer4cWhDG/+BsZe+eKtzj5LO9OCU9
        E/BXAZSbcnbH/pyhs76IhnM=
X-Google-Smtp-Source: APXvYqwQ4vOxO6VPaaSag5ZJl4fhRn/9AbcTHJw1a6Md4uNaoeUjlBZIMOfvPZujEWUvbPl62b0ZhQ==
X-Received: by 2002:a63:7158:: with SMTP id b24mr34646870pgn.153.1572939228246;
        Mon, 04 Nov 2019 23:33:48 -0800 (PST)
Received: from workstation-kernel-dev ([139.5.253.184])
        by smtp.gmail.com with ESMTPSA id b9sm19581266pfp.77.2019.11.04.23.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 23:33:47 -0800 (PST)
Date:   Tue, 5 Nov 2019 13:03:40 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Phong Tran <tranmanphong@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH v2] Documentation: RCU: whatisRCU: Fix formatting for section
 2
Message-ID: <20191105073340.GA3682@workstation-kernel-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert RCU API methods text to sub-headings and
add footnote linking to 2 literary notes
under rcu_dereference() section for improved UX

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 Documentation/RCU/whatisRCU.rst | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index ae40c8bcc56c..4c6f1f595757 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -150,6 +150,7 @@ later.  See the kernel docbook documentation for more info, or look directly
 at the function header comments.
 
 rcu_read_lock()
+^^^^^^^^^^^^^^^
 
 	void rcu_read_lock(void);
 
@@ -164,6 +165,7 @@ rcu_read_lock()
 	longer-term references to data structures.
 
 rcu_read_unlock()
+^^^^^^^^^^^^^^^^^
 
 	void rcu_read_unlock(void);
 
@@ -172,6 +174,7 @@ rcu_read_unlock()
 	read-side critical sections may be nested and/or overlapping.
 
 synchronize_rcu()
+^^^^^^^^^^^^^^^^^
 
 	void synchronize_rcu(void);
 
@@ -225,6 +228,7 @@ synchronize_rcu()
 	checklist.txt for some approaches to limiting the update rate.
 
 rcu_assign_pointer()
+^^^^^^^^^^^^^^^^^^^^
 
 	void rcu_assign_pointer(p, typeof(p) v);
 
@@ -245,6 +249,7 @@ rcu_assign_pointer()
 	the _rcu list-manipulation primitives such as list_add_rcu().
 
 rcu_dereference()
+^^^^^^^^^^^^^^^^^
 
 	typeof(p) rcu_dereference(p);
 
@@ -280,7 +285,7 @@ rcu_dereference()
 	unnecessary overhead on Alpha CPUs.
 
 	Note that the value returned by rcu_dereference() is valid
-	only within the enclosing RCU read-side critical section [1].
+	only within the enclosing RCU read-side critical section [1]_.
 	For example, the following is -not- legal::
 
 		rcu_read_lock();
@@ -304,9 +309,9 @@ rcu_dereference()
 	at any time, including immediately after the rcu_dereference().
 	And, again like rcu_assign_pointer(), rcu_dereference() is
 	typically used indirectly, via the _rcu list-manipulation
-	primitives, such as list_for_each_entry_rcu() [2].
+	primitives, such as list_for_each_entry_rcu() [2]_.
 
-	[1] The variant rcu_dereference_protected() can be used outside
+..	[1] The variant rcu_dereference_protected() can be used outside
 	of an RCU read-side critical section as long as the usage is
 	protected by locks acquired by the update-side code.  This variant
 	avoids the lockdep warning that would happen when using (for
@@ -319,7 +324,8 @@ rcu_dereference()
 	a lockdep splat is emitted.  See Documentation/RCU/Design/Requirements/Requirements.rst
 	and the API's code comments for more details and example usage.
 
-	[2] If the list_for_each_entry_rcu() instance might be used by
+
+..	[2] If the list_for_each_entry_rcu() instance might be used by
 	update-side code as well as by RCU readers, then an additional
 	lockdep expression can be added to its list of arguments.
 	For example, given an additional "lock_is_held(&mylock)" argument,
-- 
2.20.1

