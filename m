Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2A6C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540422442D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DN0EW6+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfE3CWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 22:22:13 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44832 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfE3CWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 22:22:13 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U2J1Ob011938;
        Thu, 30 May 2019 02:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=TydgSuxW1pWzusJHeoqCWsVAH6tbpZAvDeYoJkM1QCE=;
 b=DN0EW6+yE67YzXIIGLcT8zY0A3ArvRNJgHEEc1nX9jqcxgu09y7cz+SCbbZdkryTtqGP
 OlKCnkNvaO49METNTM00WTPg9KJnFWI3KIqf11ODo8jT/oPlIGpdgaXBxXSyjvx1FclQ
 k1DccYH7Dz0YvRCpbKazQqGC/WoWkOxfYmbMEIMam3KcjxGCBMVYBJYormGYV7jeG8Hm
 jllX+mfpZYaT//uzSv0c9qU4uOCulP5Md2x+pL22GAZ800r/vI17hjjENdxFTNOaXABg
 wnzn758hJm7dKcHUAU/7a1K37uz/uK4I9BWKdeJicUH3/gtxVEPH5IqiDxoXuxnONtJG lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2spu7dnkfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 02:22:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U2KZ1I034535;
        Thu, 30 May 2019 02:22:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2sqh7421vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 02:22:07 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4U2M6PH029860;
        Thu, 30 May 2019 02:22:06 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 19:22:05 -0700
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     sathya.prakash@broadcom.com, chaitra.basappa@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mpt3sas_ctl: fix double-fetch bug in _ctl_ioctl_main()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190530011030.GA6314@zhanggen-UX430UQ>
Date:   Wed, 29 May 2019 22:22:03 -0400
In-Reply-To: <20190530011030.GA6314@zhanggen-UX430UQ> (Gen Zhang's message of
        "Thu, 30 May 2019 09:10:30 +0800")
Message-ID: <yq1ef4gy94k.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=992
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300016
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gen,

> In _ctl_ioctl_main(), 'ioctl_header' is fetched the first time from 
> userspace. 'ioctl_header.ioc_number' is then checked. The legal result 
> is saved to 'ioc'. Then, in condition MPT3COMMAND, the whole struct is
> fetched again from the userspace. Then _ctl_do_mpt_command() is called,
> 'ioc' and 'karg' as inputs.
>
> However, a malicious user can change the 'ioc_number' between the two 
> fetches, which will cause a potential security issues.  Moreover, a 
> malicious user can provide a valid 'ioc_number' to pass the check in 
> first fetch, and then modify it in the second fetch.
>
> To fix this, we need to recheck the 'ioc_number' in the second fetch.

Applied to 5.3/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
