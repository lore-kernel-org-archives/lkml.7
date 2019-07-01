Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FB1C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 05:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F0D208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 05:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T7tVVwB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfGAFbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 01:31:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39661 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfGAFbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 01:31:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id 196so5431140pgc.6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 22:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sSrVuFekE0jj9BwtEox6wWPzH8cUCNr+RSAQiVlBb2c=;
        b=T7tVVwB6Szm5N/x5TuH3K9rXmZGT5jenayft+3QeEzNyoEMhIq7L7BkyHU/ZyocIdj
         +DtycBCuGnRpUM7VfrJ428U3A15TAX1MgbsCfTjpt0lYvw8o1WNJyCpixtbjdz/+kv6w
         kHxidGG3LR6j1U8yipPPRkj8RokVv7PZcMx1hqfySZglqS3h/Mb8SR7fV9zg/Ou5AIg6
         kDxB06kbqbTs1dOXeysue4TP4tpmgzzugOyFrcxDyTrayuKpceKXbqldjf4lL/FomIYV
         6jjB0LDpnjFX97ntQ7091LfSehcCRN2lBrUNj6CHCdddhni9XQm3pAIHtxPRIXSoGcFU
         zJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sSrVuFekE0jj9BwtEox6wWPzH8cUCNr+RSAQiVlBb2c=;
        b=s+I2PZAIKt52QPTR08/byQUAfaXtK1Ko0ZoL/p9hawZkRF/XrgioJKwq10OCTJIABB
         M1HOuQWko59HxUBGhjYHuw2edw4yrprycT/cX3IuXfRXGYu/BP2FYmRmT4fGiw1IT5zF
         RcVco+HzynXcghMRDUxWMFVoUC42l1TbFY6nhOjzzCRwd1c+4ZlkPByv0c0ByPAvkKIG
         BLZ8eQ5hFEbgm0Jv3LUd2+PX62Ki07iGVJdwJIi5eS/dj51aJlsEMGcOiFGNySdkmTLE
         SWKYpNyhuWXKJP3Qc36VG7bZZZ6+/n45Rn6rNVrfD2fDyPVNSZOetk1FpLos7Oj/JJQn
         nmVw==
X-Gm-Message-State: APjAAAUCewIpZYgSt1M32y2AYgOhlkJ4d9m9yLEcnJTxBvhqyeaJ2MN9
        K11D1Qr9ds4bT7iDFNyrPYPhXQ==
X-Google-Smtp-Source: APXvYqySbuYeRoauGD2OF6FPjqnlb+W4RFEID2rA1GW6RnjaAADpy5UkOfwCRcgRD3FL+g1/0kLNgQ==
X-Received: by 2002:a17:90a:d817:: with SMTP id a23mr28473172pjv.54.1561959100816;
        Sun, 30 Jun 2019 22:31:40 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 4sm3424502pfc.92.2019.06.30.22.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Jun 2019 22:31:39 -0700 (PDT)
Date:   Sun, 30 Jun 2019 22:31:37 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        xiang xiao <xiaoxiang781216@gmail.com>,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Fabien DESSENNE <fabien.dessenne@st.com>
Subject: Re: [PATCH v2 1/2] rpmsg: core: add possibility to get message
 payload length
Message-ID: <20190701053137.GC1263@builder>
References: <1557500577-22366-1-git-send-email-arnaud.pouliquen@st.com>
 <1557500577-22366-2-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557500577-22366-2-git-send-email-arnaud.pouliquen@st.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 10 May 08:02 PDT 2019, Arnaud Pouliquen wrote:

> Return the rpmsg buffer payload size for sending message, so rpmsg users
> can split a long message in several sub rpmsg buffers.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>

This should list each person who dealt with the patch. So the first
would be the author and the last would be the one that posted it on the
list.

If you both authored the patch then you should add Co-developed-by to
denote this.

> ---
>  drivers/rpmsg/rpmsg_core.c       | 20 ++++++++++++++++++++
>  drivers/rpmsg/rpmsg_internal.h   |  2 ++
>  drivers/rpmsg/virtio_rpmsg_bus.c | 11 +++++++++++
>  include/linux/rpmsg.h            | 10 ++++++++++
>  4 files changed, 43 insertions(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index 8122807db380..75c8c403ffe5 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -283,6 +283,26 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>  }
>  EXPORT_SYMBOL(rpmsg_trysend_offchannel);
>  
> +/**
> + * rpmsg_get_buf_payload_size()
> + * This function returns buffer payload size available for sending messages.
> + *
> + * @ept: the rpmsg endpoint
> + *
> + * Returns buffer payload size on success and an appropriate error value on
> + * failure.
> + */

Please read
https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt

> +int rpmsg_get_buf_payload_size(struct rpmsg_endpoint *ept)

payload size can have many meanings and hopefully we'll end up in a
situation where its dynamic. But it could be considered useful to have a
way to query the maximum transmission size in such a setup.

So please rename this rpmsg_get_mtu() or something similar.

And I would prefer ssize_t as return type.

> +{
> +	if (WARN_ON(!ept))
> +		return -EINVAL;
> +	if (!ept->ops->get_buf_payload_size)
> +		return -ENXIO;
> +
> +	return ept->ops->get_buf_payload_size(ept);
> +}
> +EXPORT_SYMBOL(rpmsg_get_buf_payload_size);
> +
>  /*
>   * match an rpmsg channel with a channel info struct.
>   * this is used to make sure we're not creating rpmsg devices for channels
> diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
> index 0d791c30b7ea..6f733a556139 100644
> --- a/drivers/rpmsg/rpmsg_internal.h
> +++ b/drivers/rpmsg/rpmsg_internal.h
> @@ -46,6 +46,7 @@ struct rpmsg_device_ops {
>   * @trysend:		see @rpmsg_trysend(), required
>   * @trysendto:		see @rpmsg_trysendto(), optional
>   * @trysend_offchannel:	see @rpmsg_trysend_offchannel(), optional
> + * @get_buf_payload_size: see @rpmsg_get_buf_payload_size(), optional
>   *
>   * Indirection table for the operations that a rpmsg backend should implement.
>   * In addition to @destroy_ept, the backend must at least implement @send and
> @@ -65,6 +66,7 @@ struct rpmsg_endpoint_ops {
>  			     void *data, int len);
>  	__poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
>  			     poll_table *wait);
> +	int (*get_buf_payload_size)(struct rpmsg_endpoint *ept);
>  };
>  
>  int rpmsg_register_device(struct rpmsg_device *rpdev);
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 5d3685bd76a2..82753e76e377 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -175,6 +175,7 @@ static int virtio_rpmsg_trysendto(struct rpmsg_endpoint *ept, void *data,
>  				  int len, u32 dst);
>  static int virtio_rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src,
>  					   u32 dst, void *data, int len);
> +static int virtio_get_buf_payload_size(struct rpmsg_endpoint *ept);
>  
>  static const struct rpmsg_endpoint_ops virtio_endpoint_ops = {
>  	.destroy_ept = virtio_rpmsg_destroy_ept,
> @@ -184,6 +185,7 @@ static const struct rpmsg_endpoint_ops virtio_endpoint_ops = {
>  	.trysend = virtio_rpmsg_trysend,
>  	.trysendto = virtio_rpmsg_trysendto,
>  	.trysend_offchannel = virtio_rpmsg_trysend_offchannel,
> +	.get_buf_payload_size = virtio_get_buf_payload_size,
>  };
>  
>  /**
> @@ -699,6 +701,15 @@ static int virtio_rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src,
>  	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, false);
>  }
>  
> +static int virtio_get_buf_payload_size(struct rpmsg_endpoint *ept)
> +{
> +	struct rpmsg_device *rpdev = ept->rpdev;
> +	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
> +	int size = vch->vrp->buf_size - sizeof(struct rpmsg_hdr);
> +
> +	return size < 0 ? -EMSGSIZE : size;

Seems that a rpmsg instance configured to not even have space for the
rpmsg_hdr in each message is rather broken. Shouldn't this be prohibited
elsewhere?

Regards,
Bjorn

> +}
> +
>  static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
>  			     struct rpmsg_hdr *msg, unsigned int len)
>  {
> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
> index 9fe156d1c018..250df2165086 100644
> --- a/include/linux/rpmsg.h
> +++ b/include/linux/rpmsg.h
> @@ -135,6 +135,8 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>  __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
>  			poll_table *wait);
>  
> +int rpmsg_get_buf_payload_size(struct rpmsg_endpoint *ept);
> +
>  #else
>  
>  static inline int register_rpmsg_device(struct rpmsg_device *dev)
> @@ -242,6 +244,14 @@ static inline __poll_t rpmsg_poll(struct rpmsg_endpoint *ept,
>  	return 0;
>  }
>  
> +static int rpmsg_get_buf_payload_size(struct rpmsg_endpoint *ept)
> +{
> +	/* This shouldn't be possible */
> +	WARN_ON(1);
> +
> +	return -ENXIO;
> +}
> +
>  #endif /* IS_ENABLED(CONFIG_RPMSG) */
>  
>  /* use a macro to avoid include chaining to get THIS_MODULE */
> -- 
> 2.7.4
> 
