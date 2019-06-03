Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70669C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BF127FB1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pQWSMaiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfFCJSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:18:21 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41584 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfFCJK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:10:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id 136so1456482lfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 02:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uxh0FCdCreUcf8edEoivfGm7FzgDoHFgRVdGAU1FrgE=;
        b=pQWSMaiuB4YPTpJ/jxzXOdfiEwulhfBjsDe1AH0XsM8ITR0LE9Bcq8Mqt8tJCpqT9a
         QnJy/6ks/G7ewIr4OMXXZMLxZH5SN+8lDFgnDRTnnGBL1QrIKX8i8j0s9dXS4NOfb19x
         up6RV847HDIar9anNx6PuMX2seb39MVDXlCP1gySCczqYGU6kBzk8fHUCGHaRGOHyf8W
         yvVD2mGfeXvGO8ZxqbpAF/YgP8IoqY+Cdx7Qk4BpNx6FS1Ir26G5UcAKoQ27J+9rjnPM
         BcaquYDFucepeZxq9ZXB2pfz6Pa5thNOMaw0kfMCRYqCFveI3YSdYMrwORv9t99PC/4l
         2Hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uxh0FCdCreUcf8edEoivfGm7FzgDoHFgRVdGAU1FrgE=;
        b=UvLmVQUHnkAhe8tNqp1o4wgD9d44QOnJfYxjSiXA7h8qp85ZjVi/y6Dbj9gRwAkELY
         CtKrURGawbVV2Np33eThux66pi/eZ6sH94EUTk9UUCc5orVtz5RZdkMxQKf1hhIDjahc
         NLjq9vzu19gwgYDdAqTu68L/ZEPGVwIrufjWHe084lRjuOJ6AUUHHiDOvCXAjv7s0hTw
         aXfuJuxYcXcyMZkum3A1hTsXwZ0ymfp9x7RN2mwBBBT9osmsOjhnQKVDbTwPZFdXBg76
         7+3+VkoiQjY3QgM7i5T5R2KRRkg/948hAS0jNOC5oKlpHIf83kT7wi00w7BNtBjlDHBD
         HAXg==
X-Gm-Message-State: APjAAAV1MVi0hNciqSDaSeI6rTiORXU45A/qO5i1we1CQ96zcdywtP5N
        PTcrXHCHZfnQ4SN1aTLQrmcZ6w==
X-Google-Smtp-Source: APXvYqwCmrpuIAS0xO3mRLHS0ITDUv3iTe2EbkFf4bmEkVuJBj8IpQOemvvjsbaAcE3uGRZpSFR5SQ==
X-Received: by 2002:ac2:4c84:: with SMTP id d4mr12944955lfl.1.1559553025224;
        Mon, 03 Jun 2019 02:10:25 -0700 (PDT)
Received: from localhost (c-1c3670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.28])
        by smtp.gmail.com with ESMTPSA id g11sm323757lfb.9.2019.06.03.02.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 02:10:24 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     will.deacon@arm.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] seqlock: mark raw_read_seqcount and read_seqcount_retry as __always_inline
Date:   Mon,  3 Jun 2019 11:10:08 +0200
Message-Id: <20190603091008.24776-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_FUNCTION_GRAPH_TRACER is enabled function sched_clock() in
kernel/time/sched_clock.c is marked as notrace. However, functions
raw_read_seqcount and read_seqcount_retry are marked as inline. If
CONFIG_OPTIMIZE_INLINING is set that will make the two functions
tracable which they shouldn't.

Rework so that functions raw_read_seqcount and read_seqcount_retry are
marked with __always_inline so they will be inlined even if
CONFIG_OPTIMIZE_INLINING is turned on.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 include/linux/seqlock.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index bcf4cf26b8c8..1b18e3df186e 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -127,7 +127,7 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
  * seqcount without any lockdep checking and without checking or
  * masking the LSB. Calling code is responsible for handling that.
  */
-static inline unsigned raw_read_seqcount(const seqcount_t *s)
+static __always_inline unsigned raw_read_seqcount(const seqcount_t *s)
 {
 	unsigned ret = READ_ONCE(s->sequence);
 	smp_rmb();
@@ -215,7 +215,8 @@ static inline int __read_seqcount_retry(const seqcount_t *s, unsigned start)
  * If the critical section was invalid, it must be ignored (and typically
  * retried).
  */
-static inline int read_seqcount_retry(const seqcount_t *s, unsigned start)
+static
+__always_inline int read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
 	smp_rmb();
 	return __read_seqcount_retry(s, start);
-- 
2.20.1

