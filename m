Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA75C76188
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 02:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8152173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 02:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZXlJnyaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbfGQCs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 22:48:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42586 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfGQCs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 22:48:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H2iQvb177284;
        Wed, 17 Jul 2019 02:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=UVcvz0ojB67vzZ8WNdqNMDmGr/Pgq7JR2kih32TkJVc=;
 b=ZXlJnyaNDROLY/C0M8G7ZBnAsvfAmi2uI7jHdajSa1wB4sActd5r1gQ08r8H9PpB8pjc
 E7uW6XK6XcqkbNqUgFVzJZjkTN0A6bYX5/HRJMS1I4UJ/PeqiM0HP5yD91ngYe9dQ/Or
 8OBf8WXwtGXRmBKFZEfQKyTYMXQCII36qXLNI6SwCkMQDpZQIu4sNaYLwT8hfIf9EtXi
 iBhw0AgHBDw7CYJniZjrWPHAP8gFXe8IBsxmqU/UiopjFLSHthQeU+46kfugigBqTLF2
 CstA45eLb67/U/r31m8bhC1Pzt3Ej0J3tBC7EuVZzt1RZpdENhk4EGNmOIuIQEsH/jgG Fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2tq78pqsm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 02:46:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H2givm007681;
        Wed, 17 Jul 2019 02:46:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2tq4du8jja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 02:46:20 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6H2kItY029346;
        Wed, 17 Jul 2019 02:46:19 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 02:46:18 +0000
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <james.smart@broadcom.com>, <dick.kennedy@broadcom.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH -next] scsi: lpfc: Remove unnecessary null check before kfree
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190711141037.57880-1-yuehaibing@huawei.com>
Date:   Tue, 16 Jul 2019 22:46:09 -0400
In-Reply-To: <20190711141037.57880-1-yuehaibing@huawei.com>
        (yuehaibing@huawei.com's message of "Thu, 11 Jul 2019 22:10:37 +0800")
Message-ID: <yq17e8hz8cu.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=927
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170032
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=994 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


YueHaibing,

> A null check before a kfree is redundant, so remove it.
> This is detected by coccinelle.

Applied to 5.4/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
