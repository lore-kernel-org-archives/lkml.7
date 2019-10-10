Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6F8C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F4C2190F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697125;
	bh=+ziAXTDsobAVyPGnV9cjpxWdeSyfaxpVevwpVRrRxBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=odo87roRcMCYegkXm52gzLDqp7SDXF0nioHTC92ibyl9JABwYm3iYC/7DAJhMP/eu
	 8u2ky32OUT/1SXUICo1HCuGZyn9Z0nLsSDM4Hac2QWu2684+r6DlPX5Y0TUCfLwEyF
	 dYgBp82opTJtc5YThePjNC24wvUy0hOT3Xwxzovk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389125AbfJJIpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:45:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389123AbfJJIpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:45:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 827E921A4A;
        Thu, 10 Oct 2019 08:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697122;
        bh=+ziAXTDsobAVyPGnV9cjpxWdeSyfaxpVevwpVRrRxBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GA7uD6YA8BupOk4XpI2BQxBRgD6rkD1B5k0bj3BEAs0r+DDgb40x9ACiG+kmbBwug
         mB5Dpggfbqez0GGV+g5x/4E6ePhn9jwWNSFEEclGYsDdGkLysxmrOHKWmg18lkYNoJ
         zdOfC4K+oW2D4EXd6H7xqcjztLCjI1n7zFOfrrNU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 026/114] crypto: ccree - use the full crypt length value
Date:   Thu, 10 Oct 2019 10:35:33 +0200
Message-Id: <20191010083556.445175875@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083544.711104709@linuxfoundation.org>
References: <20191010083544.711104709@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gilad Ben-Yossef <gilad@benyossef.com>

commit 7a4be6c113c1f721818d1e3722a9015fe393295c upstream.

In case of AEAD decryption verifcation error we were using the
wrong value to zero out the plaintext buffer leaving the end of
the buffer with the false plaintext.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Fixes: ff27e85a85bb ("crypto: ccree - add AEAD support")
CC: stable@vger.kernel.org # v4.17+
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccree/cc_aead.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/ccree/cc_aead.c
+++ b/drivers/crypto/ccree/cc_aead.c
@@ -227,7 +227,7 @@ static void cc_aead_complete(struct devi
 			/* In case of payload authentication failure, MUST NOT
 			 * revealed the decrypted message --> zero its memory.
 			 */
-			cc_zero_sgl(areq->dst, areq_ctx->cryptlen);
+			cc_zero_sgl(areq->dst, areq->cryptlen);
 			err = -EBADMSG;
 		}
 	} else { /*ENCRYPT*/


