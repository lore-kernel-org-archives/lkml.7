Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A5CC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F7D21743
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hBHQOEPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392007AbfFMQeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:34:03 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:40785 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730786AbfFMHyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:54:09 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190613075406epoutp0118888d0ed51c51b6a9d2229321968b97~nsto0COR71458114581epoutp01D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 07:54:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190613075406epoutp0118888d0ed51c51b6a9d2229321968b97~nsto0COR71458114581epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560412446;
        bh=wzSwN4u5LkJkQagGovrAV/IuOaYbJLihVMExvb/oMPM=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=hBHQOEPIsoO+aFxvTpZVyEDoiRfWPbcqbS76HzOopffB651/CNE+UmP2jXBCZOPEY
         +stdDLx4EHVyIRqh/YirI3DBLQ/Ux5DsntttvV6ch02rbaPhGnscRKchRQrOeBsY0q
         AQgkLTcbswCN1InDhnDFwBoK0xBT8ipWoXVrnze8=
Received: from epsmges2p3.samsung.com (unknown [182.195.40.182]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190613075403epcas2p3b01bba2d3999339258a2b3a6897295fd~nstmLD5ZS3243632436epcas2p3L;
        Thu, 13 Jun 2019 07:54:03 +0000 (GMT)
X-AuditID: b6c32a47-5a93e9c00000106e-dc-5d02011aba0c
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.BE.04206.A11020D5; Thu, 13 Jun 2019 16:54:02 +0900 (KST)
Mime-Version: 1.0
Subject: [RFC PATCH] mpt3sas: support target smid for [abort|query] task
Reply-To: minwoo.im@samsung.com
From:   Minwoo Im <minwoo.im@samsung.com>
To:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "MPT-FusionLinux.pdl@broadcom.com" <MPT-FusionLinux.pdl@broadcom.com>
CC:     Minwoo Im <minwoo.im@samsung.com>,
        "sathya.prakash@broadcom.com" <sathya.prakash@broadcom.com>,
        "chaitra.basappa@broadcom.com" <chaitra.basappa@broadcom.com>,
        "suganath-prabu.subramani@broadcom.com" 
        <suganath-prabu.subramani@broadcom.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Sarah Cho <sohyeon.jo@samsung.com>,
        Sungjun Park <sj1228.park@samsung.com>,
        Gyeongmin Nam <gm.nam@samsung.com>,
        Sanggwan Lee <sanggwan.lee@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190613075402epcms2p7dbd2e2f7c80bd2aef2c5dd3736393d36@epcms2p7>
Date:   Thu, 13 Jun 2019 16:54:02 +0900
X-CMS-MailID: 20190613075402epcms2p7dbd2e2f7c80bd2aef2c5dd3736393d36
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTURzu3Hu9TfPGaVn9WtDsRkiSua1mx9CIlFqkYfRfKOviLiru1e60
        7IGL3iplSVDLzIyyjLLMx2pBNXvQE8perugBaS83Gz3ogdVeUv995+P7fb/vO+fIaHkjq5CV
        mO2izSwYeTaO6eyeTlIUiCpQPX+sJD7fOYq89meRpqedFOm5UM+S6iculjTf+E2R/tuXaXLw
        o4MiTR2DMeRMg5ch1Td1pNVTy5L+O/nzOZ3z5V1WV9t0GekCfV5Gt7O9Bek+t03Oi1lhzCgW
        BYNoSxTNhRZDibkok1+yXJ+l16ap1CnqdDKHTzQLJjGTz87JS1lYYgwm5BPLBWNZkMoTJIlP
        nZdhs5TZxcRii2TP5EWrwWhVq60zJcEklZmLZhZaTHPVKpVGG1SuNBbvP30FWd14zfE/TsaB
        9nFVSCYDPBtO+xVVKE4mxy4EHcd2MSGew2NgyDU2BMdiHXxtDUM5VsL3D6oqFBtkp4PffScm
        hFmcBI69H5iQSwK+geBtux+FDjT+Q0Nz7SMqpALMwb5tfUwET4Ku5g4UweOg96Rv5DAevH4o
        yifAlhd36QgeA69+uFEkMsAL/7wIrIT24yS0CvBmBE8HTkVHU2Hj20B4FYdz4Yv7fTgog6fB
        bc91NqLJhvsnnoV5Otiry1dPhzzpYLHWC6kR+6lw1ctEFKNhe/fQyOEiroY30VJTIeDxRENO
        hOYHH6PuOni0pyY8K8fLwPn4JlWLlM5/V+v8b6/z395GRLeg8aJVMhWJksY66//HbEPh35m8
        yIU67+V4EJYhPp7DcahAHiOUSxUmDwIZzSdwmtIRBXLOIFSsFW0Wva3MKEoepA3W300rxhVa
        gn/dbNertZq0NFW6lmjTNISfwLWN6s2X4yLBLpaKolW0Dc9RsliFA+l/vPl1WPmpsid/aMae
        pT1JjiTXlOQa5cbU+g3dPd2tvsZATbu3RnOk92fCemHa3IfXOuqULecG6P2LK39XZKyBbMOl
        B5tWWrya+LZtA+UldWxA8SRPVAxOiVdvfbeqtPDit6GsWyO4uvPVa4+uXuDKXRdLYt3pvGlH
        F5V+Vn5gMc9IxYI6mbZJwl8JXOrOswMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190613075402epcms2p7dbd2e2f7c80bd2aef2c5dd3736393d36
References: <CGME20190613075402epcms2p7dbd2e2f7c80bd2aef2c5dd3736393d36@epcms2p7>
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

