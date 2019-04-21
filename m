Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D81C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 20:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F382920870
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 20:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBumPsjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfDUUlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 16:41:36 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32789 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfDUUlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 16:41:36 -0400
Received: by mail-ot1-f65.google.com with SMTP id j10so8141372otq.0;
        Sun, 21 Apr 2019 13:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r4o/6Q0G/X+qOkKNqTfldeNXYoQS6vEhD8PbuExrxH8=;
        b=HBumPsjyKZAB7HHqtR0t+LC6m/LEcm+iS2AWpWm9wFNLlOrBIKed/aEktF3/WH71yt
         mGnDrMNEMLeHw21gAyOz5m0iKpjnfifjct4GjpdVaIZ11iI/ALpULxzPj/zTGdAQ1wWd
         gOajSQC0Es7h4NvX3Y4gP9UY/M8mMmk+v6OJjQnlduD4uqRJO6L32k3x4bJ4Gv4yUYXI
         axA1u9BUbGb3dY+mUwTh2Exds2MQQp8yEmL9dSqrSLQu4I4/M5ed9aPlmiTiRYft3Akb
         woEhBdLpmJxbiQ/gllDzbMGrcbQ3xILt/nS1zIVfiVaosawHj+3tJN3BH/GPLsF8FKWX
         sWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r4o/6Q0G/X+qOkKNqTfldeNXYoQS6vEhD8PbuExrxH8=;
        b=CU3NCWIN0en7NWoNXMd5FE1Ysmass6nX+TgzpMW32hfgd/rZck90gUMWz+HHbD/Xfi
         zSJIppTlGL0OqqwyGx30/eZ5e7rsWZBT7WgW/Y4DXP1zEvWKRrTmPDh4zZv5hPaH5Ebt
         5bET4vfoGad0306Khd9TwuoGFHSUh6Y17hr/e7PNks3lu/rtDTMJJBb5Kr3hy8rtYPzF
         TIuUJWr8l3vKKvPgOPxNuko0hJq/Sx9R7AlZNqvACXHT9K+S5EcqgD+1WxkOJhJtTioL
         8vHG1BGfgp9XONAvhfD0kT+2qW9CB4xTOf5PNGCtKSw8/zFN4YyN2ug1tYO4HC0mLQgi
         n1bw==
X-Gm-Message-State: APjAAAW/mI71tZ8krdnezaijAGLwd7aIvAWeoGrCddSC7Rmm+QE0qXAY
        FDv7sfIp9RGZdmLbgV+rcg==
X-Google-Smtp-Source: APXvYqx526yDC7Nm/hWBDm1CCrhV5xsn9MZd1OlLbx71jexYmTv/T3fkDNqGu7W/c/1gcOOn+bGD0g==
X-Received: by 2002:a05:6830:128c:: with SMTP id z12mr10055073otp.101.1555879294461;
        Sun, 21 Apr 2019 13:41:34 -0700 (PDT)
Received: from ubuntu (99-149-127-125.lightspeed.rlghnc.sbcglobal.net. [99.149.127.125])
        by smtp.gmail.com with ESMTPSA id m21sm4877170otj.48.2019.04.21.13.41.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 13:41:33 -0700 (PDT)
Date:   Sun, 21 Apr 2019 16:41:26 -0400
From:   Stephen Suryaputra <ssuryaextr@gmail.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Julian Anastasov <ja@ssi.bg>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        syzbot <syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com>,
        ddstreet@ieee.org, dvyukov@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: unregister_netdevice: waiting for DEV to become free (2)
Message-ID: <20190421204126.GA19213@ubuntu>
References: <0000000000007d22100573d66078@google.com>
 <alpine.LFD.2.20.1808201527230.2758@ja.home.ssi.bg>
 <4684eef5-ea50-2965-86a0-492b8b1e4f52@I-love.SAKURA.ne.jp>
 <dc7c06ae-204d-c287-04a4-d48875476d09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc7c06ae-204d-c287-04a4-d48875476d09@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

I looked at patchwork. This patch hasn't been accepted. Is there a plan
to resubmit? It is very useful. I had to debug refcnt issues multiple
times for my employer.

Thanks,

Stephen.

On Mon, Apr 15, 2019 at 09:35:01AM -0600, David Ahern wrote:
> On 4/15/19 7:36 AM, Tetsuo Handa wrote:
> > I traced using debug printk() patch shown below.
> > 
> 
> I find tracepoints (see attached patch) and perf are easier to use to
> debug device refcnt problems.
> 
> For example, limit the stack you have to deal with via sysctl -w
> kernel.perf_event_max_stack=16, and add a filter (e.g., --filter 'name
> == "lo"') to limit collection to a specific device.

> From 068b1b8362ec5fd1b9dffdbd6e84474ada2eb829 Mon Sep 17 00:00:00 2001
> From: David Ahern <dsa@cumulusnetworks.com>
> Date: Thu, 11 Feb 2016 02:40:12 -0800
> Subject: [PATCH] Add tracepoints to dev_hold and dev_put
> 
> Signed-off-by: David Ahern <dsa@cumulusnetworks.com>
> ---
>  include/linux/netdevice.h  |  6 ++++++
>  include/trace/events/net.h | 38 ++++++++++++++++++++++++++++++++++++++
>  net/core/dev.c             | 21 +++++++++++++++++++++
>  3 files changed, 65 insertions(+)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 219f53c30cb3..7ef6fc672dfb 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3193,6 +3193,7 @@ extern int		netdev_budget;
>  /* Called by rtnetlink.c:rtnl_unlock() */
>  void netdev_run_todo(void);
>  
> +#if 0
>  /**
>   *	dev_put - release reference to device
>   *	@dev: network device
> @@ -3214,6 +3215,11 @@ static inline void dev_hold(struct net_device *dev)
>  {
>  	this_cpu_inc(*dev->pcpu_refcnt);
>  }
> +#else
> +void dev_put(struct net_device *dev);
> +void dev_hold(struct net_device *dev);
> +
> +#endif
>  
>  /* Carrier loss detection, dial on demand. The functions netif_carrier_on
>   * and _off may be called from IRQ context, but it is caller
> diff --git a/include/trace/events/net.h b/include/trace/events/net.h
> index 49cc7c3de252..9ed73dfe9d09 100644
> --- a/include/trace/events/net.h
> +++ b/include/trace/events/net.h
> @@ -236,6 +236,44 @@ DEFINE_EVENT(net_dev_rx_verbose_template, netif_rx_ni_entry,
>  	TP_ARGS(skb)
>  );
>  
> +TRACE_EVENT(dev_put,
> +
> +	TP_PROTO(struct net_device *dev),
> +
> +	TP_ARGS(dev),
> +
> +	TP_STRUCT__entry(
> +		__string(	name,		dev->name	)
> +		__field(	int,		refcnt )
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, dev->name);
> +		__entry->refcnt = netdev_refcnt_read(dev);
> +	),
> +
> +	TP_printk("dev=%s refcnt %d", __get_str(name), __entry->refcnt)
> +);
> +
> +TRACE_EVENT(dev_hold,
> +
> +	TP_PROTO(struct net_device *dev),
> +
> +	TP_ARGS(dev),
> +
> +	TP_STRUCT__entry(
> +		__string(	name,		dev->name	)
> +		__field(	int,		refcnt )
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, dev->name);
> +		__entry->refcnt = netdev_refcnt_read(dev);
> +	),
> +
> +	TP_printk("dev=%s refcnt %d", __get_str(name), __entry->refcnt)
> +);
> +
>  #endif /* _TRACE_NET_H */
>  
>  /* This part must be outside protection */
> diff --git a/net/core/dev.c b/net/core/dev.c
> index f1284835b8c9..99ac067afd18 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -8117,3 +8117,24 @@ static int __init net_dev_init(void)
>  }
>  
>  subsys_initcall(net_dev_init);
> +
> +
> +void dev_put(struct net_device *dev)
> +{
> +	this_cpu_dec(*dev->pcpu_refcnt);
> +	trace_dev_put(dev);
> +}
> +EXPORT_SYMBOL(dev_put);
> +
> +/**
> + *      dev_hold - get reference to device
> + *      @dev: network device
> + *
> + * Hold reference to device to keep it from being freed.
> + */
> +void dev_hold(struct net_device *dev)
> +{
> +	this_cpu_inc(*dev->pcpu_refcnt);
> +	trace_dev_hold(dev);
> +}
> +EXPORT_SYMBOL(dev_hold);
> -- 
> 2.1.4
> 

