Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D94C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61667206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfDZOLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:11:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45158 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfDZOLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:11:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so4597537wra.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 07:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RVcIwwwp8SsK3CaYECOTG/vA/Hn3rv+HJkD7y1tj5z8=;
        b=cNWxeh7pzpu4hJgKogelUY0qG7UOvD574idISPTIOanvf2vw+cECP/4TXQJJ1PY9Vo
         MIceOeKMPdiX2P6/HWgWsnI4k8khMtVJSg+RnJ2zhnyCXzlmL+cOCvsuPooaQ0AvDsos
         zoOGsqNCpJyKpK+GXLxM+QdPgH6JLRLgTUi9mXcaXom7TbP86YV1jOH4t/dwo0X1nu0+
         L5k3LACg1p6uZqNCJ5rTTkvDvMqZ0Ubanck+Iy7eBAXZbcpGLw5OeeRcbl1ntR06Wp77
         sOCDfjQwg/A8O7+vKyz/BnT4tmb13x5jZWA2lUqJT3/F1St9bcY7ircpMGQC3zK3MqFp
         70aw==
X-Gm-Message-State: APjAAAWyTuQGvzjdr7iZZhQrEI38zZwfTa1zDJDRUM32uFH8Ri6TaZ1y
        0dSgvTKREtBNgxhQqTL2R3aahQ==
X-Google-Smtp-Source: APXvYqzD7bqBL26F0ro/L/CU6m6tb3J2Txfw7G7b63uYkIxVzLuMELEN8VS+z0hqFy9bAtP1UwYi7g==
X-Received: by 2002:adf:fd06:: with SMTP id e6mr13949182wrr.94.1556287888631;
        Fri, 26 Apr 2019 07:11:28 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id d14sm10263253wre.78.2019.04.26.07.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 07:11:27 -0700 (PDT)
Date:   Fri, 26 Apr 2019 16:11:26 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Joseph Yasi <joe.yasi@gmail.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        e1000-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/2] Revert "e1000e: fix cyclic resets at link up with
 active tx"
Message-ID: <20190426141126.shpgjeya5lciudiw@butterfly.localdomain>
References: <155548879651.3454.13167784936351314661.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155548879651.3454.13167784936351314661.stgit@buzz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 11:13:16AM +0300, Konstantin Khlebnikov wrote:
> This reverts commit 0f9e980bf5ee1a97e2e401c846b2af989eb21c61.
> 
> That change cased false-positive warning about hardware hang:
> 
> e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
> IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> e1000e 0000:00:1f.6 eth0: Detected Hardware Unit Hang:
>    TDH                  <0>
>    TDT                  <1>
>    next_to_use          <1>
>    next_to_clean        <0>
> buffer_info[next_to_clean]:
>    time_stamp           <fffba7a7>
>    next_to_watch        <0>
>    jiffies              <fffbb140>
>    next_to_watch.status <0>
> MAC Status             <40080080>
> PHY Status             <7949>
> PHY 1000BASE-T Status  <0>
> PHY Extended Status    <3000>
> PCI Status             <10>
> e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
> 
> Besides warning everything works fine.
> Original issue will be fixed property in following patch.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Reported-by: Joseph Yasi <joe.yasi@gmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203175
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c |   15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 7acc61e4f645..ba96e52aa8d1 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -5309,13 +5309,8 @@ static void e1000_watchdog_task(struct work_struct *work)
>  			/* 8000ES2LAN requires a Rx packet buffer work-around
>  			 * on link down event; reset the controller to flush
>  			 * the Rx packet buffer.
> -			 *
> -			 * If the link is lost the controller stops DMA, but
> -			 * if there is queued Tx work it cannot be done.  So
> -			 * reset the controller to flush the Tx packet buffers.
>  			 */
> -			if ((adapter->flags & FLAG_RX_NEEDS_RESTART) ||
> -			    e1000_desc_unused(tx_ring) + 1 < tx_ring->count)
> +			if (adapter->flags & FLAG_RX_NEEDS_RESTART)
>  				adapter->flags |= FLAG_RESTART_NOW;
>  			else
>  				pm_schedule_suspend(netdev->dev.parent,
> @@ -5338,6 +5333,14 @@ static void e1000_watchdog_task(struct work_struct *work)
>  	adapter->gotc_old = adapter->stats.gotc;
>  	spin_unlock(&adapter->stats64_lock);
>  
> +	/* If the link is lost the controller stops DMA, but
> +	 * if there is queued Tx work it cannot be done.  So
> +	 * reset the controller to flush the Tx packet buffers.
> +	 */
> +	if (!netif_carrier_ok(netdev) &&
> +	    (e1000_desc_unused(tx_ring) + 1 < tx_ring->count))
> +		adapter->flags |= FLAG_RESTART_NOW;
> +
>  	/* If reset is necessary, do it outside of interrupt context. */
>  	if (adapter->flags & FLAG_RESTART_NOW) {
>  		schedule_work(&adapter->reset_task);
> 

Tested-by: Oleksandr Natalenko <oleksandr@redhat.com>

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
