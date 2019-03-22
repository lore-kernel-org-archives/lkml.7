Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754D4C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C07218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="iyQnjGnG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfCVPFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:05:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55241 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCVPFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:05:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id f3so2505755wmj.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 08:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=la79GVMa47gWOb0qD5kRoQk6VC6UfGHw4stP89HbwZw=;
        b=iyQnjGnG51BIfxJIICh18JKJdtzPSrWThifwALw2gWvK1/gNZEsTAKEvxsc3wzKXqK
         tQ08PhWRYD6ROgWHR8CED2SyxdwNUvt1+EpYx+TraC3D3f4BUhopjef2d0iHHuR+fvRW
         OK+Dxeh5EfJv5kyTXhWF0/qOB6NJxdNwXhYr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=la79GVMa47gWOb0qD5kRoQk6VC6UfGHw4stP89HbwZw=;
        b=A4y+Bs0USYTXOzIAHvvBGGyIp/hTVdTR7+DyFOnAVLXRL7LUIbBRpGZW997CBW+U34
         2tdCecGnH9jWXL6Ic4lrteYuQlOzINpufC/ljniD8HJGYGrlQu+zcNh/1MxSJfNZKrJr
         HlSQuLVcOpQSfgNL72d76J9zfjxFrTosfT7SoFmyqrMIo1+QvpqHzo3MFrAUunkV733f
         UgadmNLBl7MdKqIjZMvinZ5YFSoEV/8IF6du56U+k/6+MC6u0yS+gkLumnRyDQkKsj01
         RxFXowkWPaUyAbdOPPJsFuW7H4ptwYzqHz8mfqS43FaCwLtBOr1Zi6bjjlfB6gaurRUn
         VAKA==
X-Gm-Message-State: APjAAAU+HQNvB+LqeOir2Mp1UhZZvFxTJxk7pbEyy4RnZLcJdw088UYw
        QFQphdn5kfB/bYekWZ8m/cImeQ==
X-Google-Smtp-Source: APXvYqxcd9chc48Z5gs026zGSni+ohQ1klMDVbYgMSEarwtJFSVYwpEsS7QdBncOnajxC7rDh/Irvg==
X-Received: by 2002:a1c:4641:: with SMTP id t62mr3569438wma.53.1553267115327;
        Fri, 22 Mar 2019 08:05:15 -0700 (PDT)
Received: from localhost ([2620:10d:c092:200::1:a21b])
        by smtp.gmail.com with ESMTPSA id y125sm4365149wmc.39.2019.03.22.08.05.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 08:05:14 -0700 (PDT)
Date:   Fri, 22 Mar 2019 15:05:13 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: [PATCH] fixup: vmscan: Fix build on !CONFIG_MEMCG from nr_deactivate
 changes
Message-ID: <20190322150513.GA22021@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <155290128498.31489.18250485448913338607.stgit@localhost.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"mm: move nr_deactivate accounting to shrink_active_list()" uses the
non-irqsaved version of count_memcg_events (__count_memcg_events), but
we've only exported the irqsaving version of it to userspace, so the
build breaks:

    mm/vmscan.c: In function ‘shrink_active_list’:
    mm/vmscan.c:2101:2: error: implicit declaration of function ‘__count_memcg_events’; did you mean ‘count_memcg_events’? [-Werror=implicit-function-declaration]

This fixup makes it build with !CONFIG_MEMCG.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: kernel-team@fb.com
---
 include/linux/memcontrol.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 534267947664..b226c4bafc93 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1147,6 +1147,12 @@ static inline void count_memcg_events(struct mem_cgroup *memcg,
 {
 }
 
+static inline void __count_memcg_events(struct mem_cgroup *memcg,
+					enum vm_event_item idx,
+					unsigned long count)
+{
+}
+
 static inline void count_memcg_page_event(struct page *page,
 					  int idx)
 {
-- 
2.21.0

