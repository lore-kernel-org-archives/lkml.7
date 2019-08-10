Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BE2C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 18:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35032085B
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 18:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfHJSM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 14:12:59 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42470 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfHJSM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 14:12:59 -0400
Received: by mail-qk1-f195.google.com with SMTP id 201so74120599qkm.9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 11:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rl3GYKdvkUhjJZod4R7cIwaGENcluFkd1m8GRMDLYjA=;
        b=W5aYhRKsb3F/FZb5mxGfheLLlcP17VSgOLEuxU7oHErPmZ9GHgWcHHGGicF4VHvAHx
         UHMDm6FvSVERVcCXx4vtDcLsGX7MYF4XpaXJCaLFGoQprhSB/eE98EdMg6JEvc3+yUBu
         +ysgdLy2rjH/bMujOvGzwdQNwQENCUHbxz0IoHjobdavVyrUUCQCMZuhGOoVJ9VUPbmc
         /l/R+5sbMHiKylevBfcF05lyuqspqqRLHCZ5R78Sh6Y6tNa8IyUeOESg3jG1AM1BEASv
         w3LkrTvNxJkIAnnMlAacEVXmJXhA8f8oc/PQGAKrFRt6Gu6JXfsXSrXK88dYh3PajRVk
         UvUA==
X-Gm-Message-State: APjAAAV8OHlPJKAGpxqETCcY1pQCgw+yytFIXUO2CO3SyqpyqEnbQpyi
        smRZs7mslQ7L8yyG9ZGCpSlClg==
X-Google-Smtp-Source: APXvYqwi1TjEBF8tYTsvAGgXLmd4P+ip28ybiTZaq2rLk2el4TcxbT3QBB9TmfjhklDWaGag+v2B+A==
X-Received: by 2002:a37:a7d6:: with SMTP id q205mr24016018qke.44.1565460778101;
        Sat, 10 Aug 2019 11:12:58 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id h4sm43862894qkk.39.2019.08.10.11.12.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 11:12:57 -0700 (PDT)
Date:   Sat, 10 Aug 2019 14:12:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     amit@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        virtualization@lists.linux-foundation.org, jasowang@redhat.com,
        linux-kernel@vger.kernel.org, xiaohli@redhat.com
Subject: Re: [PATCH v3 2/2] virtio: decrement avail idx with buffer detach
 for packed ring
Message-ID: <20190810141213-mutt-send-email-mst@kernel.org>
References: <20190809064847.28918-1-pagupta@redhat.com>
 <20190809064847.28918-3-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809064847.28918-3-pagupta@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 12:18:47PM +0530, Pankaj Gupta wrote:
> This patch decrements 'next_avail_idx' count when detaching a buffer
> from vq for packed ring code. Split ring code already does this in
> virtqueue_detach_unused_buf_split function. This updates the
> 'next_avail_idx' to the previous correct index after an unused buffer
> is detatched from the vq.
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>

I would make this patch 1, not patch 2, otherwise
patch 1 corrupts the ring.


> ---
>  drivers/virtio/virtio_ring.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c8be1c4f5b55..7c69181113e2 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1537,6 +1537,12 @@ static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
>  		/* detach_buf clears data, so grab it now. */
>  		buf = vq->packed.desc_state[i].data;
>  		detach_buf_packed(vq, i, NULL);
> +		vq->packed.next_avail_idx--;
> +		if (vq->packed.next_avail_idx < 0) {
> +			vq->packed.next_avail_idx = vq->packed.vring.num - 1;
> +			vq->packed.avail_wrap_counter ^= 1;
> +		}
> +
>  		END_USE(vq);
>  		return buf;
>  	}
> -- 
> 2.20.1
