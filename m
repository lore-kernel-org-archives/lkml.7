Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A9EC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406DA206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfDZOME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:12:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42983 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDZOMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:12:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so4623428wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 07:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DuRJHInqJbjqNYjvln+H0H09ry2TmdgshJT1xiyJ9Y0=;
        b=NQOlB9QRFbXmPkcStZY4OjJOBinfF52eDE9BijWc7EIXZnVgfd2Zl2LZaxp2kKkXe5
         FhRTd4StV9rwx6unqUhel2UzLYbrjZuibHVyKzb+cR/x07zVE8XJPs1ugNFwIcKCYMke
         aVaGXVmk2tG0cBneYyXC1Cfy1Dz7fSsQTuv0Iexeqe/XiCjpXMq6ECjdIa2LzCfMjZCX
         f6NEinV+zw7BrC/3ajAwo+FZVzu0SWOlvR5k6dqdQZn5V3AjcE8mtXSPXdq3lK/E9m2u
         Jn/SgEXKDE4mf/L+7l1JgfpVhh7LgfCWCmhvvZ6sHc3z9AM2Y/GUsoM3DwSJ252dJmh7
         08Qg==
X-Gm-Message-State: APjAAAUaJOQoBBwNM8tIWYDOy/M6GWlg9qo9L6g4HmHEM2Ze6/OyNk+I
        3K/OEpW5/heJSkeTP6JLXpexEH9vKk5E/A==
X-Google-Smtp-Source: APXvYqz9VVLrne32Bgng00YdcXWlEXMxR+Q1JbhQgGewjHMDvSTkJnyzAfazkCLpp3xTVcFcftuFbw==
X-Received: by 2002:adf:f64f:: with SMTP id x15mr10612309wrp.202.1556287922342;
        Fri, 26 Apr 2019 07:12:02 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n17sm22037914wrw.77.2019.04.26.07.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 07:12:01 -0700 (PDT)
Date:   Fri, 26 Apr 2019 16:12:00 +0200
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
Subject: Re: [PATCH 2/2] e1000e: start network tx queue only when link is up
Message-ID: <20190426141159.c5e4t4er4zjry7om@butterfly.localdomain>
References: <155548879651.3454.13167784936351314661.stgit@buzz>
 <155548880068.3454.1621821881762819373.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155548880068.3454.1621821881762819373.stgit@buzz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 11:13:20AM +0300, Konstantin Khlebnikov wrote:
> Driver does not want to keep packets in tx queue when link is lost.
> But present code only reset NIC to flush them, but does not prevent
> queuing new packets. Moreover reset sequence itself could generate
> new packets via netconsole and NIC falls into endless reset loop.
> 
> This patch wakes tx queue only when NIC is ready to send packets.
> 
> This is proper fix for problem addressed by commit 0f9e980bf5ee
> ("e1000e: fix cyclic resets at link up with active tx").
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Suggested-by: Alexander Duyck <alexander.duyck@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index ba96e52aa8d1..fe643d66aa10 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -4209,7 +4209,7 @@ void e1000e_up(struct e1000_adapter *adapter)
>  		e1000_configure_msix(adapter);
>  	e1000_irq_enable(adapter);
>  
> -	netif_start_queue(adapter->netdev);
> +	/* tx queue started by watchdog timer when link is up */
>  
>  	e1000e_trigger_lsc(adapter);
>  }
> @@ -4607,6 +4607,7 @@ int e1000e_open(struct net_device *netdev)
>  	pm_runtime_get_sync(&pdev->dev);
>  
>  	netif_carrier_off(netdev);
> +	netif_stop_queue(netdev);
>  
>  	/* allocate transmit descriptors */
>  	err = e1000e_setup_tx_resources(adapter->tx_ring);
> @@ -4667,7 +4668,6 @@ int e1000e_open(struct net_device *netdev)
>  	e1000_irq_enable(adapter);
>  
>  	adapter->tx_hang_recheck = false;
> -	netif_start_queue(netdev);
>  
>  	hw->mac.get_link_status = true;
>  	pm_runtime_put(&pdev->dev);
> @@ -5289,6 +5289,7 @@ static void e1000_watchdog_task(struct work_struct *work)
>  			if (phy->ops.cfg_on_link_up)
>  				phy->ops.cfg_on_link_up(hw);
>  
> +			netif_wake_queue(netdev);
>  			netif_carrier_on(netdev);
>  
>  			if (!test_bit(__E1000_DOWN, &adapter->state))
> @@ -5302,6 +5303,7 @@ static void e1000_watchdog_task(struct work_struct *work)
>  			/* Link status message must follow this format */
>  			pr_info("%s NIC Link is Down\n", adapter->netdev->name);
>  			netif_carrier_off(netdev);
> +			netif_stop_queue(netdev);
>  			if (!test_bit(__E1000_DOWN, &adapter->state))
>  				mod_timer(&adapter->phy_info_timer,
>  					  round_jiffies(jiffies + 2 * HZ));
> 

Tested-by: Oleksandr Natalenko <oleksandr@redhat.com>

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
