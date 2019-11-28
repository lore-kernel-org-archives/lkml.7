Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5917C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B91221739
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+pGVSDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfK1QvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:51:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41196 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfK1QuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:50:10 -0500
Received: by mail-pf1-f196.google.com with SMTP id s18so4810000pfd.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 08:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/CYFf1/fglZp7zKhC9PXoy9tsiufDFpWHrIfBoNpSeA=;
        b=j+pGVSDttH9jAktUOyITmB+U/zXlXzbNFhYXzCMcA9YJZsyvOI6ptywHmqwrnG657V
         ftZVMmSzBzBStJF3FvFBVguNBN8TxhFKRNxvT/m6XssDlhTd8hg+TyGWXhlsA0w59WrP
         BLzwMuPWzNVVol4FXSGqovGCtodZh3fUTlZJVirJH1GpmyUiwk+0m8+v5p2gzNNNGQxN
         mVFASCDxrO4X8ORdulic6AyyRWOS3GnWNQdBZiXZSvIY6OrBimlNOZiFKyoeAAResIxx
         qGIVd/cUVwNW2Qs4NUVrMmgeZSxr6+xP7wLPLbJt1DPDj/umY/SMhtsdLDi8QiGvAYMq
         kWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/CYFf1/fglZp7zKhC9PXoy9tsiufDFpWHrIfBoNpSeA=;
        b=rQwTDyBXETIc136J9O0fiiWDlVtAMdLTJ2O0hZrFARMiFIFUS2ZaVTi37N947mKSJm
         1gmb/v6rzKuq5HbAAoyBMw7TiOwnQOKoGsAyK1mhUuxHTgzQfnsQHe42OpVKSDxlro98
         5E87IiDSSBhPgtB6r/Rw47olX1QORUP4Vl7mAQYsJ/uQKoC0+6/IOSuYabLM2dNlT1Ib
         idVGbdKUMDc4gAaZyv8CTMOpmmeh60qqFvbX9yBhT9YqA0dB/AoEoUOsjQN3/1YEpEeP
         lXmPxDGKXy172h6YzhkwpD4M6dn9WQ34Pzy87mg/1HFKhaZAic/T9wxI5rIAFcLqgqux
         DWWQ==
X-Gm-Message-State: APjAAAUdz4awKQs/hkLOCVNaSJ8a9YIRnWH4yRyaigIeBVrh76kjexx3
        0/dXmEfVOPsT/Grj3bjXC04wIw==
X-Google-Smtp-Source: APXvYqzpKQyfQldmlacCexxAJBteAtozIdoLogYWnWundKX96otdtVJvtxFQ/5CTEI8XhLTF/bnfEg==
X-Received: by 2002:a63:f62:: with SMTP id 34mr11469684pgp.19.1574959810061;
        Thu, 28 Nov 2019 08:50:10 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a15sm2450343pfh.169.2019.11.28.08.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 08:50:09 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19][PATCH 06/17] remoteproc: fix rproc_da_to_va in case of unallocated carveout
Date:   Thu, 28 Nov 2019 09:49:51 -0700
Message-Id: <20191128165002.6234-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128165002.6234-1-mathieu.poirier@linaro.org>
References: <20191128165002.6234-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Pallardy <loic.pallardy@st.com>

commit 74457c40f97a98142bb13153395d304ad3c85cdd upstream

With introduction of rproc_alloc_registered_carveouts() which
delays carveout allocation just before the start of the remote
processor, rproc_da_to_va() could be called before all carveouts
are allocated.
This patch adds a check in rproc_da_to_va() to return NULL if
carveout is not allocated.

Fixes: d7c51706d095 ("remoteproc: add alloc ops in rproc_mem_entry struct")

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: stable <stable@vger.kernel.org> # 4.19
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index aa6206706fe3..af9d443e7796 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -183,6 +183,10 @@ void *rproc_da_to_va(struct rproc *rproc, u64 da, int len)
 	list_for_each_entry(carveout, &rproc->carveouts, node) {
 		int offset = da - carveout->da;
 
+		/*  Verify that carveout is allocated */
+		if (!carveout->va)
+			continue;
+
 		/* try next carveout if da is too small */
 		if (offset < 0)
 			continue;
-- 
2.17.1

