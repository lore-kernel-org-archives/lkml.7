Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF9AC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AA421873
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfCNQ1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:27:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727568AbfCNQ1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:27:14 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2EGJAEa125436
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 12:27:13 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r7snntv3x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 12:27:13 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <fbarrat@linux.ibm.com>;
        Thu, 14 Mar 2019 16:27:10 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Mar 2019 16:27:08 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2EGR6tg31719428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Mar 2019 16:27:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC7E8A405D;
        Thu, 14 Mar 2019 16:27:06 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59F37A4057;
        Thu, 14 Mar 2019 16:27:06 +0000 (GMT)
Received: from [9.101.4.34] (unknown [9.101.4.34])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Mar 2019 16:27:06 +0000 (GMT)
Subject: Re: [PATCH 5/7] ocxl: Create a clear delineation between ocxl backend
 & frontend
To:     "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     "Alastair D'Silva" <alastair@d-silva.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20190313041524.14644-1-alastair@au1.ibm.com>
 <20190313041524.14644-6-alastair@au1.ibm.com>
From:   Frederic Barrat <fbarrat@linux.ibm.com>
Date:   Thu, 14 Mar 2019 17:27:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190313041524.14644-6-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19031416-0008-0000-0000-000002CD5901
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031416-0009-0000-0000-000022395C7B
Message-Id: <e7ea8286-afb4-bf93-d2fa-190f4b4e3ea5@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=761 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903140116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
> index 865b3d176431..424bb0b40afb 100644
> --- a/drivers/misc/ocxl/file.c
> +++ b/drivers/misc/ocxl/file.c

> -int ocxl_register_afu(struct ocxl_afu *afu)
> +int ocxl_file_register_afu(struct ocxl_afu *afu)
>   {
>   	int minor;
> +	int rc;
> +	struct ocxl_file_info *info;
> +	struct ocxl_fn *fn = afu->fn;
> +	struct pci_dev *pci_dev = to_pci_dev(fn->dev.parent);
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (info == NULL)
> +		return -ENOMEM;
>   
> -	minor = allocate_afu_minor(afu);
> -	if (minor < 0)
> +	info->afu = afu;
> +
> +	minor = allocate_minor(info);
> +	if (minor < 0) {
> +		kfree(info);
>   		return minor;
> -	afu->dev.devt = MKDEV(MAJOR(ocxl_dev), minor);
> -	afu->dev.class = ocxl_class;
> -	return device_register(&afu->dev);
> +	}
> +
> +	info->dev.parent = &fn->dev;
> +	info->dev.devt = MKDEV(MAJOR(ocxl_dev), minor);
> +	info->dev.class = ocxl_class;
> +
> +	ocxl_afu_set_private(afu, info, ocxl_file_release);


We no longer define a 'release' method for the AFU device. We need one, 
which should in turn free the info struct when the device ref count hits 
0. That should explain the following error seen when unloading the driver:
"Device 'xyz' does not have a release() function, it is broken and must 
be fixed. See Documentation/kobject.txt"

   Fred

