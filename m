Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DE3C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084A724684
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578430640;
	bh=b3TYZKxWPwNCOPS2YJaa8UxvCI0oODsHhPh2IJqpYaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Lc4waaKKaaPYCLvXGFmMV86h/xdhgLHfeXun0ZWqXQ4PfY/6gJw53vnAd/z8AAZm
	 4a64z9EGbzVi/W9ZtqeaaU9IhPAewWBRN5kKw8oOqXKF4ljYQTi5ebDuCgqaskkmfI
	 fm8bqdJAsT3hvfRp1WlG/5vyFGSujWB+quWVdjKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgAGU5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:57:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727500AbgAGU5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:57:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6C752087F;
        Tue,  7 Jan 2020 20:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430633;
        bh=b3TYZKxWPwNCOPS2YJaa8UxvCI0oODsHhPh2IJqpYaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=17Vo1R+gSAYFOqap+0yS0fKeSB1lal/sL3X2hXNvseFG993zR75EixuuBF2PqB3PA
         u2fc+GkHnW+DELCl2kbm1PcJgTtvjOMmSyijR513yYeDdOTCuCTW/h3eFsbQLSPrBe
         KUPi9qGIzLlA77t5kF4nRvax+veuE67HuxSg0fp4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 032/191] scsi: iscsi: qla4xxx: fix double free in probe
Date:   Tue,  7 Jan 2020 21:52:32 +0100
Message-Id: <20200107205334.717759163@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
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
index 8c674eca09f1..2323432a0edb 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -4275,7 +4275,6 @@ static int qla4xxx_mem_alloc(struct scsi_qla_host *ha)
 	return QLA_SUCCESS;
 
 mem_alloc_error_exit:
-	qla4xxx_mem_free(ha);
 	return QLA_ERROR;
 }
 
-- 
2.20.1



