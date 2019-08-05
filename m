Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413BAC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131402086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWkO6ZVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfHEMPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:15:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45416 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfHEMPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:15:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so5266981wre.12;
        Mon, 05 Aug 2019 05:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RKLUbS1uAUrCGz+7Ruxv1iTrvsfFImFHVzIVSQ1zNmc=;
        b=fWkO6ZVREfN82tGOmzmq2Tpdkxpv4ooHuYLZsxgCpdpA/lQ5zRC7iCReG3q2lGcvAO
         iOQNHzsYSDkGxhLbYnJbqZCMoUPGYOL1ndBAioequuBOTNcShGZsvoxamQ994olvwWcF
         ahsAhMKzN4Kk4b1YWpBF+PR5daiLASJI33q2cCXEoNH8ptuOCkgsB/kM2bsQ+Uu1h62i
         PYujTUkK1wgr7yZY8W87WlabLHTnZenS5r1sBkNJpFxd3XrhxcDNIp6WNDDiE0aXbgxg
         BJQZ+cbAEWoIimNYn/+AbzsJF60HUH0nfiNuErSL8kIVrh2iKteyU8DUJKNH6sBDGV7d
         KDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RKLUbS1uAUrCGz+7Ruxv1iTrvsfFImFHVzIVSQ1zNmc=;
        b=m/YnU19fKJvPul9CUXQ0HPewf0woExCHG3Wge0NoSEllXfQf5+7ZooS+8LJqZneQK9
         Afes1I6+KkSJUewhhJuXnS/9Ghl8D+ivdlTq/HM0EEVQ8J8J4mCKa2RxA3IIjISUv+dX
         H3qn8tTfFn0nLChhYEskmvAVu9T64+E4ahBqWxvTvl7TGSuwwDp2KRFeI81InVnMKpEA
         dHfcnfevvitcmIYOlMaPwbPNlkymssPJI1IdZcp1afbZUb0XtpiyWumNj7vIehAQktg/
         1kwHbfe9jYR7Ln7uFIU+BEzV22Wn+ljOykt9bZLLwFQ7MltnEniVqnksjl+oPQLzgR5r
         A9+A==
X-Gm-Message-State: APjAAAXlb0qP0Vgi6RVYOyCPeT7B8uGIqGFUPES8ksxzoNlXkGLZN/pd
        faSNlBtmsBmKEcXPQlTEz/iCqThgGXEObQ==
X-Google-Smtp-Source: APXvYqysOxKD9/4zKpucfGjMmWAxGwXfsuC6l5ic5olt32fkHiNDEqyCNo7cdXPp1YpNco2y3+ouAw==
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr22105708wrm.55.1565007332469;
        Mon, 05 Aug 2019 05:15:32 -0700 (PDT)
Received: from aparri.mshome.net ([167.220.196.45])
        by smtp.gmail.com with ESMTPSA id b203sm120786397wmd.41.2019.08.05.05.15.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 05:15:31 -0700 (PDT)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: [PATCH] MAINTAINERS: Update e-mail address for Andrea Parri
Date:   Mon,  5 Aug 2019 14:15:17 +0200
Message-Id: <20190805121517.4734-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My @amarulasolutions.com address stopped working this July, so update
to my @gmail.com address where you'll still be able to reach me.

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6426db5198f05..527317026492f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9326,7 +9326,7 @@ F:	drivers/misc/lkdtm/*
 
 LINUX KERNEL MEMORY CONSISTENCY MODEL (LKMM)
 M:	Alan Stern <stern@rowland.harvard.edu>
-M:	Andrea Parri <andrea.parri@amarulasolutions.com>
+M:	Andrea Parri <parri.andrea@gmail.com>
 M:	Will Deacon <will@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Boqun Feng <boqun.feng@gmail.com>
-- 
2.17.1

