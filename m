Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5946C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA1320675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355208;
	bh=qi3DML8mlDtblN7UzD5EbLiMc/EJcxvDlyuGK638yVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oNI0G60y4FnEPfAc3Ud+CrHPaT9qhISn2qugmYAG7Z42BJ1LxNf1Pbkdd9CGflSKJ
	 ykWWwD8nYZKsC4XR9FX5OlcGkeg/ffodALlvHGJWRSa8y5oFKUJQtxyvMl78DSDyB9
	 8sE5lOilBz//2y1vIemdaumHRkCfb4cVlYrHiIyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389358AbfETM0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:26:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389344AbfETM0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:26:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85B0020815;
        Mon, 20 May 2019 12:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355202;
        bh=qi3DML8mlDtblN7UzD5EbLiMc/EJcxvDlyuGK638yVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0m1Olg0hJZpMdfjwJIuRrxuWbB9s08G5dfPYYuQbu/fU5UUbhMCAqD9vLAx0Ji5GL
         CzbOpkFYmSK8ZF4D+ytRKbXUp1U7ogwIeP+zsPFVTGJeyqMOgl3/R611O+PlCr5fgz
         jLXDwGVWHq2KIF7R/N5iZM7ruxj3dAZUbMWZATFM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Willi <martin@strongswan.org>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.0 030/123] crypto: chacha20poly1305 - set cra_name correctly
Date:   Mon, 20 May 2019 14:13:30 +0200
Message-Id: <20190520115246.776602032@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115245.439864225@linuxfoundation.org>
References: <20190520115245.439864225@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 5e27f38f1f3f45a0c938299c3a34a2d2db77165a upstream.

If the rfc7539 template is instantiated with specific implementations,
e.g. "rfc7539(chacha20-generic,poly1305-generic)" rather than
"rfc7539(chacha20,poly1305)", then the implementation names end up
included in the instance's cra_name.  This is incorrect because it then
prevents all users from allocating "rfc7539(chacha20,poly1305)", if the
highest priority implementations of chacha20 and poly1305 were selected.
Also, the self-tests aren't run on an instance allocated in this way.

Fix it by setting the instance's cra_name from the underlying
algorithms' actual cra_names, rather than from the requested names.
This matches what other templates do.

Fixes: 71ebc4d1b27d ("crypto: chacha20poly1305 - Add a ChaCha20-Poly1305 AEAD construction, RFC7539")
Cc: <stable@vger.kernel.org> # v4.2+
Cc: Martin Willi <martin@strongswan.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Martin Willi <martin@strongswan.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/chacha20poly1305.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/crypto/chacha20poly1305.c
+++ b/crypto/chacha20poly1305.c
@@ -645,8 +645,8 @@ static int chachapoly_create(struct cryp
 
 	err = -ENAMETOOLONG;
 	if (snprintf(inst->alg.base.cra_name, CRYPTO_MAX_ALG_NAME,
-		     "%s(%s,%s)", name, chacha_name,
-		     poly_name) >= CRYPTO_MAX_ALG_NAME)
+		     "%s(%s,%s)", name, chacha->base.cra_name,
+		     poly->cra_name) >= CRYPTO_MAX_ALG_NAME)
 		goto out_drop_chacha;
 	if (snprintf(inst->alg.base.cra_driver_name, CRYPTO_MAX_ALG_NAME,
 		     "%s(%s,%s)", name, chacha->base.cra_driver_name,


