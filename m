Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84551C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5080E2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FntvYFIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391682AbfEXRfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:35:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33802 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391578AbfEXRfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:35:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id w7so4439523plz.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 10:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TdCUaEZ68qpQ0pkU47NzIQOhdzi0053++FFZ3/d/RGQ=;
        b=FntvYFIAvQYhJ/apol1z9vxNQ/Gm+qEaV5pe3mOV5Y8mHC+C5tsGFzFRRfqZTSGr7U
         /+pIlw5zaR4AJttsxs6LqPHz7SWDIog4iUePidyBdPLxGuZzuZKqrGyYUt5CsP7S6K68
         IlSI7YP7ffh/pa97PS/2rI13ECfIUXnk3gi770orY5/xU2N02CUGrhc3Q0pVRaYYUHx+
         5owFn1/THbD834pSoGhKBWJieUVjmcC9YrPdosTVIcCE+fo0qMNbQS9GDMzHw/LFAQyF
         lWm9Cm1/xI++8KnAZa2riSRk0In388mG/bpRUJvp17Bkpxgzrl8BxMSxc4+dc8hVBsrx
         8QEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TdCUaEZ68qpQ0pkU47NzIQOhdzi0053++FFZ3/d/RGQ=;
        b=df47Gj9ELMaSluowFsPPtHzjq40rI/qQlWJZS/qkCz9UVK5c2oCP9hA0vhZ4RHtWKa
         Bfe7z3Fj6qMJY5cbkdeoIWK7uiWtXtGGvD6/TqfNXb9SRGaeXTGej/00YwfKZPFdW0L9
         pBunrelhsrweuaR6C1kL2LPcI/eh7FX9Hmy+oEbNOpOaP592qZygFQrcCGQbHxIpOeCx
         1eUfW3jaOAFmPiu6JWW4OVg2GG/oat5N26X8JD9dqB0s88AkHN2ekE2Qc7oN94Suhk0e
         JFeDvCplMEiOZmfIc9RlAthBefWC70Nft8ph8JafblmB07VExG/NbDZ/fAsVqe8f0tvr
         9RYQ==
X-Gm-Message-State: APjAAAVo4zkdy+wO4bOtEg5WHFc75RDWHun3X0sRZNuSZMegSdqHDEEn
        P7FqIJI9c4a+UxG/n/s6bovHdQ==
X-Google-Smtp-Source: APXvYqw3NW/AAC+roI3nnd0ZNrupX9jWmQIuRM3DE85TINSeXq8cZjx9UQso74EyY8q4IZuWsq2mTg==
X-Received: by 2002:a17:902:2a28:: with SMTP id i37mr19562156plb.52.1558719317327;
        Fri, 24 May 2019 10:35:17 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id k13sm2809575pgr.90.2019.05.24.10.35.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 10:35:16 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, suzuki.poulose@arm.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org
Subject: [PATCH v2 06/17] perf tools: Refactor error path in cs_etm_decoder__new()
Date:   Fri, 24 May 2019 11:34:57 -0600
Message-Id: <20190524173508.29044-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524173508.29044-1-mathieu.poirier@linaro.org>
References: <20190524173508.29044-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in having two different error goto statement since
the openCSD API to free a decoder handles NULL pointers.  As such
function cs_etm_decoder__free() can be called to deal with all
aspect of freeing decoder memory.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 39fe21e1cf93..5dafec421b0d 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -577,7 +577,7 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
 	/* init library print logging support */
 	ret = cs_etm_decoder__init_def_logger_printing(d_params, decoder);
 	if (ret != 0)
-		goto err_free_decoder_tree;
+		goto err_free_decoder;
 
 	/* init raw frame logging if required */
 	cs_etm_decoder__init_raw_frame_logging(d_params, decoder);
@@ -587,15 +587,13 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
 							 &t_params[i],
 							 decoder);
 		if (ret != 0)
-			goto err_free_decoder_tree;
+			goto err_free_decoder;
 	}
 
 	return decoder;
 
-err_free_decoder_tree:
-	ocsd_destroy_dcd_tree(decoder->dcd_tree);
 err_free_decoder:
-	free(decoder);
+	cs_etm_decoder__free(decoder);
 	return NULL;
 }
 
-- 
2.17.1

