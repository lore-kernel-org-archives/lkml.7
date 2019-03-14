Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735E9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A3721019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GeLLX/EN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfCNLIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:08:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52492 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfCNLIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:08:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2EAxCer156664;
        Thu, 14 Mar 2019 11:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=LWzoZMZ/UHlJ+7SdQumtog3WWZUs0VLq8IX/rc7IR0o=;
 b=GeLLX/EN0qyPkLy0f64NCWORTZ7FymHsD2wlk4D93aZ9Tk2V3UqYxaTtNQKmrilWhp6E
 dW3lriWaYKUq1qMbepgI/FEQDYPZjopYsACWiAOB3cW1XozYXEltkN024K+gOCAf15Cj
 HAAxH5GkjG7nciZFlj4vzfNYEEFVjDdte4GhKwB+rrokw9+hGC/dU0YTWYY1bArs0Rnf
 L4HHzqQPvojz0vq5Tt4lGjtqSsXs1a6i6DSdSn2lmgJyA8Jg+8PlCO7397HX7DQ5YrB0
 MNMJ4+r1tzj94VVkcZeS2RqSi9W+SB2Y3f0450oiqmikU1gvTWqDdua41d0VeCZVv8dM MA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2r44wuga28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 11:08:05 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2EB84sv004768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 11:08:04 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2EB84vZ011707;
        Thu, 14 Mar 2019 11:08:04 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Mar 2019 11:07:01 +0000
To:     Hannes Reinecke <hare@suse.de>
Cc:     YueHaibing <yuehaibing@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH -next] scsi: libfc: Fix potential NULL pointer dereference
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190130101141.20132-1-yuehaibing@huawei.com>
        <09c3242f-9a41-65f4-7dc6-f1c8aa6425f1@huawei.com>
        <c2ae320a-e7ab-94e6-7562-a82e2aad0966@suse.de>
Date:   Thu, 14 Mar 2019 07:06:59 -0400
In-Reply-To: <c2ae320a-e7ab-94e6-7562-a82e2aad0966@suse.de> (Hannes Reinecke's
        message of "Thu, 7 Mar 2019 13:11:06 +0100")
Message-ID: <yq1y35hn298.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9194 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903140078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Hannes,

>>> There is a potential NULL pointer dereference in case
>>> fc_rport_create() fails and returns NULL.

>>> diff --git a/drivers/scsi/libfc/fc_lport.c b/drivers/scsi/libfc/fc_lport.c
>>> index ff943f4..e2a3551 100644
>>> --- a/drivers/scsi/libfc/fc_lport.c
>>> +++ b/drivers/scsi/libfc/fc_lport.c
>>> @@ -250,6 +250,10 @@ static void fc_lport_ptp_setup(struct fc_lport *lport,
>>>   	}
>>>   	mutex_lock(&lport->disc.disc_mutex);
>>>   	lport->ptp_rdata = fc_rport_create(lport, remote_fid);
>>> +	if (!lport->ptp_rdata) {
>>> +		mutex_unlock(&lport->disc.disc_mutex);
>>> +		return;
>>> +	}
>>>   	kref_get(&lport->ptp_rdata->kref);
>>>   	lport->ptp_rdata->ids.port_name = remote_wwpn;
>>>   	lport->ptp_rdata->ids.node_name = remote_wwnn;
>>>

> Reviewed-by: Hannes Reinecke <hare@suse.com>

A bit confused. You had originally replied that the patch was not
correct so I closed it in patchwork. And now there's a Reviewed-by:
without any explanation as to why you have changed your mind.

Please clarify, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
