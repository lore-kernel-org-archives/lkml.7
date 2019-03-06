Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241C3C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E9420661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfCFIMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:12:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40738 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbfCFIMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 03:12:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id q1so12291998wrp.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 00:12:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=V42LmmXuwLaIwaZFmcP96QgdK+zM16OEbVWTwpodrKg=;
        b=XSAAoLg0CUIkdxnuekAF8O1LGwOupw7WuTpEN2Id64IoFLgW6+bBET+NpWV7hC01xX
         07MgfiW0ot/8xtms7QTPxYKjUqbksB5EdjGnvbQ6I09aUWhmjMNpVR+rCrsRxkt5KUVY
         63AvAnJLApRnXB074kn61YgQbRB+73En2geBA7aMheWBW6722m7JExNpEx2CYgwBZuO1
         tIGZOeVhFg2CB/PM+NGpeB6hyPN+e3R97FgO/t6yiRCbZSs8RB4CFq7QxyWU7wBpWVhM
         hGNoptViuzmIT152eyFKLNP42HVXykyrYKnFJGtPA5mBRteij71k9oK3PusW0KskPEqe
         NFiQ==
X-Gm-Message-State: APjAAAXmezAG5stxSIcUr9/OaEQkOV7QOe5wXwFVnjfCeVcNwrkeCihW
        75Tcu8rEc1Zs4q7uQN9hq60h3A==
X-Google-Smtp-Source: APXvYqw1+pnL7jGo/lhXNmdhhuk9igJOku9BKN2nWcU+BvcOrVrl9+svCqji2E9phFgqyYXoZKytgg==
X-Received: by 2002:adf:e8cf:: with SMTP id k15mr1845287wrn.193.1551859960136;
        Wed, 06 Mar 2019 00:12:40 -0800 (PST)
Received: from steredhat.homenet.telecomitalia.it (host114-14-dynamic.30-79-r.retail.telecomitalia.it. [79.30.14.114])
        by smtp.gmail.com with ESMTPSA id n3sm1730335wrs.10.2019.03.06.00.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 00:12:39 -0800 (PST)
Date:   Wed, 6 Mar 2019 09:12:36 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsock/virtio: fix kernel panic from
 virtio_transport_reset_no_sock
Message-ID: <20190306081236.mcd4o27yw67euzgv@steredhat.homenet.telecomitalia.it>
References: <20190305180145.27161-1-alazar@bitdefender.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190305180145.27161-1-alazar@bitdefender.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adalbert,
thanks for catching this issue, I have a comment below.

On Tue, Mar 05, 2019 at 08:01:45PM +0200, Adalbert Lazăr wrote:
> Previous to commit 22b5c0b63f32 ("vsock/virtio: fix kernel panic after device hot-unplug"),
> vsock_core_init() was called from virtio_vsock_probe(). Now,
> virtio_transport_reset_no_sock() can be called before vsock_core_init()
> has the chance to run.
> 
> [Wed Feb 27 14:17:09 2019] BUG: unable to handle kernel NULL pointer dereference at 0000000000000110
> [Wed Feb 27 14:17:09 2019] #PF error: [normal kernel read fault]
> [Wed Feb 27 14:17:09 2019] PGD 0 P4D 0
> [Wed Feb 27 14:17:09 2019] Oops: 0000 [#1] SMP PTI
> [Wed Feb 27 14:17:09 2019] CPU: 3 PID: 59 Comm: kworker/3:1 Not tainted 5.0.0-rc7-390-generic-hvi #390
> [Wed Feb 27 14:17:09 2019] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
> [Wed Feb 27 14:17:09 2019] Workqueue: virtio_vsock virtio_transport_rx_work [vmw_vsock_virtio_transport]
> [Wed Feb 27 14:17:09 2019] RIP: 0010:virtio_transport_reset_no_sock+0x8c/0xc0 [vmw_vsock_virtio_transport_common]
> [Wed Feb 27 14:17:09 2019] Code: 35 8b 4f 14 48 8b 57 08 31 f6 44 8b 4f 10 44 8b 07 48 8d 7d c8 e8 84 f8 ff ff 48 85 c0 48 89 c3 74 2a e8 f7 31 03 00 48 89 df <48> 8b 80 10 01 00 00 e8 68 fb 69 ed 48 8b 75 f0 65 48 33 34 25 28
> [Wed Feb 27 14:17:09 2019] RSP: 0018:ffffb42701ab7d40 EFLAGS: 00010282
> [Wed Feb 27 14:17:09 2019] RAX: 0000000000000000 RBX: ffff9d79637ee080 RCX: 0000000000000003
> [Wed Feb 27 14:17:09 2019] RDX: 0000000000000001 RSI: 0000000000000002 RDI: ffff9d79637ee080
> [Wed Feb 27 14:17:09 2019] RBP: ffffb42701ab7d78 R08: ffff9d796fae70e0 R09: ffff9d796f403500
> [Wed Feb 27 14:17:09 2019] R10: ffffb42701ab7d90 R11: 0000000000000000 R12: ffff9d7969d09240
> [Wed Feb 27 14:17:09 2019] R13: ffff9d79624e6840 R14: ffff9d7969d09318 R15: ffff9d796d48ff80
> [Wed Feb 27 14:17:09 2019] FS:  0000000000000000(0000) GS:ffff9d796fac0000(0000) knlGS:0000000000000000
> [Wed Feb 27 14:17:09 2019] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [Wed Feb 27 14:17:09 2019] CR2: 0000000000000110 CR3: 0000000427f22000 CR4: 00000000000006e0
> [Wed Feb 27 14:17:09 2019] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [Wed Feb 27 14:17:09 2019] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [Wed Feb 27 14:17:09 2019] Call Trace:
> [Wed Feb 27 14:17:09 2019]  virtio_transport_recv_pkt+0x63/0x820 [vmw_vsock_virtio_transport_common]
> [Wed Feb 27 14:17:09 2019]  ? kfree+0x17e/0x190
> [Wed Feb 27 14:17:09 2019]  ? detach_buf_split+0x145/0x160
> [Wed Feb 27 14:17:09 2019]  ? __switch_to_asm+0x40/0x70
> [Wed Feb 27 14:17:09 2019]  virtio_transport_rx_work+0xa0/0x106 [vmw_vsock_virtio_transport]
> [Wed Feb 27 14:17:09 2019] NET: Registered protocol family 40
> [Wed Feb 27 14:17:09 2019]  process_one_work+0x167/0x410
> [Wed Feb 27 14:17:09 2019]  worker_thread+0x4d/0x460
> [Wed Feb 27 14:17:09 2019]  kthread+0x105/0x140
> [Wed Feb 27 14:17:09 2019]  ? rescuer_thread+0x360/0x360
> [Wed Feb 27 14:17:09 2019]  ? kthread_destroy_worker+0x50/0x50
> [Wed Feb 27 14:17:09 2019]  ret_from_fork+0x35/0x40
> [Wed Feb 27 14:17:09 2019] Modules linked in: vmw_vsock_virtio_transport vmw_vsock_virtio_transport_common input_leds vsock serio_raw i2c_piix4 mac_hid qemu_fw_cfg autofs4 cirrus ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops virtio_net psmouse drm net_failover pata_acpi virtio_blk failover floppy
> [Wed Feb 27 14:17:09 2019] CR2: 0000000000000110
> [Wed Feb 27 14:17:09 2019] ---[ end trace baa35abd2e040fe5 ]---
> [Wed Feb 27 14:17:09 2019] RIP: 0010:virtio_transport_reset_no_sock+0x8c/0xc0 [vmw_vsock_virtio_transport_common]
> [Wed Feb 27 14:17:09 2019] Code: 35 8b 4f 14 48 8b 57 08 31 f6 44 8b 4f 10 44 8b 07 48 8d 7d c8 e8 84 f8 ff ff 48 85 c0 48 89 c3 74 2a e8 f7 31 03 00 48 89 df <48> 8b 80 10 01 00 00 e8 68 fb 69 ed 48 8b 75 f0 65 48 33 34 25 28
> [Wed Feb 27 14:17:09 2019] RSP: 0018:ffffb42701ab7d40 EFLAGS: 00010282
> [Wed Feb 27 14:17:09 2019] RAX: 0000000000000000 RBX: ffff9d79637ee080 RCX: 0000000000000003
> [Wed Feb 27 14:17:09 2019] RDX: 0000000000000001 RSI: 0000000000000002 RDI: ffff9d79637ee080
> [Wed Feb 27 14:17:09 2019] RBP: ffffb42701ab7d78 R08: ffff9d796fae70e0 R09: ffff9d796f403500
> [Wed Feb 27 14:17:09 2019] R10: ffffb42701ab7d90 R11: 0000000000000000 R12: ffff9d7969d09240
> [Wed Feb 27 14:17:09 2019] R13: ffff9d79624e6840 R14: ffff9d7969d09318 R15: ffff9d796d48ff80
> [Wed Feb 27 14:17:09 2019] FS:  0000000000000000(0000) GS:ffff9d796fac0000(0000) knlGS:0000000000000000
> [Wed Feb 27 14:17:09 2019] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [Wed Feb 27 14:17:09 2019] CR2: 0000000000000110 CR3: 0000000427f22000 CR4: 00000000000006e0
> [Wed Feb 27 14:17:09 2019] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [Wed Feb 27 14:17:09 2019] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ---
>  net/vmw_vsock/virtio_transport_common.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 3ae3a33da70b..502201aaff2a 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -662,6 +662,7 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
>   */
>  static int virtio_transport_reset_no_sock(struct virtio_vsock_pkt *pkt)
>  {
> +	const struct virtio_transport *t;
>  	struct virtio_vsock_pkt_info info = {
>  		.op = VIRTIO_VSOCK_OP_RST,
>  		.type = le16_to_cpu(pkt->hdr.type),
> @@ -680,7 +681,11 @@ static int virtio_transport_reset_no_sock(struct virtio_vsock_pkt *pkt)
>  	if (!pkt)
>  		return -ENOMEM;
>  
> -	return virtio_transport_get_ops()->send_pkt(pkt);
> +	t = virtio_transport_get_ops();
> +	if (!t)
> +		return -ENOTCONN;

Should be better to do this check before the virtio_transport_alloc_pkt?

Otherwise, I think we should free that packet before to return -ENOTCONN.

Thanks,
Stefano

> +
> +	return t->send_pkt(pkt);
>  }
>  
>  static void virtio_transport_wait_close(struct sock *sk, long timeout)
> -- 
> 2.21.0
> 
