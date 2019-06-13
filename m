Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB836C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999CE20449
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="frSsZbuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387569AbfFMQdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:33:52 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:34817 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730803AbfFMH61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:58:27 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190613075825epoutp0482edeaefe4b863c96514a1dce5083090~nsxaHbooq3180131801epoutp04-
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 07:58:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190613075825epoutp0482edeaefe4b863c96514a1dce5083090~nsxaHbooq3180131801epoutp04-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560412705;
        bh=wzSwN4u5LkJkQagGovrAV/IuOaYbJLihVMExvb/oMPM=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=frSsZbuOIypJDjtPa0mKc/aTRFP3zfdjKJn57yeKvUfsiF0W0YrFST+seReIJcU/R
         lLrExlS2LQ2h+/hXtLUP7Stz8bxNzAc8KwQbSCEJCtmqYFg7dtwuW3zFc58E8tx6HC
         d3r+HYycPVb/EstYLhNBaYGEhKUNMArigQfknvA0=
Received: from epsmges2p1.samsung.com (unknown [182.195.40.182]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190613075822epcas2p4a781773dcd037e62ffe4ff785bab8950~nsxXiIKVN2815028150epcas2p4L;
        Thu, 13 Jun 2019 07:58:22 +0000 (GMT)
X-AuditID: b6c32a45-d47ff70000001063-fe-5d02021e9ee6
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.E6.04195.E12020D5; Thu, 13 Jun 2019 16:58:22 +0900 (KST)
Mime-Version: 1.0
Subject: [RFC PATCH] mpt3sas: support target smid for [abort|query] task
Reply-To: minwoo.im@samsung.com
From:   Minwoo Im <minwoo.im@samsung.com>
To:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "MPT-FusionLinux.pdl@broadcom.com" <MPT-FusionLinux.pdl@broadcom.com>
CC:     Minwoo Im <minwoo.im@samsung.com>,
        "sathya.prakash@broadcom.com" <sathya.prakash@broadcom.com>,
        "suganath-prabu.subramani@broadcom.com" 
        <suganath-prabu.subramani@broadcom.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Sarah Cho <sohyeon.jo@samsung.com>,
        Sungjun Park <sj1228.park@samsung.com>,
        Gyeongmin Nam <gm.nam@samsung.com>,
        Sanggwan Lee <sanggwan.lee@samsung.com>,
        "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190613075822epcms2p4ebf7116e0a10a1c80d746d9a17686a2d@epcms2p4>
Date:   Thu, 13 Jun 2019 16:58:22 +0900
X-CMS-MailID: 20190613075822epcms2p4ebf7116e0a10a1c80d746d9a17686a2d
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0hTURTHu3vP59N6cZ0/uhnUemap4dyTZrdwEZTxICutfyoc66EPJ+4X
        ezMsohYklUFZUNj6JRYp/dDyVzMJaqYrssiCUilTSCWzmZRlkdW2N6n/Pvdwzvl+z7mHJpRX
        qHi6yOIQ7RbBxFKRZEt78srUhQqFXnPLG4cHfetwdU+LAr+8e57Cx167KVzj/a3AP4/OxsNP
        7hP4wkenAlc3j4fhWxf7SHzsMY/rPRUUHu7KW8vwrndPKb7V9Tacr6i+D/iJoT6SP950DfBf
        GhbmUDtNmUZRKBDtKtGSby0oshTq2I3bDOsM2gwNl8qtwitZlUUwizp2fXZO6oYik98lq9ot
        mEr8oRxBkti0NZl2a4lDVBmtkkPHirYCk43jbGpJMEsllkJ1vtW8mtNo0rX+zF0m49m6B8DW
        Bktr/7hIJ6hkykEEjeAK1HP6A1kOImkldAP09cYwKAc0zcAoNO2ODmA05NFkfRCVcBGaGtUE
        KqNhMvK1dYUFmILLkPP0aLBLDPQCNNLkA4EHAScJ1N1YBWQtBlUeHiJlXoDu1DSH4rGo9/qn
        8Bke77wUisegsv6nhMxRaOBHW9Aaggj1+9bIeAA11eKAFIKHAOoZuxkqTUMHRyaCUgzchM41
        jAbbkDARHT/0KGRhPbo9UBeME/657nw6TwR6Ev7B6u+mye0T0MM+Us6Yi460T4fPDOK++F4h
        cwKa8HhCJuejmhcfKZl55D3oo+St5aK6uu0VYJHr32Zd/8m6/slWAeIaiBNtkrlQlNJt3P+f
        2QCCF5qS5QaVz7I9ANKAncPASKBXhgm7pT1mD0A0wcYwU7MUeiVTIOzZK9qtBnuJSZQ8QOuf
        /iQRH5tv9d+7xWHgtOkZGZpVWqzNSMfsPKZxdm+eEhYKDrFYFG2ifaZOQUfEO0FX3Cuh3JzE
        MSlrxz7wpaml35sTqt7EXjnhHJ9+0NGe5VUrf7/8rJ5K6m9dZhy0iUDv6qWWbO72XI3aobKS
        yW718+q9i+dvT9pCFCXUbs28PCdxUvfk3jdPVl7m0URDWbfDMdbaKe3vKFvyC/eeWn448pku
        d0UV3Kc/UtzydekZlpSMApdC2CXhL/Wdp8S3AwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190613075822epcms2p4ebf7116e0a10a1c80d746d9a17686a2d
References: <CGME20190613075822epcms2p4ebf7116e0a10a1c80d746d9a17686a2d@epcms2p4>
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

