Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C6DC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6D22070B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564431228;
	bh=LOARK0T404+azY1suHxq6Tt9I+LxkICd8FbLI+35sfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gi9yLg8pLGohio0L8Aa4Sjm5Om/fQjg2pM3aPqrRGXwPC+wEbw7vGDF9ikxwglS5j
	 vrXCYrCpsPYC0dYE4UWA0Ur64FPsbE/9QCo/qvDGWa8QSu7EHMfZPy8hh1W3gVZs3w
	 IZjaDE/xbbS6lQy/1/hXIlgaY4rKt0MsDSfxeNFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfG2T31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:29:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727533AbfG2T3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:29:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F714217D4;
        Mon, 29 Jul 2019 19:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428555;
        bh=LOARK0T404+azY1suHxq6Tt9I+LxkICd8FbLI+35sfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PheJRNPBQkjYTRJP91yw8vNrqWik0wZQkQrf1+Q6ysDoQsv28Izj6D5cE58bkyLWJ
         IPh38ehUMlznbLrrf3ewBGOxgnBNzy991+weKGDXBSHvZPUzDUOwkEnRZERdrFGJDU
         tu6O/47HD+LuzURPc5BY7PjEctEsFwjpM3Xo/pIk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Stan Johnson <userm57@yahoo.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 114/293] Revert "scsi: ncr5380: Increase register polling limit"
Date:   Mon, 29 Jul 2019 21:20:05 +0200
Message-Id: <20190729190833.357775795@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>

commit 25fcf94a2fa89dd3e73e965ebb0b38a2a4f72aa4 upstream.

This reverts commit 4822827a69d7cd3bc5a07b7637484ebd2cf88db6.

The purpose of that commit was to suppress a timeout warning message which
appeared to be caused by target latency. But suppressing the warning is
undesirable as the warning may indicate a messed up transfer count.

Another problem with that commit is that 15 ms is too long to keep
interrupts disabled as interrupt latency can cause system clock drift and
other problems.

Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: stable@vger.kernel.org
Fixes: 4822827a69d7 ("scsi: ncr5380: Increase register polling limit")
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Stan Johnson <userm57@yahoo.com>
Tested-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/NCR5380.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/NCR5380.h
+++ b/drivers/scsi/NCR5380.h
@@ -235,7 +235,7 @@ struct NCR5380_cmd {
 #define NCR5380_PIO_CHUNK_SIZE		256
 
 /* Time limit (ms) to poll registers when IRQs are disabled, e.g. during PDMA */
-#define NCR5380_REG_POLL_TIME		15
+#define NCR5380_REG_POLL_TIME		10
 
 static inline struct scsi_cmnd *NCR5380_to_scmd(struct NCR5380_cmd *ncmd_ptr)
 {


