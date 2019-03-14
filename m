Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1512C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 04:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5EA217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 04:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfCNE7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 00:59:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726616AbfCNE7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 00:59:33 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2E4xWq5119757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 00:59:32 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r7e67mjge-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 00:59:21 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
        Thu, 14 Mar 2019 04:59:19 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Mar 2019 04:59:16 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2E4xF3i52691170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 04:59:15 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0608A52054;
        Thu, 14 Mar 2019 04:59:15 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id AADD95204E;
        Thu, 14 Mar 2019 04:59:14 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id A8473A00D1;
        Thu, 14 Mar 2019 15:59:13 +1100 (AEDT)
Subject: Re: [PATCH 3/5] ocxl: read_pasid never returns an error, so make it
 void
To:     "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     "Alastair D'Silva" <alastair@d-silva.org>,
        Greg Kurz <groug@kaod.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20190227045741.21412-1-alastair@au1.ibm.com>
 <20190313040702.14276-1-alastair@au1.ibm.com>
 <20190313040702.14276-4-alastair@au1.ibm.com>
From:   Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date:   Thu, 14 Mar 2019 15:59:13 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190313040702.14276-4-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19031404-0008-0000-0000-000002CD12A7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031404-0009-0000-0000-000022391347
Message-Id: <b3bfc7f8-f7c5-c8a1-1784-a74f5c848412@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-14_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=850 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903140032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/3/19 3:06 pm, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> No need for a return value in read_pasid as it only returns 0.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   drivers/misc/ocxl/config.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
> index 0ee7856b033d..026ac2ac4f9c 100644
> --- a/drivers/misc/ocxl/config.c
> +++ b/drivers/misc/ocxl/config.c
> @@ -68,7 +68,7 @@ static int find_dvsec_afu_ctrl(struct pci_dev *dev, u8 afu_idx)
>   	return 0;
>   }
>   
> -static int read_pasid(struct pci_dev *dev, struct ocxl_fn_config *fn)
> +static void read_pasid(struct pci_dev *dev, struct ocxl_fn_config *fn)
>   {
>   	u16 val;
>   	int pos;
> @@ -89,7 +89,6 @@ static int read_pasid(struct pci_dev *dev, struct ocxl_fn_config *fn)
>   out:
>   	dev_dbg(&dev->dev, "PASID capability:\n");
>   	dev_dbg(&dev->dev, "  Max PASID log = %d\n", fn->max_pasid_log);
> -	return 0;
>   }
>   
>   static int read_dvsec_tl(struct pci_dev *dev, struct ocxl_fn_config *fn)
> @@ -205,11 +204,7 @@ int ocxl_config_read_function(struct pci_dev *dev, struct ocxl_fn_config *fn)
>   {
>   	int rc;
>   
> -	rc = read_pasid(dev, fn);
> -	if (rc) {
> -		dev_err(&dev->dev, "Invalid PASID configuration: %d\n", rc);
> -		return -ENODEV;
> -	}
> +	read_pasid(dev, fn);
>   
>   	rc = read_dvsec_tl(dev, fn);
>   	if (rc) {
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

