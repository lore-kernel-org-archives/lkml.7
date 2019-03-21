Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3285C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796162146E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hbe/7tUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfCUH5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:57:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36658 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUH5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:57:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id p10so3796774pff.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 00:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I77zwRuXfEdeBhoNz+IOFKnvbLXbCnG7xjarznF2B20=;
        b=Hbe/7tURPr7Ue6yVHfpjRvISbZHad3AvA24omWZuRKe+Yxp3KtBa1fDBa3IUimerzS
         w1RzBOcU+vDGwFkxo12LR9niHgKD2rJUE7AFID7kou0mKUBM8wqApE29mowg2ZPlliMD
         Zs2whoG+wRJ/XKQigCfml0CCZ4LMcHv1OgpXdI9z+ev/qy0fYgtSSUl8RJ/oIkB7rBft
         K3oX4iKdh9FMXBYYsFLWdYbPpmrlCNVCmnjfKsZugBZwJvMoP8fl/U5Kw65dLUd9VckM
         UuMShFuj0Hq683+2q6oTgRGjnSLSnaPpr7Kww0cPjy4WVyyagHCqVpp6OrOmtX5p+O79
         zgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I77zwRuXfEdeBhoNz+IOFKnvbLXbCnG7xjarznF2B20=;
        b=N5+wgZyxLwh6wkD0teE30nxgepkLM3D1iV5wf4TOYdPMdpmeAB5yZ85FCcIYJgF7gf
         72gQHJN4eJ5k/L9cmKiM4lhUH4pyWXxhdewYjDV7K2RgZHcn9Kuv08xygVAVA1EhEY92
         wV5xXfYkjrEvgKOkLx0ImBgdE3QGOPcF2V+H/dIJwsiPkOy8pSPtINpSFdqKhgf+EPJy
         ryDKP6GnF9j5eNqZphyhHCmsyDdsnb/rXQfu+o78uzvqgC9P5Z5YU3s2nbDqLxtvQQIC
         7oeYQJrKxoaU7j2hJnGiqHilpcN6GyZU6mAJp6sXSUAWEieU/HTRigb6r8yJgx0FfjL2
         2eew==
X-Gm-Message-State: APjAAAXT0eWDd1pAeVnqoqimcj1EG5jLqiRFv4EgWgFU3MW281HRDRGO
        sCoLZOFCNUUOygZAE/wLOJ4=
X-Google-Smtp-Source: APXvYqwvlUtSUTe4mWMiO9Xa7jRCQNlOgdWmPpzoy/99ZZzspDe0qbz5Hgu0l/h2v6CGcDXj6XQlHg==
X-Received: by 2002:a17:902:8b83:: with SMTP id ay3mr2073583plb.1.1553155059577;
        Thu, 21 Mar 2019 00:57:39 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id e184sm6467148pfc.143.2019.03.21.00.57.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 00:57:39 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, joe@perches.com,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 02/18] locking/lockdep: Add description and explanation in lockdep design doc
Date:   Thu, 21 Mar 2019 15:57:09 +0800
Message-Id: <20190321075725.14054-3-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190321075725.14054-1-duyuyang@gmail.com>
References: <20190321075725.14054-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More words are added to lockdep design document regarding key concepts,
which helps people understand the design as well as read the reports.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 Documentation/locking/lockdep-design.txt | 80 ++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 20 deletions(-)

diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.txt
index 49f58a0..1dcceaa 100644
--- a/Documentation/locking/lockdep-design.txt
+++ b/Documentation/locking/lockdep-design.txt
@@ -15,51 +15,91 @@ tens of thousands of) instantiations. For example a lock in the inode
 struct is one class, while each inode has its own instantiation of that
 lock class.
 
-The validator tracks the 'state' of lock-classes, and it tracks
-dependencies between different lock-classes. The validator maintains a
-rolling proof that the state and the dependencies are correct.
-
-Unlike an lock instantiation, the lock-class itself never goes away: when
-a lock-class is used for the first time after bootup it gets registered,
-and all subsequent uses of that lock-class will be attached to this
-lock-class.
+The validator tracks the 'usage state' of lock-classes, and it tracks the
+dependencies between different lock-classes. The dependency can be
+understood as lock order, where L1 -> L2 suggests L1 depends on L2, which
+can also be expressed as a forward dependency (L1 -> L2) or a backward
+dependency (L2 <- L1). From lockdep's perspective, the two locks (L1 and L2)
+are not necessarily related as opposed to in some modules an order must be
+followed. Here it just means that order ever happened. The validator
+maintains a continuing effort to prove that the lock usages and their
+dependencies are correct or the validator will shoot a splat if they are
+potentially incorrect.
+
+Unlike a lock instance, a lock-class itself never goes away: when a
+lock-class's instance is used for the first time after bootup the class gets
+registered, and all (subsequent) instances of that lock-class will be mapped
+to the lock-class.
 
 State
 -----
 
-The validator tracks lock-class usage history into 4 * nSTATEs + 1 separate
-state bits:
+The validator tracks lock-class usage history and divides the usage into
+(4 usages * n STATEs + 1) categories:
 
+Where the 4 usages can be:
 - 'ever held in STATE context'
 - 'ever held as readlock in STATE context'
 - 'ever held with STATE enabled'
 - 'ever held as readlock with STATE enabled'
 
-Where STATE can be either one of (kernel/locking/lockdep_states.h)
- - hardirq
- - softirq
+Where the n STATEs are coded in kernel/locking/lockdep_states.h and as of
+now they include:
+- hardirq
+- softirq
 
+Where the last 1 category is:
 - 'ever used'                                       [ == !unused        ]
 
-When locking rules are violated, these state bits are presented in the
-locking error messages, inside curlies. A contrived example:
+When locking rules are violated, these usage bits are presented in the
+locking error messages, inside curlies, with a total of 2 * n STATEs bits.
+See a contrived example:
 
    modprobe/2287 is trying to acquire lock:
-    (&sio_locks[i].lock){-.-...}, at: [<c02867fd>] mutex_lock+0x21/0x24
+    (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24
 
    but task is already holding lock:
-    (&sio_locks[i].lock){-.-...}, at: [<c02867fd>] mutex_lock+0x21/0x24
+    (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24
 
 
-The bit position indicates STATE, STATE-read, for each of the states listed
-above, and the character displayed in each indicates:
+For a given lock, the bit positions from left to right indicate the usage
+of the lock and readlock (if exists), for each of the n STATEs listed
+above respectively, and the character displayed at each bit position
+indicates:
 
    '.'  acquired while irqs disabled and not in irq context
    '-'  acquired in irq context
    '+'  acquired with irqs enabled
    '?'  acquired in irq context with irqs enabled.
 
-Unused mutexes cannot be part of the cause of an error.
+The bits are illustrated with an example:
+
+    (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24
+                         ||||
+                         ||| \-> softirq disabled and not in softirq context
+                         || \--> acquired in softirq context
+                         | \---> hardirq disabled and not in hardirq context
+                          \----> acquired in hardirq context
+
+
+For a given STATE, whether the lock is ever acquired in that STATE context
+and whether that STATE is enabled yields four possible cases as shown in the
+table below. It is worth noting that the bit character is able to indicate
+which exact case is for the lock as of the reporting time.
+
+   -------------------------------------------
+  |              | irq enabled | irq disabled |
+   -------------------------------------------
+  | ever in irq  |      ?      |       -      |
+   -------------------------------------------
+  | never in irq |      +      |       .      |
+   -------------------------------------------
+
+The character '-' suggests irq is disabled because if otherwise, the
+charactor '?' would have been shown instead. Similar deduction can be
+applied for '+' too.
+
+Unused locks (e.g., mutexes) cannot be part of the cause of an error.
 
 
 Single-lock state rules:
-- 
1.8.3.1

