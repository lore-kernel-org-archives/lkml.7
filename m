Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD70C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 01:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4312085A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 01:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="icfG0FHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfFSBKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 21:10:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37354 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfFSBKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 21:10:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J14gVQ192813;
        Wed, 19 Jun 2019 01:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=gYDJ565bmJ/QILPFBSke6/24C2eShrgNLI/7RNOCw/w=;
 b=icfG0FHWMgimSuNPuK9FMjXUPxMOECtOivd6pKYKAlFth5lA7sZVGJOzbZjppfZVnNXh
 WbcVRbEE6oOHJG366THADmDiveFXk/KKvFk4+5vy8jbmFc/pBS/WkR7y+rbS+gzmYezk
 m0epdJZz6kg+TwkEQXfBBQ5DzItXsVMXAu21UcDifGXzV0CHDlW441b7FVcxIhpJp4lu
 XQnwPL3CPNAo9ATiseE3r36n1e5GjbhD8KtmOyEQeHJWa3sdsOTm8o/vmrmVBg4UBmBI
 4QXYi7tCtcLTStp8798vWxD4u6aFhZK5Fb5RjHgHbAbKnpq4iFAVWIIltkuvaYvIIJr+ nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t78098g35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 01:10:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J19D8l054858;
        Wed, 19 Jun 2019 01:10:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2t77yn20dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 01:10:44 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5J1AgQA031238;
        Wed, 19 Jun 2019 01:10:43 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 18:10:42 -0700
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: tcmu: Simplify 'tcmu_update_uio_info()'
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190616070220.24189-1-christophe.jaillet@wanadoo.fr>
Date:   Tue, 18 Jun 2019 21:10:40 -0400
In-Reply-To: <20190616070220.24189-1-christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Sun, 16 Jun 2019 09:02:20 +0200")
Message-ID: <yq1blyuxtv3.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=920
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190007
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=984 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190007
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christophe,

> Use 'kasprintf()' instead of:
>    - snprintf(NULL, 0...
>    - kmalloc(...
>    - snprintf(...
>
> This is less verbose and saves 7 bytes (i.e. the space for '/(null)') if
> 'udev->dev_config' is NULL.

Applied to 5.3/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
