Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9B2C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87569216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="tz0XnmDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfEIMgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 08:36:10 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22262 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726426AbfEIMgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 08:36:10 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x49Ca38C031849;
        Thu, 9 May 2019 14:36:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=lzahlOCPl/m4qOdpoCm6sRQ4fgNa6XR57MFqoMEUk3s=;
 b=tz0XnmDlUgp6OcyUADfpM0KcP5IXW3YuoI/kJEhSBr3GV//BTyo+Ts5oylWKlc/07gWa
 Ug3TLZoqu/p85GlWC/dkQnFuhG1RUboqDfI/Zu470giPYWtV9khVH/PdUgJCLJGd3Wue
 Opg1DAnbffOG1upq0Tpi2N4Mr6fJ6kdkAVDZ55hyuQmoICtpfRhYv0wWdOx9BLVIJWCY
 DMSVG9rDOewE72xNqn/3MQ29oDK3wGFIgRfMGAhLoNITNsKUsRsVa0BC4mWxIQub01Yu
 Dh0EHUonMNaTTOvcNC5hpTBHU7sQ2zhdN02m4fNzFO/LwHipNka2t/sg+qryu4kZQcGS eA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sc9s4bfkh-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 09 May 2019 14:36:03 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EC7BB31;
        Thu,  9 May 2019 12:36:01 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BD5382527;
        Thu,  9 May 2019 12:36:01 +0000 (GMT)
Received: from [10.48.0.131] (10.75.127.45) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 9 May
 2019 14:36:00 +0200
Subject: Re: [PATCH 3/3] rpmsg: virtio_rpmsg_bus: get buffer size from config
 space
To:     Xiang Xiao <xiaoxiang781216@gmail.com>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>, <wendy.liang@xilinx.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Xiang Xiao <xiaoxiang@xiaomi.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Suman Anna <s-anna@ti.com>
References: <1548949280-31794-1-git-send-email-xiaoxiang@xiaomi.com>
 <1548949280-31794-4-git-send-email-xiaoxiang@xiaomi.com>
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
Openpgp: preference=signencrypt
Autocrypt: addr=arnaud.pouliquen@st.com; prefer-encrypt=mutual; keydata=
 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
 8mOik8I/F6EW8XyQAA2P
Message-ID: <bc0e287e-cadd-c61c-c6c4-28cad642b9eb@st.com>
Date:   Thu, 9 May 2019 14:36:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1548949280-31794-4-git-send-email-xiaoxiang@xiaomi.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Xiang,

Similar mechanism has been proposed by Loic 2 years ago (link to the
series here https://lkml.org/lkml/2017/3/28/349).

Did you see them? Regarding history, patches seem just on hold...

Main differences (except interesting RX/TX size split) seems that you
- don't use the virtio_config_ops->get
- define a new feature VIRTIO_RPMSG_F_NS.

Regards
Arnaud


On 1/31/19 4:41 PM, Xiang Xiao wrote:
> 512 bytes isn't always suitable for all case, let firmware
> maker decide the best value from resource table.
> enable by VIRTIO_RPMSG_F_BUFSZ feature bit.
> 
> Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c  | 50 +++++++++++++++++++++++++--------------
>  include/uapi/linux/virtio_rpmsg.h | 24 +++++++++++++++++++
>  2 files changed, 56 insertions(+), 18 deletions(-)
>  create mode 100644 include/uapi/linux/virtio_rpmsg.h
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 59c4554..049dd97 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -16,6 +16,7 @@
>  #include <linux/virtio.h>
>  #include <linux/virtio_ids.h>
>  #include <linux/virtio_config.h>
> +#include <linux/virtio_rpmsg.h>
>  #include <linux/scatterlist.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/slab.h>
> @@ -38,7 +39,8 @@
>   * @sbufs:	kernel address of tx buffers
>   * @num_rbufs:	total number of buffers for rx
>   * @num_sbufs:	total number of buffers for tx
> - * @buf_size:	size of one rx or tx buffer
> + * @rbuf_size:	size of one rx buffer
> + * @sbuf_size:	size of one tx buffer
>   * @last_sbuf:	index of last tx buffer used
>   * @rbufs_dma:	dma base addr of rx buffers
>   * @sbufs_dma:	dma base addr of tx buffers
> @@ -61,7 +63,8 @@ struct virtproc_info {
>  	void *rbufs, *sbufs;
>  	unsigned int num_rbufs;
>  	unsigned int num_sbufs;
> -	unsigned int buf_size;
> +	unsigned int rbuf_size;
> +	unsigned int sbuf_size;
>  	int last_sbuf;
>  	dma_addr_t rbufs_dma;
>  	dma_addr_t sbufs_dma;
> @@ -73,9 +76,6 @@ struct virtproc_info {
>  	struct rpmsg_endpoint *ns_ept;
>  };
>  
> -/* The feature bitmap for virtio rpmsg */
> -#define VIRTIO_RPMSG_F_NS	0 /* RP supports name service notifications */
> -
>  /**
>   * struct rpmsg_hdr - common header for all rpmsg messages
>   * @src: source address
> @@ -452,7 +452,7 @@ static void *get_a_tx_buf(struct virtproc_info *vrp)
>  
>  	/* either pick the next unused tx buffer */
>  	if (vrp->last_sbuf < vrp->num_sbufs)
> -		ret = vrp->sbufs + vrp->buf_size * vrp->last_sbuf++;
> +		ret = vrp->sbufs + vrp->sbuf_size * vrp->last_sbuf++;
>  	/* or recycle a used one */
>  	else
>  		ret = virtqueue_get_buf(vrp->svq, &len);
> @@ -578,7 +578,7 @@ static int rpmsg_send_offchannel_raw(struct rpmsg_device *rpdev,
>  	 * messaging), or to improve the buffer allocator, to support
>  	 * variable-length buffer sizes.
>  	 */
> -	if (len > vrp->buf_size - sizeof(struct rpmsg_hdr)) {
> +	if (len > vrp->sbuf_size - sizeof(struct rpmsg_hdr)) {
>  		dev_err(dev, "message is too big (%d)\n", len);
>  		return -EMSGSIZE;
>  	}
> @@ -718,7 +718,7 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
>  	 * We currently use fixed-sized buffers, so trivially sanitize
>  	 * the reported payload length.
>  	 */
> -	if (len > vrp->buf_size ||
> +	if (len > vrp->rbuf_size ||
>  	    msg->len > (len - sizeof(struct rpmsg_hdr))) {
>  		dev_warn(dev, "inbound msg too big: (%d, %d)\n", len, msg->len);
>  		return -EINVAL;
> @@ -751,7 +751,7 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
>  		dev_warn(dev, "msg received with no recipient\n");
>  
>  	/* publish the real size of the buffer */
> -	rpmsg_sg_init(&sg, msg, vrp->buf_size);
> +	rpmsg_sg_init(&sg, msg, vrp->rbuf_size);
>  
>  	/* add the buffer back to the remote processor's virtqueue */
>  	err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, msg, GFP_KERNEL);
> @@ -907,11 +907,24 @@ static int rpmsg_probe(struct virtio_device *vdev)
>  	else
>  		vrp->num_sbufs = MAX_RPMSG_NUM_BUFS;
>  
> -	vrp->buf_size = MAX_RPMSG_BUF_SIZE;
> +	/* try to get buffer size from config space */
> +	if (virtio_has_feature(vdev, VIRTIO_RPMSG_F_BUFSZ)) {
> +		/* note: virtio_rpmsg_config is defined from remote view */
> +		virtio_cread(vdev, struct virtio_rpmsg_config,
> +			     txbuf_size, &vrp->rbuf_size);
> +		virtio_cread(vdev, struct virtio_rpmsg_config,
> +			     rxbuf_size, &vrp->sbuf_size);
> +	}
> +
> +	/* use the default if resource table doesn't provide one */
> +	if (!vrp->rbuf_size)
> +		vrp->rbuf_size = MAX_RPMSG_BUF_SIZE;
> +	if (!vrp->sbuf_size)
> +		vrp->sbuf_size = MAX_RPMSG_BUF_SIZE;
>  
>  	/* allocate coherent memory for the buffers */
>  	vrp->rbufs = dma_alloc_coherent(vdev->dev.parent->parent,
> -					vrp->num_rbufs * vrp->buf_size,
> +					vrp->num_rbufs * vrp->rbuf_size,
>  					&vrp->rbufs_dma, GFP_KERNEL);
>  	if (!vrp->rbufs) {
>  		err = -ENOMEM;
> @@ -922,7 +935,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
>  		vrp->rbufs, &vrp->rbufs_dma);
>  
>  	vrp->sbufs = dma_alloc_coherent(vdev->dev.parent->parent,
> -					vrp->num_sbufs * vrp->buf_size,
> +					vrp->num_sbufs * vrp->sbuf_size,
>  					&vrp->sbufs_dma, GFP_KERNEL);
>  	if (!vrp->sbufs) {
>  		err = -ENOMEM;
> @@ -935,9 +948,9 @@ static int rpmsg_probe(struct virtio_device *vdev)
>  	/* set up the receive buffers */
>  	for (i = 0; i < vrp->num_rbufs; i++) {
>  		struct scatterlist sg;
> -		void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
> +		void *cpu_addr = vrp->rbufs + i * vrp->rbuf_size;
>  
> -		rpmsg_sg_init(&sg, cpu_addr, vrp->buf_size);
> +		rpmsg_sg_init(&sg, cpu_addr, vrp->rbuf_size);
>  
>  		err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, cpu_addr,
>  					  GFP_KERNEL);
> @@ -984,11 +997,11 @@ static int rpmsg_probe(struct virtio_device *vdev)
>  
>  free_sbufs:
>  	dma_free_coherent(vdev->dev.parent->parent,
> -			  vrp->num_sbufs * vrp->buf_size,
> +			  vrp->num_sbufs * vrp->sbuf_size,
>  			  vrp->sbufs, vrp->sbufs_dma);
>  free_rbufs:
>  	dma_free_coherent(vdev->dev.parent->parent,
> -			  vrp->num_rbufs * vrp->buf_size,
> +			  vrp->num_rbufs * vrp->rbuf_size,
>  			  vrp->rbufs, vrp->rbufs_dma);
>  vqs_del:
>  	vdev->config->del_vqs(vrp->vdev);
> @@ -1023,10 +1036,10 @@ static void rpmsg_remove(struct virtio_device *vdev)
>  	vdev->config->del_vqs(vrp->vdev);
>  
>  	dma_free_coherent(vdev->dev.parent->parent,
> -			  vrp->num_sbufs * vrp->buf_size,
> +			  vrp->num_sbufs * vrp->sbuf_size,
>  			  vrp->sbufs, vrp->sbufs_dma);
>  	dma_free_coherent(vdev->dev.parent->parent,
> -			  vrp->num_rbufs * vrp->buf_size,
> +			  vrp->num_rbufs * vrp->rbuf_size,
>  			  vrp->rbufs, vrp->rbufs_dma);
>  
>  	kfree(vrp);
> @@ -1039,6 +1052,7 @@ static struct virtio_device_id id_table[] = {
>  
>  static unsigned int features[] = {
>  	VIRTIO_RPMSG_F_NS,
> +	VIRTIO_RPMSG_F_BUFSZ,
>  };
>  
>  static struct virtio_driver virtio_ipc_driver = {
> diff --git a/include/uapi/linux/virtio_rpmsg.h b/include/uapi/linux/virtio_rpmsg.h
> new file mode 100644
> index 0000000..24fa0dd
> --- /dev/null
> +++ b/include/uapi/linux/virtio_rpmsg.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (C) Pinecone Inc. 2019
> + * Copyright (C) Xiang Xiao <xiaoxiang@pinecone.net>
> + */
> +
> +#ifndef _UAPI_LINUX_VIRTIO_RPMSG_H
> +#define _UAPI_LINUX_VIRTIO_RPMSG_H
> +
> +#include <linux/types.h>
> +
> +/* The feature bitmap for virtio rpmsg */
> +#define VIRTIO_RPMSG_F_NS	0 /* RP supports name service notifications */
> +#define VIRTIO_RPMSG_F_BUFSZ	2 /* RP get buffer size from config space */
> +
> +struct virtio_rpmsg_config {
> +	/* The tx/rx individual buffer size(if VIRTIO_RPMSG_F_BUFSZ) */
> +	__u32 txbuf_size;
> +	__u32 rxbuf_size;
> +	__u32 reserved[14]; /* Reserve for the future use */
> +	/* Put the customize config here */
> +} __attribute__((packed));
> +
> +#endif /* _UAPI_LINUX_VIRTIO_RPMSG_H */
> 
