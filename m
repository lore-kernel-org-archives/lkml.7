Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ECFC46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30B7217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfEJHVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 03:21:39 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38396 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfEJHVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 03:21:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id d13so5490941qth.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 00:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UYXKxPKXPsTybNC4JZhfndIieIgXto0Au/T3tY/gXyg=;
        b=b5JC0PWQc315JQIebyaYIge7943FrHWTO4KAjD2MVnwxyZXZ/I6kVypGltpScnd9a5
         wCvZbBKODpr9F1GKq+KX9rr0Wf8afzJRK/BiSP+oyT7yHRIFSi5HFvHy+grT+MhMWfw3
         GfmJHbF8LNCCq633TNDuRvk9hHEu/lABlrPgNDvLyJBDHKNQyD1lxysKf8k7RxeIpLfM
         kwjruoojRe2mtwcEWjdX1AiNvdfWCRXFtwm5lI7eMcJ9N3AdWMc3IC+divu+lNVNnM6M
         bduPG25HuKy2bAox1oNc7j2LAIx8HWfAeZtZAqznysHH/uksUkju7aoOmirGeFY8/jzT
         JD3g==
X-Gm-Message-State: APjAAAUWX8kYZWFpWB3HIKlhaO2xZhteWGEyHTCT2xZExFKLffatcXAz
        BC383n16vTJ5oM9FAA0ZLbEGh6oQu5U4TQ==
X-Google-Smtp-Source: APXvYqxw5WeE0e1Tl0rCWVbYdCmPx9jVnpRz2LqMlAgWX6iwo8mnCouCMFYdDyqwFsbfVQdq2npsFA==
X-Received: by 2002:a0c:b907:: with SMTP id u7mr7761329qvf.189.1557472896947;
        Fri, 10 May 2019 00:21:36 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b19sm2308808qkk.51.2019.05.10.00.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 00:21:36 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>, linux-mm@kvack.org
Subject: [PATCH RFC 4/4] mm/ksm: add automerging documentation
Date:   Fri, 10 May 2019 09:21:25 +0200
Message-Id: <20190510072125.18059-5-oleksandr@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190510072125.18059-1-oleksandr@redhat.com>
References: <20190510072125.18059-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document KSM "always" mode kernel cmdline option as well as
corresponding sysfs knob.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 Documentation/admin-guide/mm/ksm.rst            | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2b8ee90bb644..510766a3fa05 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2008,6 +2008,13 @@
 			0: force disabled
 			1: force enabled
 
+	ksm_mode=
+			[KNL]
+			Format: [madvise|always]
+			Default: madvise
+			Can be used to control the default behavior of the system
+			with respect to merging anonymous memory.
+
 	kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
 			Default is 0 (don't ignore, but inject #GP)
 
diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
index 9303786632d1..9af730640da7 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -78,6 +78,13 @@ KSM daemon sysfs interface
 The KSM daemon is controlled by sysfs files in ``/sys/kernel/mm/ksm/``,
 readable by all but writable only by root:
 
+mode
+        * set madvise to deduplicate only madvised memory
+        * set always to allow deduplicating all the anonymous memory
+          (applies to newly allocated memory only)
+
+        Default: madvise (maintains old behaviour)
+
 pages_to_scan
         how many pages to scan before ksmd goes to sleep
         e.g. ``echo 100 > /sys/kernel/mm/ksm/pages_to_scan``.
-- 
2.21.0

