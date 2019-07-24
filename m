Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5760AC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3AD2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033843;
	bh=zQcjsPz9w6oUvjkZNUWQFrnvNiX/hs4lk5lTh3MC5KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PN4tK8e/8E5lTz49xBTPxMfeGq77fQRtHd1adxbiPijiE+CJJKryRkWfplNgW6Ogz
	 JZsdTBlp/1R8g8ioNi+OtSkC9XtzIleGfoUDZGq0Y730fOuvrqXUoAO/nucbfu4iaM
	 cIIF5bhtPE8KaAZEsrcOg2w2HFLLzB8untkR1ysI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfGYFul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390890AbfGYFmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:42:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0259B22CD3;
        Thu, 25 Jul 2019 05:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033355;
        bh=zQcjsPz9w6oUvjkZNUWQFrnvNiX/hs4lk5lTh3MC5KQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U2hiqNUjtbjYjj9taSOi3ZvxnCl51X5rm/icNev4NTm3kA+xlrjYqYEHCaAOCm5MS
         9KkDXuvlJ6uTsSDVs+PAUAJk8gNvabEFd1kFcGe4p25nTJdKCVWm+Ei2DQL9U9XAYf
         2ctcV4InfNyU6kuQGZUK+22G7ko8mUnJMDkj1dRU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gary R Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 180/271] crypto: ccp - memset structure fields to zero before reuse
Date:   Wed, 24 Jul 2019 21:20:49 +0200
Message-Id: <20190724191710.565637571@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hook, Gary <Gary.Hook@amd.com>

commit 20e833dc36355ed642d00067641a679c618303fa upstream.

The AES GCM function reuses an 'op' data structure, which members
contain values that must be cleared for each (re)use.

This fix resolves a crypto self-test failure:
alg: aead: gcm-aes-ccp encryption test failed (wrong result) on test vector 2, cfg="two even aligned splits"

Fixes: 36cf515b9bbe ("crypto: ccp - Enable support for AES GCM on v5 CCPs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Gary R Hook <gary.hook@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccp/ccp-ops.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/crypto/ccp/ccp-ops.c
+++ b/drivers/crypto/ccp/ccp-ops.c
@@ -625,6 +625,7 @@ static int ccp_run_aes_gcm_cmd(struct cc
 
 	unsigned long long *final;
 	unsigned int dm_offset;
+	unsigned int jobid;
 	unsigned int ilen;
 	bool in_place = true; /* Default value */
 	int ret;
@@ -663,9 +664,11 @@ static int ccp_run_aes_gcm_cmd(struct cc
 		p_tag = scatterwalk_ffwd(sg_tag, p_inp, ilen);
 	}
 
+	jobid = CCP_NEW_JOBID(cmd_q->ccp);
+
 	memset(&op, 0, sizeof(op));
 	op.cmd_q = cmd_q;
-	op.jobid = CCP_NEW_JOBID(cmd_q->ccp);
+	op.jobid = jobid;
 	op.sb_key = cmd_q->sb_key; /* Pre-allocated */
 	op.sb_ctx = cmd_q->sb_ctx; /* Pre-allocated */
 	op.init = 1;
@@ -816,6 +819,13 @@ static int ccp_run_aes_gcm_cmd(struct cc
 	final[0] = cpu_to_be64(aes->aad_len * 8);
 	final[1] = cpu_to_be64(ilen * 8);
 
+	memset(&op, 0, sizeof(op));
+	op.cmd_q = cmd_q;
+	op.jobid = jobid;
+	op.sb_key = cmd_q->sb_key; /* Pre-allocated */
+	op.sb_ctx = cmd_q->sb_ctx; /* Pre-allocated */
+	op.init = 1;
+	op.u.aes.type = aes->type;
 	op.u.aes.mode = CCP_AES_MODE_GHASH;
 	op.u.aes.action = CCP_AES_GHASHFINAL;
 	op.src.type = CCP_MEMTYPE_SYSTEM;


