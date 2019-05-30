Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567D3C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C348218A0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WjcNOIJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfE3Cdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 22:33:46 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53446 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfE3Cdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 22:33:46 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U2StPf018593;
        Thu, 30 May 2019 02:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=dGCIafp7VDqohybWxtkIDVZ9hz1ctA/NYycXfmXMbg0=;
 b=WjcNOIJIaxMn+aujvfKz3xjZIAjdX3GDKmXpkVIjpjsmWwqHL7snqmM+4SZGTrgjNaEn
 41cwt5yo3XLsLiQAw44JDykMlvNYiqQXmU7ZpsKMk0XMX8an9u5OJpPU2F3We/uJLs3d
 3Cdwa2EU6A3kNTZ5TOOaWRMKo5wqyPmy5yRlhdAca3GbRvvxiPrTHkLPNi2OwaLi7MrB
 Ix8tgXWDGLbLX1sp690LxjbuXRpse/7iRff1VYFl/HTiVBoyCOCY1Ybjdm/2QMhHDfeb
 wo4o6ZTXk7/dWNrUJsHVgRMvm/K1YocntfG2WWEY4591njJLPKZ7IH2VfeYSM1aAuwDB 9A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2spu7dnmah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 02:33:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U2XWqO026510;
        Thu, 30 May 2019 02:33:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2srbdxqxys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 02:33:40 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4U2Xdfp002077;
        Thu, 30 May 2019 02:33:39 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 19:33:39 -0700
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     sathya.prakash@broadcom.com, suganath-prabu.subramani@broadcom.com,
        joe@perches.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] message/fusion/mptbase.c: Use kmemdup instead of memcpy and kmalloc
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190522160149.GA19160@bharath12345-Inspiron-5559>
Date:   Wed, 29 May 2019 22:33:36 -0400
In-Reply-To: <20190522160149.GA19160@bharath12345-Inspiron-5559> (Bharath
        Vedartham's message of "Wed, 22 May 2019 21:31:49 +0530")
Message-ID: <yq1tvdcwu0v.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=725
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300018
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=779 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bharath,

> Replace kmalloc + memcpy with kmemdup.

Applied to 5.3/scsi-queue. Thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
