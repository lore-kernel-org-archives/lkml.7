Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CAEC76186
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 03:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC062081B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 03:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="TQtynCrS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfG1DNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 23:13:10 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45665 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfG1DNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 23:13:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id y8so26197694plr.12
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 20:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FqLsZz2nSjYhrpKM+WzGM9xkHpfQDieQVUOE+LPBLEI=;
        b=TQtynCrSO8zFxyd9WBSrJDd7NsaeQpRvN24ZM12Z2d7iH1shFb7aVxAlLY19nMqC0l
         dy6mso2iQSbsIkUjKA0e7knOEc/T/i3KJ90rkncQSZMEURG/p0l6wTBBTLIQPj35NeRy
         4ViG+jegcBjIRimQLQT6694aCvUDxbDrBf/PA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FqLsZz2nSjYhrpKM+WzGM9xkHpfQDieQVUOE+LPBLEI=;
        b=hAMR+pHTqL/yhGN06L+9TWvHO3EbUp0uTQkkpBpJt3Gr8+UHmnNcjrW8IUeVXnxjeJ
         2jL3jxO4sIxICEo1PBXMrqjfERQ+6ygfl9L+xUhJjb4C6X2ZPojkwyFMkHeodl6sO5tu
         RyKBOxSG4NcHoONGpOXVFoe+tRV9jKSzrHp680VlBDe11vndmEFdhEcdqABHKBxnOWhG
         GuevJochPL+OU+eUulRADUM0Z/TnbQ6N5EaSkgHrIUlzqQ7DNDCwvbvJOq+C2ATp/jWd
         EK73DVUgWwGhP/maAOr8f5KFsLa9FpD03DMYkk0LjiJvRF6UpN5CmrCC0bJWtZNkNqxX
         vspQ==
X-Gm-Message-State: APjAAAVfQ5IFEgJIU1XvuErTcmzP06k94cZjg2CSpi/iw+CLlL1+l33P
        2gYYQuTEJZBcEG2X3jWQRkVyBqdu
X-Google-Smtp-Source: APXvYqzwDI9I9PeC8h95jHNksqEQG9WOIA03p9LLLVQYtZmq6YSewHUcA+rk5MKkl8CvZePu5/dGPQ==
X-Received: by 2002:a17:902:2869:: with SMTP id e96mr99972617plb.203.1564283588784;
        Sat, 27 Jul 2019 20:13:08 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z12sm38727125pfn.29.2019.07.27.20.13.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 20:13:07 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        kernel-team@android.com, Boqun Feng <boqun.feng@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2] lkmm/docs: Correct ->prop example with additional rfe link
Date:   Sat, 27 Jul 2019 23:13:03 -0400
Message-Id: <20190728031303.164545-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lkmm example about ->prop relation should describe an additional rfe
link between P1's store to y and P2's load of y, which should be
critical to establishing the ordering resulting in the ->prop ordering
on P0. IOW, there are 2 rfe links, not one.

Correct these in the docs to make the ->prop ordering on P0 more clear.

Cc: kernel-team@android.com
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../memory-model/Documentation/explanation.txt  | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 68caa9a976d0..aa84fce854cc 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -1302,8 +1302,8 @@ followed by an arbitrary number of cumul-fence links, ending with an
 rfe link.  You can concoct more exotic examples, containing more than
 one fence, although this quickly leads to diminishing returns in terms
 of complexity.  For instance, here's an example containing a coe link
-followed by two fences and an rfe link, utilizing the fact that
-release fences are A-cumulative:
+followed by a fence, an rfe link, another fence and and a final rfe link,
+utilizing the fact that release fences are A-cumulative:
 
 	int x, y, z;
 
@@ -1334,11 +1334,14 @@ If x = 2, r0 = 1, and r2 = 1 after this code runs then there is a prop
 link from P0's store to its load.  This is because P0's store gets
 overwritten by P1's store since x = 2 at the end (a coe link), the
 smp_wmb() ensures that P1's store to x propagates to P2 before the
-store to y does (the first fence), the store to y propagates to P2
-before P2's load and store execute, P2's smp_store_release()
-guarantees that the stores to x and y both propagate to P0 before the
-store to z does (the second fence), and P0's load executes after the
-store to z has propagated to P0 (an rfe link).
+store to y does (the first fence), P2's store to y happens before P2's
+load of y (rfe link), P2's smp_store_release() ensures that P2's load
+of y executes before P2's store to z (second fence), which implies that
+that stores to x and y propagate to P2 before the smp_store_release(), which
+means that P2's smp_store_release() will propagate stores to x and y to all
+CPUs before the store to z propagates (A-cumulative property of this fence).
+Finally P0's load of z executes after P2's store to z has propagated to
+P0 (rfe link).
 
 In summary, the fact that the hb relation links memory access events
 in the order they execute means that it must not have cycles.  This
-- 
2.22.0.709.g102302147b-goog

