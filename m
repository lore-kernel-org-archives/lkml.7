Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6347EC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C896214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="gR+D6iiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfHIUfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 16:35:15 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45322 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfHIUfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 16:35:14 -0400
Received: by mail-qt1-f196.google.com with SMTP id f7so4221190qtq.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 13:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=eGij1FbB9MgvxaYppuZV1K7DcJdfdX5GiLALsqu+zdk=;
        b=gR+D6iiBjbY6YUZdGyZSpYq3ujV9tCsEJVukL2O0IdzzyuHe+EoZtV0j+KDbWLGkU6
         O/TH5Vh7YTJ/CAJ4WOiS2sN9CWLV8Ciw/IWZMgC24j+qcm2LvpAWvGPV87CToa3hrgJG
         TqRqqr2rc4MmuPWhzW5Auh5CBZ5K9cW//N6WLcy3lXYj2oagweuhosojSclSMOZNYgHj
         M5Fh1OMFRoRr5j+ODXWdTQC7nL9m62n5Gxy6HEHM3FcoJqHTARiZHMDLK6KRUGiHwD+y
         sbRlwP9FPuw+DFBQklflbCGzHZuq0eQmmkmmFGrDvC6n8TCUIUznjZ5rPMmnZWU9W0kK
         p8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=eGij1FbB9MgvxaYppuZV1K7DcJdfdX5GiLALsqu+zdk=;
        b=ScWdpUUy356iU0jLhdqF27QoXfsG8307Ydo5s3YWTIwqEAEfB8sE4t/Kp7gxKi5F/1
         yLk38cFowf2n3a7yLboPEnmrQJm/qO138qhBaiZatfCO0uhwOGWzIPBZ9QDZmJHVTRvO
         Og9yvzlUxJSRpegTwtM1LpWrufRMoOBl5vcVg7oJHsabazPqw+Dz9xvLZ/tbn0QPoqQZ
         eN6qmYindtMoYRUrxSrOX/WWJ6nZJzkiWbJxYJ66dKVXYXEqfVQpkrFJZN/UJuwqDQrC
         Pih5Dg/CvlvhOj5eZe8pma8aiU/Duitj0xcpjc3vOhMo5i6smh19G0D0qM6HRo1lioX4
         mIBg==
X-Gm-Message-State: APjAAAVc3fVd3YimAEnbz+gaeirjAdsgfyFA3eQOSvjvJ2BgXTyJ+jUI
        1Leejc1f9GUPaR3GJfinDbfT9g==
X-Google-Smtp-Source: APXvYqwr4RA/ml4OIp/H+H4m4sminido+4Cokq14wHQ7nQRkY2KrDRMMK2dmVoaw65H4T3SbYRgMpQ==
X-Received: by 2002:ac8:53c7:: with SMTP id c7mr19537664qtq.162.1565382913830;
        Fri, 09 Aug 2019 13:35:13 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id s58sm5731144qth.59.2019.08.09.13.35.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 13:35:13 -0700 (PDT)
Date:   Fri, 9 Aug 2019 13:35:09 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, sd@queasysnail.net, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, allan.nielsen@microchip.com,
        camelia.groza@nxp.com, Simon.Edelhaus@aquantia.com
Subject: Re: [PATCH net-next v2 4/9] net: introduce MACsec ops and add a
 reference in net_device
Message-ID: <20190809133509.12dbead1@cakuba.netronome.com>
In-Reply-To: <20190808140600.21477-5-antoine.tenart@bootlin.com>
References: <20190808140600.21477-1-antoine.tenart@bootlin.com>
        <20190808140600.21477-5-antoine.tenart@bootlin.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Aug 2019 16:05:55 +0200, Antoine Tenart wrote:
> This patch introduces MACsec ops for drivers to support offloading
> MACsec operations. A reference to those ops is added in net_device.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> ---
>  include/linux/netdevice.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 88292953aa6f..59ff123d62e3 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -53,6 +53,7 @@ struct netpoll_info;
>  struct device;
>  struct phy_device;
>  struct dsa_port;
> +struct macsec_context;
>  
>  struct sfp_bus;
>  /* 802.11 specific */
> @@ -910,6 +911,29 @@ struct xfrmdev_ops {
>  };
>  #endif
>  
> +#if defined(CONFIG_MACSEC)
> +struct macsec_ops {

I think it'd be cleaner to have macsec_ops declared in macsec.h
and forward declare macsec_ops rather than macsec_context.

> +	/* Device wide */
> +	int (*mdo_dev_open)(struct macsec_context *ctx);
> +	int (*mdo_dev_stop)(struct macsec_context *ctx);
> +	/* SecY */
> +	int (*mdo_add_secy)(struct macsec_context *ctx);
> +	int (*mdo_upd_secy)(struct macsec_context *ctx);
> +	int (*mdo_del_secy)(struct macsec_context *ctx);
> +	/* Security channels */
> +	int (*mdo_add_rxsc)(struct macsec_context *ctx);
> +	int (*mdo_upd_rxsc)(struct macsec_context *ctx);
> +	int (*mdo_del_rxsc)(struct macsec_context *ctx);
> +	/* Security associations */
> +	int (*mdo_add_rxsa)(struct macsec_context *ctx);
> +	int (*mdo_upd_rxsa)(struct macsec_context *ctx);
> +	int (*mdo_del_rxsa)(struct macsec_context *ctx);
> +	int (*mdo_add_txsa)(struct macsec_context *ctx);
> +	int (*mdo_upd_txsa)(struct macsec_context *ctx);
> +	int (*mdo_del_txsa)(struct macsec_context *ctx);
> +};
> +#endif
> +
>  struct dev_ifalias {
>  	struct rcu_head rcuhead;
>  	char ifalias[];
> @@ -1755,6 +1779,8 @@ enum netdev_priv_flags {
>   *
>   *	@wol_enabled:	Wake-on-LAN is enabled
>   *
> + *	@macsec_ops:    MACsec offloading ops
> + *
>   *	FIXME: cleanup struct net_device such that network protocol info
>   *	moves out.
>   */
> @@ -2036,6 +2062,11 @@ struct net_device {
>  	struct lock_class_key	*qdisc_running_key;
>  	bool			proto_down;
>  	unsigned		wol_enabled:1;
> +
> +#if IS_ENABLED(CONFIG_MACSEC)
> +	/* MACsec management functions */
> +	const struct macsec_ops *macsec_ops;
> +#endif
>  };
>  #define to_net_dev(d) container_of(d, struct net_device, dev)
>  

