Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36247C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040D12173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEG5kSSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfEUMaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 08:30:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45710 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfEUMaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 08:30:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id i21so8511813pgi.12;
        Tue, 21 May 2019 05:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=46JMP9UhSrdZDKfv14LYnvE7EhHvgz/jp/Vs7+Uw0m8=;
        b=oEG5kSSvG9zbJ+3f/czMR7vDwCFNFp4Jnf+u/rK0GxnBoD7ewfa4HXrJHsRa2WCC9i
         jMQoDT0AROlxlwDnoVoAADQJxc7/5ixxwahNsdHb45MV3F7rpG5o1jAsZPW1+ybnJvOA
         PW4EdUn4m7XTRt9x9ApeX49b9mM5ixSdKDpREn6PVjyUpAf5ELhAIEr1s6TRYaXex47D
         +qonYxeGepQ+BTwkT6KCEKG+QymiRozg5s/Og1zxrSBtNTvYVqPRmU4o4INfJmKCCKku
         AONRcPTUbILvRZ5KZC6WQ+Y12xb+JI4j/UH7Pfe11pGOnkRzLcDqwfCmh7ggZDV6SOKQ
         jNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=46JMP9UhSrdZDKfv14LYnvE7EhHvgz/jp/Vs7+Uw0m8=;
        b=K5V5T++o41D14TpA7Bd8ZJ0G6oTtGZtFtOI5lsOamycWiSWvj6ZFAbIuepR/xRdqqd
         9IDgHtYUaGbjGiA0uW/OeKHFt57XpuEXr0WR2Y3J2QMPenmraHX3Mh7nJVJyXfrvAGcy
         fY7zNKdjGmXPsfZfBYk9Yjj8G+xwc66hN6cTtMjXmw1plT+AZSNubdqYECjqvN6JVE4G
         yYYGKMVas7AZVPOVOchCEDh6zWcCmODSTUu4ncvuIDepq3w9n6ygduYGWyn3pL8O5mbi
         1oeATVj1SPh8HDWPJNtuuVyvy9M7LhF/xSjVjL/zdNSAHm5v/ji2uQfFGFtCsEHUrnrH
         UCPw==
X-Gm-Message-State: APjAAAUuYVwbtKpaNGVosbc7RuNRp0zPxYiu8REoV+qDiaXWYBMboNgv
        nFRlTFukGn3taAVDOOqKnRk=
X-Google-Smtp-Source: APXvYqyUwd5x0qltCvnSmFr4ssrTa7CS0wIB+ItsygM5QYhTS8zEzL3qMw0XkkahRASEJT2/o0D4qQ==
X-Received: by 2002:a63:1854:: with SMTP id 20mr79450619pgy.366.1558441807157;
        Tue, 21 May 2019 05:30:07 -0700 (PDT)
Received: from masabert (150-66-66-201m5.mineo.jp. [150.66.66.201])
        by smtp.gmail.com with ESMTPSA id t7sm25540820pfh.156.2019.05.21.05.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 05:30:06 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 557972011A2; Tue, 21 May 2019 21:30:02 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, rdunlap@infradead.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] [linux-next] docs: tracing: Fix typos in histogram.rst
Date:   Tue, 21 May 2019 21:30:00 +0900
Message-Id: <20190521123000.24544-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.22.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some spelling typos in histogram.rst

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 Documentation/trace/histogram.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index fb621a1c2638..8408670d0328 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1010,7 +1010,7 @@ Extended error information
 
   For example, suppose we wanted to take a look at the relative
   weights in terms of skb length for each callpath that leads to a
-  netif_receieve_skb event when downloading a decent-sized file using
+  netif_receive_skb event when downloading a decent-sized file using
   wget.
 
   First we set up an initially paused stacktrace trigger on the
@@ -1843,7 +1843,7 @@ practice, not every handler.action combination is currently supported;
 if a given handler.action combination isn't supported, the hist
 trigger will fail with -EINVAL;
 
-The default 'handler.action' if none is explicity specified is as it
+The default 'handler.action' if none is explicitly specified is as it
 always has been, to simply update the set of values associated with an
 entry.  Some applications, however, may want to perform additional
 actions at that point, such as generate another event, or compare and
@@ -2088,7 +2088,7 @@ The following commonly-used handler.action pairs are available:
     and the saved values corresponding to the max are displayed
     following the rest of the fields.
 
-    If a snaphot was taken, there is also a message indicating that,
+    If a snapshot was taken, there is also a message indicating that,
     along with the value and event that triggered the global maximum:
 
     # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
@@ -2176,7 +2176,7 @@ The following commonly-used handler.action pairs are available:
     hist trigger entry.
 
     Note that in this case the changed value is a global variable
-    associated withe current trace instance.  The key of the specific
+    associated with current trace instance.  The key of the specific
     trace event that caused the value to change and the global value
     itself are displayed, along with a message stating that a snapshot
     has been taken and where to find it.  The user can use the key
@@ -2203,7 +2203,7 @@ The following commonly-used handler.action pairs are available:
     and the saved values corresponding to that value are displayed
     following the rest of the fields.
 
-    If a snaphot was taken, there is also a message indicating that,
+    If a snapshot was taken, there is also a message indicating that,
     along with the value and event that triggered the snapshot::
 
       # cat /sys/kernel/debug/tracing/events/tcp/tcp_probe/hist
-- 
2.22.0.rc1

