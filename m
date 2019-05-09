Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C86C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A500F216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="wMBxhHE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfEILrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 07:47:15 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36744 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725961AbfEILrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:47:14 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x49BfN8T016214;
        Thu, 9 May 2019 13:47:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=6f9n5M3hgXa5sWjQwp0pZ+4Oumgu+9zo8X5s+G/bSds=;
 b=wMBxhHE788QdtHRReSVElVb6OBU4F/7Bm6nQ1EknlUEzKnl+lNmF9Uioywxh0hkzUBmv
 zfTGXLmXouSJR6sHlPdHAj1O5PRXGOL5lysXIx6BogjoXZWOz/ALOXwZGEJWqgTrNCPa
 8/KSy1fp+Ru33uEBdRum73nbeDpV/o1vROalM4LfxXiQvkZPmxXgyFQEg0KnPps77vzQ
 Q+5ZKG+Cy7xcm+Rt4ZEXIJdG21NSVE5O5pDF+Uz3O6NyB92LOljvUjDqbDuL74ngddrj
 IpXKfGx0usMYS+C2pbA10qFcyYUIvvyXa2dEtY56aR1t3wsX19cOim63G8YS0fbN2xRA og== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2scfv2hg1c-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 09 May 2019 13:47:10 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2F1FE38;
        Thu,  9 May 2019 11:47:09 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 077942488;
        Thu,  9 May 2019 11:47:09 +0000 (GMT)
Received: from [10.48.0.131] (10.75.127.47) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 9 May
 2019 13:47:07 +0200
Subject: Re: [PATCH 1/3] rpmsg: virtio_rpmsg_bus: allow the different vring
 size for send/recv
To:     Xiang Xiao <xiaoxiang781216@gmail.com>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>, <wendy.liang@xilinx.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Xiang Xiao <xiaoxiang@xiaomi.com>
References: <1548949280-31794-1-git-send-email-xiaoxiang@xiaomi.com>
 <1548949280-31794-2-git-send-email-xiaoxiang@xiaomi.com>
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
Openpgp: preference=signencrypt
Autocrypt: addr=arnaud.pouliquen@st.com; prefer-encrypt=mutual; keydata=
 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
 8mOik8I/F6EW8XyQAA2P
Message-ID: <6d069d84-a01b-42f7-0e09-464477a7b1ee@st.com>
Date:   Thu, 9 May 2019 13:47:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1548949280-31794-2-git-send-email-xiaoxiang@xiaomi.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Xiang,

I tested your patch on stm32 platform, no issue.
No remark on you code.

Acked-by:Arnaud POULIQUEN <arnaud.pouliquen@st.com>

Thanks,
Arnaud

On 1/31/19 4:41 PM, Xiang Xiao wrote:
> it's useful if the communication throughput is different from each side
> 
> Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 47 ++++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 664f957..fb0d2eb 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -36,8 +36,9 @@
>   * @svq:	tx virtqueue
>   * @rbufs:	kernel address of rx buffers
>   * @sbufs:	kernel address of tx buffers
> - * @num_bufs:	total number of buffers for rx and tx
> - * @buf_size:   size of one rx or tx buffer
> + * @num_rbufs:	total number of buffers for rx
> + * @num_sbufs:	total number of buffers for tx
> + * @buf_size:	size of one rx or tx buffer
>   * @last_sbuf:	index of last tx buffer used
>   * @bufs_dma:	dma base addr of the buffers
>   * @tx_lock:	protects svq, sbufs and sleepers, to allow concurrent senders.
> @@ -57,7 +58,8 @@ struct virtproc_info {
>  	struct virtio_device *vdev;
>  	struct virtqueue *rvq, *svq;
>  	void *rbufs, *sbufs;
> -	unsigned int num_bufs;
> +	unsigned int num_rbufs;
> +	unsigned int num_sbufs;
>  	unsigned int buf_size;
>  	int last_sbuf;
>  	dma_addr_t bufs_dma;
> @@ -136,7 +138,7 @@ struct virtio_rpmsg_channel {
>  /*
>   * We're allocating buffers of 512 bytes each for communications. The
>   * number of buffers will be computed from the number of buffers supported
> - * by the vring, upto a maximum of 512 buffers (256 in each direction).
> + * by the vring, up to a maximum of 256 in each direction.
>   *
>   * Each buffer will have 16 bytes for the msg header and 496 bytes for
>   * the payload.
> @@ -151,7 +153,7 @@ struct virtio_rpmsg_channel {
>   * can change this without changing anything in the firmware of the remote
>   * processor.
>   */
> -#define MAX_RPMSG_NUM_BUFS	(512)
> +#define MAX_RPMSG_NUM_BUFS	(256)
>  #define MAX_RPMSG_BUF_SIZE	(512)
>  
>  /*
> @@ -446,11 +448,8 @@ static void *get_a_tx_buf(struct virtproc_info *vrp)
>  	/* support multiple concurrent senders */
>  	mutex_lock(&vrp->tx_lock);
>  
> -	/*
> -	 * either pick the next unused tx buffer
> -	 * (half of our buffers are used for sending messages)
> -	 */
> -	if (vrp->last_sbuf < vrp->num_bufs / 2)
> +	/* either pick the next unused tx buffer */
> +	if (vrp->last_sbuf < vrp->num_sbufs)
>  		ret = vrp->sbufs + vrp->buf_size * vrp->last_sbuf++;
>  	/* or recycle a used one */
>  	else
> @@ -897,19 +896,20 @@ static int rpmsg_probe(struct virtio_device *vdev)
>  	vrp->rvq = vqs[0];
>  	vrp->svq = vqs[1];
>  
> -	/* we expect symmetric tx/rx vrings */
> -	WARN_ON(virtqueue_get_vring_size(vrp->rvq) !=
> -		virtqueue_get_vring_size(vrp->svq));
> -
>  	/* we need less buffers if vrings are small */
> -	if (virtqueue_get_vring_size(vrp->rvq) < MAX_RPMSG_NUM_BUFS / 2)
> -		vrp->num_bufs = virtqueue_get_vring_size(vrp->rvq) * 2;
> +	if (virtqueue_get_vring_size(vrp->rvq) < MAX_RPMSG_NUM_BUFS)
> +		vrp->num_rbufs = virtqueue_get_vring_size(vrp->rvq);
> +	else
> +		vrp->num_rbufs = MAX_RPMSG_NUM_BUFS;
> +
> +	if (virtqueue_get_vring_size(vrp->svq) < MAX_RPMSG_NUM_BUFS)
> +		vrp->num_sbufs = virtqueue_get_vring_size(vrp->svq);
>  	else
> -		vrp->num_bufs = MAX_RPMSG_NUM_BUFS;
> +		vrp->num_sbufs = MAX_RPMSG_NUM_BUFS;
>  
>  	vrp->buf_size = MAX_RPMSG_BUF_SIZE;
>  
> -	total_buf_space = vrp->num_bufs * vrp->buf_size;
> +	total_buf_space = (vrp->num_rbufs + vrp->num_sbufs) * vrp->buf_size;
>  
>  	/* allocate coherent memory for the buffers */
>  	bufs_va = dma_alloc_coherent(vdev->dev.parent->parent,
> @@ -923,14 +923,14 @@ static int rpmsg_probe(struct virtio_device *vdev)
>  	dev_dbg(&vdev->dev, "buffers: va %p, dma %pad\n",
>  		bufs_va, &vrp->bufs_dma);
>  
> -	/* half of the buffers is dedicated for RX */
> +	/* first part of the buffers is dedicated for RX */
>  	vrp->rbufs = bufs_va;
>  
> -	/* and half is dedicated for TX */
> -	vrp->sbufs = bufs_va + total_buf_space / 2;
> +	/* and second part is dedicated for TX */
> +	vrp->sbufs = bufs_va + vrp->num_rbufs * vrp->buf_size;
>  
>  	/* set up the receive buffers */
> -	for (i = 0; i < vrp->num_bufs / 2; i++) {
> +	for (i = 0; i < vrp->num_rbufs; i++) {
>  		struct scatterlist sg;
>  		void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
>  
> @@ -999,7 +999,8 @@ static int rpmsg_remove_device(struct device *dev, void *data)
>  static void rpmsg_remove(struct virtio_device *vdev)
>  {
>  	struct virtproc_info *vrp = vdev->priv;
> -	size_t total_buf_space = vrp->num_bufs * vrp->buf_size;
> +	unsigned int num_bufs = vrp->num_rbufs + vrp->num_sbufs;
> +	size_t total_buf_space = num_bufs * vrp->buf_size;
>  	int ret;
>  
>  	vdev->config->reset(vdev);
> 
