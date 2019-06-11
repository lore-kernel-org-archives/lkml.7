Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A93C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89F62080A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zeBkKyTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391798AbfFKPse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:48:34 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35576 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387966AbfFKPsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:48:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id x25so7546726ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 08:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AmyPodx3dEFHhIzDm29UVxOwzPJji7lKWXsA6ODC9hU=;
        b=zeBkKyTEAXXRJPbJhaz4mZWlzCvaSGYQQ+u/djfCjlLfFyxrrl8LkrOaZDFCOqLl+u
         yHr4kT+6shdR//J1JUuN0Fa0iSF4sS6mrgD2GS1ZM5wFdtgRRlPmE3kcvabEjGbE78sB
         OUnNNUTrXOlD7qwM/b5G3LqRiyc3NA8FkixytFwHpgl4OiRIRxCEJcCnxYhOsQQAyJAN
         ZQrAKme+bRWXcmUimakHwn0qgxNHMm6JCm7AwRN1Lhs/jw4tOSt8cYMgxhaDCn3/pzrI
         evXt0DCNk8UrcN7SFJjMhMnpnjTKdYDmIUzODW5pILwlD7ePG9Rc54fEQxJ3r2PHA4eN
         lkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AmyPodx3dEFHhIzDm29UVxOwzPJji7lKWXsA6ODC9hU=;
        b=ohHL/ii0QYwpTbsPyI1Czy98eY3hw27ujcehdotOdbngio7+j09wW9Y6AzDPQ/D4oe
         loUV8Xr5qiCGZmloVGei6XdbkYVCT0XXuppwVURkF1hL7xHEXqKoJ+DUwhYmDNKtvjCd
         njQg1zXb0nBjW9ptBP3aZi2xW/5maADpukJLZvPtfaWB5D4fpa9tlc+uJN1iyZVQvBQv
         96UhY52zW07EvbkwELrlXKSZdiUT2xmo0Y0A+ASrKyb/OJUYVxdeXRj6oLFZ7Ms/GKSI
         y4jXKNRpDeBm3UZ8e1QJflHkgG8W7WHKsnRMFRSyVvLNWthM8sHv22q/lLB7xqYnYfrm
         W3qw==
X-Gm-Message-State: APjAAAU1UAWRRfgRWVkbQ0TZJ5+wcXpVlENX4hVIErKv3Ye4I4wHpFRP
        r59FgYwo12uo1ahj1x4p4eoI3A==
X-Google-Smtp-Source: APXvYqxiF4AqV2rXDRFEkszFqCHYH2eDejZr/BVINKIkHhGdZVWu+Tkz7zGdzKI/EQLRsmTQFojhEw==
X-Received: by 2002:a2e:8583:: with SMTP id b3mr21954347lji.171.1560268110982;
        Tue, 11 Jun 2019 08:48:30 -0700 (PDT)
Received: from localhost (c-1c3670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.28])
        by smtp.gmail.com with ESMTPSA id x79sm2593872lff.74.2019.06.11.08.48.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 08:48:30 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] seqlock: mark raw_read_seqcount and read_seqcount_retry as __always_inline
Date:   Tue, 11 Jun 2019 17:47:51 +0200
Message-Id: <20190611154751.10923-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the function graph tracer, each traced function calls sched_clock()
to take a timestamp. As sched_clock() uses
raw_read_seqcount()/read_seqcount_retry(), we must ensure that these
do not in turn trigger the graph tracer.
Both functions is marked as inline. However, if CONFIG_OPTIMIZE_INLINING
is set that may make the two functions tracable which they shouldn't.

Rework so that functions raw_read_seqcount and read_seqcount_retry are
marked with __always_inline so they will be inlined even if
CONFIG_OPTIMIZE_INLINING is turned on.

Acked-by: Will Deacon <will.deacon@arm.com>
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

