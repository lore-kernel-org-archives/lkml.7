Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CBEC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 12:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2859A208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 12:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbfIVMhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 08:37:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728920AbfIVMhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 08:37:40 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4987481F10
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 12:37:39 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id f15so14110380qth.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 05:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZIZ6PVJwNqKV66/6V0eWwKczW/IuITxJoofGCnfWMcw=;
        b=c77fwRyiUNrtR8+yFhC7EXaqOrYZz5Gw9FhjmAf465ElCz3M4juYhLZgexeV7osHUp
         BVAOuInf7Qg6mFQG2WwPYXiYJofPHfZI0Dc9NzYAfnf57k3Ka86jyCMfwibCnrxPnrz6
         OrECtmVo58DEGgd8blx7WUGR40MZDV8KF88kCxTY7sldrvmcB2bxc2TpqWFRDjHFYHgF
         iBuMEpJKnBjCj5JFA5chKNFetIlWSx1TXmKU3msLY6i+qiG7fzVh5fVdjKt65Bq9HBnX
         ztBUHvj5zT+O8zDS90C4QB2IazrIZC6xxzi7ZRsSeASA803GWkB8aQaynDDuEk+Zx7td
         3e+Q==
X-Gm-Message-State: APjAAAVHRSptOR6FsvXxYCt0LjLErAsf+LEMwhjyfinS7sszCzwdO9aU
        v5gZT6PHZ4nD9KL9UzsHjOrE9ersPbJYc5JPtvIO09zwp6MgaKwG3n35f26pU3SSqZCryd3boOq
        4Z5EFJ7Cg5V7bPShV/5Q+Qf/3
X-Received: by 2002:a0c:b0cb:: with SMTP id p11mr20902506qvc.216.1569155858544;
        Sun, 22 Sep 2019 05:37:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzCmU3TskOEyZFzEQEVup/JmX+POAXnjml1Z6r35N3M5NYpi2V6FhRyoe8OlTiMpNbNUDXHPA==
X-Received: by 2002:a0c:b0cb:: with SMTP id p11mr20902486qvc.216.1569155858290;
        Sun, 22 Sep 2019 05:37:38 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id w18sm3976903qts.44.2019.09.22.05.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 05:37:37 -0700 (PDT)
Date:   Sun, 22 Sep 2019 08:37:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Matthew Cover <werekraken@gmail.com>
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        jasowang@redhat.com, edumazet@google.com, sdf@google.com,
        matthew.cover@stackpath.com, mail@timurcelik.de, pabeni@redhat.com,
        nicolas.dichtel@6wind.com, wangli39@baidu.com,
        lifei.shirley@bytedance.com, tglx@linutronix.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH net-next] tuntap: Fallback to automq on
 TUNSETSTEERINGEBPF prog negative return
Message-ID: <20190922080326-mutt-send-email-mst@kernel.org>
References: <20190920185843.4096-1-matthew.cover@stackpath.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920185843.4096-1-matthew.cover@stackpath.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 11:58:43AM -0700, Matthew Cover wrote:
> Treat a negative return from a TUNSETSTEERINGEBPF bpf prog as a signal
> to fallback to tun_automq_select_queue() for tx queue selection.
> 
> Compilation of this exact patch was tested.
> 
> For functional testing 3 additional printk()s were added.
> 
> Functional testing results (on 2 txq tap device):
> 
>   [Fri Sep 20 18:33:27 2019] ========== tun no prog ==========
>   [Fri Sep 20 18:33:27 2019] tuntap: tun_ebpf_select_queue() returned '-1'
>   [Fri Sep 20 18:33:27 2019] tuntap: tun_automq_select_queue() ran
>   [Fri Sep 20 18:33:27 2019] ========== tun prog -1 ==========
>   [Fri Sep 20 18:33:27 2019] tuntap: bpf_prog_run_clear_cb() returned '-1'
>   [Fri Sep 20 18:33:27 2019] tuntap: tun_ebpf_select_queue() returned '-1'
>   [Fri Sep 20 18:33:27 2019] tuntap: tun_automq_select_queue() ran
>   [Fri Sep 20 18:33:27 2019] ========== tun prog 0 ==========
>   [Fri Sep 20 18:33:27 2019] tuntap: bpf_prog_run_clear_cb() returned '0'
>   [Fri Sep 20 18:33:27 2019] tuntap: tun_ebpf_select_queue() returned '0'
>   [Fri Sep 20 18:33:27 2019] ========== tun prog 1 ==========
>   [Fri Sep 20 18:33:27 2019] tuntap: bpf_prog_run_clear_cb() returned '1'
>   [Fri Sep 20 18:33:27 2019] tuntap: tun_ebpf_select_queue() returned '1'
>   [Fri Sep 20 18:33:27 2019] ========== tun prog 2 ==========
>   [Fri Sep 20 18:33:27 2019] tuntap: bpf_prog_run_clear_cb() returned '2'
>   [Fri Sep 20 18:33:27 2019] tuntap: tun_ebpf_select_queue() returned '0'
> 
> Signed-off-by: Matthew Cover <matthew.cover@stackpath.com>


Could you add a bit more motivation data here?
1. why is this a good idea
2. how do we know existing userspace does not rely on existing behaviour
3. why doesn't userspace need a way to figure out whether it runs on a kernel with and
   without this patch


thanks,
MST

> ---
>  drivers/net/tun.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index aab0be4..173d159 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -583,35 +583,37 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
>  	return txq;
>  }
>  
> -static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb)
> +static int tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb)
>  {
>  	struct tun_prog *prog;
>  	u32 numqueues;
> -	u16 ret = 0;
> +	int ret = -1;
>  
>  	numqueues = READ_ONCE(tun->numqueues);
>  	if (!numqueues)
>  		return 0;
>  
> +	rcu_read_lock();
>  	prog = rcu_dereference(tun->steering_prog);
>  	if (prog)
>  		ret = bpf_prog_run_clear_cb(prog->prog, skb);
> +	rcu_read_unlock();
>  
> -	return ret % numqueues;
> +	if (ret >= 0)
> +		ret %= numqueues;
> +
> +	return ret;
>  }
>  
>  static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
>  			    struct net_device *sb_dev)
>  {
>  	struct tun_struct *tun = netdev_priv(dev);
> -	u16 ret;
> +	int ret;
>  
> -	rcu_read_lock();
> -	if (rcu_dereference(tun->steering_prog))
> -		ret = tun_ebpf_select_queue(tun, skb);
> -	else
> +	ret = tun_ebpf_select_queue(tun, skb);
> +	if (ret < 0)
>  		ret = tun_automq_select_queue(tun, skb);
> -	rcu_read_unlock();
>  
>  	return ret;
>  }
> -- 
> 1.8.3.1
