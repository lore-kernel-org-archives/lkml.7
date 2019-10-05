Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76A8C3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 09:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F482133F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 09:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SEchh8dj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfJEJQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 05:16:42 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38819 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfJEJQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 05:16:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id j31so12167934qta.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 02:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5GP/KNw0NThi+xFyZyJwWXss0a8iqQMvGrS8dpQzhPU=;
        b=SEchh8dj4qcptxwJcOAo15ZrP0Q38g28a7exn9iyxXlFmNigonCzvKJmR+iRVs6LuZ
         pe8vklnaBfIYulObSewcnQQrqBuQJxJ/I2cyRFnh6KS/FnGui180xTOP+SyKzW1iYnlj
         b8+1/rcEni7xHn3+XNgwn8KKOMfaJMNhwG+nOI08nLatBTQSM5ZkymsT7UYadFZ2DsSN
         MvNrj0HDFMuVxFYIEnrKrucUC0Hh0WP5clNjK8Kgi1JpHRsbonXOoluIQqsOgn6FecLj
         rr+pjsUMIgoJfiL40lAgaeKoosOETz0+sdryR0vpnXdwZxjelYcPk80c9bX0jldErFH5
         4+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5GP/KNw0NThi+xFyZyJwWXss0a8iqQMvGrS8dpQzhPU=;
        b=qm9887M119pU+19NlEY3k2TOjpZgOB5g4BSE0WY0w9DRYKYIIY8/b10BAKgRFoKH1B
         Tk4LsxmebRohaEZzF2Joj99k+dhg0Ssz4buRghuhcStNwmjaYFL3wzEhJXUa7Fa7bHt7
         /r/a6LaeBv+p1PQwETYGyEC+uBHCd2UkOL/qkTmBbUClf+ElImngAUGa4CuXFGtPji4Q
         Jquf9eVAdFDaZKqa8NT2X+dMaS0NxMxuJCpChaPLwLSzzeLkb7xnF0bdwi4jsZcEvmr6
         amkn8uGGbokckFU9YUeyxINlBrlzVT8XjgqB+TsyVfhZB+jn4vjAl7egM39ZsBr3V9PR
         3RSQ==
X-Gm-Message-State: APjAAAXXR9sYoyF0kQZrM8mEysA0bIGV4cIimK+G3/obwTpHell+hi/W
        u0VwF89LgYxZQ6YhcUC6SRnDDQ==
X-Google-Smtp-Source: APXvYqzhobfhJR9iZNT/7J/wkRNUnhC1SUXWRX+wzS4iEfjknKRdpnGJm4K35HqAbQl+qFW8jWsGxQ==
X-Received: by 2002:ac8:1701:: with SMTP id w1mr20870585qtj.24.1570266999647;
        Sat, 05 Oct 2019 02:16:39 -0700 (PDT)
Received: from localhost.localdomain (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id u132sm4384621qka.50.2019.10.05.02.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 02:16:39 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 1/6] perf cs-etm: Fix unsigned variable comparison to zero
Date:   Sat,  5 Oct 2019 17:16:09 +0800
Message-Id: <20191005091614.11635-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191005091614.11635-1-leo.yan@linaro.org>
References: <20191005091614.11635-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the u64 variable 'offset' is a negative integer, comparison it with
bigger than zero is always going to be true because it is unsigned.
Fix this by using s64 type for variable 'offset'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 4ba0f871f086..4bc2d9709d4f 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -940,7 +940,7 @@ u64 cs_etm__last_executed_instr(const struct cs_etm_packet *packet)
 static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
 				     u64 trace_chan_id,
 				     const struct cs_etm_packet *packet,
-				     u64 offset)
+				     s64 offset)
 {
 	if (packet->isa == CS_ETM_ISA_T32) {
 		u64 addr = packet->start_addr;
@@ -1372,7 +1372,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		 * sample is reported as though instruction has just been
 		 * executed, but PC has not advanced to next instruction)
 		 */
-		u64 offset = (instrs_executed - instrs_over - 1);
+		s64 offset = (instrs_executed - instrs_over - 1);
 		u64 addr = cs_etm__instr_addr(etmq, trace_chan_id,
 					      tidq->packet, offset);
 
-- 
2.17.1

