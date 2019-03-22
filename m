Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6B7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1772070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258155;
	bh=AuYWipqEZzXc6dmAU9PPiLadJQIwnIrNfDYsg4PyaAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QSSQ68CgwnnLdlw18nOqJt6CfkZEZ4KTR270o+OXDHkLOwmVV8Q0UddD2U9MWPcq/
	 PCSLaIJl0JUrLBaHEJEDzVhJW9nCGCyHia900F+2LPBdy2UVbA3yShYgfXGMwfIZtN
	 nycIoE0FTOR7jSRyoiVsFopc4Rp1cfLm176JDO1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389715AbfCVMfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:35:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389356AbfCVMLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:11:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E3712192C;
        Fri, 22 Mar 2019 12:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256709;
        bh=AuYWipqEZzXc6dmAU9PPiLadJQIwnIrNfDYsg4PyaAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kdOKOllY5rnSQW0sFtwuiRXkx7WcViNEjpePIto2ZvwRQA97c6dJhTHOAymj4UvWO
         OAvSYh2HA3PMru1ZdD/s358P5UoQ38fIqqiF66ansx/Gcm0L8L+zdZuHEaJ/JADcAZ
         M9OXXBzoAd+kyZyLVPN5wwciQCzUExq1D1LPfr0Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pankaj Gupta <pankaj.gupta@nxp.com>,
        Arun Pathak <arun.pathak@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.0 014/238] crypto: caam - fixed handling of sg list
Date:   Fri, 22 Mar 2019 12:13:53 +0100
Message-Id: <20190322111259.058498867@linuxfoundation.org>
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

From: Pankaj Gupta <pankaj.gupta@nxp.com>

commit 42e95d1f10dcf8b18b1d7f52f7068985b3dc5b79 upstream.

when the source sg contains more than 1 fragment and
destination sg contains 1 fragment, the caam driver
mishandle the buffers to be sent to caam.

Fixes: f2147b88b2b1 ("crypto: caam - Convert GCM to new AEAD interface")
Cc: <stable@vger.kernel.org> # 4.2+
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Signed-off-by: Arun Pathak <arun.pathak@nxp.com>
Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/caam/caamalg.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -1040,6 +1040,7 @@ static void init_aead_job(struct aead_re
 	if (unlikely(req->src != req->dst)) {
 		if (edesc->dst_nents == 1) {
 			dst_dma = sg_dma_address(req->dst);
+			out_options = 0;
 		} else {
 			dst_dma = edesc->sec4_sg_dma +
 				  sec4_sg_index *


