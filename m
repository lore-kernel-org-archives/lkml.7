Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E760C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C442075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556625396;
	bh=TKqAad3HeCTQ5jzhurH98iRs8WRCsusuiIuMh6eGFjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=taq4g46+PqRmjygeg/TAkBZvOT+OBzO2hgfRUC6bo2o5Q38OM26YUXqcR9K0vqQwp
	 +iHMCodyWMVQV3n7A1/tmQReRkRNX7Iy7NxLJ/yolXnkwPjonAkknyt7zTxKQa7fii
	 rysaa0EcOmSJdzz3bj2c/W8EXPITFCEOSqUNbUTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfD3L4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:56:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730866AbfD3Lsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:48:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7902B20449;
        Tue, 30 Apr 2019 11:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624921;
        bh=TKqAad3HeCTQ5jzhurH98iRs8WRCsusuiIuMh6eGFjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lQlyzBzsWxcBHwvdqU7LxmzNFreBQDY77LN9+DwGjNj22iA+SeNuSEiNMTSoAqEwZ
         u1PpzVQlTzO1l+8DjVzFfY94M77RJB9eMTkxUqI0hKq3wGX484w19SDExLTmDD+aGq
         hJftTl77n15B9jkex9uIq+MhanK7wX0vOiIdEK9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH 5.0 23/89] RDMA/mlx5: Do not allow the user to write to the clock page
Date:   Tue, 30 Apr 2019 13:38:14 +0200
Message-Id: <20190430113611.124712220@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113609.741196396@linuxfoundation.org>
References: <20190430113609.741196396@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

commit c660133c339f9ab684fdf568c0d51b9ae5e86002 upstream.

The intent of this VMA was to be read-only from user space, but the
VM_MAYWRITE masking was missed, so mprotect could make it writable.

Cc: stable@vger.kernel.org
Fixes: 5c99eaecb1fc ("IB/mlx5: Mmap the HCA's clock info to user-space")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Haggai Eran <haggaie@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/main.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1982,6 +1982,7 @@ static int mlx5_ib_mmap_clock_info_page(
 
 	if (vma->vm_flags & VM_WRITE)
 		return -EPERM;
+	vma->vm_flags &= ~VM_MAYWRITE;
 
 	if (!dev->mdev->clock_info_page)
 		return -EOPNOTSUPP;
@@ -2147,6 +2148,7 @@ static int mlx5_ib_mmap(struct ib_uconte
 
 		if (vma->vm_flags & VM_WRITE)
 			return -EPERM;
+		vma->vm_flags &= ~VM_MAYWRITE;
 
 		/* Don't expose to user-space information it shouldn't have */
 		if (PAGE_SIZE > 4096)


