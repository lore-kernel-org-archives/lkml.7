Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024D8C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C785F20678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431073;
	bh=fD30xHA+J0qZBkzzvE0CUtKOV2ktSYvGLN96VwbX1Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=shJZvFgaBFdplwKAf41iajjojcn14Ct61y2dR0qlVnRph4R1gMPgyY7P6vF6jQC6U
	 vIhaYsKXCxbQ0LqOOCRsljyJOlrWqI0ZSDpwGET3Tr82VY/FzejzCoDsbXzBe+nWLp
	 CqVlY5+vy67mQaQ7IZG3hhj3bbTy1y2BCLAZefe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgAGVEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:04:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:48784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727543AbgAGVE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:04:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB3A42081E;
        Tue,  7 Jan 2020 21:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431068;
        bh=fD30xHA+J0qZBkzzvE0CUtKOV2ktSYvGLN96VwbX1Lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HtUQ6grtzEZ6TF9bJHZERjcTrlfwBtPj065HoP0twP4TxSIPHin+gMjJ7QKdbFILt
         O4mboogY9cFBKAZkyuQ35l3moRna8ouvSc+5VMUEYbuRGPa82Riz+GSzmc4MBK0wq5
         1ZlhYdt3VZ/Y98nwV7cO6WhZ4iOyp0KSlveHj0wk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 021/115] scsi: iscsi: qla4xxx: fix double free in probe
Date:   Tue,  7 Jan 2020 21:53:51 +0100
Message-Id: <20200107205254.302233135@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit fee92f25777789d73e1936b91472e9c4644457c8 ]

On this error path we call qla4xxx_mem_free() and then the caller also
calls qla4xxx_free_adapter() which calls qla4xxx_mem_free().  It leads to a
couple double frees:

drivers/scsi/qla4xxx/ql4_os.c:8856 qla4xxx_probe_adapter() warn: 'ha->chap_dma_pool' double freed
drivers/scsi/qla4xxx/ql4_os.c:8856 qla4xxx_probe_adapter() warn: 'ha->fw_ddb_dma_pool' double freed

Fixes: afaf5a2d341d ("[SCSI] Initial Commit of qla4xxx")
Link: https://lore.kernel.org/r/20191203094421.hw7ex7qr3j2rbsmx@kili.mountain
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla4xxx/ql4_os.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 25c8ce54a976..f8acf101af3d 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -4280,7 +4280,6 @@ static int qla4xxx_mem_alloc(struct scsi_qla_host *ha)
 	return QLA_SUCCESS;
 
 mem_alloc_error_exit:
-	qla4xxx_mem_free(ha);
 	return QLA_ERROR;
 }
 
-- 
2.20.1



