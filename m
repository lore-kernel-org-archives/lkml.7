Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B48EC4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D915320865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570124112;
	bh=MIecuNNRxGS+on9SL/GewOgrOrgNIMHtj3KVEuhl5CI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P18rFL4/cSThDx1HvchLfoxKgu/fvJXvz6Pf4YGVrD9wX7LwCIY630iNhqldr2UfG
	 I0prJooBlgRpyUms4ppfFykxRI1OI3CfJ6EMZ1J6Z+MZV7JMtQSJzapMYTpW2n5opN
	 7zS+flQHz8J5qHZgjKLNWAMM015c7T3ej6AQOu5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732766AbfJCQGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:06:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731884AbfJCQG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:06:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA39621783;
        Thu,  3 Oct 2019 16:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118788;
        bh=MIecuNNRxGS+on9SL/GewOgrOrgNIMHtj3KVEuhl5CI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yEm4br31E2jBUczQvkB6pwVViHoZQqqh+Sp66bHtV6HgSXc0eu/0JPH5zFFPaTj4J
         g5CY1Eqo4/G8rUUK0hayX5Aa6YtYyy/lbPtjWWtUd5XXPZ4yD3oZGtWPKik0bjlO+8
         YqCRs6G9akrYqyN6N5s7DUHX7LVbrxvr/3QucI1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 010/185] crypto: talitos - fix missing break in switch statement
Date:   Thu,  3 Oct 2019 17:51:28 +0200
Message-Id: <20191003154439.501588748@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 5fc194ea6d34dfad9833d3043ce41d6c52aff39a upstream.

Add missing break statement in order to prevent the code from falling
through to case CRYPTO_ALG_TYPE_AHASH.

Fixes: aeb4c132f33d ("crypto: talitos - Convert to new AEAD interface")
Cc: stable@vger.kernel.org
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/talitos.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -3043,6 +3043,7 @@ static int talitos_remove(struct platfor
 			break;
 		case CRYPTO_ALG_TYPE_AEAD:
 			crypto_unregister_aead(&t_alg->algt.alg.aead);
+			break;
 		case CRYPTO_ALG_TYPE_AHASH:
 			crypto_unregister_ahash(&t_alg->algt.alg.hash);
 			break;


