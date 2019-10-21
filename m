Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E46CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259A120830
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Whs5Oqw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfJUHsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 03:48:25 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36488 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfJUHsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 03:48:25 -0400
Received: by mail-qk1-f196.google.com with SMTP id y189so11684989qkc.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 00:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JxBBg9Ywns2KSENNzDozRimWLdlAzERjFMqNNveI+HE=;
        b=Whs5Oqw3E1BNGGJx9IwRUe6mYoYJgqIDXMrLa69wGTimwenlmPnyxkdD96ImvDhgnz
         QNv9x87GEYuvI72Ufu+XBTd0z4tanRKZdRfzl7rAJYHLGZWm7umbbi1lICwM0bYbzlFi
         1V6vJFo/vPS2wYYa/HaEhP0zxvJBmT63OA1/gMqCjtJNRWrCBxXpnTjkEAUqquUln5j0
         +wPnClf9WTCtGcbTgdUSxzPkITq7gSqIX6gRERMY2f73wyc2hMZrBciki2PO3CEfmABL
         Bf1Mgm1iT1HyrJByLiYHMTlzHnDhnDKqvKFaqmjAGzkn8ctfXPELU1TpewmmBXF/b+X1
         P3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JxBBg9Ywns2KSENNzDozRimWLdlAzERjFMqNNveI+HE=;
        b=DRqbJn1kj4nu5X1u9+1XZwG9VFCvbtKoJzBxz8Wc9lu4iutXlMxGmtxnTQpx4l4/UN
         UrmQGT7kfysWG40Pt4PMaobWF6jBOtKpKYBCOcyf71e9o2yLOf5elqeJ9nskrvx5vaLg
         vrnFAQQ4we+OCXjTRAJghVU28AERR+2hNI16LkcfassEWqLWVjqImUkBWTEOzL5rRkOo
         PbzrIiWUpo5Q1kX+rdvrhPWJYZ6Kq+P7coCM8Gx0htJxWGCVdzPin9ihqcOhvwI6jD80
         9KwMJVyBGV3l7eeohPY+DwpnY+PWfvTXJ+8gfqcNU5e+4Z0EZOHDIsrZz2q8yJu1c+ZT
         F0iQ==
X-Gm-Message-State: APjAAAU5DqVymTYXEtQcKegvgRM4fj1BYafzPHd2wtcjXAd/h9BNThIF
        vejGM+ejkXtJ1oACO+Ggmn0Hyw==
X-Google-Smtp-Source: APXvYqxoo8/8ejDNmP7miKhqcnWZEVADqLZQ00ERyOib7o5pAjWqGibbhSiVLUBXWrDkBggvtnjwWg==
X-Received: by 2002:a37:af46:: with SMTP id y67mr21443431qke.84.1571644104467;
        Mon, 21 Oct 2019 00:48:24 -0700 (PDT)
Received: from localhost.localdomain (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id n17sm7980615qke.103.2019.10.21.00.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 00:48:23 -0700 (PDT)
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
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf cs-etm: Fix definition of macro TO_CS_QUEUE_NR
Date:   Mon, 21 Oct 2019 15:48:08 +0800
Message-Id: <20191021074808.25795-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macro TO_CS_QUEUE_NR definition has a typo, which uses 'trace_id_chan'
as its parameter, this doesn't match with its definition body which uses
'trace_chan_id'.  So renames the parameter to 'trace_chan_id'.

It's luck to have a local variable 'trace_chan_id' in the function
cs_etm__setup_queue(), even we wrongly define the macro TO_CS_QUEUE_NR,
the local variable 'trace_chan_id' is used rather than the macro's
parameter 'trace_id_chan'; so the compiler doesn't complain for this
before.

After renaming the parameter, it leads to a compiling error due
cs_etm__setup_queue() has no variable 'trace_id_chan'.  This patch uses
the variable 'trace_chan_id' for the macro so that fixes the compiling
error.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 4ba0f871f086..f5f855fff412 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -110,7 +110,7 @@ static int cs_etm__decode_data_block(struct cs_etm_queue *etmq);
  * encode the etm queue number as the upper 16 bit and the channel as
  * the lower 16 bit.
  */
-#define TO_CS_QUEUE_NR(queue_nr, trace_id_chan)	\
+#define TO_CS_QUEUE_NR(queue_nr, trace_chan_id)	\
 		      (queue_nr << 16 | trace_chan_id)
 #define TO_QUEUE_NR(cs_queue_nr) (cs_queue_nr >> 16)
 #define TO_TRACE_CHAN_ID(cs_queue_nr) (cs_queue_nr & 0x0000ffff)
@@ -819,7 +819,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 	 * Note that packets decoded above are still in the traceID's packet
 	 * queue and will be processed in cs_etm__process_queues().
 	 */
-	cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_id_chan);
+	cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_chan_id);
 	ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, timestamp);
 out:
 	return ret;
-- 
2.17.1

