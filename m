Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAF4C282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936332186A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9E8LQQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391707AbfEXRfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:35:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39119 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391665AbfEXRfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:35:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id z26so5725610pfg.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 10:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7YTfrf6ViED9PHS/WoXTw1GGLuSsLDg5zA9R4pOhAT0=;
        b=m9E8LQQ0ybYokosZ3FSWl1NYHaoqKBGO55JdtR6b2j3oJPAh2zWI/+9SV+B04nUOmw
         uFYT4ipZZ6J4Rm3Vly6dQxTffTpuUeitYvmKsjHeXGqajJvyeQTRtmo9IssPppm6kxrR
         JQ951ByVITyZUq/x2q6BWNBukN9XTjUCFiA2pr/+KbWsZ3p5qQK2f4resF+5uEN1ASS+
         Txv8DMke5Wiio4bPoYD5syR2CWeEX2VvAKnVQOu9ATh7KZNnoigkP20IU//nVD76sQ0I
         vg1txyvZrw4Zsl9BiwrFWCTi+w2yJx4fzmllJiZBakHyC+XFLlD3UiqBARB2cN3T+bQS
         RvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7YTfrf6ViED9PHS/WoXTw1GGLuSsLDg5zA9R4pOhAT0=;
        b=CY1z9Szu9mqtCDmTFFQjdDiSBsz29wpNSVKNyS+yxrJ2K4ZAQhJfiuC/zTsh93Kak6
         bDjhFNDtPktBdp8EOQjOVEojyBvcMoDQZ+mTJsjTwr6cEBBLUYTs+nWteYMYgCm/KNng
         gF9/K5wDQ2Ch/hLzrYxudlavsPivLjDqEQqU6u5WKtXhgTMAd4XNiBPHaC9QLeYIxPsK
         uaKSyH9GQE/tbCE4u8SfYOCYaGweUoUi9XrFft/XJDWK3Iiv5SLrnh5ige8tvaP4RKy7
         sWae09DqjKUzLFqEHbg7w94V6MLwzsnrjRGGiygwPPiGOOo2fm6AsoDXzyX9XLjTNUjj
         SLZg==
X-Gm-Message-State: APjAAAVs3hXzk4NHYTuwZ0JJNJlKbsDWtQyOwi8IvFgXU2eb80J5BhWA
        yB4XoeEKc8W1TjZ2ISguAF4Y0Q==
X-Google-Smtp-Source: APXvYqyV3WL42bi9D41wkG05D+u93adpt/IhjVbA91moQ87g9r+rMF9jvPDc/IC8fJUZYHgjjwUKqQ==
X-Received: by 2002:a17:90a:1a84:: with SMTP id p4mr11101867pjp.15.1558719320267;
        Fri, 24 May 2019 10:35:20 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id k13sm2809575pgr.90.2019.05.24.10.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 10:35:19 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, suzuki.poulose@arm.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org
Subject: [PATCH v2 08/17] perf tools: Fix indentation in function cs_etm__process_decoder_queue()
Date:   Fri, 24 May 2019 11:34:59 -0600
Message-Id: <20190524173508.29044-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524173508.29044-1-mathieu.poirier@linaro.org>
References: <20190524173508.29044-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing wrong indentation of the while() loop - no change of functionality.

Fixes: 3fa0e83e2948 ("perf cs-etm: Modularize main packet processing loop")
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 108 +++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index a74c53a45839..68fec6f019fe 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1578,64 +1578,64 @@ static int cs_etm__process_decoder_queue(struct cs_etm_queue *etmq)
 
 	packet_queue = cs_etm__etmq_get_packet_queue(etmq);
 
-		/* Process each packet in this chunk */
-		while (1) {
-			ret = cs_etm_decoder__get_packet(packet_queue,
-							 etmq->packet);
-			if (ret <= 0)
-				/*
-				 * Stop processing this chunk on
-				 * end of data or error
-				 */
-				break;
+	/* Process each packet in this chunk */
+	while (1) {
+		ret = cs_etm_decoder__get_packet(packet_queue,
+						 etmq->packet);
+		if (ret <= 0)
+			/*
+			 * Stop processing this chunk on
+			 * end of data or error
+			 */
+			break;
+
+		/*
+		 * Since packet addresses are swapped in packet
+		 * handling within below switch() statements,
+		 * thus setting sample flags must be called
+		 * prior to switch() statement to use address
+		 * information before packets swapping.
+		 */
+		ret = cs_etm__set_sample_flags(etmq);
+		if (ret < 0)
+			break;
 
+		switch (etmq->packet->sample_type) {
+		case CS_ETM_RANGE:
 			/*
-			 * Since packet addresses are swapped in packet
-			 * handling within below switch() statements,
-			 * thus setting sample flags must be called
-			 * prior to switch() statement to use address
-			 * information before packets swapping.
+			 * If the packet contains an instruction
+			 * range, generate instruction sequence
+			 * events.
 			 */
-			ret = cs_etm__set_sample_flags(etmq);
-			if (ret < 0)
-				break;
-
-			switch (etmq->packet->sample_type) {
-			case CS_ETM_RANGE:
-				/*
-				 * If the packet contains an instruction
-				 * range, generate instruction sequence
-				 * events.
-				 */
-				cs_etm__sample(etmq);
-				break;
-			case CS_ETM_EXCEPTION:
-			case CS_ETM_EXCEPTION_RET:
-				/*
-				 * If the exception packet is coming,
-				 * make sure the previous instruction
-				 * range packet to be handled properly.
-				 */
-				cs_etm__exception(etmq);
-				break;
-			case CS_ETM_DISCONTINUITY:
-				/*
-				 * Discontinuity in trace, flush
-				 * previous branch stack
-				 */
-				cs_etm__flush(etmq);
-				break;
-			case CS_ETM_EMPTY:
-				/*
-				 * Should not receive empty packet,
-				 * report error.
-				 */
-				pr_err("CS ETM Trace: empty packet\n");
-				return -EINVAL;
-			default:
-				break;
-			}
+			cs_etm__sample(etmq);
+			break;
+		case CS_ETM_EXCEPTION:
+		case CS_ETM_EXCEPTION_RET:
+			/*
+			 * If the exception packet is coming,
+			 * make sure the previous instruction
+			 * range packet to be handled properly.
+			 */
+			cs_etm__exception(etmq);
+			break;
+		case CS_ETM_DISCONTINUITY:
+			/*
+			 * Discontinuity in trace, flush
+			 * previous branch stack
+			 */
+			cs_etm__flush(etmq);
+			break;
+		case CS_ETM_EMPTY:
+			/*
+			 * Should not receive empty packet,
+			 * report error.
+			 */
+			pr_err("CS ETM Trace: empty packet\n");
+			return -EINVAL;
+		default:
+			break;
 		}
+	}
 
 	return ret;
 }
-- 
2.17.1

