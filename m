Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCF4C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE96D206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfJGSEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:04:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728665AbfJGSEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:04:49 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x97I2idw105466
        for <linux-kernel@vger.kernel.org>; Mon, 7 Oct 2019 14:04:46 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vg9gr9sh9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 14:04:46 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 7 Oct 2019 19:04:44 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 7 Oct 2019 19:04:42 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x97I4BFf15991116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Oct 2019 18:04:11 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF346A4053;
        Mon,  7 Oct 2019 18:04:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03B57A4059;
        Mon,  7 Oct 2019 18:04:39 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.39.180])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Oct 2019 18:04:38 +0000 (GMT)
Subject: Re: [PATCH v2 1/1] s390/cio: fix virtio-ccw DMA without PV
To:     Halil Pasic <pasic@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>
References: <20190930153803.7958-1-pasic@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 syiRa+UVlsKmx1hsEg==
Date:   Mon, 7 Oct 2019 20:04:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190930153803.7958-1-pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100718-0028-0000-0000-000003A6E677
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100718-0029-0000-0000-00002468F826
Message-Id: <fee4157e-7dd3-e003-fbdf-5aa013147dde@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910070161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.09.19 17:38, Halil Pasic wrote:
> Commit 37db8985b211 ("s390/cio: add basic protected virtualization
> support") breaks virtio-ccw devices with VIRTIO_F_IOMMU_PLATFORM for non
> Protected Virtualization (PV) guests. The problem is that the dma_mask
> of the ccw device, which is used by virtio core, gets changed from 64 to
> 31 bit, because some of the DMA allocations do require 31 bit
> addressable memory. For PV the only drawback is that some of the virtio
> structures must end up in ZONE_DMA because we have the bounce the
> buffers mapped via DMA API anyway.
> 
> But for non PV guests we have a problem: because of the 31 bit mask
> guests bigger than 2G are likely to try bouncing buffers. The swiotlb
> however is only initialized for PV guests, because we don't want to
> bounce anything for non PV guests. The first such map kills the guest.
> 
> Since the DMA API won't allow us to specify for each allocation whether
> we need memory from ZONE_DMA (31 bit addressable) or any DMA capable
> memory will do, let us use coherent_dma_mask (which is used for
> allocations) to force allocating form ZONE_DMA while changing dma_mask
> to DMA_BIT_MASK(64) so that at least the streaming API will regard
> the whole memory DMA capable.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Fixes: 37db8985b211 ("s390/cio: add basic protected virtualization support")

Thanks applied to the s390 tree. (pending some regression tests)


> ---
> 
> v1 --> v2:
> * Fixed comment: dropped the sentence with workaround.
> 
> The idea of enabling the client code to specify on s390 whether a chunk
> of allocated DMA memory is to be allocated form ZONE_DMA for each
> allocation was not well received [1]. 
> 
> Making the streaming API threat all addresses as DMA capable, while
> restricting the DMA API allocations to  ZONE_DMA (regardless of needed
> or not) is the next best thing we can do (from s390 perspective).
> 
> [1] https://lkml.org/lkml/2019/9/23/531 
> ---
> ---
>  drivers/s390/cio/cio.h    | 1 +
>  drivers/s390/cio/css.c    | 7 ++++++-
>  drivers/s390/cio/device.c | 2 +-
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/cio/cio.h b/drivers/s390/cio/cio.h
> index ba7d2480613b..dcdaba689b20 100644
> --- a/drivers/s390/cio/cio.h
> +++ b/drivers/s390/cio/cio.h
> @@ -113,6 +113,7 @@ struct subchannel {
>  	enum sch_todo todo;
>  	struct work_struct todo_work;
>  	struct schib_config config;
> +	u64 dma_mask;
>  	char *driver_override; /* Driver name to force a match */
>  } __attribute__ ((aligned(8)));
>  
> diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
> index 22c55816100b..a05dbf2e97db 100644
> --- a/drivers/s390/cio/css.c
> +++ b/drivers/s390/cio/css.c
> @@ -232,7 +232,12 @@ struct subchannel *css_alloc_subchannel(struct subchannel_id schid,
>  	 * belong to a subchannel need to fit 31 bit width (e.g. ccw).
>  	 */
>  	sch->dev.coherent_dma_mask = DMA_BIT_MASK(31);
> -	sch->dev.dma_mask = &sch->dev.coherent_dma_mask;
> +	/*
> +	 * But we don't have such restrictions imposed on the stuff that
> +	 * is handled by the streaming API.
> +	 */
> +	sch->dma_mask = DMA_BIT_MASK(64);
> +	sch->dev.dma_mask = &sch->dma_mask;
>  	return sch;
>  
>  err:
> diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
> index 131430bd48d9..0c6245fc7706 100644
> --- a/drivers/s390/cio/device.c
> +++ b/drivers/s390/cio/device.c
> @@ -710,7 +710,7 @@ static struct ccw_device * io_subchannel_allocate_dev(struct subchannel *sch)
>  	if (!cdev->private)
>  		goto err_priv;
>  	cdev->dev.coherent_dma_mask = sch->dev.coherent_dma_mask;
> -	cdev->dev.dma_mask = &cdev->dev.coherent_dma_mask;
> +	cdev->dev.dma_mask = sch->dev.dma_mask;
>  	dma_pool = cio_gp_dma_create(&cdev->dev, 1);
>  	if (!dma_pool)
>  		goto err_dma_pool;
> 

