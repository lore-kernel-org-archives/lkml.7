Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B5AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30EC218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126066;
	bh=QmKis2BFlJaQlCBpe0IcKs28bpLwZbS6jofxw87qRpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M7YaN/8UB7GvE5nHSUQkrfz8oqrF033VgKEIcXsDpt6ZjkfwPHu8PVFOX2xW+ixek
	 InEFNc+krC4jY2r/X+yGYPuXkL9g9R3wo0mc9QR+gF7bZ4nJHsULcEBZdbL1QHb3SP
	 n0uBwnBTDMD5r1dVizIHuWhJyk9aJczN0sTnNse0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388066AbfDXROY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388055AbfDXROV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:14:21 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94440218B0;
        Wed, 24 Apr 2019 17:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126061;
        bh=QmKis2BFlJaQlCBpe0IcKs28bpLwZbS6jofxw87qRpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dog0Ax4mxH/UtjzBWFdrCrm5BdLEw/QzQevIMQTCMGmamyUoHJ5hpNCFkkjAitUF1
         B0yiRDRm+a5p15hkVigtDStUHYJ4zYELm/3p3AR0nv8rY14hUk5BKZy3L7Pl31DCEQ
         IVFDHNNtF8r0NWgcZwdq26iKYsWBjelbIClR2TRg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Tolnay <dtolnay@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 034/104] hwrng: virtio - Avoid repeated init of completion
Date:   Wed, 24 Apr 2019 19:08:51 +0200
Message-Id: <20190424170857.972033622@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
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
index 72295ea2fd1c..5cdc8c534ad4 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -74,7 +74,7 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
 
 	if (!vi->busy) {
 		vi->busy = true;
-		init_completion(&vi->have_data);
+		reinit_completion(&vi->have_data);
 		register_buffer(vi, buf, size);
 	}
 
-- 
2.19.1



