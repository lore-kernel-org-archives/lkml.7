Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B855AC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEA12054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="KzkI7bYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387899AbfG2MgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 08:36:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32880 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbfG2MgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 08:36:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so27981487pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 05:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TSzV7RC0yVMqLiuA9qX0NlSf34xDJD+fWOSh5tvbLJM=;
        b=KzkI7bYi9uaBjj+hagxShH/J9WGeYAAicHOHaZx2+ybUxAfQbLY4B1F49h66Fj9eiy
         5wTxkGxKfBGj2AdJWYTtZc5Z3qBbVFc3wTTrsSufQ6y4KX5LmvnDMis3oatVIishAYpo
         w5WBR2nE9S8W6m771/uw4SRnXlG3pZ4qeTSqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TSzV7RC0yVMqLiuA9qX0NlSf34xDJD+fWOSh5tvbLJM=;
        b=rV8UgtyUvw6OlL1S0W3ioW53qwNHwnDHhBKS7ZbdrSXX7LAuORI2kFcX3zgVeyhSdh
         uddQQh655BmXKDBLJj2+3VATrH2leVhT1xMxhWyh8WJp4Qo5unshpW+IDB43p/a5phGK
         l75GR5zNIkwJJuYlCwzKgGnXum9p/SXkAdJdOTo9X1IntLe+xdrELlKtCVzOt2jGgDRq
         xvUfSrGA3II2Df0Lxghdfu+TXV5zZl+c9TN202qvHI5eVRrLDbTyqMzvVI5RXWo7XvAW
         2gvzt3yVfuD68LA0L/sAwiPsZT0Gc2ifoBObRGHfe/Pi7Z+/zyFTotBJ4god2XhB4TVr
         jHZQ==
X-Gm-Message-State: APjAAAWvUDdu0BCf9uzDEocYzlQ7B+VIdid7ji4s+no7XNMlepg8xg5H
        99zy6aW6UJboSBZmpHgwd6XVRahb
X-Google-Smtp-Source: APXvYqwrluq6n6ipVhMOqpsRgfnzyV9l1pZ68HYGe0lLVMzOGWl8WDb5T8Z0DRVYOYGYVh2pNcUe0w==
X-Received: by 2002:a63:66c5:: with SMTP id a188mr103667702pgc.127.1564403774374;
        Mon, 29 Jul 2019 05:36:14 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q8sm121732096pjq.20.2019.07.29.05.36.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 05:36:13 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH] Use term cumul-fence instead of fence in ->prop ordering example
Date:   Mon, 29 Jul 2019 08:36:05 -0400
Message-Id: <20190729123605.150423-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To reduce ambiguity in the more exotic ->prop ordering example, let us
use the term cumul-fence instead fence for the 2 fences, so that the
implict ->rfe on loads/stores to Y are covered by the description.

Link: https://lore.kernel.org/lkml/20190729121745.GA140682@google.com

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/memory-model/Documentation/explanation.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 68caa9a976d0..634dc6db26c4 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -1302,7 +1302,7 @@ followed by an arbitrary number of cumul-fence links, ending with an
 rfe link.  You can concoct more exotic examples, containing more than
 one fence, although this quickly leads to diminishing returns in terms
 of complexity.  For instance, here's an example containing a coe link
-followed by two fences and an rfe link, utilizing the fact that
+followed by two cumul-fences and an rfe link, utilizing the fact that
 release fences are A-cumulative:
 
 	int x, y, z;
@@ -1334,10 +1334,10 @@ If x = 2, r0 = 1, and r2 = 1 after this code runs then there is a prop
 link from P0's store to its load.  This is because P0's store gets
 overwritten by P1's store since x = 2 at the end (a coe link), the
 smp_wmb() ensures that P1's store to x propagates to P2 before the
-store to y does (the first fence), the store to y propagates to P2
+store to y does (the first cumul-fence), the store to y propagates to P2
 before P2's load and store execute, P2's smp_store_release()
 guarantees that the stores to x and y both propagate to P0 before the
-store to z does (the second fence), and P0's load executes after the
+store to z does (the second cumul-fence), and P0's load executes after the
 store to z has propagated to P0 (an rfe link).
 
 In summary, the fact that the hb relation links memory access events
-- 
2.22.0.709.g102302147b-goog

