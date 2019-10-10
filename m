Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528BAECE58C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0E02067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="b7WWtw1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732544AbfJJAkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 20:40:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37827 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732504AbfJJAkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 20:40:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id l51so5933201qtc.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 17:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=EmpLSZbGnESFw5BRu3T9oQ2vsLPNikHLnrHZ4E2SsuQ=;
        b=b7WWtw1q5NY5f4d8hbqlFYATElioKhsFMKy3jfvgJqtJGssk/ZrOpgoM+Cm7xH9Sih
         t7TgqcnNx6GJBiqNxWCSP6af6PmecWBHVDtDxcBEi0PNzkY714XlWiNXg0r+b6rCVJtI
         M1TRlgAEVdgyLp0D+aJx/xl3JrZB/2RRtr1eStVB+RVYub7RbEoFp9Cql4tl5Qg6n+ze
         dt+vw3tyQz4BZ2TSDznhVJOb7k8O+ylNt9gPS8G83u6Qirendn5QhSVbVZrhja1Y7arP
         AMbSuyqQakrAZRptMsbbP7HprUuDhtWC/P7HjOVQ3M83P/iSWfzoNU1JPEnhgKblQsPL
         66qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=EmpLSZbGnESFw5BRu3T9oQ2vsLPNikHLnrHZ4E2SsuQ=;
        b=XnZDBW7oxMc3Nh3gYPNaADLyxg3SvZ+5q2MR6RP7sWr6n/h9f7zS3pN0GMNvXmz2kW
         LWQWqeMKfwPc8Why3p4r2Xsy9dQGMbclogQZc3Z08nGxteQGDMG4tI5om54M2rI51i/y
         2JMs9xjHi5blrzqZ8YsD+wqbGf2WJtzk4dKj96J7yU+2GJysCAmB550bf/n+YHjPvjKM
         rakni7gAWJonNpSa+ew2IayLkur/BS3bPUz42Reue+nfUZMa9j6SUYns4kpE0hiY0/lD
         CEsZ0LNZ2Ju+hQSlgL8CAQcGkU5bFiRXROmMlyN9N8Xur2tFfLxPPC7A6Na+IyUnnoLG
         FXrA==
X-Gm-Message-State: APjAAAXbEVEDy3X+4kbJtrRvwNVYeenbI6iUBTxKbPfKJHbIj8OpQrJA
        4MEEGcAVRsD4HxknRUvyFzeD+g==
X-Google-Smtp-Source: APXvYqy2/etBM3Y4o1m1X7nu8yQP8ccfjmntYl/WLKoe/MVCR1+VUGZlNI71v3S0aiomLQcsob3pbA==
X-Received: by 2002:ac8:f28:: with SMTP id e37mr7140558qtk.274.1570668038323;
        Wed, 09 Oct 2019 17:40:38 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id q44sm2594824qtk.16.2019.10.09.17.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 17:40:38 -0700 (PDT)
Date:   Wed, 9 Oct 2019 17:40:23 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Jilayne Lovejoy <opensource@jilayne.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Winslow <swinslow@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Johan Hovold <johan@kernel.org>,
        netdev@vger.kernel.org (open list:NFC SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list),
        Claudiu Beznea <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v9 4/7] nfc: pn533: Split pn533 init & nfc_register
Message-ID: <20191009174023.528c278b@cakuba.netronome.com>
In-Reply-To: <20191008140544.17112-5-poeschel@lemonage.de>
References: <20191008140544.17112-1-poeschel@lemonage.de>
        <20191008140544.17112-5-poeschel@lemonage.de>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 Oct 2019 16:05:41 +0200, Lars Poeschel wrote:
> There is a problem in the initialisation and setup of the pn533: It
> registers with nfc too early. It could happen, that it finished
> registering with nfc and someone starts using it. But setup of the pn533
> is not yet finished. Bad or at least unintended things could happen.
> So I split out nfc registering (and unregistering) to seperate functions
> that have to be called late in probe then.
> 
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Claudiu Beznea <Claudiu.Beznea@microchip.com>
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>

> diff --git a/drivers/nfc/pn533/i2c.c b/drivers/nfc/pn533/i2c.c
> index 1abd40398a5a..e9e5a1ec8857 100644
> --- a/drivers/nfc/pn533/i2c.c
> +++ b/drivers/nfc/pn533/i2c.c
> @@ -193,12 +193,10 @@ static int pn533_i2c_probe(struct i2c_client *client,
>  	phy->i2c_dev = client;
>  	i2c_set_clientdata(client, phy);
>  
> -	priv = pn533_register_device(PN533_DEVICE_PN532,
> -				     PN533_NO_TYPE_B_PROTOCOLS,
> +	priv = pn53x_common_init(PN533_DEVICE_PN532,
>  				     PN533_PROTO_REQ_ACK_RESP,
>  				     phy, &i2c_phy_ops, NULL,
> -				     &phy->i2c_dev->dev,
> -				     &client->dev);
> +				     &phy->i2c_dev->dev);

nit: start of continuation lines should match the opening parenthesis,
     please run checkpatch and fix the style issue

>  	if (IS_ERR(priv)) {
>  		r = PTR_ERR(priv);
> @@ -220,13 +218,17 @@ static int pn533_i2c_probe(struct i2c_client *client,
>  	if (r)
>  		goto fn_setup_err;
>  
> -	return 0;
> +	r = pn53x_register_nfc(priv, PN533_NO_TYPE_B_PROTOCOLS, &client->dev);
> +	if (r)
> +		goto fn_setup_err;
> +
> +	return r;
>  
>  fn_setup_err:
>  	free_irq(client->irq, phy);
>  
>  irq_rqst_err:
> -	pn533_unregister_device(phy->priv);
> +	pn53x_common_clean(phy->priv);
>  
>  	return r;
>  }
> @@ -239,7 +241,8 @@ static int pn533_i2c_remove(struct i2c_client *client)
>  
>  	free_irq(client->irq, phy);
>  
> -	pn533_unregister_device(phy->priv);
> +	pn53x_unregister_nfc(phy->priv);
> +	pn53x_common_clean(phy->priv);
>  
>  	return 0;
>  }
> diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
> index 64836c727aee..e5d5e4c83a04 100644
> --- a/drivers/nfc/pn533/pn533.c
> +++ b/drivers/nfc/pn533/pn533.c
> @@ -2590,14 +2590,12 @@ int pn533_finalize_setup(struct pn533 *dev)
>  }
>  EXPORT_SYMBOL_GPL(pn533_finalize_setup);
>  
> -struct pn533 *pn533_register_device(u32 device_type,
> -				u32 protocols,
> +struct pn533 *pn53x_common_init(u32 device_type,
>  				enum pn533_protocol_type protocol_type,
>  				void *phy,
>  				struct pn533_phy_ops *phy_ops,
>  				struct pn533_frame_ops *fops,
> -				struct device *dev,
> -				struct device *parent)
> +				struct device *dev)
>  {
>  	struct pn533 *priv;
>  	int rc = -ENOMEM;
> @@ -2638,43 +2636,18 @@ struct pn533 *pn533_register_device(u32 device_type,
>  	skb_queue_head_init(&priv->fragment_skb);
>  
>  	INIT_LIST_HEAD(&priv->cmd_queue);
> -
> -	priv->nfc_dev = nfc_allocate_device(&pn533_nfc_ops, protocols,
> -					   priv->ops->tx_header_len +
> -					   PN533_CMD_DATAEXCH_HEAD_LEN,
> -					   priv->ops->tx_tail_len);
> -	if (!priv->nfc_dev) {
> -		rc = -ENOMEM;
> -		goto destroy_wq;
> -	}
> -
> -	nfc_set_parent_dev(priv->nfc_dev, parent);
> -	nfc_set_drvdata(priv->nfc_dev, priv);
> -
> -	rc = nfc_register_device(priv->nfc_dev);
> -	if (rc)
> -		goto free_nfc_dev;

Aren't you moving too much out of here? Looking at commit 32ecc75ded72
("NFC: pn533: change order operations in dev registation") it seems like
IRQ handler may want to access the data structures, do this change not
reintroduce the problem?

>  	return priv;
>  
> -free_nfc_dev:
> -	nfc_free_device(priv->nfc_dev);
> -
> -destroy_wq:
> -	destroy_workqueue(priv->wq);
>  error:
>  	kfree(priv);
>  	return ERR_PTR(rc);
>  }
> -EXPORT_SYMBOL_GPL(pn533_register_device);
> +EXPORT_SYMBOL_GPL(pn53x_common_init);
>  
> -void pn533_unregister_device(struct pn533 *priv)
> +void pn53x_common_clean(struct pn533 *priv)
>  {
>  	struct pn533_cmd *cmd, *n;
>  
> -	nfc_unregister_device(priv->nfc_dev);
> -	nfc_free_device(priv->nfc_dev);
> -
>  	flush_delayed_work(&priv->poll_work);
>  	destroy_workqueue(priv->wq);
>  

