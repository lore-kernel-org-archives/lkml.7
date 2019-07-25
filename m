Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F9CC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4385721734
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="S7vms56M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfGYS1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:27:19 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39437 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfGYS1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:27:18 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9so50017767qtu.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 11:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=P4CCz8h/sb1Hg6P4gplDK79Mjvk5eov5xfIeAMWHuFQ=;
        b=S7vms56Mu5rVxjLWZHlGqJbYmTrcanBA6gTq5t303UihJXmVRdeMG9lSFgeTTZW3vH
         ZL29capltikE6wSzZNVdjdzvXG1e1bKEVaCnfDpZ08r73K2f9/Q4VrRVNFmtmF/UYf+v
         PpbMpqK+gFgPPfrsEKil7XumdcrP8VKWAy4nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=P4CCz8h/sb1Hg6P4gplDK79Mjvk5eov5xfIeAMWHuFQ=;
        b=rzQRdITwCdsUckv1lQ6oniXSMnd7sygWWbo20q6+/11XKbEp2kS7KAk18IJGqx8+n7
         J77+2dZA1cRejtNEwhKfcFvKX82+WE/c5LvsHDM7yGrMHL9FQjHwZ+XTVvZf70YHy6vE
         qO0zGAb6f1BENl2bvT7sMPNt0K3QCVdnDN7rp0oYkUoIuV7tWjIDpsQPteJSSiy4Kr3t
         oUw/saL86c9scEEI0KL0EldJnvA3jb6Unn0+W/Sc55UBpT7wYorqdmBQbS23VaaLYc1q
         6wK8IYKcZu9DqWLbvOzSx24uBdqrEbu4DnFclXXcaHjF31HEYLkwPen/PxfmtAgaGJ//
         MflQ==
X-Gm-Message-State: APjAAAUTW7+sl43q9i7OLP4BLYurPdPsV7Y7fd8W4PF2hZjiRbE1/blC
        HIb0Aq/jY25ItDSk8n/4oBidorKZaOo=
X-Google-Smtp-Source: APXvYqz5StrrKTHmBSYuahBc1QaPP5r/2reEMaH1lhdU5FM5lBCGBQ60mYSC5+XzRFLGi71JiMg1Tw==
X-Received: by 2002:ac8:30a7:: with SMTP id v36mr61537994qta.119.1564079237322;
        Thu, 25 Jul 2019 11:27:17 -0700 (PDT)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id v75sm24789895qka.38.2019.07.25.11.27.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 11:27:16 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 25 Jul 2019 14:27:14 -0400 (EDT)
X-X-Sender: vince@macbook-air
To:     linux-kernel@vger.kernel.org
cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [patch] perf report segfault with 0-sized strings
Message-ID: <alpine.DEB.2.21.1907251423410.22624@macbook-air>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the perf_data_fuzzer found an issue when strings have size 0.
malloc() in do_read_string() is happy to allocate a string of 
size 0 but when code (in this case the pmu parser) tries to work with 
those it will segfault.

Signed-off-by: Vince Weaver <vincent.weaver@maine.edu>

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index c24db7f4909c..641129efa987 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -251,6 +252,9 @@ static char *do_read_string(struct feat_fd *ff)
 	if (do_read_u32(ff, &len))
 		return NULL;
 
+	if (len==0)
+		return NULL;
+
 	buf = malloc(len);
 	if (!buf)
 		return NULL;
@@ -1781,6 +1785,10 @@ static void print_pmu_mappings(struct feat_fd *ff, FILE *fp)
 	str = ff->ph->env.pmu_mappings;
 
 	while (pmu_num) {
+
+		if (str==NULL)
+			goto error;
+
 		type = strtoul(str, &tmp, 0);
 		if (*tmp != ':')
 			goto error;
