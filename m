Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E207C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4516F24682
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781760;
	bh=7K7fB04p0JMzjWIQ0S0tHZBBYEMuF7Tj4YxhfcvKRbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D2iQSADhA3khzu3ZMetGJz3n4zCxjCUJpmv13pK3AdbdSGHV8HpT+nrZxI/LI3XIt
	 2BU2RbW26iYiXUDXCJ8bvswkgHbkelL1hJhQP1/044cb04JB94KT9vDXwY4QTK4BG3
	 ga1gtv931FbFM1THX9vMde6kd0ptF80B40y2H5Jk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbfLSSz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:55:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:52122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730738AbfLSSzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:55:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BA8324689;
        Thu, 19 Dec 2019 18:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781752;
        bh=7K7fB04p0JMzjWIQ0S0tHZBBYEMuF7Tj4YxhfcvKRbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G9CS4O/NSR025t/twJqowYElezpq4MjyXTAhYb9wBdcEeB6a3hh+IPJCm4kBSn3Jy
         7p6bsVhwkdTp9TgGJIUIi1KAzpuKk23hUHjKjWM0tjhQ6r0VSWmtAFRf+koZDIRaJP
         8QM1s3oQplVo0UOKuOqyxUQHktyQSB+GWQV3JkP8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Hernandez <mhernandez@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.4 65/80] scsi: qla2xxx: Fix incorrect SFUB length used for Secure Flash Update MB Cmd
Date:   Thu, 19 Dec 2019 19:34:57 +0100
Message-Id: <20191219183137.458270274@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183031.278083125@linuxfoundation.org>
References: <20191219183031.278083125@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Hernandez <mhernandez@marvell.com>

commit c868907e1ac6a08a17f8fa9ce482c0a496896e9e upstream.

SFUB length should be in DWORDs when passed to FW.

Fixes: 3f006ac342c03 ("scsi: qla2xxx: Secure flash update support for ISP28XX")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20191203223657.22109-4-hmadhani@marvell.com
Signed-off-by: Michael Hernandez <mhernandez@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_sup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_sup.c
+++ b/drivers/scsi/qla2xxx/qla_sup.c
@@ -2897,7 +2897,7 @@ qla28xx_write_flash_data(scsi_qla_host_t
 			    "Sending Secure Flash MB Cmd\n");
 			rval = qla28xx_secure_flash_update(vha, 0, region.code,
 				buf_size_without_sfub, sfub_dma,
-				sizeof(struct secure_flash_update_block));
+				sizeof(struct secure_flash_update_block) >> 2);
 			if (rval != QLA_SUCCESS) {
 				ql_log(ql_log_warn, vha, 0xffff,
 				    "Secure Flash MB Cmd failed %x.", rval);


