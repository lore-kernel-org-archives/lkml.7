Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7279FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A2B2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PjPCwvaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfCTSZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:25:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54402 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfCTSZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:25:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2KIIiAl058146;
        Wed, 20 Mar 2019 18:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=R1yP7UCzlwxAWXTCKsGcdM+AdiTDUzVvsZjuxTqbEHI=;
 b=PjPCwvaOqY2grdV4fDxIvO6Y8kNONJrggVlIee54fzuBkcYjKEYiZpbuBN32g/EccOyN
 ntJu3sNw/4rOFZg2K5yYqPr4e+YVo1KKDldICRxZ9CpyL+g/ngh3uFRknr93wjr/7r85
 0VfVmkL97bAXP9FacTc87RNV80vT1RafqqNVO9FJAj+LmokBpEe9vpTuSHAWXvi3YFZk
 aU30mO4I91A+tTKa1b8NAXgbkOG6tzlv4lqkdYAXecJ905S/RenfYf5xO+ee0QeaaA2H
 it46q/QICXk2nR9B4kz18LSoJpfBHG6UAQfq19YziwSIHo4jdFuEUm+jU+4+Z9rfgda7 fA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2r8ssrmd8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 18:25:44 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2KIPhfa012710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 18:25:43 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2KIPhXH028263;
        Wed, 20 Mar 2019 18:25:43 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Mar 2019 11:25:43 -0700
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Luo Jiaxing <luojiaxing@huawei.com>
Subject: Re: [PATCH] scsi: hisi_sas: Add softreset in hisi_sas_I_T_nexus_reset()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1553077294-129863-1-git-send-email-john.garry@huawei.com>
Date:   Wed, 20 Mar 2019 14:25:40 -0400
In-Reply-To: <1553077294-129863-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Wed, 20 Mar 2019 18:21:34 +0800")
Message-ID: <yq1k1gt8kt7.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9201 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=485 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903200134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> We need to always follow an internal abort with a software reset, as
> per HW programming flow, so add this.

Mangled patch. Applied it by hand to 5.1/scsi-fixes but please use git
send-email.

-- 
Martin K. Petersen	Oracle Linux Engineering
