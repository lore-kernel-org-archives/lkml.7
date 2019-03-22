Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C521FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910BD2195D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256713;
	bh=S47NSWzpzWBygLdfIQbBL5muhP+weMDCZtgmVTXy71U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YRuM1eoNBugmLNvR3MsscTaeGp/NdqtpalfWNEsPKNDz0KShj5cMIx8x5RJz2tfPz
	 dIIVW8MiUZB96zWf4T8LzRUD/5MaGNN8oAsqEzNE7zpfQIxCrmZmzvKZFrmvERYc3R
	 Ea9gtHVXp1z/ee5MOC3ajfM1iiFFSeGpL06OTqzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389419AbfCVMLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:11:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389553AbfCVMLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:11:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACD9A2083D;
        Fri, 22 Mar 2019 12:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256706;
        bh=S47NSWzpzWBygLdfIQbBL5muhP+weMDCZtgmVTXy71U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ip3/eKccI9/2L7o9OmTsKyuq69kBe9dIMvYko2IVeJ+4ksyXgO122aTEEjDBX/PKO
         UuWphRlRpo3DXDhU10rCYpgETpILFZAxKFTxeKmpr/rkVupX2ABdrSX268+qFydHlE
         dNd7Mu1BG7l4rB1bLqk4djsNx981+Vg6uzJaFZ9Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.0 013/238] crypto: ccree - fix missing break in switch statement
Date:   Fri, 22 Mar 2019 12:13:52 +0100
Message-Id: <20190322111259.012590292@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit b5be853181a8d4a6e20f2073ccd273d6280cad88 upstream.

Add missing break statement in order to prevent the code from falling
through to case S_DIN_to_DES.

This bug was found thanks to the ongoing efforts to enable
-Wimplicit-fallthrough.

Fixes: 63ee04c8b491 ("crypto: ccree - add skcipher support")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccree/cc_cipher.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -80,6 +80,7 @@ static int validate_keys_sizes(struct cc
 		default:
 			break;
 		}
+		break;
 	case S_DIN_to_DES:
 		if (size == DES3_EDE_KEY_SIZE || size == DES_KEY_SIZE)
 			return 0;


