Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67ED6C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F8320C01
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563219890;
	bh=oQj6Q2Yz9cXpmNLaOyHdKv66gt1/MQq7sOD0zHWZ/W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NynvavzF+O90FCFAhgfVzsN1SecIyS2B86IeC07OEXvHzt3mW1iE10+odljxu/izX
	 P4B59YzLyH6qaV2WpGaRjrnmjRbItVF8mJzWu1TxoQoIzj4VrUKwYaaalxe6Up+w/r
	 dqt946ROrIX4mE2vSaDaO2Hbd6RdNz6chXaUqY/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbfGOTot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:44:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729598AbfGOTos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:44:48 -0400
Received: from localhost (unknown [88.128.80.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B1D520659;
        Mon, 15 Jul 2019 19:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563219887;
        bh=oQj6Q2Yz9cXpmNLaOyHdKv66gt1/MQq7sOD0zHWZ/W4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hKwDwB7SbQEXh2CssSpDmxo/fQYxnXFtKXqdkf5B5vQKo5TfBSrcwvciknaszoTal
         HAKUOvAQ8yJMFljsBENv6+pwHubByMlh4WtqjFjRoeKlDxR6r9dmaChxOYhzUZN45S
         HmWqKH1zt7Puxk4qZ6s/m2+rfBUd0803N6TRojMI=
Date:   Mon, 15 Jul 2019 21:19:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        tglx@linutronix.de
Subject: Re: [PATCH 4/7] staging: most: Use spinlock_t instead of struct
 spinlock
Message-ID: <20190715191933.GA10934@kroah.com>
References: <20190704153803.12739-1-bigeasy@linutronix.de>
 <20190704153803.12739-5-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704153803.12739-5-bigeasy@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 05:38:00PM +0200, Sebastian Andrzej Siewior wrote:
> For spinlocks the type spinlock_t should be used instead of "struct
> spinlock".
> 
> Use spinlock_t for spinlock's definition.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Christian Gromm <christian.gromm@microchip.com>
> Cc: devel@driverdev.osuosl.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/staging/most/net/net.c     | 3 +--
>  drivers/staging/most/video/video.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/most/net/net.c b/drivers/staging/most/net/net.c
> index c8a64e2090273..09b604df45e63 100644
> --- a/drivers/staging/most/net/net.c
> +++ b/drivers/staging/most/net/net.c
> @@ -69,7 +69,7 @@ struct net_dev_context {
>  
>  static struct list_head net_devices = LIST_HEAD_INIT(net_devices);
>  static struct mutex probe_disc_mt; /* ch->linked = true, most_nd_open */
> -static struct spinlock list_lock; /* list_head, ch->linked = false, dev_hold */
> +static DEFINE_SPINLOCK(list_lock); /* list_head, ch->linked = false, dev_hold */
>  static struct core_component comp;
>  
>  static int skb_to_mamac(const struct sk_buff *skb, struct mbo *mbo)
> @@ -507,7 +507,6 @@ static struct core_component comp = {
>  
>  static int __init most_net_init(void)
>  {
> -	spin_lock_init(&list_lock);
>  	mutex_init(&probe_disc_mt);
>  	return most_register_component(&comp);
>  }
> diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
> index adca250062e1b..fcd9e111e8bd0 100644
> --- a/drivers/staging/most/video/video.c
> +++ b/drivers/staging/most/video/video.c
> @@ -54,7 +54,7 @@ struct comp_fh {
>  };
>  
>  static struct list_head video_devices = LIST_HEAD_INIT(video_devices);
> -static struct spinlock list_lock;
> +static DEFINE_SPINLOCK(list_lock);
>  
>  static inline bool data_ready(struct most_video_dev *mdev)
>  {
> @@ -540,7 +540,6 @@ static struct core_component comp = {
>  
>  static int __init comp_init(void)
>  {
> -	spin_lock_init(&list_lock);
>  	return most_register_component(&comp);
>  }
>  

Does not apply on top of Linus's tree right now :(

Can you rebase and resend once 5.3-rc1 is out?

thanks,

greg k-h
