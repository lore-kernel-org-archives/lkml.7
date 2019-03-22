Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A265CC10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722B22183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259001;
	bh=cjtv8OCNeu5A2apGaX5+iEBd8qIVZPoMtrrcBU3k2fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l1XIGOW41kEKNres6MxB2OhFqL7adzT5I3Yqk/xXwI2sFwNXwXR6ZcMqq42Qim0lT
	 CxalkM4wn1F43X/cCkVIiTgnUeo+lXk5OJxU08zpd/nNc/cdNn0b/OEb2Q8c1+j9MR
	 vtHqrbEsAdvuGA4hNfvoxqe0FE0PUEWIDnC7/oJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733174AbfCVMt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:49:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:32768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733000AbfCVL4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:56:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DCB820850;
        Fri, 22 Mar 2019 11:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255777;
        bh=cjtv8OCNeu5A2apGaX5+iEBd8qIVZPoMtrrcBU3k2fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=quW3wyKuX0X2V0pVYOX6w72Gusy/73IdVrG/4QHJCIrW0EglmsbcqeF3tYdMn0sNv
         oKERcaqTImJs8RZDkwaLB9sDfI1B74q/C0s8KLRwiaq5XVoPgeq54WH39C3v4NX8/q
         si+qi4ZfMaRHfF5qUzdCfPt6J1YRcK8hjfuhHGE4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 012/280] crypto: ccree - fix missing break in switch statement
Date:   Fri, 22 Mar 2019 12:12:45 +0100
Message-Id: <20190322111306.998764187@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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
@@ -79,6 +79,7 @@ static int validate_keys_sizes(struct cc
 		default:
 			break;
 		}
+		break;
 	case S_DIN_to_DES:
 		if (size == DES3_EDE_KEY_SIZE || size == DES_KEY_SIZE)
 			return 0;


