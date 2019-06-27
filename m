Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18343C5B576
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D575D20828
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvwP3K3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfF0VBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 17:01:51 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43258 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0VBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:01:50 -0400
Received: by mail-ot1-f68.google.com with SMTP id i8so3726836oth.10;
        Thu, 27 Jun 2019 14:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=46fsmRV54TI9u4qvwSxfKVE3AHZxURoD917dwtDUxuM=;
        b=lvwP3K3iw+5FF+C4mYw4gFEeOjHmRThblBmhHO/VELWQQvqCGTfD4rQdLwv8dKEVdg
         W6LXzT2aqC8tsrx9Yyd4mV824j3zik4+R7plhAeYd6EICVKCk5cBUeZKPfg6xgOE98kp
         hMohMvZhSwq0M4kQiEpyN/RQyj9G9v4cFQi5WsGJJIjU/HnZT6iE+xbYRzh0RqL/g/wp
         D4Bh/+wMh4UsN69yc/2aKoJg58TNTm0K9IlDJTzOXSIPP1lm1q3c74pJNbJuwLEjoj4m
         VmEFxspsTO41zNkZk43bQvFnH0iVJvZWliz435qG3frj/MnZs394VaV9miBP3YMV2uuB
         TJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=46fsmRV54TI9u4qvwSxfKVE3AHZxURoD917dwtDUxuM=;
        b=OfM/ncHbpI0KK+lDOgej+xsW63796uad8ywkRS+Xecjm4bTnqG3XkWvpCeg2mHU45s
         z8sUr00r04VVJJ1IoybesWXTVwL5MPry9gq+h1vW4faBS7yPraShNhrCaSGR9hhhj9+r
         K5hCDLB7uavyxO+c8OH6ihyUplUEhZ9zING3EqaGHAHVQaMJ4wwdyKV77kfErUhEke/a
         UQEO0iOom75wCJt0+IKbs1Ane5Cmyh15GWhHJkapA32xtAibFEeAXhGjWWTIAX0FOQDd
         AH5oMK0Q7xSSjdrWZFLFZ51V88+XA0gBn6dAeFRRmiokghPaR+WUGsPaOZDy475jk0eo
         x2zg==
X-Gm-Message-State: APjAAAXJdJCSBssg1HtFJu+woS2ekueHgnnv9CpBnB6sKHlbo69Fr5ea
        jYjArxixtiJb55iOED5NvnM=
X-Google-Smtp-Source: APXvYqxoOvmkT354FS4zQ8PRDBJ2dMz7T6UzEens2gmdol9ZIB+5jtPYW8BBEy9FnlGLTNy5FtkkFQ==
X-Received: by 2002:a9d:6a92:: with SMTP id l18mr5033616otq.294.1561669309835;
        Thu, 27 Jun 2019 14:01:49 -0700 (PDT)
Received: from rYz3n.attlocal.net ([2600:1700:210:3790::48])
        by smtp.googlemail.com with ESMTPSA id c64sm86066otb.79.2019.06.27.14.01.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 14:01:49 -0700 (PDT)
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees][PATCH] doc: RCU callback locks need only _bh, not necessarily _irq
Date:   Thu, 27 Jun 2019 16:01:47 -0500
Message-Id: <20190627210147.19510-1-c0d1n61at3@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UP.rst file calls for locks acquired within RCU callback functions
to use _irq variants (spin_lock_irqsave() or similar), which does work,
but can be overkill.  This commit therefore instead calls for _bh variants
(spin_lock_bh() or similar), while noting that _irq does work.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
---
 Documentation/RCU/UP.rst | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/RCU/UP.rst b/Documentation/RCU/UP.rst
index 67715a47ae89..e26dda27430c 100644
--- a/Documentation/RCU/UP.rst
+++ b/Documentation/RCU/UP.rst
@@ -113,12 +113,13 @@ Answer to Quick Quiz #1:
 Answer to Quick Quiz #2:
 	What locking restriction must RCU callbacks respect?
 
-	Any lock that is acquired within an RCU callback must be
-	acquired elsewhere using an _irq variant of the spinlock
-	primitive.  For example, if "mylock" is acquired by an
-	RCU callback, then a process-context acquisition of this
-	lock must use something like spin_lock_irqsave() to
-	acquire the lock.
+	Any lock that is acquired within an RCU callback must be acquired
+	elsewhere using an _bh variant of the spinlock primitive.
+	For example, if "mylock" is acquired by an RCU callback, then
+	a process-context acquisition of this lock must use something
+	like spin_lock_bh() to acquire the lock.  Please note that
+	it is also OK to use _irq variants of spinlocks, for example,
+	spin_lock_irqsave().
 
 	If the process-context code were to simply use spin_lock(),
 	then, since RCU callbacks can be invoked from softirq context,
-- 
2.22.0

