Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04303C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECF82070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gz6GXQvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfECXwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 19:52:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46199 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfECXwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 19:52:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id j11so3632787pff.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 16:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zFYO46dMP3SAqBcqLg5CJF+YJTDQUoBvDpuV2RH5L8k=;
        b=gz6GXQvIhiRKo7gHSNL7icfBycNvIyLAkP/uuPyKgv3b8qvGaYPvg0CZiS/1UiF+K4
         +CiZIZbL04xpT0Cdcdm7jmAdxkRSx2gmsqSqNN/aenbrHMFrvIQVe3DSj3oay0qgIK9Z
         XzclcQjv6TE9dRNeLfh33aOEGRNRfIJqObuJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zFYO46dMP3SAqBcqLg5CJF+YJTDQUoBvDpuV2RH5L8k=;
        b=EIVPP9g0LFHosuOqjntdgEfzBhR57DAwmk+Cwlk0o0YDoCZUVQ6uXPmTc9VY5dSuUm
         idPJqfLn/Ko5mtg8jqnOVd6z0lFAmkRX/ouMJsGYDAauip2Mb2lc0br1C7CEbWNq8pHJ
         XZ4jPRVAloy+wLMjJQ4X3ih5dHtrGRL2zQ6uqKzQZAgIcoJHwtJJS48zbwq+ed0py/oC
         q2RS1hW/rrcTniGJuF0iL8nQTRCgoX9A/qB+p3ixBu3H4NJI1Wr54dH6rtcCivNIscKE
         4ynSn0zV1kSYeo+wW0swKTgQeHpdxDHqjKB+LpvDawdzelCSzbX8UUPhOK0wwGX13hn3
         ijAA==
X-Gm-Message-State: APjAAAUDdcNFOad+0ghsM5vwdW0azkHnkybTerOcCQNqb3gV+js0CiWm
        gPSZPH0zqvAH0qAiXmgyKd6/jA==
X-Google-Smtp-Source: APXvYqxWLkDJ2g1GBDJh6wJtE/dVgOii3cn8aUKEB3XBCyO9lNe+ybALhKiV+alJ0o+0S+nTV+jW8g==
X-Received: by 2002:a65:6688:: with SMTP id b8mr14057572pgw.81.1556927563905;
        Fri, 03 May 2019 16:52:43 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id j12sm8848865pgg.79.2019.05.03.16.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 16:52:43 -0700 (PDT)
Date:   Fri, 3 May 2019 16:52:42 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-rockchip@lists.infradead.org, groeck@chromium.org,
        drinkcat@chromium.org, Ming Lei <ming.lei@redhat.com>,
        linux-mmc@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH] mmc: block: Fix memory leak in blk-mq when cleaning up
Message-ID: <20190503235242.GC40515@google.com>
References: <20190503233526.226272-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190503233526.226272-1-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 04:35:26PM -0700, Douglas Anderson wrote:
> If I run the following on rk3288-veyron-minnie (a 2GB machine)
> 
>   cd /sys/bus/platform/drivers/dwmmc_rockchip
>   for i in $(seq 1 3000); do
>     echo "========================" $i
>     echo ff0f0000.dwmmc > unbind
>     sleep .5
>     echo ff0f0000.dwmmc > bind
>     while true; do
>       if [ -e /dev/mmcblk2 ]; then
>         break;
>       fi
>       sleep .1
>     done
>   done
> 
> Then I start OOMing somewhere between iteration 200 and 250.  Using
> kmemleak, I see reports like:
> 
> unreferenced object 0xe39c5580 (size 64):
>   comm "kworker/1:0", pid 17, jiffies 4294821091 (age 96.952s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ad19d10a>] __kmalloc+0x1ec/0x2dc
>     [<a28614c3>] blk_mq_alloc_tag_set+0x27c/0x2bc
>     [<0955ae01>] mmc_init_queue+0xa8/0x2a8
>     [<5102b986>] mmc_blk_alloc_req+0xf8/0x2d4
>     [<f1c2214f>] mmc_blk_probe+0x4a8/0x6c0
>     [<0dfdd9d5>] mmc_bus_probe+0x24/0x28
> 
> It's pretty clear that we're missing a call to blk_mq_free_tag_set().
> Let's add it.
> 
> Fixes: 81196976ed94 ("mmc: block: Add blk-mq support")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/mmc/core/queue.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 7c364a9c4eeb..09071e13282e 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -480,6 +480,8 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
>  	 */
>  	flush_work(&mq->complete_work);
>  
> +	blk_mq_free_tag_set(&mq->tag_set);
> +
>  	mq->card = NULL;
>  }
>  

FWIW:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
