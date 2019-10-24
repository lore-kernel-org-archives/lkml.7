Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A64ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E672166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KhtIu0dC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409679AbfJXPPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:15:39 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45796 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409599AbfJXPPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:15:39 -0400
Received: by mail-qk1-f195.google.com with SMTP id q70so16190183qke.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 08:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+iIRtubR+3wcJynWU+Kes2QJp/E/y+xxgrhDiusBOkw=;
        b=KhtIu0dCBCIld0cRA5SUcUS0KOYjEc4cfXPg8KYjHxlBNZegNKIW0LE1dFWTzdCJXh
         XUQXG5Zc6ePCGNVe7v+Y7NRdYoXFxV8EinQmz7Z4e3MQPPmeDGTHMpOLD8gDxqYKn22I
         8hMZF9W4N4Dz6VQ48+unWncjtlnk+ljhv817Cs5eAP/8XOa7uUc3iPIyKfQ6XIfcnK/g
         HbBn+S0oxLTyyEsLnnmGIkyOom6kq3bS9L/dzVAZ3LvkNtMAa4fJzxcyKT+LZzu5o33I
         c6w4nBBsi08CAsqiaATFlWr5WDDf7fTODch3cCyRefSwjhMB6Onh+6g9Q1mDeqQVl+mK
         vbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+iIRtubR+3wcJynWU+Kes2QJp/E/y+xxgrhDiusBOkw=;
        b=WqFK9nxnAVN+KN65L9fgr05mj1cpr9iManB3Y1eFGNP1xaUX4rF9tVQ71ycfbLbLr0
         XaTLCp8xAo4q0vzrA2z4B4JM1L5WJcOF367J9LhKS4Gnk9vvrryhMBo3JuisPdFwNAnf
         sl5QqCSTay6nj/BNuKrtOLDYwN2kUV6RYwxBWQfsMZaLXbgPFwIw49zBzhtNeZKfTIF3
         tT8FveeF2o2KebZCWGb7Sie2SFCMv/OIF4UMFMk9WCO5AoNcHsEPUTGT7QBTg9+o9f4P
         OcwoaAVD2juTAEGei+b0KvXVW2x1ddQS9+tC4Y67J5V6nko3zfR1sU2yb/NhplElsp76
         Q08w==
X-Gm-Message-State: APjAAAU1gMB+NRQj7O3AMuLZhzWLiD/Ja09u6iVmJ2Icu7RBKQwVsuXf
        altoFCl7Bdb7/x/cq0RUxrb4Tw==
X-Google-Smtp-Source: APXvYqy18zf3XosU8y4peGneBh50FW2Gynb+ZaBTGHs+TmE6Px6rp0nwka0P0vb4Yv2oZ65stPVprg==
X-Received: by 2002:a37:e50f:: with SMTP id e15mr14378854qkg.192.1571930138163;
        Thu, 24 Oct 2019 08:15:38 -0700 (PDT)
Received: from localhost.localdomain (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id l5sm4346073qtj.52.2019.10.24.08.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:15:37 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>,
        Robert Walker <robert.walker@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 4/4] perf cs-etm: Fix unsigned variable comparison to zero
Date:   Thu, 24 Oct 2019 23:13:25 +0800
Message-Id: <20191024151325.28623-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024151325.28623-1-leo.yan@linaro.org>
References: <20191024151325.28623-1-leo.yan@linaro.org>
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

