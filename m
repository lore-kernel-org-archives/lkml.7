Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9343C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C802086A
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765681;
	bh=igNzxv6Hh1bfS9Yen3GU42DNBAOjWDN0ZfkeRh5KStc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aLV3Eu2kKxQmtcylQir1CyY1HbD7F/8go3aVqk4iC85M8QqYv8QFHCiRQBQa1Ehk/
	 ZCMzXjczWzGM0uEMH0wijcWuTX2PsGVyV51ttinwvfRQoHtoVhy2VyF5p4tAJL0XjN
	 9Xi5r0YNsCxi1G2wHoZ6IltzWNYC5lMSAnNLhGS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbfI2OBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 10:01:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730010AbfI2OBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 10:01:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E2702082F;
        Sun, 29 Sep 2019 14:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765677;
        bh=igNzxv6Hh1bfS9Yen3GU42DNBAOjWDN0ZfkeRh5KStc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ip4/rMUjrsdn08iwq455yIN67pKlWj10lF2ObIByiBnxJQBmy4DDwclCvnvByroLm
         RSoeHfPMTCwsaBJmIOrT4GQp9FfZdExxWAn2TJ/YkmzEBZStPc1ZHAzsb1Nzp5Lpz+
         0mjwqmjyx/8oUGSLBDgCRmEFCO0vSZXHrVAgQewQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.2 19/45] crypto: talitos - fix missing break in switch statement
Date:   Sun, 29 Sep 2019 15:55:47 +0200
Message-Id: <20190929135030.284207271@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929135024.387033930@linuxfoundation.org>
References: <20190929135024.387033930@linuxfoundation.org>
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
@@ -3190,6 +3190,7 @@ static int talitos_remove(struct platfor
 			break;
 		case CRYPTO_ALG_TYPE_AEAD:
 			crypto_unregister_aead(&t_alg->algt.alg.aead);
+			break;
 		case CRYPTO_ALG_TYPE_AHASH:
 			crypto_unregister_ahash(&t_alg->algt.alg.hash);
 			break;


