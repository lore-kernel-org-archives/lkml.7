Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65938C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 09:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C632084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 09:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="kDX5G9Yx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="rHxcN80G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfDMJ7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 05:59:07 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50902 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbfDMJ7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 05:59:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0E17D8EE0CF;
        Sat, 13 Apr 2019 02:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1555149547;
        bh=EOYJpO+6PIi+mhdtKMaJuiSVJkC2oE+YZVU0Xw4sUWE=;
        h=Subject:From:To:Cc:Date:From;
        b=kDX5G9Yx4EY+PLuSM/UNXUAlsWRf+VVi+P8jBSkrHddI+cZ1zZXru6NWT2bIQeZV7
         HTb3qvzUIilKpRJ5xX12C7y411iOx1vui0zCet3SaywqqFtxr4zAmTcAIZH4uPuD9r
         jo9WaFeSEKEtLNzoYiAyF1LBlPAezHegRaAA73Js=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dsWghZPIQJWt; Sat, 13 Apr 2019 02:59:06 -0700 (PDT)
Received: from [10.130.243.102] (unknown [195.77.194.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D5AC98EE062;
        Sat, 13 Apr 2019 02:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1555149546;
        bh=EOYJpO+6PIi+mhdtKMaJuiSVJkC2oE+YZVU0Xw4sUWE=;
        h=Subject:From:To:Cc:Date:From;
        b=rHxcN80Gua7NUeIZ4F74HFqC7OxznYwCsLp+vA8O95ZBcDrMILCo2FTDJkUTBjjpV
         6CS+Gpequ+rJ3a/e5VguQX1fFh6iYlWMDg63XOtSIJOnO79ZIPr2yy2dcBiI0tpTdr
         WoSTntbmlbPEd1HyF3OOVCRqsorMWwVlPQK7DtAM=
Message-ID: <1555149542.2995.15.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.1-rc4
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 13 Apr 2019 11:59:02 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One obvious fix for a ciostor data corruption on error bug.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Varun Prakash (1):
      scsi: csiostor: fix missing data copy in csio_scsi_err_handler()

And the diffstat:

 drivers/scsi/csiostor/csio_scsi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

With full diff below.

James

---

diff --git a/drivers/scsi/csiostor/csio_scsi.c b/drivers/scsi/csiostor/csio_scsi.c
index 462560b2855e..469d0bc9f5fe 100644
--- a/drivers/scsi/csiostor/csio_scsi.c
+++ b/drivers/scsi/csiostor/csio_scsi.c
@@ -1713,8 +1713,11 @@ csio_scsi_err_handler(struct csio_hw *hw, struct csio_ioreq *req)
 	}
 
 out:
-	if (req->nsge > 0)
+	if (req->nsge > 0) {
 		scsi_dma_unmap(cmnd);
+		if (req->dcopy && (host_status == DID_OK))
+			host_status = csio_scsi_copy_to_sgl(hw, req);
+	}
 
 	cmnd->result = (((host_status) << 16) | scsi_status);
 	cmnd->scsi_done(cmnd);
