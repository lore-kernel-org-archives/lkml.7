Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF38C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 21:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C5420863
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 21:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBdTX9+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfEZVW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 17:22:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46021 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfEZVWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 17:22:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id r76so2156773lja.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 14:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fnFIhfm6w+x6vlcZglDCubHYA2sqJDEBTXH+zDoT54E=;
        b=UBdTX9+e4FvlHF4JFOYIDGquBW1PRTf6/hoP7Ew9uurKyudFzrNtQsPK+PpY2kJbcz
         RrbaPQyrg87qkICEVv2tBAVhjYD+SMpSdxNurR6cJfHLCn1BtGBQfSdPP9AkBjsdJAfg
         aLzuFtmSM/Yp6QTaZ94jvl3W56Eqf8+1cBNozcS581wGb4CnsbDB+ce8MuQkYEWOHghV
         2WNVzQwZavCHCwYE9pLaKNRczb/qIwTAeNH1O3VcpMY3WFa+yJHRgnyaecSjfbSODT0E
         gmJH9eFilpIPj/xNffX9FYFqVn5/b4fsxxF6OCytbaResF1Q+VfdYOqoeb1a+V4haXP8
         IGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fnFIhfm6w+x6vlcZglDCubHYA2sqJDEBTXH+zDoT54E=;
        b=ZOlHQGWlro+trQQRu9SLQXZOXc1/v/2edfyXKp+mLJ5pcu8/m7/0nM9GTkLp8bkj+U
         XWqZzdL5qar0vE1bqNsBNnTV7sLCkPFaviFoKR6SEnQHKQJztoyFZSTXl2QZWRLT9QOX
         X8C+8mHQE9Kd5LV6K7oVXeLOr2pP+7Reh8/IKxQtPaBX82lnOBFcST2or6u0j9bRQJ8Q
         zDBWHkBV1QxUdVgPkNZYA02IYrTJ1pZxg1qjolSjsV3bAvaggYXkESILkHbTRWkh4+cA
         ZRH2A/qmu2ApYc6p1pMJj+pXVP8o/1BSdF+VnzcKFCRW2z+8lr3mU265CjCGn97dRAMU
         ngHg==
X-Gm-Message-State: APjAAAWmHgHU/yPpoMwGPeyXM5I4VytT54r7u+cPlbGHUkpaFo5cOhin
        ZjOYdpnozqfR+SYQqli3DGjS+7of6ps=
X-Google-Smtp-Source: APXvYqxKcunfWrPxCigO2o6ZR9K3hxrEk96bNlekmsQEeZIMZuGoXyAQXyF5tttat3bj0KboCwbv8g==
X-Received: by 2002:a2e:249:: with SMTP id 70mr56398543ljc.178.1558905743514;
        Sun, 26 May 2019 14:22:23 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id y4sm1885105lje.24.2019.05.26.14.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 14:22:22 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Roman Gushchin <guro@fb.com>, Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 1/4] mm/vmap: remove "node" argument
Date:   Sun, 26 May 2019 23:22:10 +0200
Message-Id: <20190526212213.5944-2-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190526212213.5944-1-urezki@gmail.com>
References: <20190526212213.5944-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused argument from the __alloc_vmap_area() function.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index c42872ed82ac..ea1b65fac599 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -985,7 +985,7 @@ adjust_va_to_fit_type(struct vmap_area *va,
  */
 static __always_inline unsigned long
 __alloc_vmap_area(unsigned long size, unsigned long align,
-	unsigned long vstart, unsigned long vend, int node)
+	unsigned long vstart, unsigned long vend)
 {
 	unsigned long nva_start_addr;
 	struct vmap_area *va;
@@ -1062,7 +1062,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	 * If an allocation fails, the "vend" address is
 	 * returned. Therefore trigger the overflow path.
 	 */
-	addr = __alloc_vmap_area(size, align, vstart, vend, node);
+	addr = __alloc_vmap_area(size, align, vstart, vend);
 	if (unlikely(addr == vend))
 		goto overflow;
 
-- 
2.11.0

