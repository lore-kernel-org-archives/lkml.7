Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB98CC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88274243F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i1pyhqTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfE3BmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 21:42:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52162 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfE3BmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 21:42:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U1d0Ba163161;
        Thu, 30 May 2019 01:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Pjb0boqwhTohB5CBxIww2RHM4T6rpUs5ByWOgMxA14A=;
 b=i1pyhqTEk9+RgzRoTyJW05yH7bUu4ol9s1bBaotXN1OuiwDlLSCfrzkniJYP6QqEbq5h
 QjhsrfsUkRQDwXmUUyveLNXAKrehEVKwYsS52wEzXx6I+QFYJ0Nv3TBw+A5Yd5t3OP+x
 9De6NirKMjseFgN88SoBd5H6BHGdFLWipTeksf3mVkS09zkbdIZ+HID12aeu8XpzmyKy
 h6SHA9RwbYvMccGwmelptsyaY/vEpDq7GIbj0KoHFOknOSOkTCNGJ2Kx/xA9GewMiJRF
 tBiqB6Jl5jrD7qIdR2phJlKdRPAcOPlpYNq38Ln7HpW4za/kbPofRWr/4kpGxgxyytk3 8A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2spw4tn9d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 01:41:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U1fNeo085043;
        Thu, 30 May 2019 01:41:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ss1fnss91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 01:41:56 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4U1ft5l008704;
        Thu, 30 May 2019 01:41:55 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 18:41:54 -0700
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     ddiss@suse.de, "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] target/iscsi: fix possible condition with no effect (if == else)
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190528012151.GA4845@hari-Inspiron-1545>
Date:   Wed, 29 May 2019 21:41:52 -0400
In-Reply-To: <20190528012151.GA4845@hari-Inspiron-1545> (Hariprasad Kelam's
        message of "Tue, 28 May 2019 06:51:52 +0530")
Message-ID: <yq1pno0zpjz.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=841
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=895 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hariprasad,

> fix below warning reported by coccicheck
>
> drivers/target/iscsi/iscsi_target_nego.c:175:6-8: WARNING: possible
> condition with no effect (if == else)

Applied to 5.3/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
