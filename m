Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEB2C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BAD2089E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="lfcT9wl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfEIMCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 08:02:13 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:64810 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726411AbfEIMCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 08:02:13 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x49C1E1t018521;
        Thu, 9 May 2019 14:02:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=sEvzOi/QzaGsuHXN7zZECXWsXfKXQgXC8Cgqu9yuy9o=;
 b=lfcT9wl1TT9pptAszVisUS+VizxTZbMklRc2ywkEO2SqMGZ6TRLzbe09gCTQ1m5hYnYb
 XA7KD+Ngu/DQNhhspYYc42OQ/gg1jj+8qC2a/fLMZuvtxJeTQYaBQr8zMDHD1KYfxa7u
 o7KAIqtlU3DqpQOWGBFjPJUL+M5rWcbDvC246W3xG5R+R80LZXNSHniNCgNkuE4OQGSj
 VdDopDdQYPjA4WUypsy1BT1Jisic31eNpQefzc9lvjNa76Fx2PJbtrtrjzPkau2XzztP
 e5425HB2bagLogFIgJmhtFVYhHdXcTXqGuRoMK3UTumiJ+YtbKiBLxC0DZg5STl0PVFz Jg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2scdjp278h-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 09 May 2019 14:02:07 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A27F231;
        Thu,  9 May 2019 12:02:06 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 556E524D3;
        Thu,  9 May 2019 12:02:06 +0000 (GMT)
Received: from [10.48.0.131] (10.75.127.47) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 9 May
 2019 14:02:05 +0200
Subject: Re: [PATCH 2/3] rpmsg: virtio_rpmsg_bus: allocate rx/tx buffer
 separately
To:     Xiang Xiao <xiaoxiang781216@gmail.com>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>, <wendy.liang@xilinx.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Xiang Xiao <xiaoxiang@xiaomi.com>
References: <1548949280-31794-1-git-send-email-xiaoxiang@xiaomi.com>
 <1548949280-31794-3-git-send-email-xiaoxiang@xiaomi.com>
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
Openpgp: preference=signencrypt
Autocrypt: addr=arnaud.pouliquen@st.com; prefer-encrypt=mutual; keydata=
 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
 8mOik8I/F6EW8XyQAA2P
Message-ID: <01b88b99-ebc1-a5a3-2ff9-39fe476847be@st.com>
Date:   Thu, 9 May 2019 14:02:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1548949280-31794-3-git-send-email-xiaoxiang@xiaomi.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Xiang,

This patch has the opposite effect on my platform as DMA allocation is
aligned on 4k page.
For instance i declared:
- in RX  6 buffers (of 512 bytes)
- in TX  4 buffers ( of 512 bytes)

The result is (kernel trace)
[   41.915896] virtio_rpmsg_bus virtio0: rx buffers: va ebb5f5ca, dma
0x0x10042000
[   41.915922] virtio_rpmsg_bus virtio0: tx buffers: va a7865153, dma
0x0x10043000

The TX buffer memory is allocated on next 4k page...

Anyway separate the RX and TX allocation makes sense. This could also
allow to allocate buffers in 2 different memories.
For time being, issue is that only one memory area can be attached to
the virtio device for DMA allocation... and PA/DA translations are missing.
This means that we probably need (in a first step) a new remoteproc API
for memory allocation.
These memories should be declared and mmaped in rproc platform drivers
(memory region) or in resource table (carveout).
This is partially done in the API for the platform driver
(rproc_mem_entry_init) but not available for rproc clients.

Regards
Arnaud


On 1/31/19 4:41 PM, Xiang Xiao wrote:
> many dma allocator align the returned address with buffer size,
> so two small allocation could reduce the alignment requirement
> and save the the memory space wasted by the potential alignment.
> 
> Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 58 +++++++++++++++++++++++-----------------
>  1 file changed, 34 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index fb0d2eb..59c4554 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -40,7 +40,8 @@
>   * @num_sbufs:	total number of buffers for tx
>   * @buf_size:	size of one rx or tx buffer
>   * @last_sbuf:	index of last tx buffer used
> - * @bufs_dma:	dma base addr of the buffers
> + * @rbufs_dma:	dma base addr of rx buffers
> + * @sbufs_dma:	dma base addr of tx buffers
>   * @tx_lock:	protects svq, sbufs and sleepers, to allow concurrent senders.
>   *		sending a message might require waking up a dozing remote
>   *		processor, which involves sleeping, hence the mutex.
> @@ -62,7 +63,8 @@ struct virtproc_info {
>  	unsigned int num_sbufs;
>  	unsigned int buf_size;
>  	int last_sbuf;
> -	dma_addr_t bufs_dma;
> +	dma_addr_t rbufs_dma;
> +	dma_addr_t sbufs_dma;
>  	struct mutex tx_lock;
>  	struct idr endpoints;
>  	struct mutex endpoints_lock;
> @@ -872,9 +874,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
>  	static const char * const names[] = { "input", "output" };
>  	struct virtqueue *vqs[2];
>  	struct virtproc_info *vrp;
> -	void *bufs_va;
>  	int err = 0, i;
> -	size_t total_buf_space;
>  	bool notify;
>  
>  	vrp = kzalloc(sizeof(*vrp), GFP_KERNEL);
> @@ -909,25 +909,28 @@ static int rpmsg_probe(struct virtio_device *vdev)
>  
>  	vrp->buf_size = MAX_RPMSG_BUF_SIZE;
>  
> -	total_buf_space = (vrp->num_rbufs + vrp->num_sbufs) * vrp->buf_size;
> -
>  	/* allocate coherent memory for the buffers */
> -	bufs_va = dma_alloc_coherent(vdev->dev.parent->parent,
> -				     total_buf_space, &vrp->bufs_dma,
> -				     GFP_KERNEL);
> -	if (!bufs_va) {
> +	vrp->rbufs = dma_alloc_coherent(vdev->dev.parent->parent,
> +					vrp->num_rbufs * vrp->buf_size,
> +					&vrp->rbufs_dma, GFP_KERNEL);
> +	if (!vrp->rbufs) {
>  		err = -ENOMEM;
>  		goto vqs_del;
>  	}
>  
> -	dev_dbg(&vdev->dev, "buffers: va %p, dma %pad\n",
> -		bufs_va, &vrp->bufs_dma);
> +	dev_dbg(&vdev->dev, "rx buffers: va %p, dma 0x%pad\n",
> +		vrp->rbufs, &vrp->rbufs_dma);
>  
> -	/* first part of the buffers is dedicated for RX */
> -	vrp->rbufs = bufs_va;
> +	vrp->sbufs = dma_alloc_coherent(vdev->dev.parent->parent,
> +					vrp->num_sbufs * vrp->buf_size,
> +					&vrp->sbufs_dma, GFP_KERNEL);
> +	if (!vrp->sbufs) {
> +		err = -ENOMEM;
> +		goto free_rbufs;
> +	}
>  
> -	/* and second part is dedicated for TX */
> -	vrp->sbufs = bufs_va + vrp->num_rbufs * vrp->buf_size;
> +	dev_dbg(&vdev->dev, "tx buffers: va %p, dma 0x%pad\n",
> +		vrp->sbufs, &vrp->sbufs_dma);
>  
>  	/* set up the receive buffers */
>  	for (i = 0; i < vrp->num_rbufs; i++) {
> @@ -954,7 +957,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
>  		if (!vrp->ns_ept) {
>  			dev_err(&vdev->dev, "failed to create the ns ept\n");
>  			err = -ENOMEM;
> -			goto free_coherent;
> +			goto free_sbufs;
>  		}
>  	}
>  
> @@ -979,9 +982,14 @@ static int rpmsg_probe(struct virtio_device *vdev)
>  
>  	return 0;
>  
> -free_coherent:
> -	dma_free_coherent(vdev->dev.parent->parent, total_buf_space,
> -			  bufs_va, vrp->bufs_dma);
> +free_sbufs:
> +	dma_free_coherent(vdev->dev.parent->parent,
> +			  vrp->num_sbufs * vrp->buf_size,
> +			  vrp->sbufs, vrp->sbufs_dma);
> +free_rbufs:
> +	dma_free_coherent(vdev->dev.parent->parent,
> +			  vrp->num_rbufs * vrp->buf_size,
> +			  vrp->rbufs, vrp->rbufs_dma);
>  vqs_del:
>  	vdev->config->del_vqs(vrp->vdev);
>  free_vrp:
> @@ -999,8 +1007,6 @@ static int rpmsg_remove_device(struct device *dev, void *data)
>  static void rpmsg_remove(struct virtio_device *vdev)
>  {
>  	struct virtproc_info *vrp = vdev->priv;
> -	unsigned int num_bufs = vrp->num_rbufs + vrp->num_sbufs;
> -	size_t total_buf_space = num_bufs * vrp->buf_size;
>  	int ret;
>  
>  	vdev->config->reset(vdev);
> @@ -1016,8 +1022,12 @@ static void rpmsg_remove(struct virtio_device *vdev)
>  
>  	vdev->config->del_vqs(vrp->vdev);
>  
> -	dma_free_coherent(vdev->dev.parent->parent, total_buf_space,
> -			  vrp->rbufs, vrp->bufs_dma);
> +	dma_free_coherent(vdev->dev.parent->parent,
> +			  vrp->num_sbufs * vrp->buf_size,
> +			  vrp->sbufs, vrp->sbufs_dma);
> +	dma_free_coherent(vdev->dev.parent->parent,
> +			  vrp->num_rbufs * vrp->buf_size,
> +			  vrp->rbufs, vrp->rbufs_dma);
>  
>  	kfree(vrp);
>  }
> 
