Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02CAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB4D2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gawf/U1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfCVFXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 01:23:03 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:46204 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfCVFXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 01:23:03 -0400
Received: by mail-pf1-f175.google.com with SMTP id 9so694047pfj.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 22:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=Bm2/0l3EnSnA2QcIYRm55mK3EOwRNo4/J4hf1JHlCFQ=;
        b=gawf/U1NZHpEr1tgXu1ggaM8SJ0+iw+HCQZ7FL166nr12qiB4UKjt/ES83mOUhLp3z
         FAt3Se/5/Ho7RnCkxmDgULcCYASPhrNIKsEGg8ZWXWvTpYL9BKDd8vbjbvIgoUCHbGeh
         7zKf5ehUgZOrqF2z0nkx9A6netypV4ZlguCi3IyXQz7IBMOKEcpZqZ+9c2WuA0JSsrBj
         Vd0ndlg/dlguquNz8TPp07L0cnBvxMrgyI5yUe8oMU8H/xHu79OfQSdPxyaa5hGBXU6W
         pnmTgsFQjhbzbH8yaizbJ23EDwHWHKwrL5HDA5CYqdoDeffIy5eihGBnKO/nfnpp15mP
         O/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=Bm2/0l3EnSnA2QcIYRm55mK3EOwRNo4/J4hf1JHlCFQ=;
        b=aTfdArd5dvBzf/lGZlsR1d2Vr9g+t49MhT/xLuZ+L8U1S3Hrva4eR+ri9/7p17xnDN
         tQElnC6tSERfw60ZETb9/ZOXC6JWdunnmaE86sDCpNIItMoc9KrGk44ioJ7tSS9j6ZU8
         Xrl7GLUGk11deI135skB4OIxlJPHKgfLyJYeaqcPJS+NyWJN4YnV0YHCP4kzdU2PCqMf
         81Wcvupy9ieGpNqz70LdSvEzBPeNjvWX8vR85pn6HtnblRXZMk00LRvQL3KZ/i9c61h7
         VC91mwYZfDQbKTskVqO72ckAXizjrRJR2vuGVbKlLIwWjfctdYEBwoGPkDrzxKtPtCRM
         FW8A==
X-Gm-Message-State: APjAAAUV26ERdKZ4gzZSky4XEb1f5GpIlDeK77mNFOnBncAMiuR6V/W9
        mZcoSF/Vm625Dd3hSDPogJ4=
X-Google-Smtp-Source: APXvYqyZ9ryV2fgkgwxq6Jy0wCDHERJStpzKH2V61LNhYNzUlOc0c28ZwU59Bn+InI74kKUfUIlYHQ==
X-Received: by 2002:a65:510c:: with SMTP id f12mr7280369pgq.40.1553232182045;
        Thu, 21 Mar 2019 22:23:02 -0700 (PDT)
Received: from w-OptiPlex-7050 ([111.65.47.227])
        by smtp.gmail.com with ESMTPSA id r3sm17811303pgb.82.2019.03.21.22.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 22:23:01 -0700 (PDT)
Date:   Fri, 22 Mar 2019 13:22:55 +0800
From:   Solomon Tan <solomonbobstoner@gmail.com>
To:     mathieu.poirier@linaro.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, robert.walker@arm.com,
        acme@redhat.com, solomonbstoner@protonmail.ch
Subject: [PATCH v5] perf tools: Add missing case value
Message-ID: <20190322052255.GA4809@w-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following error was thrown when compiling `tools/perf` using OpenCSD
v0.11.1. This patch fixes said error.
```
  CC       util/intel-pt-decoder/intel-pt-log.o
  CC       util/cs-etm-decoder/cs-etm-decoder.o
util/cs-etm-decoder/cs-etm-decoder.c: In function
‘cs_etm_decoder__buffer_range’:
util/cs-etm-decoder/cs-etm-decoder.c:370:2: error: enumeration value
‘OCSD_INSTR_WFI_WFE’ not handled in switch [-Werror=switch-enum]
  switch (elem->last_i_type) {
  ^~~~~~
  CC       util/intel-pt-decoder/intel-pt-decoder.o
cc1: all warnings being treated as errors
```

Because `OCSD_INSTR_WFI_WFE` case was added only in v0.11.0, the minimum
required OpenCSD library version for this patch is no longer v0.10.0.

Signed-off-by: Solomon Tan <solomonbobstoner@gmail.com>
---
 tools/build/feature/test-libopencsd.c           | 4 ++--
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
index d68eb4fb40cc..2b0e02c38870 100644
--- a/tools/build/feature/test-libopencsd.c
+++ b/tools/build/feature/test-libopencsd.c
@@ -4,9 +4,9 @@
 /*
  * Check OpenCSD library version is sufficient to provide required features
  */
-#define OCSD_MIN_VER ((0 << 16) | (10 << 8) | (0))
+#define OCSD_MIN_VER ((0 << 16) | (11 << 8) | (0))
 #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
-#error "OpenCSD >= 0.10.0 is required"
+#error "OpenCSD >= 0.11.0 is required"
 #endif
 
 int main(void)
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index ba4c623cd8de..39fe21e1cf93 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -387,6 +387,7 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
 		break;
 	case OCSD_INSTR_ISB:
 	case OCSD_INSTR_DSB_DMB:
+	case OCSD_INSTR_WFI_WFE:
 	case OCSD_INSTR_OTHER:
 	default:
 		packet->last_instr_taken_branch = false;
-- 
2.19.1

