Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFC1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490AA2192D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138473;
	bh=zvTc5sA+VvsZ7XiulKDf7aag+8RPQ0JGo293Jq+KfuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DATRJMir/7ZETki5yOIBDgHUlS5nJ9u5r06FpsOAtj/SWwcTre2jeT/DF2KcGUfEG
	 clFZ7mKp5E1ydVMR62XkfFEbTdRv9ZYZmWUssmDLx4nul0peaFH7er/aFAMnpqhYA7
	 p7cljtWYB+jsRdFrr5JlQ/qQ2/jQVv0m5WMOFd08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbfDARHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:07:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728830AbfDARHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:07:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE1172192C;
        Mon,  1 Apr 2019 17:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138466;
        bh=zvTc5sA+VvsZ7XiulKDf7aag+8RPQ0JGo293Jq+KfuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oaQ6v6nOOuTcJwICc0bK2+U1BSTIO4tS5GHh6YhKUokwYEM5NPgdLS7uJw9ZUzQIK
         aoyztB3VJG6iPl+Ji1MPXdRJXTWPNKC9NChtJvfFUZoRhFJBo/BWDK4NRB0ou4LkDU
         Hhp/qoAm1pJDLPUyo8apPda2PN8zwSmZ9m2bhYn4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Hussam Al-Tayeb <ht990332@gmx.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.0 073/146] scsi: sd: Quiesce warning if device does not report optimal I/O size
Date:   Mon,  1 Apr 2019 19:01:25 +0200
Message-Id: <20190401170054.902723017@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin K. Petersen <martin.petersen@oracle.com>

commit 1d5de5bd311be7cd54f02f7cd164f0349a75c876 upstream.

Commit a83da8a4509d ("scsi: sd: Optimal I/O size should be a multiple
of physical block size") split one conditional into several separate
statements in an effort to provide more accurate warning messages when
a device reports a nonsensical value. However, this reorganization
accidentally dropped the precondition of the reported value being
larger than zero. This lead to a warning getting emitted on devices
that do not report an optimal I/O size at all.

Remain silent if a device does not report an optimal I/O size.

Fixes: a83da8a4509d ("scsi: sd: Optimal I/O size should be a multiple of physical block size")
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: <stable@vger.kernel.org>
Reported-by: Hussam Al-Tayeb <ht990332@gmx.com>
Tested-by: Hussam Al-Tayeb <ht990332@gmx.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sd.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3054,6 +3054,9 @@ static bool sd_validate_opt_xfer_size(st
 	unsigned int opt_xfer_bytes =
 		logical_to_bytes(sdp, sdkp->opt_xfer_blocks);
 
+	if (sdkp->opt_xfer_blocks == 0)
+		return false;
+
 	if (sdkp->opt_xfer_blocks > dev_max) {
 		sd_first_printk(KERN_WARNING, sdkp,
 				"Optimal transfer size %u logical blocks " \


