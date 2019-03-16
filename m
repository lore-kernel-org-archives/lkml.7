Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6F6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F57F218FC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0S3l4/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfCPIGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:06:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43556 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfCPIGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:06:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id c8so1250442pfd.10;
        Sat, 16 Mar 2019 01:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tO5iYu2G3NwF3tZcWUCVD75AHAkLZD7cs7AoLmgDFv4=;
        b=U0S3l4/LlrSbWR5/V2QeUfVg5LMRMwl5M+ug9OJQPwweo4Qj0bRGICOzjcN/HH8rFe
         EqEmb7I6deI1Sp4mtn4yy/a7XnynI+oj3AdLx64kj0FjUtUWHh8llq4G3n+RdWMgSE/1
         6Mm8Yps416Zya0CIV2CKQ/pOnrcpr3E2R246ErdFf/m/IHC2KzGRrAuhAMxY8tnxC9NS
         +c7tVOze93ANV2NtnxHx3VQR9RwHhNFLkckTHf5WaxrdcnKoBzWp71N0U5dGxzHbGbNC
         utT6bwW4nxXDA/82tmNabstzvkSdEjOTA+Ik3S51c6F0xRBoRqbzNUNr5VErIJwD/Hwb
         NK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tO5iYu2G3NwF3tZcWUCVD75AHAkLZD7cs7AoLmgDFv4=;
        b=YvCMPp8XFHtmHl8oqtagAJch3cvXxQ9iuN95PbNByhjiXikCyeOa7Vshc7NC0d/zd4
         dqIndD1d9+IMHaPiy8PplyKfzgMRrnsiSmIrLRAGovOiAPf+5EaXoRitRNAFh2z2ulWF
         t/gHYcVjL2NBPM9qC0qmF/iHBenlWoh6wcLJS2ZuZmmNkxsk6URvrSyGNsIK8cb3gOrO
         dbGz18yqbsHTyrBursTMeAHy7LN5J45lbl7KVH6OvsyLPX5FW9sdh5DjST/iaHXMm/Zq
         ucHUzHNIykYKE2q6mw8IACiT/l+7VemB4cMnm+KRkOlUYV0FtHekwWROaGkeyxn6B0tX
         h/cw==
X-Gm-Message-State: APjAAAVG7nZYRM8AQkjyIBSlcy9YdCAi1y2rRZ+iXD1miZ07k5pKADBP
        eXRjP8bDQ40Qkp0s0vi1vkU=
X-Google-Smtp-Source: APXvYqxefhLDTxepdcmnj02r+MS0HSdlKMonHTBckde76EY34Ms+fYmmOehjrj1quk3VfTEbQICQ4w==
X-Received: by 2002:a63:1060:: with SMTP id 32mr7524857pgq.126.1552723611656;
        Sat, 16 Mar 2019 01:06:51 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y14sm10690975pgs.47.2019.03.16.01.06.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 01:06:50 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 04/16] perf: fix an error in config template
Date:   Sat, 16 Mar 2019 16:05:44 +0800
Message-Id: <20190316080556.3075-5-changbin.du@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190316080556.3075-1-changbin.du@gmail.com>
References: <20190316080556.3075-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The option 'sort-order' should be 'sort_order'.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf-config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 86f3dcc15f83..ba7485d86837 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -114,7 +114,7 @@ Given a $HOME/.perfconfig like this:
 
 	[report]
 		# Defaults
-		sort-order = comm,dso,symbol
+		sort_order = comm,dso,symbol
 		percent-limit = 0
 		queue-size = 0
 		children = true
-- 
2.19.1

