Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97099C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 20:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6926F2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 20:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxT+BZVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbfIKU0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 16:26:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46351 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729186AbfIKU0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 16:26:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so14397614pfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 13:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/UAVegAIhAQSbSpxp8ObJcBzX5BUzT4wfrwqu1iDBBk=;
        b=oxT+BZVm4Jpx0PjvWILzqeEtF1mbhyvkXEf3lhC2bCY8sRmbVDBWqBU7lOF+CiJD01
         XVmySZONj7sivHkdA43Lt/12LXmiNZ9jYQ/QU3+fW1taqFRn7GprRwN1uoRH936ePocu
         WHGvYzzO1YnlKR29pnFLUrmVAvxDwakA1dxUktqhznHs8J3H3Y6rqfgA/yhyQjeTNhtA
         AWmMCDZ5JK74g1+UFJ/kO3AgwJeB+qqM6xcuNrlNvSipgTvK/KQpv7FxGZ6re/HtaL9t
         bucpnOOAs+aojx8Q2A8JrIq3anfFZIfkEy00QrRNUNqLHP0A/TjjF2bVJfA4o4Kjen3U
         R4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/UAVegAIhAQSbSpxp8ObJcBzX5BUzT4wfrwqu1iDBBk=;
        b=Xvkbs4adUJSqXNt9jspG8A9JmIWysOX465U57y0DRBc8Fl6hbW+ypkRwkILOmBrtRO
         M4nDhOo1N7+hwC/LIDEhicBsFupoWee3r0L99CdgixJK9P8zxWx2UTe5vGRv6CxHfDob
         8T0XETiG5ypageOZkRksFksbQkbBLSukOxJnivX1iIRrrIoUTQZTDJjEwS097gdA8ntq
         msqWk5qQx1LpiUuE78JuIz84MBBLMLEGtr+8+TzdWYzOyOOEh3ga4Pm5MnkDFd3EQwdL
         S42sTiy8NA6FjaRfQnvt0mTm9XWz6cF3NjXkmFyC1/CLE1yqUi763UYdwLxnj1gIQFCf
         0CmQ==
X-Gm-Message-State: APjAAAXbOD8ygZofPA9bkDs7vWStb6/Tj3HeoQb9pHKF3SPMRyrBhxEc
        BMY3ECSRh9woz56JFvVV974=
X-Google-Smtp-Source: APXvYqyOwlwOHp7+hXZnTE3WUluW+R15WCGJp4Eo+ix7mwC6XAvc6HKFCgQoHJqj98v4wfUkNiLpvA==
X-Received: by 2002:a62:d45a:: with SMTP id u26mr42945149pfl.137.1568233603357;
        Wed, 11 Sep 2019 13:26:43 -0700 (PDT)
Received: from localhost.localdomain ([1.39.178.185])
        by smtp.gmail.com with ESMTPSA id e10sm33196577pfh.77.2019.09.11.13.26.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Sep 2019 13:26:42 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, osalvador@suse.de, mhocko@suse.com,
        david@redhat.com, pasha.tatashin@soleen.com,
        dan.j.williams@intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] mm/memory_hotplug.c: s/is/if
Date:   Thu, 12 Sep 2019 02:02:34 +0530
Message-Id: <1568233954-3913-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corrected typo in documentation.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index dc0118f..5a404d3 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1795,7 +1795,7 @@ void __remove_memory(int nid, u64 start, u64 size)
 {
 
 	/*
-	 * trigger BUG() is some memory is not offlined prior to calling this
+	 * trigger BUG() if some memory is not offlined prior to calling this
 	 * function
 	 */
 	if (try_remove_memory(nid, start, size))
-- 
1.9.1

