Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF25C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3346220838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="GVLIcWJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbfHASar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:30:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41156 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHASar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:30:47 -0400
Received: by mail-qt1-f195.google.com with SMTP id d17so71153664qtj.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 11:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=BrDv6APd0h3KKvHtt3FYKhGAppJikXhHxXPF+0kU7LA=;
        b=GVLIcWJG4pk+OPkIVwfx3j8MTPjtxN13IsNRR4Or8UVZsgqKu022eMxw5PhrIzNImF
         PBby+icwtwUyrM8K9wcd71jfEZR5fQ/MiYQFk9GjZH5HOxlCsOVS2A4kL1qzHVyXbbN8
         MC5/+qiYfxl2wcyhaN+3Y+3mhLQTuNlYnnWo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=BrDv6APd0h3KKvHtt3FYKhGAppJikXhHxXPF+0kU7LA=;
        b=qJAZCYO9pIOunIi+EUve0mCBkaFAgicFHB1lPj1A7BYPtR8Z0djmDf6ztKJeIw1TBV
         BrhlXBxjz8eHKmzT49werpYXF4KMKTYOau+wW/yGv6wIiMCzSrLIaiG5Mun0P2sm9zVb
         LeamRSZiGnohq2EgIghKTRAOk36ggYa1lvYpZlvkh3kbMu1AlGl6z7ydINLlnXtjxecy
         QJ56gIiBc/7RqZ81rBWGy2UDV/J1Rx7mYcICwzXhW7Y+5KL6+jNkb0vLy07+JFjvkE0c
         XevaPX2mvjszpbALtbRtQB5ejCCzvA1TcOLS9l25YReqkZzYvQDkjq5L83GLH3rg2cLW
         q74A==
X-Gm-Message-State: APjAAAWygazba0ZFwjWMFTyrBkGnyWnVhirJHhkCPIHQZ5vuTN/L1cm/
        wEC3yPTsRr0sqQQYgMlzlNcH+IkpQT8=
X-Google-Smtp-Source: APXvYqz/XyQ69qOmFgAiuZ+EqFSSUyqUobzsuNxglKK0HRdp/68vyweANAdQD8i/tzYJJdQa3oAWjg==
X-Received: by 2002:ac8:3794:: with SMTP id d20mr91528243qtc.392.1564684245935;
        Thu, 01 Aug 2019 11:30:45 -0700 (PDT)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id 18sm32650473qkh.77.2019.08.01.11.30.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 11:30:44 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 1 Aug 2019 14:30:43 -0400 (EDT)
X-X-Sender: vince@macbook-air
To:     linux-kernel@vger.kernel.org
cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Chong Jiang <chongjiang@chromium.org>,
        Simon Que <sque@chromium.org>
Subject: [patch] perf.data documentation clarify HEADER_SAMPLE_TOPOLOGY
 format
Message-ID: <alpine.DEB.2.21.1908011425240.14303@macbook-air>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The perf.data file format documentation for HEADER_SAMPLE_TOPOLOGY 
specifies the layout in a confusing manner that doesn't match the rest of 
the document.  This patch attempts to describe things consistent with the 
rest of the file.

Signed-off-by: Vince Weaver <vincent.weaver@maine.edu>

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 5f54feb19977..6a7dceaae709 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -298,16 +298,21 @@ Physical memory map and its node assignments.
 
 The format of data in MEM_TOPOLOGY is as follows:
 
-   0 - version          | for future changes
-   8 - block_size_bytes | /sys/devices/system/memory/block_size_bytes
-  16 - count            | number of nodes
-
-For each node we store map of physical indexes:
-
-  32 - node id          | node index
-  40 - size             | size of bitmap
-  48 - bitmap           | bitmap of memory indexes that belongs to node
-                        | /sys/devices/system/node/node<NODE>/memory<INDEX>
+	u64 version;            // Currently 1
+	u64 block_size_bytes;   // /sys/devices/system/memory/block_size_bytes
+	u64 count;              // number of nodes
+
+struct memory_node {
+        u64 node_id;            // node index
+        u64 size;               // size of bitmap
+        struct bitmap {
+		/* size of bitmap again */
+                u64 bitmapsize; 
+		/* bitmap of memory indexes that belongs to node     */
+		/* /sys/devices/system/node/node<NODE>/memory<INDEX> */
+                u64 entries[(bitmapsize/64)+1];
+        }
+}[count];
 
 The MEM_TOPOLOGY can be displayed with following command:
 
