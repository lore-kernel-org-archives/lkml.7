Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C8FC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 22:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF952087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 22:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmqH7Bd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfEQWKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 18:10:52 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:42054 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfEQWKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 18:10:52 -0400
Received: by mail-pg1-f170.google.com with SMTP id 145so3905070pgg.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 15:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ibv3vqoAL5W2pTRfdVDs8V03jMw/WmL1P5VFdR41BZI=;
        b=SmqH7Bd8JB+9uk8UZhIPPj9bG3o2svySo3izE7dOT5ssqTVDyd8hrwauvxPA2cfJMn
         pHs671bYSHVziplhLxrxDq6nfyMqcSC7mLVvWKomKONdARbLCzGgJ6JFDAFcEVnkS3hJ
         X9q5EEbDYejEobDZLHlYtIGdlRlNhLLzL5GoKQ3JjZSy4sOG8+0QtWQjrWMDqPyZgrr1
         J64uHCK2I9h9qxwuhuePwd++YXme59YHyQ2KJJOklwC18iiq1la8Ljg7mL0C2Sfl55Bl
         nK1h0DmbwejZashPVCUFZdWmhJDE9u9WdtQ8hOIhKskJ3GBEdy+/21qVInxemuKHXBCR
         hmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ibv3vqoAL5W2pTRfdVDs8V03jMw/WmL1P5VFdR41BZI=;
        b=XOcVvdYg8d5FHVMfHeMe9rueLMU8KSBsijrouxsIudqEYLbLUSbOelnh4DDhAqbqkV
         5oAFyb8+lYsS/1hB+ti7qWg54+pb0+ZJ2cJUMyVGsBZ12XyOCFJJr7OmBx8oAsPbqsfX
         8C3mM2M1IW1yQjAFXu6xViSc4n6he9LdGr9ENXZCIAGMxHXtSBDw6GdTsgO1O+ul9x4o
         IZ4tHlI7f8/KEOpbGxPqcFb0uXaC8l6TAQj+MANIiCKh4cjXoRxxxjCm94Yt0D9xPBJH
         UuOMuxz/ga3KRkDbOn7Hx1S3PCBISshC8zjKFFuGJOYGxVF+gE9NqIeAnxWhPspCfLsP
         7Jtw==
X-Gm-Message-State: APjAAAXpE4a+AI44jyKwh+PxaRTF6Nv+iyvXu+1wtRY33PprQnC537GK
        nduwmSgsT89bfDej1/8n4d3L++1B
X-Google-Smtp-Source: APXvYqxcpCQQ7qwuZzEzLwn11TXn7H3NL+xJnMg8vMSqyN5KKtb6T3TM/KUaWiL/Bt9gR9jQDvI7sQ==
X-Received: by 2002:a62:6dc6:: with SMTP id i189mr62976146pfc.155.1558131051633;
        Fri, 17 May 2019 15:10:51 -0700 (PDT)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id k30sm3991299pgl.89.2019.05.17.15.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 15:10:50 -0700 (PDT)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [Patch] perf stat: always separate stalled cycles per insn
Date:   Fri, 17 May 2019 15:10:39 -0700
Message-Id: <20190517221039.8975-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "stalled cycles per insn" is appended to "instructions" when
the CPU has this hardware counter directly. We should always make it
a separate line, which also aligns to the output when we hit the
"if (total && avg)" branch.

Before:
$ sudo perf stat --all-cpus --field-separator , --log-fd 1 -einstructions,cycles -- sleep 1
4565048704,,instructions,64114578096,100.00,1.34,insn per cycle,,
3396325133,,cycles,64146628546,100.00,,

After:
$ sudo ./tools/perf/perf stat --all-cpus --field-separator , --log-fd 1 -einstructions,cycles -- sleep 1
6721924,,instructions,24026790339,100.00,0.22,insn per cycle
,,,,,0.00,stalled cycles per insn
30939953,,cycles,24025512526,100.00,,

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 tools/perf/util/stat-shadow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 83d8094be4fe..5c5e012e99c4 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -800,7 +800,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					"stalled cycles per insn",
 					ratio);
 		} else if (have_frontend_stalled) {
-			print_metric(config, ctxp, NULL, NULL,
+			out->new_line(config, ctxp);
+			print_metric(config, ctxp, NULL, "%7.2f ",
 				     "stalled cycles per insn", 0);
 		}
 	} else if (perf_evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES)) {
-- 
2.21.0

