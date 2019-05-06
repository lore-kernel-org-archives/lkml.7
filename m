Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A715BC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABA721479
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153939;
	bh=gayqogWeaoXwcCQx1yzFUiUarQ1AJbH0Dw+KMKkYVXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sHMjQmEGdfUrKs0aijrv609OA59ZLJHM0OIEDb1h5zB9vfJmyfQ8S1Dyihk6cA6T6
	 AA/wyMpl1WYfKTVu02g6bVoYqfvvnCl5JWCMnWorRLlAwU4Kb8nFf5ORc8Z0Qp3Jqi
	 lSxLRxHO0aotmMRd9F950eE+0ELoAIB8GaFaxnEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfEFOph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:45:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728965AbfEFOpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:45:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 578EB20C01;
        Mon,  6 May 2019 14:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153933;
        bh=gayqogWeaoXwcCQx1yzFUiUarQ1AJbH0Dw+KMKkYVXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BWXP0P+ZD7O522BqpcL+EdAAYCBJG+k5zqemkLCd+qF/srNk4AfkV2mNIzBg2LLNy
         9vIaMYRJJVPwWM47uXL1g3bhPqLVCTlzO7CNiiUjOmtS2aip6GGpW435cTUnfae5Wj
         JmEXsM2dQs1Rw036C9oOTb5tzA39jkhqQC5DB/Z0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Louis Taylor <louis@kragniz.eu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 44/75] vfio/pci: use correct format characters
Date:   Mon,  6 May 2019 16:32:52 +0200
Message-Id: <20190506143057.210575988@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.287515952@linuxfoundation.org>
References: <20190506143053.287515952@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 426b046b748d1f47e096e05bdcc6fb4172791307 ]

When compiling with -Wformat, clang emits the following warnings:

drivers/vfio/pci/vfio_pci.c:1601:5: warning: format specifies type
      'unsigned short' but the argument has type 'unsigned int' [-Wformat]
                                vendor, device, subvendor, subdevice,
                                ^~~~~~

drivers/vfio/pci/vfio_pci.c:1601:13: warning: format specifies type
      'unsigned short' but the argument has type 'unsigned int' [-Wformat]
                                vendor, device, subvendor, subdevice,
                                        ^~~~~~

drivers/vfio/pci/vfio_pci.c:1601:21: warning: format specifies type
      'unsigned short' but the argument has type 'unsigned int' [-Wformat]
                                vendor, device, subvendor, subdevice,
                                                ^~~~~~~~~

drivers/vfio/pci/vfio_pci.c:1601:32: warning: format specifies type
      'unsigned short' but the argument has type 'unsigned int' [-Wformat]
                                vendor, device, subvendor, subdevice,
                                                           ^~~~~~~~~

drivers/vfio/pci/vfio_pci.c:1605:5: warning: format specifies type
      'unsigned short' but the argument has type 'unsigned int' [-Wformat]
                                vendor, device, subvendor, subdevice,
                                ^~~~~~

drivers/vfio/pci/vfio_pci.c:1605:13: warning: format specifies type
      'unsigned short' but the argument has type 'unsigned int' [-Wformat]
                                vendor, device, subvendor, subdevice,
                                        ^~~~~~

drivers/vfio/pci/vfio_pci.c:1605:21: warning: format specifies type
      'unsigned short' but the argument has type 'unsigned int' [-Wformat]
                                vendor, device, subvendor, subdevice,
                                                ^~~~~~~~~

drivers/vfio/pci/vfio_pci.c:1605:32: warning: format specifies type
      'unsigned short' but the argument has type 'unsigned int' [-Wformat]
                                vendor, device, subvendor, subdevice,
                                                           ^~~~~~~~~
The types of these arguments are unconditionally defined, so this patch
updates the format character to the correct ones for unsigned ints.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Louis Taylor <louis@kragniz.eu>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/pci/vfio_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 695b9d1a1aae..6f5cc67e343e 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1443,11 +1443,11 @@ static void __init vfio_pci_fill_ids(void)
 		rc = pci_add_dynid(&vfio_pci_driver, vendor, device,
 				   subvendor, subdevice, class, class_mask, 0);
 		if (rc)
-			pr_warn("failed to add dynamic id [%04hx:%04hx[%04hx:%04hx]] class %#08x/%08x (%d)\n",
+			pr_warn("failed to add dynamic id [%04x:%04x[%04x:%04x]] class %#08x/%08x (%d)\n",
 				vendor, device, subvendor, subdevice,
 				class, class_mask, rc);
 		else
-			pr_info("add [%04hx:%04hx[%04hx:%04hx]] class %#08x/%08x\n",
+			pr_info("add [%04x:%04x[%04x:%04x]] class %#08x/%08x\n",
 				vendor, device, subvendor, subdevice,
 				class, class_mask);
 	}
-- 
2.20.1



