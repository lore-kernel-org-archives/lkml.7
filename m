Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B99C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 21:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851EE20873
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 21:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aYMTEae7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbfERVAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 17:00:55 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:34850 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbfERVAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 17:00:55 -0400
Received: by mail-it1-f193.google.com with SMTP id u186so17424700ith.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 14:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9fOLiRqWBUpYnlZub/rhVPd8bsOux5KQfu9ZRSShNRI=;
        b=aYMTEae73webdQYbt0Mng0wPe52e1WpMisbAlBM88jo1kVSG8VNx4iiCT2qsekSEfG
         lk08kKf/gbUkZ9NgQMfKlsWMO+4vVLcDWgNrAgMo5ITUU8P+rMSikTiCxAHGXzWGpPhi
         fBvXezyghQpyU00JA+cg7RQQADPZQy1wCrAmu6gYyAMRBJjeLMR4+0Nm88ZpsunO2wu3
         4XGvGi8aEsYyZeIKVISbDc5J3v75TuW+NaQpNsGv8sTMWEeXD4rOIrzJ03HJgJmdZQAV
         pSgu2D1K64JBjRHO05zZtqL1ggBx0i+s9e4TI3V6X52kNK4M4499d/G3t73gujwrPbRh
         2G5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9fOLiRqWBUpYnlZub/rhVPd8bsOux5KQfu9ZRSShNRI=;
        b=LAUUM+4xvmWasRAmJFAWg+m/0fdn3BYd/MdXeDZJs7ba3yRYURf7+8AEVTiCI9gJVX
         VJxbyI9BgTa6Lv4ys0v8A5L3CxPYEgTnZ7LAciEbD71ZcZvgIDcKRc8ZnutklpQW5Zxb
         kz2Nmn0cSe0HbSEiQWbS+qAHXHH13Bw4WBT065UiN8uVmuZyKfuDxaW4H/AYpxl+qo1D
         R+DdoH51kJ9saIpI7NKf1WBfnaPGa6BXjof+H7P/PvgixyhZx1l37IrU8FH5DarscQVE
         jeK9wK7YCZsrUkAEbh3ScKoJm0QxSwZF8vaFr7mE3QKZL+Ysjm/jIk/vKIDEgemcExuC
         xAHQ==
X-Gm-Message-State: APjAAAUQO0ZP3eS5n2AiaPngyPyqgiJcCt17L96dH1M2vsj/lPh8ZUUO
        7CXTC4mHJu05X3d4j+rMlOQ09cvfd0A=
X-Google-Smtp-Source: APXvYqw1R6j1kBeWguTOcJlF2BF2+mGMX/V5QI5qOj8o1dLxkfHinybt+vdMuaQotKPnFL4R2vNB/g==
X-Received: by 2002:a02:c88d:: with SMTP id m13mr44253281jao.63.1558213254349;
        Sat, 18 May 2019 14:00:54 -0700 (PDT)
Received: from viisi.lan (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id f1sm4107284iop.53.2019.05.18.14.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 14:00:53 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] scripts/spelling.txt: drop "sepc" from the misspelling list
Date:   Sat, 18 May 2019 14:00:38 -0700
Message-Id: <20190518210037.13674-1-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V architecture has a register named the "Supervisor Exception
Program Counter", or "sepc".  This abbreviation triggers
checkpatch.pl's misspelling detector, resulting in noise in the
checkpatch output.  The risk that this noise could cause more useful
warnings to be missed seems to outweigh the harm of an occasional
misspelling of "spec".  Thus drop the "sepc" entry from the
misspelling list.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 scripts/spelling.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 86b87332b9e5..5ae83ce31902 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -1145,7 +1145,6 @@ senarios||scenarios
 sentivite||sensitive
 separatly||separately
 sepcify||specify
-sepc||spec
 seperated||separated
 seperately||separately
 seperate||separate
-- 
2.20.1

