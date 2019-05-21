Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBCCC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE356217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5UoPeIhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfEUMDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 08:03:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45888 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbfEUMDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 08:03:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LBwx54123998;
        Tue, 21 May 2019 12:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=TZYqrfFAU+1Y5NvFpYrOWNNOjV39r1AmCN+iJWl6phE=;
 b=5UoPeIhp+Fc2/NcSF86S1fKiYqMWKcw4TMoE9iBwYIjYmhOcvIVsqBYBfXewzTLzEJMo
 5COM6F8+KtTzwnB2AcROwv75BgFX7Wnhztfucx3Fr3eTf38kAJ3ucZY7UsGe+f/AuPck
 I/yN3zfYBVwnv2JqHwXi2FZpIG676cP5cdaeekZJTKTL/laGWsYdRnYtBhmJ/meHmQER
 FXUIflumM/14L9hMRWtFRFMqLRKa+Y9wkpXrAtoo3tOpNPiTy34sLI21cyihGYH5btlG
 sdyg81EIRE/bHZzFdm9QPBRADFsbaDU6ptMR/fHRdL5v4kmmmnLc1V4c3A+cFtT37Mye 1g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2sjapqcpn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 12:02:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LC2109025847;
        Tue, 21 May 2019 12:02:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2sm046xeyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 12:02:53 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4LC2ocm027898;
        Tue, 21 May 2019 12:02:50 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 May 2019 12:02:50 +0000
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ses: Fix out-of-bounds memory access in ses_enclosure_data_process()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190501180535.26718-1-longman@redhat.com>
        <1fd39969-4413-2f11-86b2-729787680efa@redhat.com>
        <1558363938.3742.1.camel@linux.ibm.com>
        <3385cf54-7b6c-3f28-e037-f0d4037368eb@redhat.com>
        <1558367212.3742.10.camel@linux.ibm.com> <yq1zhnh8625.fsf@oracle.com>
        <c14d427c-1d17-fc8f-672d-d612851abcc1@interlog.com>
Date:   Tue, 21 May 2019 08:02:48 -0400
In-Reply-To: <c14d427c-1d17-fc8f-672d-d612851abcc1@interlog.com> (Douglas
        Gilbert's message of "Mon, 20 May 2019 17:53:08 -0400")
Message-ID: <yq1h89o6mmv.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9263 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905210075
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9263 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905210075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Doug,

>> I am collecting "bad" SES pages from these devices. I have added
>> support for RECEIVE DIAGNOSTICS to scsi_debug and added a bunch of
>> deliberately broken SES pages so we could debug this
>
> Patches ??

I have included the plumbing below. However, I need to synthesize the
contents of the pages with problems. I can't share the ones I have
received from customers so I removed the arrays from the patch.

-- 
Martin K. Petersen	Oracle Linux Engineering

From 968dfc5cd498d2ea6e77801cc9b9183a1a28b35d Mon Sep 17 00:00:00 2001
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Date: Thu, 28 Mar 2019 22:29:13 -0400
Subject: [PATCH] scsi: scsi_debug: Implement support for Receive Diagnostics
 command

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 2740a90501a0..db8745a7000e 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -356,7 +356,8 @@ enum sdeb_opcode_index {
 	SDEB_I_WRITE_SAME = 26,		/* 10, 16 */
 	SDEB_I_SYNC_CACHE = 27,		/* 10, 16 */
 	SDEB_I_COMP_WRITE = 28,
-	SDEB_I_LAST_ELEMENT = 29,	/* keep this last (previous + 1) */
+	SDEB_I_RECV_DIAG = 29,
+	SDEB_I_LAST_ELEMENT = 30,	/* keep this last (previous + 1) */
 };
 
 
@@ -367,8 +368,8 @@ static const unsigned char opcode_ind_arr[256] = {
 	SDEB_I_READ, 0, SDEB_I_WRITE, 0, 0, 0, 0, 0,
 	0, 0, SDEB_I_INQUIRY, 0, 0, SDEB_I_MODE_SELECT, SDEB_I_RESERVE,
 	    SDEB_I_RELEASE,
-	0, 0, SDEB_I_MODE_SENSE, SDEB_I_START_STOP, 0, SDEB_I_SEND_DIAG,
-	    SDEB_I_ALLOW_REMOVAL, 0,
+	0, 0, SDEB_I_MODE_SENSE, SDEB_I_START_STOP, SDEB_I_RECV_DIAG,
+	SDEB_I_SEND_DIAG, SDEB_I_ALLOW_REMOVAL, 0,
 /* 0x20; 0x20->0x3f: 10 byte cdbs */
 	0, 0, 0, 0, 0, SDEB_I_READ_CAPACITY, 0, 0,
 	SDEB_I_READ, 0, SDEB_I_WRITE, 0, 0, 0, 0, SDEB_I_VERIFY,
@@ -433,6 +434,7 @@ static int resp_write_same_16(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_comp_write(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_write_buffer(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_sync_cache(struct scsi_cmnd *, struct sdebug_dev_info *);
+static int resp_recv_diag(struct scsi_cmnd *, struct sdebug_dev_info *);
 
 /*
  * The following are overflow arrays for cdbs that "hit" the same index in
@@ -613,8 +615,9 @@ static const struct opcode_info_t opcode_info_arr[SDEB_I_LAST_ELEMENT + 1] = {
 	{0, 0x89, 0, F_D_OUT | FF_MEDIA_IO, resp_comp_write, NULL,
 	    {16,  0xf8, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0, 0,
 	     0, 0xff, 0x3f, 0xc7} },		/* COMPARE AND WRITE */
-
-/* 29 */
+	{0, 0x1c, 0, FF_RESPOND | F_D_IN, resp_recv_diag, NULL, /* RECV DIAG */
+	    {6,  0x1, 0xff, 0xff, 0xff, 0xc7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
+/* 30 */
 	{0xff, 0, 0, 0, NULL, NULL,		/* terminating element */
 	    {0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
 };
@@ -1516,7 +1519,7 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 	arr[5] = (int)have_dif_prot;	/* PROTECT bit */
 	if (sdebug_vpd_use_hostno == 0)
 		arr[5] |= 0x10; /* claim: implicit TPGS */
-	arr[6] = 0x10; /* claim: MultiP */
+	arr[6] = 0x10 | 0x40; /* claim: MultiP */
 	/* arr[6] |= 0x40; ... claim: EncServ (enclosure services) */
 	arr[7] = 0xa; /* claim: LINKED + CMDQUE */
 	memcpy(&arr[8], sdebug_inq_vendor_id, 8);
@@ -3597,6 +3600,36 @@ static int resp_sync_cache(struct scsi_cmnd *scp,
 	return res;
 }
 
+static unsigned char diag0[] = {
+	0x00, 0x00, 0x00, 0x07, 0x00, 0x01, 0x02, 0x06, 0x07, 0x0a, 0xa0, 0x00,
+};
+#define DIAG0_LEN 12
+
+
+static int resp_recv_diag(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
+{
+	unsigned char *cmd = scp->cmnd;
+
+	switch(cmd[2]) {
+	case 0:
+		return fill_from_dev_buffer(scp, diag0, DIAG0_LEN);
+	case 1:
+		return fill_from_dev_buffer(scp, diag1, DIAG1_LEN);
+	case 2:
+		return fill_from_dev_buffer(scp, diag2, DIAG2_LEN);
+	case 6:
+		return fill_from_dev_buffer(scp, diag6, DIAG6_LEN);
+	case 7:
+		return fill_from_dev_buffer(scp, diag7, DIAG7_LEN);
+	case 0xa:
+		return fill_from_dev_buffer(scp, diaga, DIAGA_LEN);
+	case 0xa0:
+		return fill_from_dev_buffer(scp, diaga0, DIAGA0_LEN);
+	}
+
+	return DID_ERROR << 16;
+}
+
 #define RL_BUCKET_ELEMS 8
 
 /* Even though each pseudo target has a REPORT LUNS "well known logical unit"
