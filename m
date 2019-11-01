Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1847DCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCDC208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KBf2RlKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfKACIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 22:08:11 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46611 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfKACIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 22:08:11 -0400
Received: by mail-yw1-f66.google.com with SMTP id i2so2958491ywg.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 19:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iAgomrDaaw+p9SyPDKe+DIwZEIKyPHeJdp6rMCsSqrc=;
        b=KBf2RlKG/HVF+HdZkZwipGGFDc87+W3TEb3cKUL72YSFO06gGeEQCdgEwVcGArbIEC
         0hSgawpERrPxShlj96U8j0EgDlDAsSoXTlAfDF2GR344/R8BofFgqibEFBlB+mtGqpuN
         yFMWgZDIShlUYgLFAy6VDY/j17XU0RC2KQPP9Zcp0/Fq/zv2fYl5Gzg2C+K9spCxNznK
         QykUXf43faePtkV1/a+P/HuHQYCopqaTgTTJtmlrkvjthjf5XRXXi8vGr5ds8Y7RcjoL
         KbYzAlzMi2De7OyKSieTdE1sGOTS6Q/7qt25zBlxC+3NjFCaXNOZpXMQxfg/hFGQtbec
         FXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iAgomrDaaw+p9SyPDKe+DIwZEIKyPHeJdp6rMCsSqrc=;
        b=KGKj1h/YmuZ6t6FDgjyA5QAqtZ0FjuZB+CQKsNuwdOGl+aXgAqnJYtTBw69xEYZe3t
         koYMeqMvj7ffkCr3qEwcqEmB9TRHKkgrEJJ8LtHMr7hBSM4pl7dDyusvy2ac2+0xJThI
         r0L5Cxi3cIrxFoNP7P86q9h8RXtiIDh2dJJhynzqb2K+NXMfqHtSqRotkAFB6pqfBFgf
         o2mCdc3F3IXw8VNTztEDrIQ3ndk7MXs6yp2m4B0NQEr1wAOARfaI7xi8o5iOvrg2NtAO
         yxX6thGBjL+rLY3jTPxDrK6uSBMdTZ/R9avVaEX1m1zTNac2EXWBK913f2PIl3BwRgxf
         tcIg==
X-Gm-Message-State: APjAAAWyM6tFOlC3uASKqNbrtgDDZ70VyDXjHHzRt7+erWmzduD7370a
        E+tEdZDCIpyoShtMBrYgOMzdmw==
X-Google-Smtp-Source: APXvYqwocgrzQk2qV7HduXfj8l1PhQC22H7kaTVlKis0qq4lCq0+YnTVSRlOOzrOxdeHR3aunn2FAQ==
X-Received: by 2002:a81:8501:: with SMTP id v1mr6501020ywf.406.1572574090230;
        Thu, 31 Oct 2019 19:08:10 -0700 (PDT)
Received: from localhost.localdomain (li1038-30.members.linode.com. [45.33.96.30])
        by smtp.gmail.com with ESMTPSA id m5sm3762076ywj.27.2019.10.31.19.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 19:08:09 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Robert Walker <robert.walker@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 1/4] perf cs-etm: Continuously record last branches
Date:   Fri,  1 Nov 2019 10:07:47 +0800
Message-Id: <20191101020750.29063-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101020750.29063-1-leo.yan@linaro.org>
References: <20191101020750.29063-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every time synthesize instruction sample, the last branches recording
will be reset.  This would be fine if the instruction period is big
enough, for example if we use the option '--itrace=i100000', the last
branch array is reset for every instruction sample (10000 instructions
per period); before generate the next instruction sample, there has the
enough packets coming to fill last branch array.  On the other hand,
if set a very small period, the packets will be significantly reduced
between two continuous instruction samples, thus if the last branch
array is reset for the previous instruction sample, it's almost empty
for the next instruction sample.

To allow the last branches to work for any instruction periods, this
patch avoids to reset the last branches for every instruction sample
and only reset it when flush the trace data.  The last branches will
be reset only for two cases, one is for trace starting, another case
is for discontinuous trace; thus it can continuously record last
branches.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f5f855fff412..8be6d010ae84 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1153,9 +1153,6 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 			"CS ETM Trace: failed to deliver instruction event, error %d\n",
 			ret);
 
-	if (etm->synth_opts.last_branch)
-		cs_etm__reset_last_branch_rb(tidq);
-
 	return ret;
 }
 
@@ -1486,6 +1483,10 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 		tidq->prev_packet = tmp;
 	}
 
+	/* Reset last branches after flush the trace */
+	if (etm->synth_opts.last_branch)
+		cs_etm__reset_last_branch_rb(tidq);
+
 	return err;
 }
 
-- 
2.17.1

