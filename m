Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5885CA9EC2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BC020717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="znJoO/4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbfJ2IYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 04:24:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35600 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728892AbfJ2IYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 04:24:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id x5so1395660wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 01:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mlvWUHz6b/I7z2o6G925iPKfRblwtc3ymYLiU24jl8Y=;
        b=znJoO/4IcDqIxbCVMPW+19bVBXc9sqwbd7aZWWqNPGo3LmGX2CLxOoCeZeP0nLObqa
         u06zZhdIVgYt/u9fE7Pkq+FDbWGt50hkMi2TDCNCORd3PbP65XA91VNNkPbGOj0ikZsn
         GNN37Kh92uMv8OLqpIBnEvbYuwP2nwQWx2bRbZqAJ/0vvxY7Yjq6JgcqOjOkJJJVcwwp
         JJS8wD97kwyOzxa0glC5AMUiRsyfFOYUkA3o5QzEhp/rWxlv7P+uOFP2Lnxe+7oCcv9p
         I6q9un3AtibUNcLt/LGVA/DCuybUP6j1NJQnJ9t51hMRUcgU/MIFCYiEDgpMHgslO9Ul
         /HNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mlvWUHz6b/I7z2o6G925iPKfRblwtc3ymYLiU24jl8Y=;
        b=OUi+M5syfNtHIzQVur1HWADlREnmGhAEwmZeZfBWOCgzSKo6p8TXyOqfbLq63noi82
         VtupqT0EX06brfHCqVFsJ+295tBdTXpoNrLq/ug3OGVzVJpfZX75F5xdRmeXCK+qr/7o
         dkq3KBP/NYJsfQKhzq1kQ8/nw9qZYGunzZMYxu0BBQnZLlNvttPIvqpqQyrJTWiHxnwp
         SyvL6InDWJE4S6JDfQPxIzy02hmZGpXl/JDo5VS//JVEPRNmiSBVbARjiBaeNg4ibkhN
         u2B/KokbDooj5BFFMCk6ZhnUZAw7keWb4O5/MDcotFlNHp8+XG5jGd/D4Srx6fRrGH/u
         6TKw==
X-Gm-Message-State: APjAAAW8uZkTGjgyLb9sLhjeZHiZH4HhYbF13v5ByFwA3iduIhfcRur4
        kLtI3JvdaaQk8tSqS0d6tTnHwA==
X-Google-Smtp-Source: APXvYqyaUuIZzfuyser7xEw58tuvIXgnZdKtOozf/OE2exXkKYqPqXT6Z0Ey71mdOmuLPrwcvaQymA==
X-Received: by 2002:a7b:caa9:: with SMTP id r9mr2699781wml.47.1572337469034;
        Tue, 29 Oct 2019 01:24:29 -0700 (PDT)
Received: from netronome.com (fred-musen.rivierenbuurt.horms.nl. [2001:470:7eb3:404:a2a4:c5ff:fe4c:9ce9])
        by smtp.gmail.com with ESMTPSA id y5sm2001272wmi.10.2019.10.29.01.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 01:24:28 -0700 (PDT)
Date:   Tue, 29 Oct 2019 09:24:27 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     kvalo@codeaurora.org, davem@davemloft.net, swinslow@gmail.com,
        will@kernel.org, opensource@jilayne.com, baijiaju1990@gmail.com,
        tglx@linutronix.de, linux-wireless@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] b43: Fix use true/false for bool type
Message-ID: <20191029082427.GB23615@netronome.com>
References: <20191028190204.GA27248@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028190204.GA27248@saurav>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saurav,

thanks for your patch.

On Tue, Oct 29, 2019 at 12:32:04AM +0530, Saurav Girepunje wrote:
> use true/false on bool type variable assignment.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>

This does not seem to cover the case in dma.c,
which seems to want fixing for the sake of consistency.

Also, I wonder why bools rather than a bitmask was chosen
for this field, it seems rather space intensive in its current form.

> ---
>  drivers/net/wireless/broadcom/b43/main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
> index b85603e91c7a..39da1a4c30ac 100644
> --- a/drivers/net/wireless/broadcom/b43/main.c
> +++ b/drivers/net/wireless/broadcom/b43/main.c
> @@ -3600,7 +3600,7 @@ static void b43_tx_work(struct work_struct *work)
>  			else
>  				err = b43_dma_tx(dev, skb);
>  			if (err == -ENOSPC) {
> -				wl->tx_queue_stopped[queue_num] = 1;
> +				wl->tx_queue_stopped[queue_num] = true;
>  				ieee80211_stop_queue(wl->hw, queue_num);
>  				skb_queue_head(&wl->tx_queue[queue_num], skb);
>  				break;
> @@ -3611,7 +3611,7 @@ static void b43_tx_work(struct work_struct *work)
>  		}
>  
>  		if (!err)
> -			wl->tx_queue_stopped[queue_num] = 0;
> +			wl->tx_queue_stopped[queue_num] = false;
>  	}
>  
>  #if B43_DEBUG
> @@ -5603,7 +5603,7 @@ static struct b43_wl *b43_wireless_init(struct b43_bus_dev *dev)
>  	/* Initialize queues and flags. */
>  	for (queue_num = 0; queue_num < B43_QOS_QUEUE_NUM; queue_num++) {
>  		skb_queue_head_init(&wl->tx_queue[queue_num]);
> -		wl->tx_queue_stopped[queue_num] = 0;
> +		wl->tx_queue_stopped[queue_num] = false;
>  	}
>  
>  	snprintf(chip_name, ARRAY_SIZE(chip_name),
> -- 
> 2.20.1
> 
