Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEDBC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842FB215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121356;
	bh=tgroMNcvxwArRTks3sCAEnqyWlNndrYFv3ukcCXLdjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cBbZZpR6xOdJCVxFvDX0N3MyLYbxt2M65cS71W8ooDgeuhJ82vmqbM/i839G5veSR
	 3dwlYE/wJqcZmtU9QHaWqfpfG/vK61AK6y1M2iBcbe0FiaJ5hoZkRXxiFZktem6ktx
	 IcSHbGHe2tiI9rU90D+vGQLpR0ZavcIqY4vRMMzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392695AbfJCQtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:49:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405630AbfJCQtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:49:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFAAC20830;
        Thu,  3 Oct 2019 16:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121351;
        bh=tgroMNcvxwArRTks3sCAEnqyWlNndrYFv3ukcCXLdjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J8+ymSWTYnV/kKtboM3vi8UrFQhBMHGViWi+z+msQpv05+rBY3moXL8y9yW6kXq5A
         STFqY5U/L5pT3tzPePiEoBX/Nh97Q2BYke8MgM0aEFqPJ1ie0iDVBkas2fctsTNfn4
         XONNxqIH4TSQBtRRwWy5sHCu4WltINwnT2LcqSwg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.3 246/344] RDMA: Fix double-free in srq creation error flow
Date:   Thu,  3 Oct 2019 17:53:31 +0200
Message-Id: <20191003154604.699571015@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
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
@@ -3484,7 +3484,8 @@ static int __uverbs_create_xsrq(struct u
 
 err_copy:
 	ib_destroy_srq_user(srq, uverbs_get_cleared_udata(attrs));
-
+	/* It was released in ib_destroy_srq_user */
+	srq = NULL;
 err_free:
 	kfree(srq);
 err_put:


