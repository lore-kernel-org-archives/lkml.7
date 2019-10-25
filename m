Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27511CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29832070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571988392;
	bh=Wd6PWuzTZOB9cAk62y9NmmJ/1tAkhe18AQu6gJ6kduk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b5UMHi9RPZdiwImBKIz5LT6KXSH1DK6LsrAdNHTaBOMwIlsaOSLcmmy/VH6j/X2qs
	 +tQjnPoxn4ZMCRLzeN9uHx7RPLnGGBGWpCbDZRBNeRm/lvUSni/XtFch90Wnya8O8F
	 TlGCBZlPw8IRAOHxVqjKkSRPS+50HxFu/iWRyYKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436530AbfJYH0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:26:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51872 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390344AbfJYH03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:26:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id q70so905004wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 00:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7W6FbSGYxJZDumQvlMVc5ne/04KsfBxl9tYdZk3V7Nw=;
        b=hGvr9l+EvhDGN/rVvvdidlQz/72wNUBqQYFXypsjNgBJUoqYuIvkIjT5gPyrRXvUCq
         OtedoZLcg6at3u0ZfUOVFNFR4zwsRXfLZPvV7HKQEfDuVuFIg24FEOaIMNaTMYerS6rq
         Ef7XadHSsLFheu09KVDsg/KjP1mNNH5dgIfIYDvO95DY+f2NpCc28Ki3zsHiimymSF/O
         JIqmgyQAK6zxvVTzxftB1Uhe3UJoWJLjR4Gki3DPMQYRGzQSi6yYZM4KsXIwl8arg8fK
         xq3hOGlGMC2+OSXcUc4UczXNhlX552j3FK0m37jefYwvuie6HrO63OW0EauXEY6akzGM
         DSmA==
X-Gm-Message-State: APjAAAXZEaT5qMpJmTAEMxxh2uZpGZDyh0fEfIIkcr6zDGdDur8NLUV1
        evCVPerLTE6XHbj2eNoZeeU=
X-Google-Smtp-Source: APXvYqzlrOJMqwfNEekFRcsxH77kBxe3u0ROf9E7iGhcUHQQHJ0GCyAXn5S6NSbQ6DgpH57CuJdohQ==
X-Received: by 2002:a05:600c:2293:: with SMTP id 19mr2010511wmf.9.1571988387773;
        Fri, 25 Oct 2019 00:26:27 -0700 (PDT)
Received: from tiehlicka.microfocus.com (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id x21sm1482446wmj.42.2019.10.25.00.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 00:26:27 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
Subject: [PATCH 1/2] mm, vmstat: hide /proc/pagetypeinfo from normal users
Date:   Fri, 25 Oct 2019 09:26:09 +0200
Message-Id: <20191025072610.18526-2-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025072610.18526-1-mhocko@kernel.org>
References: <20191025072610.18526-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

/proc/pagetypeinfo is a debugging tool to examine internal page
allocator state wrt to fragmentation. It is not very useful for
any other use so normal users really do not need to read this file.

Waiman Long has noticed that reading this file can have negative side
effects because zone->lock is necessary for gathering data and that
a) interferes with the page allocator and its users and b) can lead to
hard lockups on large machines which have very long free_list.

Reduce both issues by simply not exporting the file to regular users.

Reported-by: Waiman Long <longman@redhat.com>
Cc: stable
Fixes: 467c996c1e19 ("Print out statistics in relation to fragmentation avoidance to /proc/pagetypeinfo")
Acked-by: Mel Gorman <mgorman@suse.de>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Waiman Long <longman@redhat.com>
Acked-by: Rafael Aquini <aquini@redhat.com>
Acked-by: David Rientjes <rientjes@google.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/vmstat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 6afc892a148a..4e885ecd44d1 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1972,7 +1972,7 @@ void __init init_mm_internals(void)
 #endif
 #ifdef CONFIG_PROC_FS
 	proc_create_seq("buddyinfo", 0444, NULL, &fragmentation_op);
-	proc_create_seq("pagetypeinfo", 0444, NULL, &pagetypeinfo_op);
+	proc_create_seq("pagetypeinfo", 0400, NULL, &pagetypeinfo_op);
 	proc_create_seq("vmstat", 0444, NULL, &vmstat_op);
 	proc_create_seq("zoneinfo", 0444, NULL, &zoneinfo_op);
 #endif
-- 
2.20.1

