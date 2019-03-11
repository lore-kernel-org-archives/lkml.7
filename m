Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BIGNUM_EMAILS,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E95C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8102171F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334471;
	bh=xqSH6Ug08OJM5BJzsIndgwf8a+opMnwf04AfziuWUl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NO+l2WtGmEGULUHf+GDoqGhN8uyb0q/sPkkAFxSW+Y7hlsf9syKTBBmQUHreAisVz
	 x0Qx8yeeZl4ODGKhG/ySrHc9Ad87n5JgQaLoeHf4NU4FRzlgvTXI8AfE9QCZ7+PzNt
	 OhZ3y3ZFdkWqDLn95mq14D2n/y5AxTXc5uljAvN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbfCKUBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:01:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729661AbfCKT7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:59:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCA7F2173C;
        Mon, 11 Mar 2019 19:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334382;
        bh=xqSH6Ug08OJM5BJzsIndgwf8a+opMnwf04AfziuWUl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qdp6QM9s43TOlzy/SHBsTUT4CB9ED/qXuVQORCcQr/V1ULAdqKf9hsywATgdBGhPc
         RQSesLORT8c+1kwDD592GMq4aJwkWzpjmiS+mpk75Vk4nSYPuDdlS1X42fJWcCOmUU
         EW730XeJfxRr6qlc7rCNvLgy3op0shEbHLrjQer4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 3/8] s390/dasd: fix using offset into zero size array error
Date:   Mon, 11 Mar 2019 15:59:33 -0400
Message-Id: <20190311195938.139603-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195938.139603-1-sashal@kernel.org>
References: <20190311195938.139603-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Haberland <sth@linux.ibm.com>

[ Upstream commit 4a8ef6999bce998fa5813023a9a6b56eea329dba ]

Dan Carpenter reported the following:

The patch 52898025cf7d: "[S390] dasd: security and PSF update patch
for EMC CKD ioctl" from Mar 8, 2010, leads to the following static
checker warning:

	drivers/s390/block/dasd_eckd.c:4486 dasd_symm_io()
	error: using offset into zero size array 'psf_data[]'

drivers/s390/block/dasd_eckd.c
  4458          /* Copy parms from caller */
  4459          rc = -EFAULT;
  4460          if (copy_from_user(&usrparm, argp, sizeof(usrparm)))
                                    ^^^^^^^
The user can specify any "usrparm.psf_data_len".  They choose zero by
mistake.

  4461                  goto out;
  4462          if (is_compat_task()) {
  4463                  /* Make sure pointers are sane even on 31 bit. */
  4464                  rc = -EINVAL;
  4465                  if ((usrparm.psf_data >> 32) != 0)
  4466                          goto out;
  4467                  if ((usrparm.rssd_result >> 32) != 0)
  4468                          goto out;
  4469                  usrparm.psf_data &= 0x7fffffffULL;
  4470                  usrparm.rssd_result &= 0x7fffffffULL;
  4471          }
  4472          /* alloc I/O data area */
  4473          psf_data = kzalloc(usrparm.psf_data_len, GFP_KERNEL
  			   				 | GFP_DMA);
  4474          rssd_result = kzalloc(usrparm.rssd_result_len, GFP_KERNEL
							       | GFP_DMA);
  4475          if (!psf_data || !rssd_result) {

kzalloc() returns a ZERO_SIZE_PTR (0x16).

  4476                  rc = -ENOMEM;
  4477                  goto out_free;
  4478          }
  4479
  4480          /* get syscall header from user space */
  4481          rc = -EFAULT;
  4482          if (copy_from_user(psf_data,
  4483                             (void __user *)(unsigned long)
  				   	 		 usrparm.psf_data,
  4484                             usrparm.psf_data_len))

That all works great.

  4485                  goto out_free;
  4486          psf0 = psf_data[0];
  4487          psf1 = psf_data[1];

But now we're assuming that "->psf_data_len" was at least 2 bytes.

Fix this by checking the user specified length psf_data_len.

Fixes: 52898025cf7d ("[S390] dasd: security and PSF update patch for EMC CKD ioctl")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd_eckd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index dac2f6883e28..80a43074c2f9 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -4023,6 +4023,14 @@ static int dasd_symm_io(struct dasd_device *device, void __user *argp)
 		usrparm.psf_data &= 0x7fffffffULL;
 		usrparm.rssd_result &= 0x7fffffffULL;
 	}
+	/* at least 2 bytes are accessed and should be allocated */
+	if (usrparm.psf_data_len < 2) {
+		DBF_DEV_EVENT(DBF_WARNING, device,
+			      "Symmetrix ioctl invalid data length %d",
+			      usrparm.psf_data_len);
+		rc = -EINVAL;
+		goto out;
+	}
 	/* alloc I/O data area */
 	psf_data = kzalloc(usrparm.psf_data_len, GFP_KERNEL | GFP_DMA);
 	rssd_result = kzalloc(usrparm.rssd_result_len, GFP_KERNEL | GFP_DMA);
-- 
2.19.1

