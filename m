Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1764C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C969620840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pMjDtZJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfCGKNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:13:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39941 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfCGKNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:13:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id y6so1563337wrn.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 02:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QZXoHVQPaXkLWzJQl44F85OjDTIH9iGYQGdOEpv6nuY=;
        b=pMjDtZJPJQTw0RSw2Ka5bahtRkfV765FB9eL2raft0YXUfyRD7NI7HsQwp3PwWVC8z
         5PH6MjR3S88X8GTvDCApUmoebrLIHWKhVliVHwPxFsvxG0V0nfpbok5UKiL3faQZ2DQC
         OjpxtrGMQI7yoXR2KW2LqFxn7YTiSenp6jyMkxYDt4OgvLBJe3a1fWJp9EskU2WBtjz0
         1dnocfoXzTm9I1CBCzj0Xu5N6W5KmXFppVhQZ83lC0q4CwXyAFGIyshkgdRkB4QBm+OZ
         ZeXUqREKk2Dew0l0wtcnMTSWxR7V4+8CiB5UFbdZrGsq/t1YvfDTmOOIRFfROBXDRpvv
         OnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QZXoHVQPaXkLWzJQl44F85OjDTIH9iGYQGdOEpv6nuY=;
        b=XHUM1c/+J1paIJoekdhoB/h1UA6KeAYJ8MC9sdsiVxdrOKf/SPPrPzJf9I5ASKFvYW
         wyCdVt0rbEmaGgCPsar3k7IykW0doU+hkZpBkGXUSSiMfE+RqH6ZLIs/Zk7+n0rUrBba
         rm3a+k1wQKVr51o6Otyzg+Q69Ag2vOtbLAyAcPjNJDKIe1MUCUDG2Rg/XHA0HmY1YAMz
         tcQvV7D+B8ZyYkteLBXIKkS9DK/4VK8okyf43SKkDApR3TvzQe0ZBcYxDBI6g4vCVtTg
         04w7XIzj6XpXxQ4zQZbpoOS1UgxS1zAdoj6qm7ZTKGTDvX57SQaDwymmEKn75EGUb9H0
         gG/A==
X-Gm-Message-State: APjAAAUttM8XGCELyERtzNgNkQO44thkWwBTRXUe0m+xAj0ukkX5AfkI
        LtBSMBQdAfvk7qQ0p5Zqrr24TA==
X-Google-Smtp-Source: APXvYqz4Ggk2/O9AqhkyOf9PaIXn0uj8rpHJ9fnQ9niz7Q6qfMPooJBq9iY1R/aaJTXwO6e4mwvXpA==
X-Received: by 2002:a5d:690d:: with SMTP id t13mr6067865wru.135.1551953600131;
        Thu, 07 Mar 2019 02:13:20 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id n9sm3529767wmi.33.2019.03.07.02.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 02:13:19 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        ktadakam@qti.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/8] misc: fastrpc: consider address offset before sending to DSP
Date:   Thu,  7 Mar 2019 10:12:26 +0000
Message-Id: <20190307101229.7856-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190307101229.7856-1-srinivas.kandagatla@linaro.org>
References: <20190307101229.7856-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While passing address phy address to DSP, take care of the offset
calculated from virtual address vma.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f71b5faae1dd..209f3e63f660 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -679,8 +679,16 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 		pages[i].size = roundup(len, PAGE_SIZE);
 
 		if (ctx->maps[i]) {
+			struct vm_area_struct *vma = NULL;
+
 			rpra[i].pv = (u64) ctx->args[i].ptr;
 			pages[i].addr = ctx->maps[i]->phys;
+
+			vma = find_vma(current->mm, ctx->args[i].ptr);
+			if (vma)
+				pages[i].addr += ctx->args[i].ptr -
+						 vma->vm_start;
+
 		} else {
 			rlen -= ALIGN(args, FASTRPC_ALIGN) - args;
 			args = ALIGN(args, FASTRPC_ALIGN);
-- 
2.21.0

