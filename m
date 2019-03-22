Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BIGNUM_EMAILS,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6434FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3329F21929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255220;
	bh=IGPrcJR8c1E4Z0PIDgaNZD55pX6/8cx/2nEyVslIN1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RtXuLdoyCT9kfdrFoPOyGwBhYASmg87mOx+CHjqpVPGRaP33uWUCyi4hmqftJxywl
	 jV6MGzZN1f+j6X9o8IpSi2HJVjjwZnOI6gmGoH5gvgKJVd+DWu3F/PMpm8JNkI+Al2
	 T7PjhSkmN2T0NFagdgwAluWfkElVv19ZeO38XTGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbfCVLq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:46:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbfCVLq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:46:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 040432075E;
        Fri, 22 Mar 2019 11:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255216;
        bh=IGPrcJR8c1E4Z0PIDgaNZD55pX6/8cx/2nEyVslIN1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zr6t1y6JtFwYXLhmBG5wo7Op5MgxVdkVd2AD9o2K0M1JNcM9wVInR0gpmuWrgzNAS
         6LocBwocUodOymS0kz/QxrdUQQSpTwnvshOKUND84QkQL1Jh1c7i30Xgb55Xw6mfvA
         e1U00p2bhdj/C+1c3UnPv4rDU+QZ2fACC5sw/sJ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 014/183] s390/dasd: fix using offset into zero size array error
Date:   Fri, 22 Mar 2019 12:14:02 +0100
Message-Id: <20190322111242.820889032@linuxfoundation.org>
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
index 4c7c8455da96..0a1e7f9b5239 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -4463,6 +4463,14 @@ static int dasd_symm_io(struct dasd_device *device, void __user *argp)
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



