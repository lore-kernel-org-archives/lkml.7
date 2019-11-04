Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68260CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D45D2184C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luvJ6kxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfKDNdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:33:24 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36916 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbfKDNdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:33:23 -0500
Received: by mail-pf1-f193.google.com with SMTP id p24so5707222pfn.4;
        Mon, 04 Nov 2019 05:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=10qTlHam78u6yRC3L6QqGT06Q7p6TYbTqIxEC0HhRO0=;
        b=luvJ6kxWnZqEyiG7YB72VUOBY1mNPZxfclcjQrTtik9vSLH0CjUhqgxnXOfSz5xvwT
         gXg/4L0NsTbMsO0m6n7whf6O78+ynOyB5fqotfyOVeWgt0QeXV+Ek2loqI5LbJexlfY2
         amUx3QNXYKzQMqphwzMIRAcluHrQ4h/z4Lo8qADt6nUzzqcpwOouTkuRC0AmrDPMF+bN
         TXD/ZzJb3H8fJO/yQ9rqCwzhA2x9aWromkrPJwBLPiBdik0bBx6ajPa/mZdPOIWuVla+
         f8+fB8VMgkT6G3Bk7wxsjPjZQvzwCn1A3XX9gyOrC281IPjcI1106kguun3LnCXXLWu9
         YO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=10qTlHam78u6yRC3L6QqGT06Q7p6TYbTqIxEC0HhRO0=;
        b=a/TF6hDWlFmPpeQAn5nI29598OPkZyu+Md/+N/qAc6SjfOMeG4MlgkNLaIEbNs32/D
         +gMknwI9Ne9RL8PVT/cAE6JZ4yE6gSsahX4p6lKrEg5pc7ysYYIt55ViXYJN5hC6cTow
         DvLYNtcskegEXWwLfANT0P86VmtNazWXTxb4pUo0y/flpsxpVlVQ7MpKEwYaHFhrc6jv
         L10/ya3FUgzMVjcm5OzPiqyjP0YFoZYAHuzYdl89PSt4cmLe0WZnle0sY4yQ+5dyLD3M
         cROAeIvGHpwA4VsKXQmOHfzx6meggS+S3JNrRJWBbsz1xvjaasRrODSKz+ODYFw/+5no
         QyrQ==
X-Gm-Message-State: APjAAAXrlcWCNVM3dKZFjrKd2EjkcMXaRr4HqXrxv1oZfP0d56+8lV+H
        uwc0teCmdpe4ahVLw01BFZ4PsZtB6ZyeMA==
X-Google-Smtp-Source: APXvYqxMCYkoZ3FwXu4e+XkbHtaCGCUa4MI0iVdDjAo7UC2iJOGftkvkz53xSD4jAY6u9adoa6VoMQ==
X-Received: by 2002:a17:90a:9f8a:: with SMTP id o10mr34979785pjp.91.1572874402452;
        Mon, 04 Nov 2019 05:33:22 -0800 (PST)
Received: from workstation-kernel-dev ([139.5.253.170])
        by smtp.gmail.com with ESMTPSA id l3sm15530908pff.9.2019.11.04.05.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 05:33:22 -0800 (PST)
Date:   Mon, 4 Nov 2019 19:03:15 +0530
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
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH] Documentation: RCU: whatisRCU: Fix formatting for section 2
Message-ID: <20191104133315.GA14499@workstation-kernel-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert RCU API method text to sub-headings and
add hyperlink and superscript to 2 literary notes
under rcu_dereference() section

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 Documentation/RCU/whatisRCU.rst | 34 +++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index ae40c8bcc56c..3cf6e17d0065 100644
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
 
@@ -279,8 +284,10 @@ rcu_dereference()
 	if an update happened while in the critical section, and incur
 	unnecessary overhead on Alpha CPUs.
 
+.. _back_to_1:
+
 	Note that the value returned by rcu_dereference() is valid
-	only within the enclosing RCU read-side critical section [1].
+	only within the enclosing RCU read-side critical section |cs_1|.
 	For example, the following is -not- legal::
 
 		rcu_read_lock();
@@ -298,15 +305,27 @@ rcu_dereference()
 	it was acquired is just as illegal as doing so with normal
 	locking.
 
+.. _back_to_2:
+
 	As with rcu_assign_pointer(), an important function of
 	rcu_dereference() is to document which pointers are protected by
 	RCU, in particular, flagging a pointer that is subject to changing
 	at any time, including immediately after the rcu_dereference().
 	And, again like rcu_assign_pointer(), rcu_dereference() is
 	typically used indirectly, via the _rcu list-manipulation
-	primitives, such as list_for_each_entry_rcu() [2].
+	primitives, such as list_for_each_entry_rcu() |entry_2|.
+
+.. |cs_1| raw:: html
+
+	<a href="#cs"><sup>[1]</sup></a>
+
+.. |entry_2| raw:: html
 
-	[1] The variant rcu_dereference_protected() can be used outside
+	<a href="#entry"><sup>[2]</sup></a>
+
+.. _cs:
+
+	\ :sup:`[1]`\  The variant rcu_dereference_protected() can be used outside
 	of an RCU read-side critical section as long as the usage is
 	protected by locks acquired by the update-side code.  This variant
 	avoids the lockdep warning that would happen when using (for
@@ -317,15 +336,18 @@ rcu_dereference()
 	a lockdep expression to indicate which locks must be acquired
 	by the caller. If the indicated protection is not provided,
 	a lockdep splat is emitted.  See Documentation/RCU/Design/Requirements/Requirements.rst
-	and the API's code comments for more details and example usage.
+	and the API's code comments for more details and example usage. :ref:`back <back_to_1>`
+
+
+.. _entry:
 
-	[2] If the list_for_each_entry_rcu() instance might be used by
+	\ :sup:`[2]`\  If the list_for_each_entry_rcu() instance might be used by
 	update-side code as well as by RCU readers, then an additional
 	lockdep expression can be added to its list of arguments.
 	For example, given an additional "lock_is_held(&mylock)" argument,
 	the RCU lockdep code would complain only if this instance was
 	invoked outside of an RCU read-side critical section and without
-	the protection of mylock.
+	the protection of mylock. :ref:`back <back_to_2>`
 
 The following diagram shows how each API communicates among the
 reader, updater, and reclaimer.
-- 
2.20.1

