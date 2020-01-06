Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D4FC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8D82468D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMNwFlMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgAFUIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:08:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39130 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgAFUIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:08:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id 20so16664690wmj.4;
        Mon, 06 Jan 2020 12:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dDOXvXXB7UzDluxKr8AnFvkjJq1L4DGq2Yh5s/+W6X8=;
        b=jMNwFlMnALeZZ+7eRW+U8dzYhiSTRoLXXVwGFXYAba58drghyxEICAxLI90JB0jaCc
         43Nc6mxMH8y9GIQhvD+PzThdiutSaiU2aru80ovUzjwvfGKXK9sZdaw0yRp7XxdwyQ82
         EoKmahAgCmRk+3jyOTTf8i1oNx4KEPh6bepYVKkqwIF8vpHugOcbFGzyWL+F/Z96P+1U
         1a3Hu2SUSipGzOcopzCcGTcMnt+OqJe1LPUkemltqxLEMZ7Ca+DrHx7PKV9FE751lTAd
         2zpdM+5djI1UDgxGAxaYH6zxmIeI+BMZPkAVE/UfmcK6jS9n4v1QUf6ZRiKEBVqeyjx1
         4izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dDOXvXXB7UzDluxKr8AnFvkjJq1L4DGq2Yh5s/+W6X8=;
        b=RO14YLiN+B//qQxeQHgv/oQNyGVJui92LdAtZl/bOh3J1DX3wJ5TqUNM1799eZZeZS
         KJcYXO9+GrBZ1181WRLHOA1a3S/wwfWt4kGsZR6S7NBlFZXh+fSHi6ZzTGaTp8UD0+Qh
         w68EO5RrM0mQcO2133ZChn1acCBIlug7pIT+hJvyaT7u+ZWC0eN+GjzYnR3cUsypOJd1
         6pZ5VmZq4+k4fPsOublA7rtUOF3uHu0AqZgsRLzXNiZeaCzIw2Ot2SlASiNRAHlenuJk
         VMwvqAzen7JurEb2qINGDmglbPGRiJnwTdFBicQ4ZEK+7WNiYXBjmxZAHKpthY/ozHvr
         hF6w==
X-Gm-Message-State: APjAAAUH8pYtCmM+jB2M0rmWHVEAT9NraYvMCQxg3xQxoUhU7i+q1vOP
        FnZ3Q5MsM1UTXTgRMJfnwQ0winlf
X-Google-Smtp-Source: APXvYqxnxPEf4e1+4Ghr+XwPRYNc2eRS4k+pFtEADUHA4ZGzRfqZFljNE2fuw4cbiXv90m+bN3Z5Fg==
X-Received: by 2002:a7b:cc09:: with SMTP id f9mr36595819wmh.71.1578341310144;
        Mon, 06 Jan 2020 12:08:30 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:74f9:b588:decc:794d])
        by smtp.gmail.com with ESMTPSA id t190sm23836982wmt.44.2020.01.06.12.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:08:29 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, madhuparnabhowmik04@gmail.com, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v3 6/7] doc/RCU/rcu: Use https instead of http if possible
Date:   Mon,  6 Jan 2020 21:08:01 +0100
Message-Id: <20200106200802.26994-7-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106200802.26994-1-sj38.park@gmail.com>
References: <20200106200802.26994-1-sj38.park@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/RCU/rcu.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
index 2a830c51477e..0e03c6ef3147 100644
--- a/Documentation/RCU/rcu.rst
+++ b/Documentation/RCU/rcu.rst
@@ -79,7 +79,7 @@ Frequently Asked Questions
   Of these, one was allowed to lapse by the assignee, and the
   others have been contributed to the Linux kernel under GPL.
   There are now also LGPL implementations of user-level RCU
-  available (http://liburcu.org/).
+  available (https://liburcu.org/).
 
 - I hear that RCU needs work in order to support realtime kernels?
 
-- 
2.17.1

