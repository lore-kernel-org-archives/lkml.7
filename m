Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAF3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDEC21917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254831;
	bh=q4FEIakVlzZntlXA4oHE47KW8JhznzCUCjQg/HbqiQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MiF17L6RfMk4Mx7AsYxbxzVjv2k8+EfIGw4LsVeU3X9MMgDNpsjQ12GLbjA36nz9k
	 OyMR0iFqLQKnslYFeYofahk1U84y4h/Sv7e4y6hYBQLGUs5c2wePGjTiox9JJQgXqF
	 jjO8NWftCCl8NjmCR4Nmr4ELA8Ra0F7i1NrTjbt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbfCVLka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:40:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730878AbfCVLk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:40:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E593218B0;
        Fri, 22 Mar 2019 11:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254825;
        bh=q4FEIakVlzZntlXA4oHE47KW8JhznzCUCjQg/HbqiQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DD+zUmueivh8WQEs+4LUMfPzss583LliTawYKqFOei7bCkfqQUzR1IskQfgtP9SqP
         jJYtLmpJMHchxaTYPVYmtL1ai8QlhSznz4us/grYAqATo52zHEqWAOERDlyxeiC5KW
         Xh5XFyoikYL7osIOfmBGtC5FO6qwFoGEPhQuhy8Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pankaj Gupta <pankaj.gupta@nxp.com>,
        Arun Pathak <arun.pathak@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.9 007/118] crypto: caam - fixed handling of sg list
Date:   Fri, 22 Mar 2019 12:14:39 +0100
Message-Id: <20190322111216.507312529@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2131,6 +2131,7 @@ static void init_aead_job(struct aead_re
 	if (unlikely(req->src != req->dst)) {
 		if (!edesc->dst_nents) {
 			dst_dma = sg_dma_address(req->dst);
+			out_options = 0;
 		} else {
 			dst_dma = edesc->sec4_sg_dma +
 				  sec4_sg_index *


