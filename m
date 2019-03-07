Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C76C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAF820835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MyY/T+4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfCGKNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:13:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34631 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfCGKNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:13:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id o10so6364248wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 02:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FPxNdvt+kGcCG8uzNQ9lroy0iRhdBt0KuB6zFefUSXk=;
        b=MyY/T+4heOH9NyLJAPUtf+h+tOOTQ8w5lyCiHswAOkciuxnZZ6cy4xY5fRJAIrbjih
         Xp54rf/2Zv++De+fDp4m9fGyqICPYROXsUdk/YZoseajrB1xo4P2YMJtPYvsdF4F2Ui2
         39pm5ovfhNJokRMnByEP0I1o5wWOt8a2SRShhX7x29DT9G/5FZucynJqqJA+IbbMSxmJ
         HWljc38inYK6/Bm0k1Ig0UIBE0G48KLlHPWINZJS0p5Dbl59bHDsCQHfQblTwclFU6tJ
         Gjq6MplvHraf/q+8pEIAE4kMDPXOENrR85NTf7T7mAu8I/z9Dr8WcKSr1b8liB6QzeZR
         Twxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FPxNdvt+kGcCG8uzNQ9lroy0iRhdBt0KuB6zFefUSXk=;
        b=ZmEH10zK9bk36vaRrsHXvcKkgKgE/IwtXIsq0eb/PDYo/xdD9wgP+58OKZItJmG2ez
         aM7XMWYPB0EN5kVnQ7f9RH4suGnsx25b2898HXApNMDzA4IIkEx+++AJipJOAjZlNCyY
         b7XZPmbylC9Jc3XUhD/mDhfqgwHVit8LcaV0Y8zFN0ZzcRXgaV1KUORULnqdcK/bLNCM
         NGVc7rZtQ35wmx7bveVGoNM1hrlCE0ku46DrL3hwtmMcol5ZVXhnKJUVf7zxb0FoSglx
         ss8qd3wH4tbQhwXJ4GW7FwOHPpbLJNcteJ/nL4L9habVl7p+X91QVQkUkon6CZ3NATMD
         FySA==
X-Gm-Message-State: APjAAAUuAugCHdWjc9n1Ybb1dEE0lgr0iFAWiagGCG1G2VC1mglWhBJa
        3xdEvxtRZfJ9oodyfW3Ahak1YA==
X-Google-Smtp-Source: APXvYqyIc4wKrIBuiP1HgJ3aapQUwC47zh24QaW859GlrZr2bB+ott7Dgb9yKFprUDl42jBNuA1waQ==
X-Received: by 2002:a1c:a885:: with SMTP id r127mr5582093wme.74.1551953602372;
        Thu, 07 Mar 2019 02:13:22 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id n9sm3529767wmi.33.2019.03.07.02.13.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 02:13:21 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        ktadakam@qti.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 7/8] misc: fastrpc: fix remote page size calculation
Date:   Thu,  7 Mar 2019 10:12:28 +0000
Message-Id: <20190307101229.7856-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190307101229.7856-1-srinivas.kandagatla@linaro.org>
References: <20190307101229.7856-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remote page size should be calculated based on address and size, fix this!
Without this we will endup with one page less in cases where the buffer
is across 3 pages.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Reported-by: Krishnaiah Tadakamalla <ktadakam@qti.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 17bbb017bb08..d0e2e2620087 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -712,6 +712,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 	struct fastrpc_phy_page *pages;
 	int inbufs, i, oix, err = 0;
 	u64 len, rlen, pkt_size;
+	u64 pg_start, pg_end;
 	uintptr_t args;
 	int metalen;
 
@@ -751,8 +752,6 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 		if (!len)
 			continue;
 
-		pages[i].size = roundup(len, PAGE_SIZE);
-
 		if (ctx->maps[i]) {
 			struct vm_area_struct *vma = NULL;
 
@@ -764,6 +763,11 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 				pages[i].addr += ctx->args[i].ptr -
 						 vma->vm_start;
 
+			pg_start = (ctx->args[i].ptr & PAGE_MASK) >> PAGE_SHIFT;
+			pg_end = ((ctx->args[i].ptr + len - 1) & PAGE_MASK) >>
+				  PAGE_SHIFT;
+			pages[i].size = (pg_end - pg_start + 1) * PAGE_SIZE;
+
 		} else {
 
 			if (ctx->olaps[oix].offset == 0) {
@@ -782,6 +786,9 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 					(pkt_size - rlen);
 			pages[i].addr = pages[i].addr &	PAGE_MASK;
 
+			pg_start = (args & PAGE_MASK) >> PAGE_SHIFT;
+			pg_end = ((args + len - 1) & PAGE_MASK) >> PAGE_SHIFT;
+			pages[i].size = (pg_end - pg_start + 1) * PAGE_SIZE;
 			args = args + mlen;
 			rlen -= mlen;
 		}
-- 
2.21.0

