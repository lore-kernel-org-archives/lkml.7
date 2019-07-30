Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3465DC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1235720665
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbfG3O4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:56:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727129AbfG3O4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:56:45 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6UErli7110338
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 10:56:44 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u2nnt79ar-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 10:56:44 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.ibm.com>;
        Tue, 30 Jul 2019 15:56:41 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 30 Jul 2019 15:56:39 +0100
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6UEuci351446036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 14:56:38 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 906EF2805E;
        Tue, 30 Jul 2019 14:56:38 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCA2E28059;
        Tue, 30 Jul 2019 14:56:37 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.131.103])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Jul 2019 14:56:37 +0000 (GMT)
Subject: Re: [PATCH] scsi: 3w-sas: Fix unterminated strncpy
From:   James Bottomley <jejb@linux.ibm.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Adam Radford <aradford@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 30 Jul 2019 07:56:37 -0700
In-Reply-To: <20190730084047.26482-1-hslester96@gmail.com>
References: <20190730084047.26482-1-hslester96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19073014-0064-0000-0000-000004047A97
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011523; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01239635; UDB=6.00653626; IPR=6.01021048;
 MB=3.00027958; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-30 14:56:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19073014-0065-0000-0000-00003E79B900
Message-Id: <1564498597.4300.10.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=728 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907300154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-30 at 16:40 +0800, Chuhong Yuan wrote:
> strncpy(dest, src, strlen(src)) leads to unterminated
> dest, which is dangerous.

I don't buy that.  The structure is only used for the
TW_IOCTL_GET_COMPATIBILITY_INFO ioctl and all the fields for that are
fixed width and are copied over as such.

> Here driver_version's len is 32 and TW_DRIVER_VERSION
> is shorter than 32.
> Therefore strcpy is OK.

The best practice for copying a string to a fixed width destination
that does get printed within the kernel would be what the 3w-9xxx.c
does

	strlcpy(tw_dev->tw_compat_info.driver_version, TW_DRIVER_VERSION,
		sizeof(tw_dev->tw_compat_info.driver_version));

But as I said, it doesn't really matter for a fixed width field that's
never printed within the kernel.

James

