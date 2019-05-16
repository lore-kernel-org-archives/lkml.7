Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EE8C04E87
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BD12089E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfEPJmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 05:42:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53935 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfEPJmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 05:42:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id 198so2878079wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 02:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I6Qf9WePQnjM1qP5GnvXQ6iGQgDn7ErWaVxKlruplAs=;
        b=aakeEEMBdRn3zuLuopJRfhSbvE3+fo2f5/w26VGEteexomB6EjhoJ1RustBwrbduFn
         kUJ2NGrESzVxI+DpwrLcIoulX5VQlMAIYGG5e88gEt5Jk/LYY5lIQmm6lF/hkywQ7qmL
         eMLlUfhfFwHwo3B0AdwoRYFC7yYiNlP4Ng+p98qBT2c6HYMOTlNb8MQA/Ss2UGOZrsjp
         QKGWJFyNGmJ4Sxk3ZeHKQdEIu71Bm9iUGJ1ICGwckUhp0LEaWQoyp8rpXkssvLc69a0g
         Ip5dPlmk4ti+X3ZCardFN3R16T/586Bdya0qDoVLzvRzcLf59IVYXerOUKLoRLSfKF82
         qhGA==
X-Gm-Message-State: APjAAAWid0yEX3H2ydKz1fXH9F1a+nO1Wm1B6EEBpmdRoH2jRD92+mY6
        ZGuTt+rvhWgfqeFsoqETcVd1KOmdoWQ+IA==
X-Google-Smtp-Source: APXvYqwocKMkkFgpDNBPx7AOMP66gc9e2eLJvBHtDID7H77ayfvD2k23YyAA2hs51SHVNKxVSScv4w==
X-Received: by 2002:a1c:a695:: with SMTP id p143mr27260709wme.128.1557999764844;
        Thu, 16 May 2019 02:42:44 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t15sm4635388wmt.2.2019.05.16.02.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 02:42:44 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Greg KH <greg@kroah.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: [PATCH RFC 5/5] mm/ksm, proc: add remote madvise documentation
Date:   Thu, 16 May 2019 11:42:34 +0200
Message-Id: <20190516094234.9116-6-oleksandr@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190516094234.9116-1-oleksandr@redhat.com>
References: <20190516094234.9116-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document respective /proc/<pid>/madvise knob.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 Documentation/filesystems/proc.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 66cad5c86171..17106e435bba 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -45,6 +45,7 @@ Table of Contents
   3.9   /proc/<pid>/map_files - Information about memory mapped files
   3.10  /proc/<pid>/timerslack_ns - Task timerslack value
   3.11	/proc/<pid>/patch_state - Livepatch patch operation state
+  3.12  /proc/<pid>/madvise - Remote madvise
 
   4	Configuring procfs
   4.1	Mount options
@@ -1948,6 +1949,18 @@ patched.  If the patch is being enabled, then the task has already been
 patched.  If the patch is being disabled, then the task hasn't been
 unpatched yet.
 
+3.12    /proc/<pid>/madvise - Remote madvise
+--------------------------------------------
+This write-only file allows executing madvise operation for another task.
+
+If CONFIG_KSM is enabled, the following actions are available:
+
+  * marking task's memory as mergeable:
+    # echo merge > /proc/<pid>/madvise
+
+  * unmerging all the task's memory:
+    # echo unmerge > /proc/<pid>/madvise
+
 
 ------------------------------------------------------------------------------
 Configuring procfs
-- 
2.21.0

