Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725EDC3A5A5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 15:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFE721744
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 15:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbfIBPB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 11:01:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731784AbfIBPB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 11:01:57 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2070081F13
        for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2019 15:01:57 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id x11so15871292qtm.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 08:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3eUULgrjIJg0a0dnW4SKY8dVu/LzudzFut/uYLoCkM0=;
        b=rS6INlhdqeYSJM01vsLzbUT/aotkl0zuLB3KDgXtc+cWLLW/8AkKnLYzN9yqYE8myp
         CA/sSGfXQcVl7uzKCvay4zhUhMzZkKCTITojnjuK+PcPLFvBhTxUj1ZYlzt2C124sh4N
         KDTQRtTYtKTBmrW/rx0GzPWLhBK5hMKtHDfqq41U8Q/AlfISzxEumDzRmyZmouE8Lijn
         D8Tskdtk/8FLmms2mE9yiXjZBpMgFUIJ3cs63HycB0lGm7t22icOIsQZgTkS+kJ5j9f2
         5gZzh11oQEaWWGWDli86iwPDiRD5Sx3wod5ebZ4JYhG1Kf7lWYmbPpnP8gfZHHvdbivm
         tsGA==
X-Gm-Message-State: APjAAAXb0VOU0VZDH/9ilE2Z5vAb1dipjAYjbZWxGgJ767zCV9oqjbSm
        n4twSkjRsDgH2dk/5f71/368jvHxbHjoLRakB+ep6ypccjo7kE75d18BUXaSpUv5UZpm6aaTCeb
        kBjE5YZgj5zMzvll+sfos9qi0
X-Received: by 2002:ac8:750e:: with SMTP id u14mr28909660qtq.282.1567436516414;
        Mon, 02 Sep 2019 08:01:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzukZkbHkn1xgGj19iRwoWTZ0EUi0+QeIBA4njsNuROpWrZ/97Kw7ZdMd2ZPPImX2/1Fxx4Fg==
X-Received: by 2002:ac8:750e:: with SMTP id u14mr28909631qtq.282.1567436516228;
        Mon, 02 Sep 2019 08:01:56 -0700 (PDT)
Received: from redhat.com (bzq-79-180-62-110.red.bezeqint.net. [79.180.62.110])
        by smtp.gmail.com with ESMTPSA id o11sm4589103qkm.105.2019.09.02.08.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 08:01:55 -0700 (PDT)
Date:   Mon, 2 Sep 2019 11:01:48 -0400
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
Subject: Re: [PATCH v3] virtio-net: lower min ring num_free for efficiency
Message-ID: <20190902110038-mutt-send-email-mst@kernel.org>
References: <BYAPR14MB32059DD9439280B66B532351A6AB0@BYAPR14MB3205.namprd14.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR14MB32059DD9439280B66B532351A6AB0@BYAPR14MB3205.namprd14.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 02:51:23AM +0000, ? jiang wrote:
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
> Further, current code suffers from a starvation problem: the amount of
> work done by try_fill_recv is not bounded by the budget parameter, thus
> (with large queues) once in a while userspace gets blocked for a long
> time while queue is being refilled. Trigger refills earlier to make sure
> the amount of work to do is limited.
> 
> Signed-off-by: jiangkidd <jiangkidd@hotmail.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>


Dave, could you merge this please?

Either net or net-next at your discretion.

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
