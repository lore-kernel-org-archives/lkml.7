Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57401C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7F52084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfKLLvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:51:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25722 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbfKLLvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:51:04 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACBlhJu141110;
        Tue, 12 Nov 2019 06:50:55 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w7qdbrgfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 06:50:51 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xACBoRui011350;
        Tue, 12 Nov 2019 11:50:34 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04wdc.us.ibm.com with ESMTP id 2w5n35x8b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 11:50:34 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACBoX0B58458540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 11:50:33 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23AD17805F;
        Tue, 12 Nov 2019 11:50:33 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 150547805C;
        Tue, 12 Nov 2019 11:50:29 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.45.124])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 12 Nov 2019 11:50:28 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc:     peterz@infradead.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 11/16] libnvdimm: Simplify root read-only definition for the 'resource' attribute
In-Reply-To: <157309905534.1582359.13927459228885931097.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com> <157309905534.1582359.13927459228885931097.stgit@dwillia2-desk3.amr.corp.intel.com>
Date:   Tue, 12 Nov 2019 17:20:26 +0530
Message-ID: <87ftits48t.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-12_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> Rather than update the permission in ->is_visible() set the permission
> directly at declaration time.
>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/nvdimm/namespace_devs.c |    9 +++------
>  drivers/nvdimm/pfn_devs.c       |   10 +---------
>  drivers/nvdimm/region_devs.c    |   10 +++-------
>  3 files changed, 7 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> index 37471a272c1a..85b553094d19 100644
> --- a/drivers/nvdimm/namespace_devs.c
> +++ b/drivers/nvdimm/namespace_devs.c
> @@ -1303,7 +1303,7 @@ static ssize_t resource_show(struct device *dev,
>  		return -ENXIO;
>  	return sprintf(buf, "%#llx\n", (unsigned long long) res->start);
>  }
> -static DEVICE_ATTR_RO(resource);
> +static DEVICE_ATTR(resource, 0400, resource_show, NULL);
>  
>  static const unsigned long blk_lbasize_supported[] = { 512, 520, 528,
>  	4096, 4104, 4160, 4224, 0 };
> @@ -1619,11 +1619,8 @@ static umode_t namespace_visible(struct kobject *kobj,
>  {
>  	struct device *dev = container_of(kobj, struct device, kobj);
>  
> -	if (a == &dev_attr_resource.attr) {
> -		if (is_namespace_blk(dev))
> -			return 0;
> -		return 0400;
> -	}
> +	if (a == &dev_attr_resource.attr && is_namespace_blk(dev))
> +		return 0;
>  
>  	if (is_namespace_pmem(dev) || is_namespace_blk(dev)) {
>  		if (a == &dev_attr_size.attr)
> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> index e809961e2b6f..9f9cb51301e7 100644
> --- a/drivers/nvdimm/pfn_devs.c
> +++ b/drivers/nvdimm/pfn_devs.c
> @@ -218,7 +218,7 @@ static ssize_t resource_show(struct device *dev,
>  
>  	return rc;
>  }
> -static DEVICE_ATTR_RO(resource);
> +static DEVICE_ATTR(resource, 0400, resource_show, NULL);
>  
>  static ssize_t size_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
> @@ -269,16 +269,8 @@ static struct attribute *nd_pfn_attributes[] = {
>  	NULL,
>  };
>  
> -static umode_t pfn_visible(struct kobject *kobj, struct attribute *a, int n)
> -{
> -	if (a == &dev_attr_resource.attr)
> -		return 0400;
> -	return a->mode;
> -}
> -
>  static struct attribute_group nd_pfn_attribute_group = {
>  	.attrs = nd_pfn_attributes,
> -	.is_visible = pfn_visible,
>  };
>  
>  const struct attribute_group *nd_pfn_attribute_groups[] = {
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index 0afc1973e938..be3e429e86af 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -553,7 +553,7 @@ static ssize_t resource_show(struct device *dev,
>  
>  	return sprintf(buf, "%#llx\n", nd_region->ndr_start);
>  }
> -static DEVICE_ATTR_RO(resource);
> +static DEVICE_ATTR(resource, 0400, resource_show, NULL);
>  
>  static ssize_t persistence_domain_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
> @@ -605,12 +605,8 @@ static umode_t region_visible(struct kobject *kobj, struct attribute *a, int n)
>  	if (!is_memory(dev) && a == &dev_attr_badblocks.attr)
>  		return 0;
>  
> -	if (a == &dev_attr_resource.attr) {
> -		if (is_memory(dev))
> -			return 0400;
> -		else
> -			return 0;
> -	}
> +	if (a == &dev_attr_resource.attr && !is_memory(dev))
> +		return 0;
>  
>  	if (a == &dev_attr_deep_flush.attr) {
>  		int has_flush = nvdimm_has_flush(nd_region);
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
