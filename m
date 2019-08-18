Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C37C3A59E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 07:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C27421773
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 07:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfHRHKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 03:10:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfHRHKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 03:10:45 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 300E9C054907
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 07:10:44 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id o4so350032qkg.11
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 00:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pG67TpAucqj+QXErTkQVEhnyrRaRpklq4dlSH5XWxbY=;
        b=hQ+ZO+6Fu4lGFn8imftaAV/awwOaQH6/QxjOPXlJyQhf/YHL4SYV60ncQQad9vBo4L
         x9u/UUn2+wFX4soZ/7wgkEmzb5vQxG/jnxCq7e+y1UufVs6eV+QhAhYsAk1B3yAohpsp
         /pn9swO1B8zxJmILImUjEKU/YJgrk2lnjM38iU+zkyd2Ha6ikREwd5kHkEU04hpqudgX
         6eNc/pr2stf0oEGAWXPDstzEg2RLtTslINa2l4FT9YR50rhVrTy+H4QOPxBD+ly5v3aH
         k3xr2hKYlIFP30aFY9LaicWCtzNgWgMp1KzAxNX/6pl9ybZYej2qXpLK6mlchwvfuG+B
         mWZg==
X-Gm-Message-State: APjAAAVdp08KLo3UOnUChSnhOIlIeX2Fysvma6o4kjKrtims2wm/c9K5
        sH4EssPp1nYNWJ8Iv7KJztQM1k00Ag4xMgJ/AinDMHes1pHZop03gAnNomlJF03KPv6r+6V2FLL
        Fvyqt2jVDhjdn1Pgj5+vEidwM
X-Received: by 2002:a37:a013:: with SMTP id j19mr16437428qke.401.1566112243568;
        Sun, 18 Aug 2019 00:10:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw+lwpHXPdpc20v/W4ahvahjXp7xvnN6kcPiBu5Jkb2fdOBr/0eK82rKArgosyck6pKhjs7pA==
X-Received: by 2002:a37:a013:: with SMTP id j19mr16437415qke.401.1566112243373;
        Sun, 18 Aug 2019 00:10:43 -0700 (PDT)
Received: from redhat.com (bzq-79-180-62-110.red.bezeqint.net. [79.180.62.110])
        by smtp.gmail.com with ESMTPSA id h4sm4900625qtq.82.2019.08.18.00.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 00:10:42 -0700 (PDT)
Date:   Sun, 18 Aug 2019 03:10:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     ? jiang <jiangkidd@hotmail.com>
Cc:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kafai@fb.com" <kafai@fb.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "yhs@fb.com" <yhs@fb.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xdp-newbies@vger.kernel.org" <xdp-newbies@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "jiangran.jr@alibaba-inc.com" <jiangran.jr@alibaba-inc.com>
Subject: Re: [PATCH v2] virtio-net: lower min ring num_free for efficiency
Message-ID: <20190818030410-mutt-send-email-mst@kernel.org>
References: <BYAPR14MB32058F4B2AD162F5421BB9B4A6AC0@BYAPR14MB3205.namprd14.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR14MB32058F4B2AD162F5421BB9B4A6AC0@BYAPR14MB3205.namprd14.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 09:42:40AM +0000, ? jiang wrote:
> This change lowers ring buffer reclaim threshold from 1/2*queue to budget
> for better performance. According to our test with qemu + dpdk, packet
> dropping happens when the guest is not able to provide free buffer in
> avail ring timely with default 1/2*queue. The value in the patch has been
> tested and does show better performance.
> 
> Test setup: iperf3 to generate packets to guest (total 30mins, pps 400k, UDP)
> avg packets drop before: 2842
> avg packets drop after: 360(-87.3%)
> 
> Signed-off-by: jiangkidd <jiangkidd@hotmail.com>

To add to that:

Further, current code suffers from a starvation problem: the amount of
work done by try_fill_recv is not bounded by the budget parameter, thus
(with large queues) once in a while userspace gets blocked for a long
time while queue is being refilled. Trigger refills earlier to make sure
the amount of work to do is limited.

With this addition to the log:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0d4115c9e20b..bc08be7925eb 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1331,7 +1331,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>  		}
>  	}
>  
> -	if (rq->vq->num_free > virtqueue_get_vring_size(rq->vq) / 2) {
> +	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
>  		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
>  			schedule_delayed_work(&vi->refill, 0);
>  	}
> -- 
> 2.11.0
