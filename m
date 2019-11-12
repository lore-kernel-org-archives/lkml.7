Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53412C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC732084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfKLLvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:51:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727044AbfKLLvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:51:20 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACBlmeE066031;
        Tue, 12 Nov 2019 06:50:13 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w7td0v0mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 06:50:12 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xACBhKKq016153;
        Tue, 12 Nov 2019 11:50:15 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01wdc.us.ibm.com with ESMTP id 2w5n36e805-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 11:50:15 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACBoAYs50200876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 11:50:10 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BA096A051;
        Tue, 12 Nov 2019 11:50:10 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57B9E6A047;
        Tue, 12 Nov 2019 11:50:06 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.45.124])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 12 Nov 2019 11:50:05 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc:     peterz@infradead.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 12/16] dax: Add numa_node to the default device-dax attributes
In-Reply-To: <157309906102.1582359.4262088001244476001.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com> <157309906102.1582359.4262088001244476001.stgit@dwillia2-desk3.amr.corp.intel.com>
Date:   Tue, 12 Nov 2019 17:20:03 +0530
Message-ID: <87imnps49g.fsf@linux.ibm.com>
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

> It is confusing that device-dax instances publish a 'target_node'
> attribute, but not a 'numa_node'. The 'numa_node' information is
> available elsewhere in the sysfs device hierarchy, but it is not obvious
> and not reliable from one device-dax instance-type (e.g. child devices
> of nvdimm namespaces) to the next (e.g. 'hmem' devices defined by EFI
> Specific Purpose Memory and the ACPI HMAT).
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/dax/bus.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index ce6d648d7670..0879b9663eb7 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -322,6 +322,13 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(modalias);
>  
> +static ssize_t numa_node_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d\n", dev_to_node(dev));
> +}
> +static DEVICE_ATTR_RO(numa_node);
> +
>  static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
>  {
>  	struct device *dev = container_of(kobj, struct device, kobj);
> @@ -329,6 +336,8 @@ static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
>  
>  	if (a == &dev_attr_target_node.attr && dev_dax_target_node(dev_dax) < 0)
>  		return 0;
> +	if (a == &dev_attr_numa_node.attr && !IS_ENABLED(CONFIG_NUMA))
> +		return 0;
>  	return a->mode;
>  }
>  
> @@ -337,6 +346,7 @@ static struct attribute *dev_dax_attributes[] = {
>  	&dev_attr_size.attr,
>  	&dev_attr_target_node.attr,
>  	&dev_attr_resource.attr,
> +	&dev_attr_numa_node.attr,
>  	NULL,
>  };
>  
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
