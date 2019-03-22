Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236BAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E749D218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255207;
	bh=znMkddJcjVto+p97eDOprf0x0nH3xomdE+wbOmgMAbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tQ9q3tjPlW4LdrJca9GnAe8EfngzOAruTyQL/bZeDJEFR5JgCWqKZT7LYvnQcAO7A
	 Z+GxcGtI/J0RY/H+JaG7jWjx2lIwKcGtMeGEw4IAwi0vxjd2VZKe6jp7U4qyl6tnDm
	 jswwq6ZtBc5dzLjsGWIZVtVxoGRhWnIjI29n7xJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbfCVLqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731770AbfCVLqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:46:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F18E52075E;
        Fri, 22 Mar 2019 11:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255199;
        bh=znMkddJcjVto+p97eDOprf0x0nH3xomdE+wbOmgMAbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ugiTZluu5kLZU/OXuXS1m9lzbi3PRFQaH0s5j+PUiuRDKAdN0T7m5VJrJnBlSboWB
         0HLrsLsTi82yDvTChA/4Ze6dLIN/k35gTFxsYkuUD5zSe7EAgEtNk372gItewXiB7c
         DD35Vv+gBIDDYfk96t0tTNQ0R63Z5wZRWvLqHU5s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pankaj Gupta <pankaj.gupta@nxp.com>,
        Arun Pathak <arun.pathak@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 006/183] crypto: caam - fixed handling of sg list
Date:   Fri, 22 Mar 2019 12:13:54 +0100
Message-Id: <20190322111242.250612206@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1097,6 +1097,7 @@ static void init_ablkcipher_job(u32 *sh_
 	} else {
 		if (edesc->dst_nents == 1) {
 			dst_dma = sg_dma_address(req->dst);
+			out_options = 0;
 		} else {
 			dst_dma = edesc->sec4_sg_dma + (edesc->src_nents + 1) *
 				  sizeof(struct sec4_sg_entry);


