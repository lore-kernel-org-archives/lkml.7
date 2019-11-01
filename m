Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00D4CA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7956216F4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NC1q5M8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbfKACI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 22:08:29 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38376 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfKACI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 22:08:27 -0400
Received: by mail-yb1-f195.google.com with SMTP id w6so1736643ybj.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 19:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+iIRtubR+3wcJynWU+Kes2QJp/E/y+xxgrhDiusBOkw=;
        b=NC1q5M8jluovAv+CJVmfUvLK4FahIG39LJ6l6gjbCZNa0UpX/mFDwNFqHQiy1rePxC
         /lbNlkIbyZL58s39+0Wb2t5W1VYQ6Y0GCUYYdttaWTpE8t46toe9NpguBwwHVVOSaw01
         +fvDyEdd3LOlUWQsIxhWRiNIxniYiHEyi04hLDNX7S/Rma6Ub8dSPdWBA3vKjwhZ2Nse
         PqomKFz8PSBasrKVgjJNsSp+eHqcpecI8MOiLr2G1mHF1PIPxkCgFkSilH+tM1D7QREx
         iAtGvPl+1b1RtFLTVvsNP+F19SDMMjmPa50SD3+5SFhh2FlphPLBnDYHBI5bc/oJ67eF
         gd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+iIRtubR+3wcJynWU+Kes2QJp/E/y+xxgrhDiusBOkw=;
        b=fFPJIMqIBnqKj7sR5UUKLvJoP6b6pRhI2T+5JU+DWtOyguCRgXF8FuouePw09HPply
         IYlIY013YZMjFcUMG5nKyZJXPJEvmaR0cq6xbT/wIsa+U0OT9FOLkyfcoWwZGKYzv2EL
         uNT3lGjhrnX175M9FB87IyA98Y2s6/XU+S1u+W9oNbmlmecsW8s4+J4EkfuhvE78KMIm
         +IGpoRRP2jY8uO27Al5YE6OmC4C66U5UivNZ+rhDl3JJTk44qFs06wErPyr6V1FIAE0w
         SsHAhv/aTPSisT2qJCSteZyMRw5xpyEUTlmoq25/NCWVl9I1JT4yJ5wykhA3mmpVTZIc
         3lTw==
X-Gm-Message-State: APjAAAUIw3ANKwqyO7XiZ9gWxZhz8iC9GIZRWyC0r1Q0rqdpI/30RvfY
        FrxIT0eCLobGL6V6dEQAZV1HWg==
X-Google-Smtp-Source: APXvYqz424xHGG16+/K9JPBVe1fOQq/35yq0LWtrtLqUcROwmuCiXiEielnF0h1UJtanrtLPpBZZZA==
X-Received: by 2002:a25:c008:: with SMTP id c8mr7402086ybf.318.1572574106466;
        Thu, 31 Oct 2019 19:08:26 -0700 (PDT)
Received: from localhost.localdomain (li1038-30.members.linode.com. [45.33.96.30])
        by smtp.gmail.com with ESMTPSA id m5sm3762076ywj.27.2019.10.31.19.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 19:08:25 -0700 (PDT)
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
Subject: [PATCH v2 4/4] perf cs-etm: Fix unsigned variable comparison to zero
Date:   Fri,  1 Nov 2019 10:07:50 +0800
Message-Id: <20191101020750.29063-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101020750.29063-1-leo.yan@linaro.org>
References: <20191101020750.29063-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'offset' in function cs_etm__sample() is u64 type, it's not
appropriate to check it with 'while (offset > 0)'; this patch changes to
'while (offset)'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index d9a857abaca8..52fe7d6d4f29 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -945,7 +945,7 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
 	if (packet->isa == CS_ETM_ISA_T32) {
 		u64 addr = packet->start_addr;
 
-		while (offset > 0) {
+		while (offset) {
 			addr += cs_etm__t32_instr_size(etmq,
 						       trace_chan_id, addr);
 			offset--;
-- 
2.17.1

