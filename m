Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66D3C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7AF42084D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888280;
	bh=RUmIk2AyAHnF+oOB0qFKnfPjkDLo8tbmg3+ir3tzxSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GK2Gdo0IsffZi2DijeBnhkf07s4P9mP/7h70tvPOWDwtmf8p3TcemX28BBZl9LpUM
	 2oNv2DgNH46JnZt1c3PIeHQIT4fEPGCAdKOz/hS661AlNFueL8aGnZ8ONQWuqnNNq6
	 A9DS0eroGmqV8Q33cKkbH4hkFNVhGO/ykT5+fUcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfK0U56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:57:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:49014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730688AbfK0U5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:57:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED61E20862;
        Wed, 27 Nov 2019 20:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888272;
        bh=RUmIk2AyAHnF+oOB0qFKnfPjkDLo8tbmg3+ir3tzxSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mqHkS8xT67Qj1lAlAhQXmasSNIRbbD0GkfHDaQBqfcHQdathyMflw6E3jxeL/mTwN
         HlY5cXADhPP8S8wiT4SYnc22TUGR433DCx5GODmWytGQBDmcDtds/2/bfd0IBJv0y/
         30n1itdA/VGaC9ZR/cB75mvOBIDL3Dic407jazIA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 070/306] scsi: isci: Use proper enumerated type in atapi_d2h_reg_frame_handler
Date:   Wed, 27 Nov 2019 21:28:40 +0100
Message-Id: <20191127203119.915281460@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit e9e9a103528c7e199ead6e5374c9c52cf16b5802 ]

Clang warns when one enumerated type is implicitly converted to another.

drivers/scsi/isci/request.c:1629:13: warning: implicit conversion from
enumeration type 'enum sci_io_status' to different enumeration type
'enum sci_status' [-Wenum-conversion]
                        status = SCI_IO_FAILURE_RESPONSE_VALID;
                               ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/isci/request.c:1631:12: warning: implicit conversion from
enumeration type 'enum sci_io_status' to different enumeration type
'enum sci_status' [-Wenum-conversion]
                status = SCI_IO_FAILURE_RESPONSE_VALID;
                       ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

status is of type sci_status but SCI_IO_FAILURE_RESPONSE_VALID is of
type sci_io_status. Use SCI_FAILURE_IO_RESPONSE_VALID, which is from
sci_status and has SCI_IO_FAILURE_RESPONSE_VALID's exact value since
that is what SCI_IO_FAILURE_RESPONSE_VALID is mapped to in the isci.h
file.

Link: https://github.com/ClangBuiltLinux/linux/issues/153
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/isci/request.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/isci/request.c b/drivers/scsi/isci/request.c
index ed197bc8e801a..2f151708b59ae 100644
--- a/drivers/scsi/isci/request.c
+++ b/drivers/scsi/isci/request.c
@@ -1626,9 +1626,9 @@ static enum sci_status atapi_d2h_reg_frame_handler(struct isci_request *ireq,
 
 	if (status == SCI_SUCCESS) {
 		if (ireq->stp.rsp.status & ATA_ERR)
-			status = SCI_IO_FAILURE_RESPONSE_VALID;
+			status = SCI_FAILURE_IO_RESPONSE_VALID;
 	} else {
-		status = SCI_IO_FAILURE_RESPONSE_VALID;
+		status = SCI_FAILURE_IO_RESPONSE_VALID;
 	}
 
 	if (status != SCI_SUCCESS) {
-- 
2.20.1



