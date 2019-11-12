Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC6EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3452084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfKLLrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:47:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725775AbfKLLra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:47:30 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACBgLnl107835;
        Tue, 12 Nov 2019 06:46:10 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w7t1wcrsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 06:46:09 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xACBhwwV030087;
        Tue, 12 Nov 2019 11:46:07 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03dal.us.ibm.com with ESMTP id 2w5n36drg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 11:46:06 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACBk6Sc59048424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 11:46:06 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EDAB6E053;
        Tue, 12 Nov 2019 11:46:06 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88F346E058;
        Tue, 12 Nov 2019 11:46:01 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.45.124])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 12 Nov 2019 11:46:00 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>, peterz@infradead.org,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 06/16] libnvdimm: Move nd_mapping_attribute_group to device_type
In-Reply-To: <157309902686.1582359.6749533709859492704.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com> <157309902686.1582359.6749533709859492704.stgit@dwillia2-desk3.amr.corp.intel.com>
Date:   Tue, 12 Nov 2019 17:15:58 +0530
Message-ID: <87woc5s4g9.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-12_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> A 'struct device_type' instance can carry default attributes for the
> device. Use this facility to remove the export of
> nd_mapping_attribute_group and put the responsibility on the core rather
> than leaf implementations to define this attribute.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/powerpc/platforms/pseries/papr_scm.c |    6 ------
>  drivers/acpi/nfit/core.c                  |    1 -
>  drivers/nvdimm/region_devs.c              |    4 ++--
>  include/linux/libnvdimm.h                 |    1 -
>  4 files changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 6428834d7cd5..0405fb769336 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -284,11 +284,6 @@ int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>  	return 0;
>  }
>  
> -static const struct attribute_group *region_attr_groups[] = {
> -	&nd_mapping_attribute_group,
> -	NULL,
> -};
> -
>  static const struct attribute_group *bus_attr_groups[] = {
>  	&nvdimm_bus_attribute_group,
>  	NULL,
> @@ -362,7 +357,6 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>  	mapping.size = p->blocks * p->block_size; // XXX: potential overflow?
>  
>  	memset(&ndr_desc, 0, sizeof(ndr_desc));
> -	ndr_desc.attr_groups = region_attr_groups;
>  	target_nid = dev_to_node(&p->pdev->dev);
>  	online_nid = papr_scm_node(target_nid);
>  	ndr_desc.numa_node = online_nid;
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 99e20b8b6ea0..69c406ecc3a6 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -2196,7 +2196,6 @@ static const struct attribute_group acpi_nfit_region_attribute_group = {
>  };
>  
>  static const struct attribute_group *acpi_nfit_region_attribute_groups[] = {
> -	&nd_mapping_attribute_group,
>  	&acpi_nfit_region_attribute_group,
>  	NULL,
>  };
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index f97166583294..0afc1973e938 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -751,11 +751,10 @@ static struct attribute *mapping_attributes[] = {
>  	NULL,
>  };
>  
> -struct attribute_group nd_mapping_attribute_group = {
> +static const struct attribute_group nd_mapping_attribute_group = {
>  	.is_visible = mapping_visible,
>  	.attrs = mapping_attributes,
>  };
> -EXPORT_SYMBOL_GPL(nd_mapping_attribute_group);
>  
>  static const struct attribute_group nd_region_attribute_group = {
>  	.attrs = nd_region_attributes,
> @@ -766,6 +765,7 @@ static const struct attribute_group *nd_region_attribute_groups[] = {
>  	&nd_device_attribute_group,
>  	&nd_region_attribute_group,
>  	&nd_numa_attribute_group,
> +	&nd_mapping_attribute_group,
>  	NULL,
>  };
>  
> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> index 312248d334c7..eb597d1cb891 100644
> --- a/include/linux/libnvdimm.h
> +++ b/include/linux/libnvdimm.h
> @@ -67,7 +67,6 @@ enum {
>  
>  extern struct attribute_group nvdimm_bus_attribute_group;
>  extern struct attribute_group nvdimm_attribute_group;
> -extern struct attribute_group nd_mapping_attribute_group;
>  
>  struct nvdimm;
>  struct nvdimm_bus_descriptor;
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
