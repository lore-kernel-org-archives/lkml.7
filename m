Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F7BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1D621916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255785;
	bh=Ylw65E9Zkeo0xSHVmxbaMSl6jX6ae9ure4QyrUfn1w4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EBwvVVen21m3iubFf63ZxMOh8tlnZyd8znJZvJou3bG4JlPLyw5HMtWgak7pioEdb
	 nC/ild3ufRj/bShhYh0ifzQ2evRoBB0y9jQyZ4lzMGLQLMo1aIzMryvXsDDTBcQMFz
	 Z/oGP7uD80j8SezuckOrPqOXLka2ZsiOkh0eaZdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbfCVL4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:56:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:32830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732975AbfCVL4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:56:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 539E621916;
        Fri, 22 Mar 2019 11:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255781;
        bh=Ylw65E9Zkeo0xSHVmxbaMSl6jX6ae9ure4QyrUfn1w4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yMjMCOnO61y4MVskMXr1nv63Me9Jj+pCI6M8rcc/0WEDie9KnE1ZEB0D8YJSkEaz8
         BHgrdtX9mxlSFx1G0iZdUgbru9uZH8zYyOvKC6pZ3XZYHImmhLSkCWywz/xnKo6l+F
         gaDigpR4ybFF71zRqhxuxNEMP5Yi/96yLLey0qIY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pankaj Gupta <pankaj.gupta@nxp.com>,
        Arun Pathak <arun.pathak@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 013/280] crypto: caam - fixed handling of sg list
Date:   Fri, 22 Mar 2019 12:12:46 +0100
Message-Id: <20190322111307.054641503@linuxfoundation.org>
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
@@ -1005,6 +1005,7 @@ static void init_aead_job(struct aead_re
 	if (unlikely(req->src != req->dst)) {
 		if (edesc->dst_nents == 1) {
 			dst_dma = sg_dma_address(req->dst);
+			out_options = 0;
 		} else {
 			dst_dma = edesc->sec4_sg_dma +
 				  sec4_sg_index *


