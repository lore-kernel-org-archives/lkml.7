Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52F6C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B2820830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122580;
	bh=WfxDNclaPwQMRAUKsE1cmWMDs3Yv+dnYyxNB+8LnBpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pCfjq4WYjUvrxPfXGhNfLa+vWBeM2fxaTTPsyXl25RmeLP/82krFnXVnID/QjSvPt
	 O7Rt/C1WOo8YVUMbJ4wmGmP7t9s5pw0K3NjBOq2q/+wItR7M1pexeh9wgIxYGs68np
	 Dy52joUG/c3SgnT0HTvU0RiNdv9X86+2lEt0jRos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392383AbfJCRJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:09:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731952AbfJCQeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:34:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12F2C2133F;
        Thu,  3 Oct 2019 16:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120443;
        bh=WfxDNclaPwQMRAUKsE1cmWMDs3Yv+dnYyxNB+8LnBpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JNFTW0ZbNzTVdaXx9IC30sUcfTqhrAy4QqOG4NNf3zL7DVUUY+QmcXjP0acKtfZUm
         HH8QPXYtwUmsXFA/ey7nZDYm4DKDbHg/Wh6yy/xbtfUq4zPVHW2tPxmXM8Zb/GX+oU
         ALfGzejVIhEGWRr4tnz47c2ov5A6X8wjFUtyDpgk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.2 224/313] RDMA: Fix double-free in srq creation error flow
Date:   Thu,  3 Oct 2019 17:53:22 +0200
Message-Id: <20191003154555.095265867@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

commit 3eca7fc2d8d1275d9cf0c709f0937becbfcf6d96 upstream.

The cited commit introduced a double-free of the srq buffer in the error
flow of procedure __uverbs_create_xsrq().

The problem is that ib_destroy_srq_user() called in the error flow also
frees the srq buffer.

Thus, if uverbs_response() fails in __uverbs_create_srq(), the srq buffer
will be freed twice.

Cc: <stable@vger.kernel.org>
Fixes: 68e326dea1db ("RDMA: Handle SRQ allocations by IB/core")
Link: https://lore.kernel.org/r/20190916071154.20383-5-leon@kernel.org
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/uverbs_cmd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3477,7 +3477,8 @@ static int __uverbs_create_xsrq(struct u
 
 err_copy:
 	ib_destroy_srq_user(srq, uverbs_get_cleared_udata(attrs));
-
+	/* It was released in ib_destroy_srq_user */
+	srq = NULL;
 err_free:
 	kfree(srq);
 err_put:


