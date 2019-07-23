Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA4DC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E175218D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="Q5a8LDnL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391842AbfGWUme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:42:34 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:43110 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfGWUme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:42:34 -0400
Received: by mail-qk1-f182.google.com with SMTP id m14so6445941qka.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 13:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=HSqeERIVrrWNRJGBPRu/DavE1UKkc6TVYy1oqy1qzFk=;
        b=Q5a8LDnLnxwPPp1uXvPjDmqYEATc1C0TF9Bnd9Qtmm/8/RjCNFVbH1WlKCtMhq9n5+
         1HdHN0OakFy5sKHnxj1HbG+Ut+ztkWKC0wFIO3XP9Imfckix3FbpHfKTY2sAMAfj1LJz
         fHGV6NWaSINJSyq4sJ28QRsi9rW/yltdVDkLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=HSqeERIVrrWNRJGBPRu/DavE1UKkc6TVYy1oqy1qzFk=;
        b=X9JTw53xYvZCpnkB0l1xUUQmzgD1yuhrVmMcbJnLUmESzJtIG2+5WNFWKX/ogcSSNA
         GuV2asev/EJbRjiK/1IeVXqZmX0OTub9GfyzxL62Yy5TyZNuaMqj/43rvfV6csp6URTj
         mMN34zwRHYjwC6ICpSZNxRwP+S054OP/YL/X/usD3bSXLZx9oLV/OFj/+okw8oMhptXv
         xXEwehH4Gx3xxFIaycdhoJ5VtrVfJKTfRN1JExFjE5lYfboP23pId0EPeofMjXgRTzaA
         Q2OzOZW28iu0koNYtdNuTnG75ZZC+Aws0uAOVTxa5UygFwvtn4wbw9QFITjFub1dYGGD
         xXpw==
X-Gm-Message-State: APjAAAWQWwm/Gs6ZKCCiVZBgatVOluzrOXD+ey2y5tuwbIs2VrxYsKlX
        SWtLDWQ6c1vGTcQf1xnS1tqmcUbFMKY=
X-Google-Smtp-Source: APXvYqzxJKpsuazAcglZO3ZdUKSXcLg2wj1Rt5vvrtCzbn/5MwA8/ZAgqKRXdcMv2+DknxpFIJJu5w==
X-Received: by 2002:a05:620a:142e:: with SMTP id k14mr51238951qkj.336.1563914552595;
        Tue, 23 Jul 2019 13:42:32 -0700 (PDT)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id f25sm23360508qta.81.2019.07.23.13.42.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 13:42:31 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Tue, 23 Jul 2019 16:42:30 -0400 (EDT)
X-X-Sender: vince@macbook-air
To:     linux-kernel@vger.kernel.org
cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [patch] perf tool buffer overflow in perf_header__read_build_ids
In-Reply-To: <alpine.DEB.2.21.1907231100440.14532@macbook-air>
Message-ID: <alpine.DEB.2.21.1907231639120.14532@macbook-air>
References: <alpine.DEB.2.21.1907231100440.14532@macbook-air>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

my perf_tool_fuzzer has found another issue, this one a buffer overflow
in perf_header__read_build_ids.  The build id filename is read in with a 
filename length read from the perf.data file, but this can be longer than
PATH_MAX which will smash the stack.

This might not be the right fix, not sure if filename should be NUL
terminated or not.

Signed-off-by: Vince Weaver <vincent.weaver@maine.edu>

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index c24db7f4909c..9a893a26e678 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2001,6 +2001,9 @@ static int perf_header__read_build_ids(struct perf_header *header,
 			perf_event_header__bswap(&bev.header);
 
 		len = bev.header.size - sizeof(bev);
+
+		if (len>PATH_MAX) len=PATH_MAX;
+
 		if (readn(input, filename, len) != len)
 			goto out;
 		/*
