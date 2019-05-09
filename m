Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B355FC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72976217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428006;
	bh=AvzCBlu9b21RH+Bn5XnyCH1lsWQ02IjRZ9x6cTTvQXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L1xWiFoGcvp/yUOVB4P3JnOF0KeTQL4l4vW9Z38rWM1XSLV/6mr7gu6Wa5jhG7v1O
	 0fDFl4PPDMNITjvNYuzFDrAe2ROkYj10GR+vD70UAYQoHxCaJMwYMppI6MgIfj7CrG
	 fZdIxNvtArBQ1Cd/QTf5dMNkOxuN05Qdl3Iahr5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfEISxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbfEISxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:53:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0B8020578;
        Thu,  9 May 2019 18:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557428000;
        bh=AvzCBlu9b21RH+Bn5XnyCH1lsWQ02IjRZ9x6cTTvQXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AsQiJH2P/SXUMPAXICC+/P2de+u5V6kwquKa9c7oR5eeUOpbuccHpVFNUYE+co3rU
         gYjBh+qAuxb2OD2piqqKkQnn9WqqqYT2ACG8n9XBUtgWRn2e0KmehYDv2BN7XGinuD
         EK7hhW1cJer4SawfBfh9r3raeONS4z+UdsSrua3k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Vasquez <andrewv@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.0 85/95] scsi: qla2xxx: Fix incorrect region-size setting in optrom SYSFS routines
Date:   Thu,  9 May 2019 20:42:42 +0200
Message-Id: <20190509181315.221891173@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181309.180685671@linuxfoundation.org>
References: <20190509181309.180685671@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Vasquez <andrewv@marvell.com>

commit 5cbdae10bf11f96e30b4d14de7b08c8b490e903c upstream.

Commit e6f77540c067 ("scsi: qla2xxx: Fix an integer overflow in sysfs
code") incorrectly set 'optrom_region_size' to 'start+size', which can
overflow option-rom boundaries when 'start' is non-zero.  Continue setting
optrom_region_size to the proper adjusted value of 'size'.

Fixes: e6f77540c067 ("scsi: qla2xxx: Fix an integer overflow in sysfs code")
Cc: stable@vger.kernel.org
Signed-off-by: Andrew Vasquez <andrewv@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_attr.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -364,7 +364,7 @@ qla2x00_sysfs_write_optrom_ctl(struct fi
 		}
 
 		ha->optrom_region_start = start;
-		ha->optrom_region_size = start + size;
+		ha->optrom_region_size = size;
 
 		ha->optrom_state = QLA_SREADING;
 		ha->optrom_buffer = vmalloc(ha->optrom_region_size);
@@ -437,7 +437,7 @@ qla2x00_sysfs_write_optrom_ctl(struct fi
 		}
 
 		ha->optrom_region_start = start;
-		ha->optrom_region_size = start + size;
+		ha->optrom_region_size = size;
 
 		ha->optrom_state = QLA_SWRITING;
 		ha->optrom_buffer = vmalloc(ha->optrom_region_size);


