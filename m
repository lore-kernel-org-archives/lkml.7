Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC168C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C1521019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfCMSGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:06:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726033AbfCMSGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:06:53 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2DHsAru111935
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 14:06:52 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r76dh1fjp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 14:06:51 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <fbarrat@linux.ibm.com>;
        Wed, 13 Mar 2019 18:06:49 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Mar 2019 18:06:45 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2DI6iJU37224534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Mar 2019 18:06:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE580A4054;
        Wed, 13 Mar 2019 18:06:43 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80108A4069;
        Wed, 13 Mar 2019 18:06:43 +0000 (GMT)
Received: from [9.145.182.34] (unknown [9.145.182.34])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Mar 2019 18:06:43 +0000 (GMT)
Subject: Re: [PATCH 1/7] ocxl: Provide global MMIO accessors for external
 drivers
To:     "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     "Alastair D'Silva" <alastair@d-silva.org>,
        Greg Kurz <groug@kaod.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20190313041524.14644-1-alastair@au1.ibm.com>
 <20190313041524.14644-2-alastair@au1.ibm.com>
From:   Frederic Barrat <fbarrat@linux.ibm.com>
Date:   Wed, 13 Mar 2019 19:06:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190313041524.14644-2-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031318-0028-0000-0000-000003539EE9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031318-0029-0000-0000-00002412284E
Message-Id: <d264d773-acb3-3dec-e914-5b455e4ed44c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-13_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=940 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903130125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alastair,

I only realize now that this patch looks a bit out of place and would 
fit better later in the series: it assumes an external driver can get an 
ocxl_afu handle, which can only happen after patch 5.

And since I'm nitpicking, the year at the top of the new mmio file could 
be adjusted.

The mmio accessors look ok to me.

   Fred

Le 13/03/2019 à 05:15, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> External drivers that communicate via OpenCAPI will need to make
> MMIO calls to interact with the devices.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---
>   drivers/misc/ocxl/Makefile |   2 +-
>   drivers/misc/ocxl/mmio.c   | 234 +++++++++++++++++++++++++++++++++++++
>   include/misc/ocxl.h        | 113 ++++++++++++++++++
>   3 files changed, 348 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/misc/ocxl/mmio.c
> 
> diff --git a/drivers/misc/ocxl/Makefile b/drivers/misc/ocxl/Makefile
> index 5229dcda8297..922e47cd4f0d 100644
> --- a/drivers/misc/ocxl/Makefile
> +++ b/drivers/misc/ocxl/Makefile
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   ccflags-$(CONFIG_PPC_WERROR)	+= -Werror
>   
> -ocxl-y				+= main.o pci.o config.o file.o pasid.o
> +ocxl-y				+= main.o pci.o config.o file.o pasid.o mmio.o
>   ocxl-y				+= link.o context.o afu_irq.o sysfs.o trace.o
>   obj-$(CONFIG_OCXL)		+= ocxl.o
>   
> diff --git a/drivers/misc/ocxl/mmio.c b/drivers/misc/ocxl/mmio.c
> new file mode 100644
> index 000000000000..7f6ebae1c6c7
> --- /dev/null
> +++ b/drivers/misc/ocxl/mmio.c
> @@ -0,0 +1,234 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright 2017 IBM Corp.
> +#include <linux/sched/mm.h>
> +#include "trace.h"
> +#include "ocxl_internal.h"
> +
> +int ocxl_global_mmio_read32(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u32 *val)
> +{
> +	if (offset > afu->config.global_mmio_size - 4)
> +		return -EINVAL;
> +
> +#ifdef __BIG_ENDIAN__
> +	if (endian == OCXL_HOST_ENDIAN)
> +		endian = OCXL_BIG_ENDIAN;
> +#endif
> +
> +	switch (endian) {
> +	case OCXL_BIG_ENDIAN:
> +		*val = readl_be((char *)afu->global_mmio_ptr + offset);
> +		break;
> +
> +	default:
> +		*val = readl((char *)afu->global_mmio_ptr + offset);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ocxl_global_mmio_read32);
> +
> +int ocxl_global_mmio_read64(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u64 *val)
> +{
> +	if (offset > afu->config.global_mmio_size - 8)
> +		return -EINVAL;
> +
> +#ifdef __BIG_ENDIAN__
> +	if (endian == OCXL_HOST_ENDIAN)
> +		endian = OCXL_BIG_ENDIAN;
> +#endif
> +
> +	switch (endian) {
> +	case OCXL_BIG_ENDIAN:
> +		*val = readq_be((char *)afu->global_mmio_ptr + offset);
> +		break;
> +
> +	default:
> +		*val = readq((char *)afu->global_mmio_ptr + offset);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ocxl_global_mmio_read64);
> +
> +int ocxl_global_mmio_write32(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u32 val)
> +{
> +	if (offset > afu->config.global_mmio_size - 4)
> +		return -EINVAL;
> +
> +#ifdef __BIG_ENDIAN__
> +	if (endian == OCXL_HOST_ENDIAN)
> +		endian = OCXL_BIG_ENDIAN;
> +#endif
> +
> +	switch (endian) {
> +	case OCXL_BIG_ENDIAN:
> +		writel_be(val, (char *)afu->global_mmio_ptr + offset);
> +		break;
> +
> +	default:
> +		writel(val, (char *)afu->global_mmio_ptr + offset);
> +		break;
> +	}
> +
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ocxl_global_mmio_write32);
> +
> +int ocxl_global_mmio_write64(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u64 val)
> +{
> +	if (offset > afu->config.global_mmio_size - 8)
> +		return -EINVAL;
> +
> +#ifdef __BIG_ENDIAN__
> +	if (endian == OCXL_HOST_ENDIAN)
> +		endian = OCXL_BIG_ENDIAN;
> +#endif
> +
> +	switch (endian) {
> +	case OCXL_BIG_ENDIAN:
> +		writeq_be(val, (char *)afu->global_mmio_ptr + offset);
> +		break;
> +
> +	default:
> +		writeq(val, (char *)afu->global_mmio_ptr + offset);
> +		break;
> +	}
> +
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ocxl_global_mmio_write64);
> +
> +int ocxl_global_mmio_set32(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u32 mask)
> +{
> +	u32 tmp;
> +
> +	if (offset > afu->config.global_mmio_size - 4)
> +		return -EINVAL;
> +
> +#ifdef __BIG_ENDIAN__
> +	if (endian == OCXL_HOST_ENDIAN)
> +		endian = OCXL_BIG_ENDIAN;
> +#endif
> +
> +	switch (endian) {
> +	case OCXL_BIG_ENDIAN:
> +		tmp = readl_be((char *)afu->global_mmio_ptr + offset);
> +		tmp |= mask;
> +		writel_be(tmp, (char *)afu->global_mmio_ptr + offset);
> +		break;
> +
> +	default:
> +		tmp = readl((char *)afu->global_mmio_ptr + offset);
> +		tmp |= mask;
> +		writel(tmp, (char *)afu->global_mmio_ptr + offset);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ocxl_global_mmio_set32);
> +
> +int ocxl_global_mmio_set64(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u64 mask)
> +{
> +	u64 tmp;
> +
> +	if (offset > afu->config.global_mmio_size - 8)
> +		return -EINVAL;
> +
> +#ifdef __BIG_ENDIAN__
> +	if (endian == OCXL_HOST_ENDIAN)
> +		endian = OCXL_BIG_ENDIAN;
> +#endif
> +
> +	switch (endian) {
> +	case OCXL_BIG_ENDIAN:
> +		tmp = readq_be((char *)afu->global_mmio_ptr + offset);
> +		tmp |= mask;
> +		writeq_be(tmp, (char *)afu->global_mmio_ptr + offset);
> +		break;
> +
> +	default:
> +		tmp = readq((char *)afu->global_mmio_ptr + offset);
> +		tmp |= mask;
> +		writeq(tmp, (char *)afu->global_mmio_ptr + offset);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ocxl_global_mmio_set64);
> +
> +int ocxl_global_mmio_clear32(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u32 mask)
> +{
> +	u32 tmp;
> +
> +	if (offset > afu->config.global_mmio_size - 4)
> +		return -EINVAL;
> +
> +#ifdef __BIG_ENDIAN__
> +	if (endian == OCXL_HOST_ENDIAN)
> +		endian = OCXL_BIG_ENDIAN;
> +#endif
> +
> +	switch (endian) {
> +	case OCXL_BIG_ENDIAN:
> +		tmp = readl_be((char *)afu->global_mmio_ptr + offset);
> +		tmp &= ~mask;
> +		writel_be(tmp, (char *)afu->global_mmio_ptr + offset);
> +		break;
> +
> +	default:
> +		tmp = readl((char *)afu->global_mmio_ptr + offset);
> +		tmp &= ~mask;
> +		writel(tmp, (char *)afu->global_mmio_ptr + offset);
> +		break;
> +	}
> +
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ocxl_global_mmio_clear32);
> +
> +int ocxl_global_mmio_clear64(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u64 mask)
> +{
> +	u64 tmp;
> +
> +	if (offset > afu->config.global_mmio_size - 8)
> +		return -EINVAL;
> +
> +#ifdef __BIG_ENDIAN__
> +	if (endian == OCXL_HOST_ENDIAN)
> +		endian = OCXL_BIG_ENDIAN;
> +#endif
> +
> +	switch (endian) {
> +	case OCXL_BIG_ENDIAN:
> +		tmp = readq_be((char *)afu->global_mmio_ptr + offset);
> +		tmp &= ~mask;
> +		writeq_be(tmp, (char *)afu->global_mmio_ptr + offset);
> +		break;
> +
> +	default:
> +		tmp = readq((char *)afu->global_mmio_ptr + offset);
> +		tmp &= ~mask;
> +		writeq(tmp, (char *)afu->global_mmio_ptr + offset);
> +		break;
> +	}
> +
> +	writeq(tmp, (char *)afu->global_mmio_ptr + offset);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ocxl_global_mmio_clear64);
> diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
> index 9530d3be1b30..3b320c39f0af 100644
> --- a/include/misc/ocxl.h
> +++ b/include/misc/ocxl.h
> @@ -49,6 +49,119 @@ struct ocxl_fn_config {
>   	s8 max_afu_index;
>   };
>   
> +// These are opaque outside the ocxl driver
> +struct ocxl_afu;
> +
> +enum ocxl_endian {
> +	OCXL_BIG_ENDIAN = 0,    /**< AFU data is big-endian */
> +	OCXL_LITTLE_ENDIAN = 1, /**< AFU data is little-endian */
> +	OCXL_HOST_ENDIAN = 2,   /**< AFU data is the same endianness as the host */
> +};
> +
> +/**
> + * Read a 32 bit value from global MMIO
> + *
> + * @afu: The AFU
> + * @offset: The Offset from the start of MMIO
> + * @endian: the endianness that the MMIO data is in
> + * @val: returns the value
> + *
> + * Returns 0 for success, negative on error
> + */
> +int ocxl_global_mmio_read32(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u32 *val);
> +
> +/**
> + * Read a 64 bit value from global MMIO
> + *
> + * @afu: The AFU
> + * @offset: The Offset from the start of MMIO
> + * @endian: the endianness that the MMIO data is in
> + * @val: returns the value
> + *
> + * Returns 0 for success, negative on error
> + */
> +int ocxl_global_mmio_read64(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u64 *val);
> +
> +/**
> + * Write a 32 bit value to global MMIO
> + *
> + * @afu: The AFU
> + * @offset: The Offset from the start of MMIO
> + * @endian: the endianness that the MMIO data is in
> + * @val: The value to write
> + *
> + * Returns 0 for success, negative on error
> + */
> +int ocxl_global_mmio_write32(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u32 val);
> +
> +/**
> + * Write a 64 bit value to global MMIO
> + *
> + * @afu: The AFU
> + * @offset: The Offset from the start of MMIO
> + * @endian: the endianness that the MMIO data is in
> + * @val: The value to write
> + *
> + * Returns 0 for success, negative on error
> + */
> +int ocxl_global_mmio_write64(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u64 val);
> +
> +/**
> + * Set bits in a 32 bit global MMIO register
> + *
> + * @afu: The AFU
> + * @offset: The Offset from the start of MMIO
> + * @endian: the endianness that the MMIO data is in
> + * @mask: a mask of the bits to set
> + *
> + * Returns 0 for success, negative on error
> + */
> +int ocxl_global_mmio_set32(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u32 mask);
> +
> +/**
> + * Set bits in a 64 bit global MMIO register
> + *
> + * @afu: The AFU
> + * @offset: The Offset from the start of MMIO
> + * @endian: the endianness that the MMIO data is in
> + * @mask: a mask of the bits to set
> + *
> + * Returns 0 for success, negative on error
> + */
> +int ocxl_global_mmio_set64(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u64 mask);
> +
> +/**
> + * Set bits in a 32 bit global MMIO register
> + *
> + * @afu: The AFU
> + * @offset: The Offset from the start of MMIO
> + * @endian: the endianness that the MMIO data is in
> + * @mask: a mask of the bits to set
> + *
> + * Returns 0 for success, negative on error
> + */
> +int ocxl_global_mmio_clear32(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u32 mask);
> +
> +/**
> + * Set bits in a 64 bit global MMIO register
> + *
> + * @afu: The AFU
> + * @offset: The Offset from the start of MMIO
> + * @endian: the endianness that the MMIO data is in
> + * @mask: a mask of the bits to set
> + *
> + * Returns 0 for success, negative on error
> + */
> +int ocxl_global_mmio_clear64(struct ocxl_afu *afu, size_t offset,
> +				enum ocxl_endian endian, u64 mask);
> +
>   /*
>    * Read the configuration space of a function and fill in a
>    * ocxl_fn_config structure with all the function details
> 

