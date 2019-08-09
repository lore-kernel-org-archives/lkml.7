Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35ACC32756
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6302171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnGtnDam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405729AbfHIHKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 03:10:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36122 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405239AbfHIHKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 03:10:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so45390767pgm.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 00:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AfFInu/BKl5gok1YyMJiKglvG/hgOvmiC2oJHUZbiVA=;
        b=qnGtnDamMWxXkDvOfVvqZyiG6ESs3LPrdiIFipKW0wSvRvybAaPD6u37c/y+Acoxl5
         WcyXF6qUzNvxq9ql7r5zVsKIrKNF6L629QOCJF+cMyfo8LL+m4L+kas/k9Z4REFndMw9
         Ma/5yipfNJ0LrB5NNa4xGgCzqc3BNHGZ8C5CBQ6nKC5fULk8MJgDqoc6WSVQMGUTLNIi
         RWKkW5eTgoovXCx8d2pLjD4muWZYJdK4s1gfk+sDHLMVec5Zam0ER72GybKZGyuhS8KD
         W8ovG9Oe+OzKUSVXog6pgZmJDGg26HIq7jDbIxKADkCXHo0pjEpkXFluSrfOGAjLTkPv
         H4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AfFInu/BKl5gok1YyMJiKglvG/hgOvmiC2oJHUZbiVA=;
        b=E3sv1wYDqfcYec56wLV4GPG697MMsWQTxIE7xU8o/xiMgmTSX6mH0lMoH/q9iCBktc
         b0Q31Wg01Ofej7kzoxmq2Ffa5mw72q2/RO7Xzjfugjg9nJcmKfMgAKXtelSF3qCmjOFm
         3TUS75LX79trgw3leBZqZL9Qmmd2Hse478UCuqsCrFKhsR1HAAWHjv/79ww6sRlSTa4N
         IsOtW6bfUMyWqYTBlE8z8qJH3wHeZDI1BZAXOt0InmCzRPQfBxaDgD4EGDBZQt+no4Pw
         8dDBfdqdHgNlHZVIOe3nYZ860k+gTQFAupZtaA8za9PRPAiAVep+5UyJjcmnr0mBWJIR
         xBhQ==
X-Gm-Message-State: APjAAAW4iQPRXr9SMUhudrg3EUmvWo5q8MbKjSgkQ/CRR0kxTQ5RO1mG
        Z45ZsB8ku6Zm+yK0w0ADzXA=
X-Google-Smtp-Source: APXvYqyCJqVbpv6emN3HFwU1RDjesGU99ywfAwLyfs9TJwWgVvpkgL6a+uXlTNL0WPBQjy2+H6017g==
X-Received: by 2002:a62:1444:: with SMTP id 65mr19563170pfu.145.1565334614339;
        Fri, 09 Aug 2019 00:10:14 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id w4sm120886334pfn.144.2019.08.09.00.10.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 00:10:13 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v4 1/8] dma: debug: Replace strncmp with str_has_prefix
Date:   Fri,  9 Aug 2019 15:10:09 +0800
Message-Id: <20190809071009.17114-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncmp(str, const, len) is error-prone because len
is easy to have typo.
The example is the hard-coded len has counting error
or sizeof(const) forgets - 1.
So we prefer using newly introduced str_has_prefix()
to substitute such strncmp to make code better.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 kernel/dma/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 099002d84f46..0f9e1aba3e1a 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -970,7 +970,7 @@ static __init int dma_debug_cmdline(char *str)
 	if (!str)
 		return -EINVAL;
 
-	if (strncmp(str, "off", 3) == 0) {
+	if (str_has_prefix(str, "off")) {
 		pr_info("debugging disabled on kernel command line\n");
 		global_disable = true;
 	}
-- 
2.20.1

