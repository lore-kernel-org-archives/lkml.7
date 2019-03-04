Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F539C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34AA20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688121;
	bh=pTJnMxFllj7aTqqrTmxFu5Ok/d79jW3dFbd7EVTxdj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AmQAaIAVs2/RleevPjXMOmlarP+hXVw7Ben27zeYYfCzxInm0eNMs9qGVRkp/ye3k
	 wqO+QzGKc6rPJwM/670yglgqxrCQAv2E499kIVeMSf64RQTaEeDN9CbAKOKwLVZg1g
	 UaWF9PUmhwZBwbHE3VA9bp1iIn9OsrOhJ48dMYek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfCDI2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:28:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:53870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbfCDI2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:28:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E701220823;
        Mon,  4 Mar 2019 08:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688115;
        bh=pTJnMxFllj7aTqqrTmxFu5Ok/d79jW3dFbd7EVTxdj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WdMMyX897P1L58NSz7ceZk8D+ZpQnWJvzKGCee3003K2gYf7HIg3iRTXx8RAqvi35
         YulSZi9tyT4/6oYJG0Xmv8JcBlZ4id9f9KZsTPzcAA2b2aRjiVMEVrkgQnmPKF4rQA
         LfNOH6/ciKrH8TB4Bh63QwPY/QBvWXxJ9xkJ6lVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 08/78] ALSA: compress: prevent potential divide by zero bugs
Date:   Mon,  4 Mar 2019 09:21:51 +0100
Message-Id: <20190304081625.871784190@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 678e2b44c8e3fec3afc7202f1996a4500a50be93 ]

The problem is seen in the q6asm_dai_compr_set_params() function:

	ret = q6asm_map_memory_regions(dir, prtd->audio_client, prtd->phys,
				       (prtd->pcm_size / prtd->periods),
                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
				       prtd->periods);

In this code prtd->pcm_size is the buffer_size and prtd->periods comes
from params->buffer.fragments.  If we allow the number of fragments to
be zero then it results in a divide by zero bug.  One possible fix would
be to use prtd->pcm_count directly instead of using the division to
re-calculate it.  But I decided that it doesn't really make sense to
allow zero fragments.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/compress_offload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 26b5e245b0747..8b78ddffa509a 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -529,7 +529,8 @@ static int snd_compress_check_input(struct snd_compr_params *params)
 {
 	/* first let's check the buffer parameter's */
 	if (params->buffer.fragment_size == 0 ||
-	    params->buffer.fragments > INT_MAX / params->buffer.fragment_size)
+	    params->buffer.fragments > INT_MAX / params->buffer.fragment_size ||
+	    params->buffer.fragments == 0)
 		return -EINVAL;
 
 	/* now codec parameters */
-- 
2.19.1



