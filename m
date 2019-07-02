Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6D6C06511
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE97206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pqlvgy1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfGBRdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 13:33:04 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:56985 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBRdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 13:33:03 -0400
Received: by mail-pl1-f201.google.com with SMTP id o6so710660plk.23
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 10:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=owFzYWSiBQ36MNNsLRQ1/NX8lTAESlyxM0Stn+FRyAw=;
        b=Pqlvgy1xgR+IalADZQrC2d+jhjOW0aS0kwR02OkncMdn9aPTkF4X54v4YuIj8BVAch
         ty/DBW3mdGQnMCyrclkoz/mNkqvP+tiW7rx1p8mQoo2k3OqYgFA+9iflsan5jNUVCOZM
         gTjaHqFJkLnyRRtnABIMYkMCw2K4MBY6eeW5xNQwDoU5xp/MGurWlwlHPbN7WvLfGwdO
         bo/0y/ON4BFaYKtuMVNDzc/fjp9QE3VM4KnfEER2uoPG4SKVnR/g8ZPLkjXK+jd/CdGm
         2XwYtNDe4Y3RDA7yLGvVVkLWmuGjNcelhQ9XwX9AmxF4oFDVLKKI9tMR3ZRpcrDe4hBm
         TwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=owFzYWSiBQ36MNNsLRQ1/NX8lTAESlyxM0Stn+FRyAw=;
        b=kHzCVGACOI0l0UcgP83IDCn1hxfwfMg7HsmHUv85QllGWZ3qrTr6boHzd53XPNxb2H
         Qrr0MIwyuzJGxkXHkdcu3O/B7WnO+VsfrWz4O7Pn2qFdeiQQSj0s/fZCdvtF3MMWxMH1
         uD3ZuD3G/45lfBaDhue43dG0SUElJRG2DWM9Ka5Z4foDoy4CVpbfuuUNeI0Ss7UMr6zl
         eJe/eAfNXXlwCzPu/6pr8UvRRu5F11mJAyfzC6rYddRnQtEYcUiG8vC+k1aaLLSfKjhY
         89wvsGR4nZrwT7WF4Cjo2BpYhoY9jiXrQ8CBRxtHfoOxRaYhRaLv3cZkcM8oX42Xy/sB
         lrqA==
X-Gm-Message-State: APjAAAW9LfCVDWtvRR/XcFTS8u9RebTANbisLF6PhfLHFsHzHRpL0RBl
        wnMul4D2xjLF5WNhSd14ygzX9xk7
X-Google-Smtp-Source: APXvYqziFk7LQkhgENWbUatXtwaWbEKJ1pBu2us5QWs62+RjkrPO+tDfe3Dq131vOGL2aeWV0d6B7y+q
X-Received: by 2002:a65:5a44:: with SMTP id z4mr18488037pgs.41.1562088782664;
 Tue, 02 Jul 2019 10:33:02 -0700 (PDT)
Date:   Tue,  2 Jul 2019 10:32:56 -0700
Message-Id: <20190702173256.50485-1-cfir@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2] crypto: ccp/gcm - use const time tag comparison.
From:   Cfir Cohen <cfir@google.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Rientjes <rientjes@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Cfir Cohen <cfir@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid leaking GCM tag through timing side channel.

Fixes: 36cf515b9bbe ("crypto: ccp - Enable support for AES GCM on v5 CCPs")
Cc: <stable@vger.kernel.org> # v4.12+
Signed-off-by: Cfir Cohen <cfir@google.com>
---
 drivers/crypto/ccp/ccp-ops.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/ccp-ops.c b/drivers/crypto/ccp/ccp-ops.c
index db8de89d990f..633670220f6c 100644
--- a/drivers/crypto/ccp/ccp-ops.c
+++ b/drivers/crypto/ccp/ccp-ops.c
@@ -840,7 +840,8 @@ static int ccp_run_aes_gcm_cmd(struct ccp_cmd_queue *cmd_q,
 		if (ret)
 			goto e_tag;
 
-		ret = memcmp(tag.address, final_wa.address, AES_BLOCK_SIZE);
+		ret = crypto_memneq(tag.address, final_wa.address,
+				    AES_BLOCK_SIZE) ? -EBADMSG : 0;
 		ccp_dm_free(&tag);
 	}
 
-- 
2.22.0.410.gd8fdbe21b5-goog

