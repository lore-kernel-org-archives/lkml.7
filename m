Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E132C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 06:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5066120872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 06:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bujZ9xU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfERF7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 01:59:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33816 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfERF7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 01:59:51 -0400
Received: by mail-pl1-f193.google.com with SMTP id w7so4323369plz.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 22:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aS57w+JjSNQkH2rknXCc7Q22hExiMUTERsu/lABkOdw=;
        b=bujZ9xU5Tx6d78rQ1gOjR1lDe0mK19wzpmNpSVgHo3HwkMdDaChHxoavIJFLDByJg+
         MVLIrbIhCTBiQTzL6Pj4utmWdppNmXnyOmX/MOcc4gip/NJ9hTILgM8rdcDbfxCy4jhZ
         ppYqHwBe+SGYLjFC8s8LZ5gy7zO/X3E6KMENM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aS57w+JjSNQkH2rknXCc7Q22hExiMUTERsu/lABkOdw=;
        b=fwLnkUIGqPfvZ8rUTkGgK0unjkzLYjVbgSIm3uvqZ2NurU3CAauJZCq1ZjFw93NRZM
         ozQEbYlzEGtvc2lQvpMq5c+Yw7gzSMIiPyxMkugTjnAihdyDN6dF3j4x4mXi04ZCICtm
         Azjc6AY040lUxwDNSRw7TjE+V0uFXiTuVHRnZfl504/1Mo43LHK+DROPtMmz4KwBP7S1
         S98LPaa14zzs3BosNZQEwu40bH6D8jJdE9oqxoiQY6c8DeNQE/4oM2UuPKdOgjyWYBJe
         ovNkMqPW3ylU7YNOsy0pShTFEkoiY/BtDY+xNXtZPCEVq2JTlNKy/RMGCvNcShv6Rcvb
         xJrA==
X-Gm-Message-State: APjAAAUY1wUxPgRaHHLeqDG/MlC18yt6C6fZafpY5ALXhwdxN7k9GiZr
        2Xf1eEgGaeVcm8FQF0aYiPI5Gw==
X-Google-Smtp-Source: APXvYqzsVqvky95IbCzBSeQtEr5Xjf/A4aknBtRLNER/MPoGiXfE7gaygm3JAAaxM/qKF+MvL3ioKw==
X-Received: by 2002:a17:902:2e83:: with SMTP id r3mr46277325plb.139.1558159191105;
        Fri, 17 May 2019 22:59:51 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id j12sm11599940pff.148.2019.05.17.22.59.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 22:59:50 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/decode_stacktrace: Match basepath using shell prefix operator, not regex
Date:   Sat, 18 May 2019 13:59:46 +0800
Message-Id: <20190518055946.181563-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The basepath may contain special characters, which would confuse
the regex matcher. ${var#prefix} does the right thing.

Fixes: 67a28de47faa8358 ("scripts/decode_stacktrace: only strip base path when a prefix of the path")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

I'm not sure how people normally use this script, but this seems to break
even with a simple full path as parameter (e.g. /home/.../kernel/).

 scripts/decode_stacktrace.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index bcdd45df3f5127a..e042acedcc0332c 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -85,7 +85,7 @@ parse_symbol() {
 	fi
 
 	# Strip out the base of the path
-	code=${code//^$basepath/""}
+	code=${code#$basepath/}
 
 	# In the case of inlines, move everything to same line
 	code=${code//$'\n'/' '}
-- 
2.21.0.1020.gf2820cf01a-goog

