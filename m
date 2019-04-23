Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47C4C10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 00:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA7020811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 00:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVqjjPMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfDWAvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 20:51:02 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52726 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDWAvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 20:51:01 -0400
Received: by mail-it1-f195.google.com with SMTP id x132so20767624itf.2;
        Mon, 22 Apr 2019 17:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7IzJQfMfcbJ3GY4q41cW4H36gtaA7o57eCLtAONQIoo=;
        b=VVqjjPMdKnbgeQLMovAysdrXkhWjpHgXKdDlsTWs390ogm3LRe09lyC9yjyHG25JAN
         lvdhNOIaf+DWcL1dbYnmXT7ppgTZCXIRcT8d+oXonbrPeAwN81r4BJsZZUuRIy2VFaZO
         aEJ4KdK7BfcnCI78tg7XxbVPY41m/3Vtzphb9qqsa3WBDlqLB7zo2UBTbyq5bjbOLD8+
         ZM5o2lGP7OqkqvyeLSfwzm+qm4AuAjNLtMSeggmoG9TimE5r8Paxux7qBtLheun5lwjL
         VnTPj6KoXNqJfQ/Ru+ntHEUQNq7tuFHQgmwouTVzXPaIfJVwmSqC/9a1YSWhj1+eczH2
         5JTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7IzJQfMfcbJ3GY4q41cW4H36gtaA7o57eCLtAONQIoo=;
        b=bA9sUHHQoJ7vMChjCU4ak394oS92lF+5eALV1VGM443SMiHt+dD4Tx6+I7Vx5uWijF
         nmle2E1AXcO9UNc1tyY4DGiFuPzrBbTQq4tiHGflvwGd0u/wpYF6yjMN7/r1dLE7Pr18
         7ssrdVJ1CrWX9yShS9sGT/7MmS7vgdx5aR29kVPB39Scyi5CyfAhSco3TLAV/Y/9qwwC
         /mV6Yl3qVAwogfJciU4JexWrhOz0+Zg+fu6U6vBLYNVxsDZPLmrv+aRLe04iMc/0oU1Y
         OIgBQLvpDeCLIPq8btHuEcQq42y1/8IsJgbyMBL+v35uHg+pfSCsLja+BFjJ/O1sBijI
         iDoA==
X-Gm-Message-State: APjAAAUqBLGjYWW8Lk574rwJj/vCvO/5ApxB5UhfAS7VFcykKel66vSZ
        +tw7qp72Z2cY1pWyK+evwuNsEA+M/eg3NLClXDM=
X-Google-Smtp-Source: APXvYqwILmZPCiW11hqjWfuykqF8zVJTAOh6DnPPq9COeg6uUoZPwMhn4JUM+e+ynv1YVXnjs2PN6gKC/LKhCQMtAq8=
X-Received: by 2002:a24:9a03:: with SMTP id l3mr132470ite.3.1555980660537;
 Mon, 22 Apr 2019 17:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <155548879651.3454.13167784936351314661.stgit@buzz> <155548880068.3454.1621821881762819373.stgit@buzz>
In-Reply-To: <155548880068.3454.1621821881762819373.stgit@buzz>
From:   Joseph Yasi <joe.yasi@gmail.com>
Date:   Mon, 22 Apr 2019 20:50:49 -0400
Message-ID: <CADzA9o=zsmWz6wO1cmccegAj8Vuqkjm-LwRVe=kptd-1mBfy1g@mail.gmail.com>
Subject: Re: [PATCH 2/2] e1000e: start network tx queue only when link is up
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        e1000-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 4:13 AM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
>
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
Tested-by: Joseph Yasi <joe.yasi@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index ba96e52aa8d1..fe643d66aa10 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -4209,7 +4209,7 @@ void e1000e_up(struct e1000_adapter *adapter)
>                 e1000_configure_msix(adapter);
>         e1000_irq_enable(adapter);
>
> -       netif_start_queue(adapter->netdev);
> +       /* tx queue started by watchdog timer when link is up */
>
>         e1000e_trigger_lsc(adapter);
>  }
> @@ -4607,6 +4607,7 @@ int e1000e_open(struct net_device *netdev)
>         pm_runtime_get_sync(&pdev->dev);
>
>         netif_carrier_off(netdev);
> +       netif_stop_queue(netdev);
>
>         /* allocate transmit descriptors */
>         err = e1000e_setup_tx_resources(adapter->tx_ring);
> @@ -4667,7 +4668,6 @@ int e1000e_open(struct net_device *netdev)
>         e1000_irq_enable(adapter);
>
>         adapter->tx_hang_recheck = false;
> -       netif_start_queue(netdev);
>
>         hw->mac.get_link_status = true;
>         pm_runtime_put(&pdev->dev);
> @@ -5289,6 +5289,7 @@ static void e1000_watchdog_task(struct work_struct *work)
>                         if (phy->ops.cfg_on_link_up)
>                                 phy->ops.cfg_on_link_up(hw);
>
> +                       netif_wake_queue(netdev);
>                         netif_carrier_on(netdev);
>
>                         if (!test_bit(__E1000_DOWN, &adapter->state))
> @@ -5302,6 +5303,7 @@ static void e1000_watchdog_task(struct work_struct *work)
>                         /* Link status message must follow this format */
>                         pr_info("%s NIC Link is Down\n", adapter->netdev->name);
>                         netif_carrier_off(netdev);
> +                       netif_stop_queue(netdev);
>                         if (!test_bit(__E1000_DOWN, &adapter->state))
>                                 mod_timer(&adapter->phy_info_timer,
>                                           round_jiffies(jiffies + 2 * HZ));
>
