Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55704C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2548C21909
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126287;
	bh=nWSw3dpRfrh23uz92UnFunuYPReheyzgcl9q1cC91BM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y0BuR9UyXW8Y+ECdXEctCKsdM6i/eqrsSXeFqeQJdQel37i10XhceMiLFBA1LTw3J
	 92vlHwAR/69whwBl28n11nLt4Gn47HidOEXYu7MxQRch7/XgHDceEqIuJJrWvhnSl8
	 3ProtJgPPuxXCRsMuUn8+TVb9NdTGw9M/QOSrzCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388783AbfDXRSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:18:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388749AbfDXRSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:18:04 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2526B21909;
        Wed, 24 Apr 2019 17:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126283;
        bh=nWSw3dpRfrh23uz92UnFunuYPReheyzgcl9q1cC91BM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EJWuOhG2hOfrgagpwuh1oZf8Bq8PxYv0zAKBlRoQWRP6vbelG7swkevrLtWx90IwZ
         gLt2+qMoMKDqINzgKSCDSYGSC7BAKe235k+b7xLX1NPOGpvIVaJk5a2ov2tUhqdpb4
         tAq+PUwtUN8S8Ex+doqyax0D31I/XBtBOr0LRIds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Tolnay <dtolnay@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 058/168] hwrng: virtio - Avoid repeated init of completion
Date:   Wed, 24 Apr 2019 19:08:22 +0200
Message-Id: <20190424170927.224435608@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit aef027db48da56b6f25d0e54c07c8401ada6ce21 ]

The virtio-rng driver uses a completion called have_data to wait for a
virtio read to be fulfilled by the hypervisor. The completion is reset
before placing a buffer on the virtio queue and completed by the virtio
callback once data has been written into the buffer.

Prior to this commit, the driver called init_completion on this
completion both during probe as well as when registering virtio buffers
as part of a hwrng read operation. The second of these init_completion
calls should instead be reinit_completion because the have_data
completion has already been inited by probe. As described in
Documentation/scheduler/completion.txt, "Calling init_completion() twice
on the same completion object is most likely a bug".

This bug was present in the initial implementation of virtio-rng in
f7f510ec1957 ("virtio: An entropy device, as suggested by hpa"). Back
then the have_data completion was a single static completion rather than
a member of one of potentially multiple virtrng_info structs as
implemented later by 08e53fbdb85c ("virtio-rng: support multiple
virtio-rng devices"). The original driver incorrectly used
init_completion rather than INIT_COMPLETION to reset have_data during
read.

Tested by running `head -c48 /dev/random | hexdump` within crosvm, the
Chrome OS virtual machine monitor, and confirming that the virtio-rng
driver successfully produces random bytes from the host.

Signed-off-by: David Tolnay <dtolnay@gmail.com>
Tested-by: David Tolnay <dtolnay@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/hw_random/virtio-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 3fa2f8a009b3..1c5c4314c6b5 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -73,7 +73,7 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
 
 	if (!vi->busy) {
 		vi->busy = true;
-		init_completion(&vi->have_data);
+		reinit_completion(&vi->have_data);
 		register_buffer(vi, buf, size);
 	}
 
-- 
2.19.1



