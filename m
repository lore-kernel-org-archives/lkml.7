Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD78C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E3621880
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033364;
	bh=GWlPhUNbVExvvTQJxLHAIfvmtR2eDbAuMFv4BJ3d6Xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ylH+UmU3zCns9JB0ZnutRA8MORyELR0CaDyHSG27/MNWZDuqYthO80QTAT0CBq1Vi
	 xhBDftG2ZxDlpvnz61i1RSi1alEhiEHOM0YIkin8r/BZohQSc7nwSBz/VY2ziS+XCE
	 2j2dScc/JJyg4XbQRcr1Celc5uR/GiZUxkBO7nyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390921AbfGYFml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:42:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390887AbfGYFmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:42:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E12521850;
        Thu, 25 Jul 2019 05:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033358;
        bh=GWlPhUNbVExvvTQJxLHAIfvmtR2eDbAuMFv4BJ3d6Xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TyAn5/qVcCrWOW04JvrrJRufST7mooCrFTaI+PFtlMstdFPTrnUcUPGYkWMWsJGgZ
         7cgV7i6qgpvANHl4iqxhrE6bpRBcHx9gV3qmhXnlkmXbvg/MIGqO4bigc5kNTddV0W
         eSdHcosaRdxSv9YT6PHIv/Vi2mqb9RyNDbrzsOvY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cfir Cohen <cfir@google.com>,
        Gary R Hook <ghook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 181/271] crypto: ccp/gcm - use const time tag comparison.
Date:   Wed, 24 Jul 2019 21:20:50 +0200
Message-Id: <20190724191710.650102308@linuxfoundation.org>
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
 


