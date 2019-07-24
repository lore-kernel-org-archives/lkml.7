Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92046C76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC7B217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998119;
	bh=GWlPhUNbVExvvTQJxLHAIfvmtR2eDbAuMFv4BJ3d6Xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WnmJCuOMqG5MYYeAf21hH20ePTO7/Uml0WF/qvMdyTww2GWFDgpGjfv8E0eN9ba7a
	 QM2yHzjyDX7qo+ON8AYrsfboXuM0unz2gM2c2p/qE3PRsylvq7zb3Yx/To/SQMJKKA
	 w8L+q2UVAUtICwMHC7fhKCd0ckWC4oDhqIs7FxQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391851AbfGXTzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391745AbfGXTzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:55:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A9D220665;
        Wed, 24 Jul 2019 19:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998114;
        bh=GWlPhUNbVExvvTQJxLHAIfvmtR2eDbAuMFv4BJ3d6Xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QuKDD/H7Gq1FXzNWVFS2x/Pr4DLyLjBSqtGFHIOm9VWd9GsM/z9ICZeHZiGslBSKi
         c2Pfa/hs9IqVxKUpwBduHp8+LFI7+2u9o6OswOCKDox5SkCsgC81Tsjp6NB9jR2wxo
         8hfqeiAW4Lb+f+OzxA5XAZe6r96U8/+RTEX7G7QM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cfir Cohen <cfir@google.com>,
        Gary R Hook <ghook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.1 249/371] crypto: ccp/gcm - use const time tag comparison.
Date:   Wed, 24 Jul 2019 21:20:01 +0200
Message-Id: <20190724191743.436078558@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
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
@@ -853,7 +853,8 @@ static int ccp_run_aes_gcm_cmd(struct cc
 		if (ret)
 			goto e_tag;
 
-		ret = memcmp(tag.address, final_wa.address, AES_BLOCK_SIZE);
+		ret = crypto_memneq(tag.address, final_wa.address,
+				    AES_BLOCK_SIZE) ? -EBADMSG : 0;
 		ccp_dm_free(&tag);
 	}
 


