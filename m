Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E516C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D91216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802394;
	bh=t6eA6VKXVROaAH59iF6DMwE06CidU+UM0bKpkui1p7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vVoaB80qkcRpWggZkJnDZAsYFFHCO2j6EvwJm/VLbBfdSwnTzrV5fBh0He1E0d5Fi
	 aTt6xcmOKnQG4Htpeb5Eqd1gX8rwSVli79j9N2RKUO5kdYTnEAV+hfsBDo75Xq7v43
	 WVjOHCwcSBwhrVjYLdtF6CEqRKFkuVpneL8o15PY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbfHNRGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:06:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729670AbfHNRGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:06:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 988C0208C2;
        Wed, 14 Aug 2019 17:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802391;
        bh=t6eA6VKXVROaAH59iF6DMwE06CidU+UM0bKpkui1p7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d6bDvq+aCvQKT1O1FtxVrNdHEsw2ASdMvOwmU+6+bPADu41P14segcEN3X8A7lN+v
         S8/afAB4yTj7n7a4T+MCZwqzJ2U2zIW1QtBFLdsfmR+aaQKCXWxrhcO+zjcsArKQvE
         sei4HWLLV0MS9FKQBDdVQk9Ne2xjKQ0Rb6o11iCE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Junxiao Bi <junxiao.bi@oracle.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 107/144] scsi: megaraid_sas: fix panic on loading firmware crashdump
Date:   Wed, 14 Aug 2019 19:01:03 +0200
Message-Id: <20190814165804.380628302@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165759.466811854@linuxfoundation.org>
References: <20190814165759.466811854@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 3b5f307ef3cb5022bfe3c8ca5b8f2114d5bf6c29 ]

While loading fw crashdump in function fw_crash_buffer_show(), left bytes
in one dma chunk was not checked, if copying size over it, overflow access
will cause kernel panic.

Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 7237114a1d534..5f30016e9b64f 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3045,6 +3045,7 @@ megasas_fw_crash_buffer_show(struct device *cdev,
 	u32 size;
 	unsigned long buff_addr;
 	unsigned long dmachunk = CRASH_DMA_BUF_SIZE;
+	unsigned long chunk_left_bytes;
 	unsigned long src_addr;
 	unsigned long flags;
 	u32 buff_offset;
@@ -3070,6 +3071,8 @@ megasas_fw_crash_buffer_show(struct device *cdev,
 	}
 
 	size = (instance->fw_crash_buffer_size * dmachunk) - buff_offset;
+	chunk_left_bytes = dmachunk - (buff_offset % dmachunk);
+	size = (size > chunk_left_bytes) ? chunk_left_bytes : size;
 	size = (size >= PAGE_SIZE) ? (PAGE_SIZE - 1) : size;
 
 	src_addr = (unsigned long)instance->crash_buf[buff_offset / dmachunk] +
-- 
2.20.1



