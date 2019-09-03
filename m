Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D87C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB23522DCC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uYPuC0yV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfICLg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:36:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46383 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbfICLgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:36:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id h7so15769693wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 04:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9KHg7Qe2ES8vkKFWvrCHSGJdsSSlcK8bcwIxUgcjXNM=;
        b=uYPuC0yVQGlcY2cTAR5JGAnD5f2N1lZR4isNU72syvJSAYwVtciTX7bqqDdw2BvR7i
         JLKZ19hueQKoiIP5/2imTa6n2YbhWYxYPl3RjTCWdicnvkkeFTC+WQT0bDPD8yhI10J/
         yftzHRMVwND/+L70ex2h5fnZjX995Qo8yVg2vEjjan6rWeAblQBbFz+eUh5BT+evLMqJ
         7SAjxQ7Aq28+4bX6+0rkkQDX45fIlOqlxaOxWYVpUWy0p/68DUoV8tSy8RXvpkOMAPl1
         jwkaveo27gIfLpaRnTCmlicPnPu8rsKSvjE/BiHMxoZAwPd64BOAy0ZUGcv/fsqFTDA+
         sKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=9KHg7Qe2ES8vkKFWvrCHSGJdsSSlcK8bcwIxUgcjXNM=;
        b=rWy5eofOIJjZXBe11SWL0a9nlvxYYAJ6wQCvgqFH4mzQPbynkylHsjqEa4ofzMB7gA
         vp1q3v6mwzHIEVdq9FMD4weJfrAp3IMQsvZpVghESN0t6KRf7HG5kcTQdHVtdQ010k4G
         u663rJNxSEIWr2KWy6fuStwUGbjyh5BDlnZ+W53X/HC1dKwgp/Z28UiEX89SXyVvK21A
         A6IeBu527myprMjNL5LKQW22qsTXEwY1BS0GI6N5eIgmsD/DtddGkvTuD4PgXdjIm/Rx
         68vIElnHfpsPLQNFw+IoGh8e4Q81Cu2SjXWE1F2rweVjyn9cUkgp47W0zagUl5rQtysR
         EXFQ==
X-Gm-Message-State: APjAAAV/aJ1mzXioxO/2H/EZSI71tbe6mmj5Wl98I45SxNRIeeMshWoc
        7NHXhPYrb5gJ8VoBWnPucmxryR1/KDSBKw==
X-Google-Smtp-Source: APXvYqxH3YjlOc0QiUvufW8q79U+uj37cujkxwcAjATvhnH7t23jzxkO+dFnCBlBh+/2zAahJaCltA==
X-Received: by 2002:adf:fcc1:: with SMTP id f1mr12863956wrs.308.1567510612755;
        Tue, 03 Sep 2019 04:36:52 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id y186sm32950067wmd.26.2019.09.03.04.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:36:52 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] csky: Move static keyword to the front of declaration
Date:   Tue,  3 Sep 2019 13:36:51 +0200
Message-Id: <20190903113651.3862-1-kw@linux.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the static keyword to the front of declaration of
csky_pmu_of_device_ids, and resolve the following compiler
warning that can be seen when building with warnings
enabled (W=1):

arch/csky/kernel/perf_event.c:1340:1: warning:
  ‘static’ is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
Related: https://lore.kernel.org/r/20190827233017.GK9987@google.com

 arch/csky/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index 4c1a1934d76a..bc33e4ed189d 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -1337,7 +1337,7 @@ int csky_pmu_device_probe(struct platform_device *pdev,
 	return ret;
 }
 
-const static struct of_device_id csky_pmu_of_device_ids[] = {
+static const struct of_device_id csky_pmu_of_device_ids[] = {
 	{.compatible = "csky,csky-pmu"},
 	{},
 };
-- 
2.22.1

