Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93718C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6611C21951
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996958;
	bh=PT6DfoSs+iQkViIua4q5ciViDMnsl3QPT8AElINdXBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nwK4RM3qgxwJfeMf6HQ0lew8MQq6S32ANyMKzxTrOK0RJItIwO4diE2mseklswEnm
	 Uw6HiAkRCEKRvQGPgSNdfCFMq5xAxQIw5FcJGLqT1WhoIM6MnNaEWAH3/Jj0SFidu6
	 UhaNGj+GrroLQbHQgD1KD8oU9zSWdJ0tJoGNXU+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388952AbfGXTf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:35:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388938AbfGXTfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:35:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D630E21951;
        Wed, 24 Jul 2019 19:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996954;
        bh=PT6DfoSs+iQkViIua4q5ciViDMnsl3QPT8AElINdXBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hJJwzQK0OC5eCMo9c49WbU9gKITuU2LUuzeuRrgtgF3D8mNCSY9BvmZDH339E/Hm0
         2vlQiS0E5eU7FJMm3szVL3TzVAZYFXHaEFoLD87tT+p947hu6pszqf6S+lrWpA8SwE
         xy2Zv0AnYWvS7b5Lyb/Aqrtde8aLVOx+w2q/enDY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cfir Cohen <cfir@google.com>,
        Gary R Hook <ghook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.2 273/413] crypto: ccp/gcm - use const time tag comparison.
Date:   Wed, 24 Jul 2019 21:19:24 +0200
Message-Id: <20190724191755.776712513@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cfir Cohen <cfir@google.com>

commit 538a5a072e6ef04377b180ee9b3ce5bae0a85da4 upstream.

Avoid leaking GCM tag through timing side channel.

Fixes: 36cf515b9bbe ("crypto: ccp - Enable support for AES GCM on v5 CCPs")
Cc: <stable@vger.kernel.org> # v4.12+
Signed-off-by: Cfir Cohen <cfir@google.com>
Acked-by: Gary R Hook <ghook@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccp/ccp-ops.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/crypto/ccp/ccp-ops.c
+++ b/drivers/crypto/ccp/ccp-ops.c
@@ -850,7 +850,8 @@ static int ccp_run_aes_gcm_cmd(struct cc
 		if (ret)
 			goto e_tag;
 
-		ret = memcmp(tag.address, final_wa.address, AES_BLOCK_SIZE);
+		ret = crypto_memneq(tag.address, final_wa.address,
+				    AES_BLOCK_SIZE) ? -EBADMSG : 0;
 		ccp_dm_free(&tag);
 	}
 


