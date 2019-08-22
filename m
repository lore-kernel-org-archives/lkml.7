Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E509FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B854E2089E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CPtPkL7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389586AbfHVPVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 11:21:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36021 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389554AbfHVPVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:21:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so6198545wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 08:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dQo/3gCQPUZclinUkVyhVJImer3HlnMgJva1KNL7p2s=;
        b=CPtPkL7rqtuuqAFgy+uhFEw2Nx8tcwkjur3v/fj0Adcr4K8/+LteVFwtZIl5s++8GK
         6LInXMWdf7WoaVYbrfrOWZQKfRU5uAw1gR/f1UuVhuGxkizCnYXhvtqzlm3HU/kuWrWw
         XPUWMGwuLQ51wWbkPpXxXa3aeSuqHwiSpEOZvZTHaI4KXRRGsl9a0hTCDumOcFj3OQbf
         p8wIRavzYFIeRoSPkXhQhkcAtdqPh7I64AWh8IEV8c/WjqpSYj+Xl180r4y8hO2oRyLe
         AU1ws1HIxNV3oaFTaa8hR2Z5PsZ77+sbGNq+svtVGpbGy6nXkaZWliogDeh33zV3CZNx
         5Zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dQo/3gCQPUZclinUkVyhVJImer3HlnMgJva1KNL7p2s=;
        b=JjfoUbjL3DHroMtiTx9GNP58ndl+EBP0nH4UqK0MM3ckfVx2A58X/S9xkLtUkeV9lQ
         xXRoeOdsN05yMnZOGEk8HHUrLwNJ3G+4HrUASiPp8tju8l7IgGQIH0+203C8gEQou997
         uvdimeixwugqWdWF9nD4gNvY1xta472pcIBr3jehSfBDB3U/o7WRdJVreNJi3g0JME7u
         StCOyXgZdFtrfxki30I98QQ1P+p3x3eNFADApmD9cRcCTfwQnpJ0+HVEq3Qa1WWE+Htw
         XtB7pTHnYmDKsMin0L9hPzqbchJHo/GWgdHb8Ue9goKk1PLXUdZKK2OiHa0Sz4PLZmlJ
         aUwg==
X-Gm-Message-State: APjAAAV4vNaL6iomLlbmU4oYcj9Gu7pwFaMgDVSLMcKXRJ7FYz8cynym
        rWIx1BUkrO7vFloViBrg6SdzFyh7oEM=
X-Google-Smtp-Source: APXvYqx+RPajfN/Z+9lgie4Z+FxDwW+FRUhfHznXuS+cA2uc391gatlhFjJt2iECdWeyjhf9diV00w==
X-Received: by 2002:a7b:c246:: with SMTP id b6mr7330814wmj.13.1566487263542;
        Thu, 22 Aug 2019 08:21:03 -0700 (PDT)
Received: from localhost.localdomain (146-241-115-105.dyn.eolo.it. [146.241.115.105])
        by smtp.gmail.com with ESMTPSA id a19sm79833974wra.2.2019.08.22.08.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 08:21:03 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 4/4] block, bfq: push up injection only after setting service time
Date:   Thu, 22 Aug 2019 17:20:37 +0200
Message-Id: <20190822152037.15413-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822152037.15413-1-paolo.valente@linaro.org>
References: <20190822152037.15413-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If equal to 0, the injection limit for a bfq_queue is pushed to 1
after a first sample of the total service time of the I/O requests of
the queue is computed (to allow injection to start). Yet, because of a
mistake in the branch that performs this action, the push may happen
also in some other case. This commit fixes this issue.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ddac93e910fa..0319d6339822 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5823,12 +5823,14 @@ static void bfq_update_inject_limit(struct bfq_data *bfqd,
 	 */
 	if ((bfqq->last_serv_time_ns == 0 && bfqd->rq_in_driver == 1) ||
 	    tot_time_ns < bfqq->last_serv_time_ns) {
+		if (bfqq->last_serv_time_ns == 0) {
+			/*
+			 * Now we certainly have a base value: make sure we
+			 * start trying injection.
+			 */
+			bfqq->inject_limit = max_t(unsigned int, 1, old_limit);
+		}
 		bfqq->last_serv_time_ns = tot_time_ns;
-		/*
-		 * Now we certainly have a base value: make sure we
-		 * start trying injection.
-		 */
-		bfqq->inject_limit = max_t(unsigned int, 1, old_limit);
 	} else if (!bfqd->rqs_injected && bfqd->rq_in_driver == 1)
 		/*
 		 * No I/O injected and no request still in service in
-- 
2.20.1

