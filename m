Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1630C10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 00:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9057B20811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 00:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIpNU5mL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfDWAvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 20:51:21 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:56186 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDWAvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 20:51:20 -0400
Received: by mail-it1-f193.google.com with SMTP id y134so20719037itc.5;
        Mon, 22 Apr 2019 17:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x4+ag9AJfwSTPhSJ5HEqILf1XWA5F3SNB56ycvEHmbw=;
        b=cIpNU5mLMC4FzXkhAM6ui1SZHisuc9AG+i5gJ/5et6hyhZlecrfBLwoEmD6So1wkiX
         8EjWw6xPZj6zLb21WPt9DWKKjk1I0xLcVBWgqd/lbiOQ3mihcOuKf4WbyqWna7tir2Bs
         TwByo6KBGCp6eCIZzL4pnOD+At8OgTcKYot5B/P3oLopbi/N2aV+iDsJlkCgBdYwfLfW
         eIfJmtvqkKxMk7EwDnOtHglwEeVMABYFbYA1YLy/YqPokBadM5Mq1V9V6Qy/7WVjec0O
         c+wCEssH+Yc/iaosT08zuCKBUSYTZiIYy8+XhMA7hBKe6xRLWSME5eh44XH9T9qhmcR5
         nYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x4+ag9AJfwSTPhSJ5HEqILf1XWA5F3SNB56ycvEHmbw=;
        b=BWy4kjLTq0bkutzTYkGzXSVBrytA30xvnFzrNJQ/Kn2l0Pjeob5opq4yZthY+qVyLE
         4qOrBWP+VDgANmm5y3leAuE0YU2gncmWwXjtDXPpojqBZ21ytw311DgBGIt4Slos65xe
         3yAD0OzXvIXxiCVoGFmB7XxUlGKVZ/CZsL1UqdRqc4fyXLI18/4UlVNRUZYX7YOy+n+x
         dfdKe+MAnsC8yGcqfhip90fzkwLMJwmI15jAyoyww5xLOKSly+iKAB1KTOelRuIcU/OS
         rsMa2myJ8Ep8jGijBDS7alXxOt2GDkpBY3USMvYtK8BeLGkyGwiBm6IhibOD2gihBw5M
         jyoQ==
X-Gm-Message-State: APjAAAU6aIrEvD72IN71aTfF0ZVtPhN0+BDXkkNsdVjF4sIZjxNBks9w
        SrH4swBVB66tWjgUtPyrng1ZrFdYzYOLz/3HGkE=
X-Google-Smtp-Source: APXvYqxUZkHIWsXtg4IyxdVKEc0GLrV1VEr/GNl402Zl/1MtLBfjvhJPmKy5GxVka4wkj6HBIlxcOf+17W0Y0FZ0wBs=
X-Received: by 2002:a24:c685:: with SMTP id j127mr141625itg.21.1555980679764;
 Mon, 22 Apr 2019 17:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <155548879651.3454.13167784936351314661.stgit@buzz>
In-Reply-To: <155548879651.3454.13167784936351314661.stgit@buzz>
From:   Joseph Yasi <joe.yasi@gmail.com>
Date:   Mon, 22 Apr 2019 20:51:09 -0400
Message-ID: <CADzA9o=6gUg4xrsqOKhgSXfXWiAtD6BbD4PsN4gf4H4GYyvvHg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "e1000e: fix cyclic resets at link up with
 active tx"
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
Tested-by: Joseph Yasi <joe.yasi@gmail.com>
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
>                         /* 8000ES2LAN requires a Rx packet buffer work-around
>                          * on link down event; reset the controller to flush
>                          * the Rx packet buffer.
> -                        *
> -                        * If the link is lost the controller stops DMA, but
> -                        * if there is queued Tx work it cannot be done.  So
> -                        * reset the controller to flush the Tx packet buffers.
>                          */
> -                       if ((adapter->flags & FLAG_RX_NEEDS_RESTART) ||
> -                           e1000_desc_unused(tx_ring) + 1 < tx_ring->count)
> +                       if (adapter->flags & FLAG_RX_NEEDS_RESTART)
>                                 adapter->flags |= FLAG_RESTART_NOW;
>                         else
>                                 pm_schedule_suspend(netdev->dev.parent,
> @@ -5338,6 +5333,14 @@ static void e1000_watchdog_task(struct work_struct *work)
>         adapter->gotc_old = adapter->stats.gotc;
>         spin_unlock(&adapter->stats64_lock);
>
> +       /* If the link is lost the controller stops DMA, but
> +        * if there is queued Tx work it cannot be done.  So
> +        * reset the controller to flush the Tx packet buffers.
> +        */
> +       if (!netif_carrier_ok(netdev) &&
> +           (e1000_desc_unused(tx_ring) + 1 < tx_ring->count))
> +               adapter->flags |= FLAG_RESTART_NOW;
> +
>         /* If reset is necessary, do it outside of interrupt context. */
>         if (adapter->flags & FLAG_RESTART_NOW) {
>                 schedule_work(&adapter->reset_task);
>
