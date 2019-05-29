Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F83C04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50614206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jRY3uG8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfE2BEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 21:04:14 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45844 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfE2BEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 21:04:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id a5so264025pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 18:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eDM5fdSuTRnA5fXaF+6hZdcJmU1/PIyQ7UxywRR2Zog=;
        b=jRY3uG8W1jMZob8W9ofGD/se970aLLuWe8jQ03NxTzulzSjjpWbkKesIq8eGFxh7T+
         qgp/CGZTXI5WP0lrsBwWI/9QE/pTpkHOV65N4W3vATnRLtk+x0vJGO5wJiB+mPzAmprz
         yhfiUWLV8419oXZTadCTiDl8546amwwXjTNKbLvRtH72RxXdhky9YKKOUThJECLpc+YA
         iNSPtol1fajjIznq7Rbm9CCRPd9dxGP2vF0FRQzOKNPhe8Agk3RRcwvcE0ugE4U1zARI
         AcJ8v4CIkWwvHRnoA5dK9tJogm7shN1jfQnNDsR9h2oWpum22MDihS+0qXCS2erERKol
         eOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eDM5fdSuTRnA5fXaF+6hZdcJmU1/PIyQ7UxywRR2Zog=;
        b=RcJ2AuYS61G+knyjnhax3D3inEqiJ8aCYq4oSP67r8DD9zxNFgGRNYq72R0oMURAL0
         t8zG0F+m6UO9U6vvtgxhOAoTTP+IW/wkZlFnuvCmdtVV7xnu6OsCRNJ5MouwcB37Nfvt
         q89aUohygZgqp5q5LWs8REh0X+wAXH9mlGKqy2iM7ju3Wvv6oYMj2Jscrsfdxxwn3akk
         5v3sLN05lQoeLi964arziyb2p0H5uJnf1l5ZtUeyvAOhXXCAp9z0ZddHJACWIi/nolLE
         u0ObEtCggNP8PCnqLWQ6Lw05srR1apl/BocSYXhxsqcRFmhAPFJQNYToPiWhF+uQW/IU
         A7KA==
X-Gm-Message-State: APjAAAXszAdHlvFZm1GIqCcRbHVu5j8MNAVykTtBfjbIasVo3wVnXJ+L
        RELk+P65/W/O8mHauruM0cleTg==
X-Google-Smtp-Source: APXvYqxova5B2ZxYzxrpOdJ/qUyycjlqZCJMv+XpnPdomRoSmE60kwLkJxo5XWWbioRRYWw3FjMYkw==
X-Received: by 2002:a17:902:9698:: with SMTP id n24mr53203712plp.118.1559091852902;
        Tue, 28 May 2019 18:04:12 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l141sm19334761pfd.24.2019.05.28.18.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 18:04:11 -0700 (PDT)
Date:   Tue, 28 May 2019 18:04:10 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rohitkr@codeaurora.org, bgoswami@codeaurora.org
Subject: Re: [PATCH v2] qcom: apr: Make apr callbacks in non-atomic context
Message-ID: <20190529010410.GA24059@builder>
References: <20190208175510.26837-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208175510.26837-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08 Feb 09:55 PST 2019, Srinivas Kandagatla wrote:

> APR communication with DSP is not atomic in nature.
> Its request-response type. Trying to pretend that these are atomic
> and invoking apr client callbacks directly under atomic/irq context has
> endless issues with soundcard. It makes more sense to convert these
> to nonatomic calls. This also coverts all the dais to be nonatomic.
> 
> All the callbacks are now invoked as part of rx work queue.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Picked up

Thanks,
Bjorn

> ---
> Changes since v1:
>  - flush and destroy work queue after removing the device
> 	 to avoid active communication from device. suggested by Bjorn.
> 
>  drivers/soc/qcom/apr.c | 74 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 69 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
> index 74f8b9607daa..039e3aa6f5e0 100644
> --- a/drivers/soc/qcom/apr.c
> +++ b/drivers/soc/qcom/apr.c
> @@ -8,6 +8,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/idr.h>
>  #include <linux/slab.h>
> +#include <linux/workqueue.h>
>  #include <linux/of_device.h>
>  #include <linux/soc/qcom/apr.h>
>  #include <linux/rpmsg.h>
> @@ -17,8 +18,18 @@ struct apr {
>  	struct rpmsg_endpoint *ch;
>  	struct device *dev;
>  	spinlock_t svcs_lock;
> +	spinlock_t rx_lock;
>  	struct idr svcs_idr;
>  	int dest_domain_id;
> +	struct workqueue_struct *rxwq;
> +	struct work_struct rx_work;
> +	struct list_head rx_list;
> +};
> +
> +struct apr_rx_buf {
> +	struct list_head node;
> +	int len;
> +	uint8_t buf[];
>  };
>  
>  /**
> @@ -62,11 +73,7 @@ static int apr_callback(struct rpmsg_device *rpdev, void *buf,
>  				  int len, void *priv, u32 addr)
>  {
>  	struct apr *apr = dev_get_drvdata(&rpdev->dev);
> -	uint16_t hdr_size, msg_type, ver, svc_id;
> -	struct apr_device *svc = NULL;
> -	struct apr_driver *adrv = NULL;
> -	struct apr_resp_pkt resp;
> -	struct apr_hdr *hdr;
> +	struct apr_rx_buf *abuf;
>  	unsigned long flags;
>  
>  	if (len <= APR_HDR_SIZE) {
> @@ -75,6 +82,34 @@ static int apr_callback(struct rpmsg_device *rpdev, void *buf,
>  		return -EINVAL;
>  	}
>  
> +	abuf = kzalloc(sizeof(*abuf) + len, GFP_ATOMIC);
> +	if (!abuf)
> +		return -ENOMEM;
> +
> +	abuf->len = len;
> +	memcpy(abuf->buf, buf, len);
> +
> +	spin_lock_irqsave(&apr->rx_lock, flags);
> +	list_add_tail(&abuf->node, &apr->rx_list);
> +	spin_unlock_irqrestore(&apr->rx_lock, flags);
> +
> +	queue_work(apr->rxwq, &apr->rx_work);
> +
> +	return 0;
> +}
> +
> +
> +static int apr_do_rx_callback(struct apr *apr, struct apr_rx_buf *abuf)
> +{
> +	uint16_t hdr_size, msg_type, ver, svc_id;
> +	struct apr_device *svc = NULL;
> +	struct apr_driver *adrv = NULL;
> +	struct apr_resp_pkt resp;
> +	struct apr_hdr *hdr;
> +	unsigned long flags;
> +	void *buf = abuf->buf;
> +	int len = abuf->len;
> +
>  	hdr = buf;
>  	ver = APR_HDR_FIELD_VER(hdr->hdr_field);
>  	if (ver > APR_PKT_VER + 1)
> @@ -132,6 +167,23 @@ static int apr_callback(struct rpmsg_device *rpdev, void *buf,
>  	return 0;
>  }
>  
> +static void apr_rxwq(struct work_struct *work)
> +{
> +	struct apr *apr = container_of(work, struct apr, rx_work);
> +	struct apr_rx_buf *abuf, *b;
> +	unsigned long flags;
> +
> +	if (!list_empty(&apr->rx_list)) {
> +		list_for_each_entry_safe(abuf, b, &apr->rx_list, node) {
> +			apr_do_rx_callback(apr, abuf);
> +			spin_lock_irqsave(&apr->rx_lock, flags);
> +			list_del(&abuf->node);
> +			spin_unlock_irqrestore(&apr->rx_lock, flags);
> +			kfree(abuf);
> +		}
> +	}
> +}
> +
>  static int apr_device_match(struct device *dev, struct device_driver *drv)
>  {
>  	struct apr_device *adev = to_apr_device(dev);
> @@ -285,6 +337,14 @@ static int apr_probe(struct rpmsg_device *rpdev)
>  	dev_set_drvdata(dev, apr);
>  	apr->ch = rpdev->ept;
>  	apr->dev = dev;
> +	apr->rxwq = create_singlethread_workqueue("qcom_apr_rx");
> +	if (!apr->rxwq) {
> +		dev_err(apr->dev, "Failed to start Rx WQ\n");
> +		return -ENOMEM;
> +	}
> +	INIT_WORK(&apr->rx_work, apr_rxwq);
> +	INIT_LIST_HEAD(&apr->rx_list);
> +	spin_lock_init(&apr->rx_lock);
>  	spin_lock_init(&apr->svcs_lock);
>  	idr_init(&apr->svcs_idr);
>  	of_register_apr_devices(dev);
> @@ -303,7 +363,11 @@ static int apr_remove_device(struct device *dev, void *null)
>  
>  static void apr_remove(struct rpmsg_device *rpdev)
>  {
> +	struct apr *apr = dev_get_drvdata(&rpdev->dev);
> +
>  	device_for_each_child(&rpdev->dev, NULL, apr_remove_device);
> +	flush_workqueue(apr->rxwq);
> +	destroy_workqueue(apr->rxwq);
>  }
>  
>  /*
> -- 
> 2.20.1
> 
