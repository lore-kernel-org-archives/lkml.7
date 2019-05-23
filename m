Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691B2C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D5C20863
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RW8IHPk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbfEWNcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 09:32:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40005 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730613AbfEWNcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 09:32:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id 15so5798233wmg.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 06:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZL2mTowtd+iMS19QPGPsV0ihDUcR6R3pM4Mf8egGGYk=;
        b=RW8IHPk8xrGrRfFLfeE7DQsgUQlpaZ98zcUFZ9VMv9++4lY8ZqqqCwrgPtGDNaLnQT
         AIydtDp0R/68FYPA4lMfw8o1ekSgcBnzXcKcW8qg67lhOtQwEA+yAlAe42grac7wXFqL
         JJaoX8Qvrgn3Tjdmz8TvMP2hifGpOat5AH48E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZL2mTowtd+iMS19QPGPsV0ihDUcR6R3pM4Mf8egGGYk=;
        b=sUuldVD4RGIzTloyd52EEL6205k65+9fDBiMoCQRIT/jVnYtl3BEn7+ZCl+mhwgksS
         4MzuO8yvy1gKwRVoLN2UfLWxCIrP12gCpuioX1PxgpGiokrAKiCPrk6wW9prZcDTxnRD
         zP3J/Aaxerih52Ic80JaEW+4QtN/lYDg1ecnnMq7n5BZ6c1tfIUPNO5izkQxeMxhSaPc
         3tKF+Ta4pfnP3MiS7xdUQtnVd36qYuu3T6sHJ2Peji14tBbuDPQVRPCSRN4tB/wvakR2
         RPI/NLmIo0inEnnQL53qhWqfXdz+PMWmP2Lky4gMHn23UCGDtTR2/C4dV5z43414CijM
         LP9g==
X-Gm-Message-State: APjAAAUfv8HwNcBwvWY+KHvbDDU/xHIoGD2eOU3iaNUqI8n1R3PAWIM7
        l7g9PM2/2Mbz7eFIXcaR/TtPk6PRKs+Pxg==
X-Google-Smtp-Source: APXvYqxKrJOPJRcvYLMrdPZnlVlCNLb48gdjcwCy4V1eDa2hEzDxmAnHtDnBkHcBtZSUt+9RfSJwmQ==
X-Received: by 2002:a1c:7c0b:: with SMTP id x11mr11221336wmc.86.1558618370123;
        Thu, 23 May 2019 06:32:50 -0700 (PDT)
Received: from localhost.localdomain (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id g16sm1633868wrm.96.2019.05.23.06.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 May 2019 06:32:49 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH] rcu: Make 'rcu_assign_pointer(p, v)' of type 'typeof(p)'
Date:   Thu, 23 May 2019 15:32:20 +0200
Message-Id: <1558618340-17254-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The expression

  rcu_assign_pointer(p, typeof(p) v)

is reported to be of type 'typeof(p)' in the documentation (c.f., e.g.,
Documentation/RCU/whatisRCU.txt) but this is not the case: for example,
the following snippet

  int **y;
  int *x;
  int *r0;

  ...

  r0 = rcu_assign_pointer(*y, x);

can currently result in the compiler warning

  warning: assignment to ‘int *’ from ‘uintptr_t’ {aka ‘long unsigned int’} makes pointer from integer without a cast [-Wint-conversion]

Cast the uintptr_t value to a typeof(p) value.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: rcu@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
NOTE:

TBH, I'm not sure this is 'the right patch' (hence the RFC...): in
fact, I'm currently missing the motivations for allowing assignments
such as the "r0 = ..." assignment above in generic code.  (BTW, it's
not currently possible to use such assignments in litmus tests...)

The usual concern is, of course, that if something is allowed (read
'compile!' ;/) then people will soon or later use it and they'll do
it in all sorts of 'creative' ways, such as 'to extend dependencies
across rcu_assign_pointer() calls' as in

  x = READ_ONCE(*z);
  r0 = rcu_assign_pointer(*y, x);
  WRITE_ONCE(*w, r0);

Notice that using a 'do { ... } while (0)', say, would prevent such
tricks/rvalues. (The same approach is used by smp_store_release().)

For a related discussion, please see:

  https://lkml.kernel.org/r/20190523083013.GA4616@andrea

Thoughts?

  Andrea
---
 include/linux/rcupdate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 915460ec08722..b94ba5de78fba 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -375,7 +375,7 @@ static inline void rcu_preempt_sleep_check(void) { }
 		WRITE_ONCE((p), (typeof(p))(_r_a_p__v));		      \
 	else								      \
 		smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
-	_r_a_p__v;							      \
+	((typeof(p))_r_a_p__v);						      \
 })
 
 /**
-- 
2.7.4

