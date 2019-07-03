Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF8FC06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B34E218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vquzm1hY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfGCWZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 18:25:46 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:37273 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfGCWZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 18:25:46 -0400
Received: by mail-pl1-f201.google.com with SMTP id w14so2096941plp.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 15:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/fwf2hS+FH+8ndyIC8K7gBIFC/3vRCm/FJLdZBdEm/k=;
        b=vquzm1hYXT47ySQqIBzuZGDHgu4KdvHeTswUE70Te8jQQwiq+56wNSvYEci2KJxElv
         IZDxY6v9CKCc/8ojvq71MWXxgli+JIRSDYk5FCqbaJKyhCNmlmmzROZQSnoLyCScA3uo
         OuH27g5q8jaaWHI4hW5e6iCD4TcD5BgnTmUeOliCr5nWFmAYoMpGGDYqYYXrOKbDsIUg
         2fxnb6LZM12BqRYmFKLXl6TXd6JBUfLF0Z2k9tUPctlB3LWoZJo/qrXFrc4+wk5eppjV
         HKfSJO1iIqJM2EonnN2Ycewe50280QXVtBeHgmIT9ejP22Oe4saYb4QCyv6CPhfjsoVw
         v0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/fwf2hS+FH+8ndyIC8K7gBIFC/3vRCm/FJLdZBdEm/k=;
        b=q33sTXwFH3cSIBvJF50SAdZOzEQfJ7VUgxKKlr5/G50aSSQTAWx09tvqgIiOkyimR6
         s2TL6ZKQqf9RsQjOz/XmD2uO2vwfr41DaWuet+o4cVKExOxjrVnpUodsyiECb7h68weE
         XC1g0/Q+ff0c9CpKoeOYEmTd63YdoTRjZLFjVRkf3gq617gbSP4NJR0SDDIyMr/dliWZ
         pFGgxj1DrxvQxe8xS8l5m7kQpd2NPiBs2HuDZsdezAV4EC7fajF/11GvqPSXhyhPu285
         /GbRgqwmn31MYOZqZZ5/fxAWmeahwEe3i2NM/ViH5C/TqbaU5hsw9KXinix1PI/dzFEf
         ohpg==
X-Gm-Message-State: APjAAAVmkih3BGcN4vEH48RDYBWP+Boc5KrdGQUISt1+0YmKpLHyy/Km
        bRiFMEzmQDXuX+CRr1dfc6kOf0rtucuq9+P6
X-Google-Smtp-Source: APXvYqyiprx3DttN4XiqHCHLf2vtenkMOX/Mrr+olWfWpnRcqhv9dBBm1lrA17oS6wVuTjZogoGmgW63GZ6igXfe
X-Received: by 2002:a63:b46:: with SMTP id a6mr13481138pgl.235.1562192745251;
 Wed, 03 Jul 2019 15:25:45 -0700 (PDT)
Date:   Wed,  3 Jul 2019 15:25:09 -0700
In-Reply-To: <20190703222509.109616-1-lukemujica@google.com>
Message-Id: <20190703222509.109616-2-lukemujica@google.com>
Mime-Version: 1.0
References: <20190703222509.109616-1-lukemujica@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] perf parse-events: Remove unused variable: error
From:   Luke Mujica <lukemujica@google.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com, Luke Mujica <lukemujica@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove error variable because it is declared but not used in
parse-events.y or in the generated parse-events.c.

Signed-off-by: Luke Mujica <lukemujica@google.com>
---
 tools/perf/util/parse-events.y | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 172dbb73941f..f1c36ed1cf36 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -480,7 +480,6 @@ event_bpf_file:
 PE_BPF_OBJECT opt_event_config
 {
 	struct parse_events_state *parse_state = _parse_state;
-	struct parse_events_error *error = parse_state->error;
 	struct list_head *list;
 
 	ALLOC_LIST(list);
-- 
2.22.0.410.gd8fdbe21b5-goog

