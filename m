Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9957FC31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68ACF21743
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jEBSalUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbfFMQfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:35:06 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:63977 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730735AbfFMHpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:45:18 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190613074515epoutp03dbd7b05041249195471621cc0b002369~nsl6hKQ7M1941419414epoutp03F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 07:45:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190613074515epoutp03dbd7b05041249195471621cc0b002369~nsl6hKQ7M1941419414epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560411915;
        bh=wzSwN4u5LkJkQagGovrAV/IuOaYbJLihVMExvb/oMPM=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=jEBSalUQJ1oRRkn4CwhvyZVi+JaoIF0/J27tJR8dkAwYuBkdOUA5fd+Hka+b9eGRM
         r53Gmtvjzam3N+O5ZhLb5e8nzOSeHEn7uO8b/YOvMol0hEPKnt04W/6imjAepVnPZ1
         thHMwQDf8ydNYJH/uAR04VEuaaqdFslPwvTOjq40=
Received: from epsmges2p1.samsung.com (unknown [182.195.40.189]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190613074512epcas2p10a951359c2519e822ad7704992aa6188~nsl31cA0g2450724507epcas2p1T;
        Thu, 13 Jun 2019 07:45:12 +0000 (GMT)
X-AuditID: b6c32a45-d47ff70000001063-53-5d01ff078130
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.AF.04195.70FF10D5; Thu, 13 Jun 2019 16:45:11 +0900 (KST)
Mime-Version: 1.0
Subject: [RFC PATCH] mpt3sas: support target smid for [abort|query] task
Reply-To: minwoo.im@samsung.com
From:   Minwoo Im <minwoo.im@samsung.com>
To:     "MPT-FusionLinux.pdl@broadcom.com" <MPT-FusionLinux.pdl@broadcom.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Minwoo Im <minwoo.im@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "sathya.prakash@broadcom.com" <sathya.prakash@broadcom.com>,
        "chaitra.basappa@broadcom.com" <chaitra.basappa@broadcom.com>,
        "suganath-prabu.subramani@broadcom.com" 
        <suganath-prabu.subramani@broadcom.com>,
        Sarah Cho <sohyeon.jo@samsung.com>,
        Gyeongmin Nam <gm.nam@samsung.com>,
        Sanggwan Lee <sanggwan.lee@samsung.com>,
        Sungjun Park <sj1228.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190613074511epcms2p4cfd590711eefbd66414400f46d87354a@epcms2p4>
Date:   Thu, 13 Jun 2019 16:45:11 +0900
X-CMS-MailID: 20190613074511epcms2p4cfd590711eefbd66414400f46d87354a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTURjHO7vX6828dZwvnTRKb5QlqLujrVOkFWWsF0GrDxHZurnbFPfG
        7pT0S7MXrIRYRGSjMg2caGml1kgCXalJFvSuRmYvGvmKRVKU2bY7qW+/c3ie///5P+fQhPwK
        FU3nmmyC1cQbWCqEvH1/hSoxeBpkKT70q/HoaIMMvx/biCu7b8vw87sXKVz62k1hV8cfGR58
        1ELgS8N2Ga5sGg/CNy73kri0U4PrPQ4KD3btXc9onO8eUxpHZQvQTAz0kprTjTVA8+3Wooyg
        PYa1OQKvE6yxginbrMs16VPYbTu1G7UqtYJL5FbjVWysiTcKKeym7RmJm3MN3gnZ2ALekO+9
        yuBFkU1OXWs159uE2ByzaEthBYvOYOE4S5LIG8V8kz4p22xcwykUSpW3cr8h50JdK7A0w0PV
        007SDsqYU2A2jeBK1PC0lvSxHLoBmroedQrQNAPD0JQ73IfhUIO+1/tRDhejH0MKX3E4XIHG
        mruCfEzBeGQ/N+QVCaEjYAdAPVXVMt+BgNMEspffoyQrBpWVDJASx6A7riYgcSTqqR0NnuHx
        9vLAfQQ63veYkDgM9f9sBr4hEESobyxVwsOosRr7rBA8BlD3yPVAazIq/jzht2JgOnLcdPiZ
        hEtRc/eJgOQm1PbhtN+W8Oa6M3qR8GkS3mD1d5Ml+SXoQS8pVcxFJ+5PBc8EcV/+JJN4CZrw
        eAKKC5Dr2XAgrAZVXCuWSXvNREeel1MOsNj5b7XO/3yd/3yvAKIGRAkW0agXRKWF+/8xbwH/
        70xIc4OyJ9s9ANKADWVgCMiSB/EFYqHRAxBNsBGMMm9WlpzR8YVFgtWsteYbBNEDVN74Z4jo
        yGyz96+bbFpOpVSrFatVWKVWYnY+0zCnZ68c6nmbkCcIFsE60yejZ0fbwcL4l67irRv0RfqK
        qq+NW7SdYQ03Y0qp4cm2wjhr22BN+qoS9+RH1pWa1pWrT8tMPnBIrJ5+kd70KPTqgiLq5L6o
        vAt1fY7GVw9/11+rm8e92T/++eRZYd2ag3Hnd3T8XG6W7/qybKhlpF0V4inf3TqgK3X9qmrf
        dbTf9dZUEJcZ086SYg7PJRBWkf8LXzkEYLMDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190613074511epcms2p4cfd590711eefbd66414400f46d87354a
References: <CGME20190613074511epcms2p4cfd590711eefbd66414400f46d87354a@epcms2p4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can request task management IOCTL command(MPI2_FUNCTION_SCSI_TASK_MGMT)
to /dev/mpt3ctl.  If the given task_type is either abort task or query
task, it may need a field named "Initiator Port Transfer Tag to Manage"
in the IU.

Current code does not support to check target IPTT tag from the
tm_request.  This patch introduces to check TaskMID given from the
userspace as a target tag.  We have a rule of relationship between
(struct request *req->tag) and smid in mpt3sas_base.c:

3318 u16
3319 mpt3sas_base_get_smid_scsiio(struct MPT3SAS_ADAPTER *ioc, u8 cb_idx,
3320         struct scsi_cmnd *scmd)
3321 {
3322         struct scsiio_tracker *request = scsi_cmd_priv(scmd);
3323         unsigned int tag = scmd->request->tag;
3324         u16 smid;
3325
3326         smid = tag + 1;

So if we want to abort a request tagged #X, then we can pass (X + 1) to
this IOCTL handler.

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
---
 drivers/scsi/mpt3sas/mpt3sas_ctl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index b2bb47c14d35..5c7539dae713 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -596,15 +596,17 @@ _ctl_set_task_mid(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command *karg,
 		if (priv_data->sas_target->handle != handle)
 			continue;
 		st = scsi_cmd_priv(scmd);
-		tm_request->TaskMID = cpu_to_le16(st->smid);
-		found = 1;
+		if (tm_request->TaskMID == st->smid) {
+			tm_request->TaskMID = cpu_to_le16(st->smid);
+			found = 1;
+		}
 	}
 
 	if (!found) {
 		dctlprintk(ioc,
-			   ioc_info(ioc, "%s: handle(0x%04x), lun(%d), no active mid!!\n",
+			   ioc_info(ioc, "%s: handle(0x%04x), lun(%d), no matched mid(%d)!!\n",
 				    desc, le16_to_cpu(tm_request->DevHandle),
-				    lun));
+				    lun, tm_request->TaskMID));
 		tm_reply = ioc->ctl_cmds.reply;
 		tm_reply->DevHandle = tm_request->DevHandle;
 		tm_reply->Function = MPI2_FUNCTION_SCSI_TASK_MGMT;
-- 
2.16.1

