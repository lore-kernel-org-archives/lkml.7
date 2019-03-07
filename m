Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C8EC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01C620449
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfCGTMq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:12:46 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41682 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfCGTMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:12:45 -0500
Received: by mail-ot1-f68.google.com with SMTP id t7so15108612otk.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 11:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r5B1Q+YmHy9SUdGBKf9gycOuLgQ9gPPMw8UFpi0au7E=;
        b=mXMstCSXLxZr1YCvP9wXd3ejtOBRY2IwFJ9hlLO7C89b7ruf/eGJZOR4AGeG4Cs1f9
         VZ1qLjuT3PEgpbxD0x3x6nAzs5U3NATht27IiELyxpXjicjmDzO0RlDCf7okZTTEK9jd
         8q6Ia7wdC0izVKkr7nrjLv648wt7g69HCDsFk9vTHUL8b68ey5E1V6uxA2w9u5YJ/J82
         31s6rU5DEAysVxlVCQW2WT8GtvqJw9raNuGekNs2kCuKR+RGKO7Mw5x8+B6lYgv0fVLZ
         wayydmi5J/Yh1GuBt4CeKuebg0UC8cuGsneNUB4skOsnfr8h+o3157Ld6op/RzFh39YM
         xRIQ==
X-Gm-Message-State: APjAAAUYoHWgGpRjks1J+vgNKvk3XNtYKIvkqTDTitpP5KkIlAiYfmhe
        U1lXcXnMMKaF1fJxgMIou8JS+W2FG/d7WBGreA7plA==
X-Google-Smtp-Source: APXvYqxXGnQ07h8mKO5yYWJL5RTXi5g9Smdm69uPpMgtoyDjgbs9onDQj87FEnseUeQa3bx6hekac6lwAqzTCQCyyc0=
X-Received: by 2002:a9d:7657:: with SMTP id o23mr9605905otl.260.1551985963986;
 Thu, 07 Mar 2019 11:12:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:153:0:0:0:0:0 with HTTP; Thu, 7 Mar 2019 11:12:43 -0800 (PST)
In-Reply-To: <20190306101353.9938-1-alazar@bitdefender.com>
References: <20190306101353.9938-1-alazar@bitdefender.com>
From:   Stefano Garzarella <sgarzare@redhat.com>
Date:   Thu, 7 Mar 2019 20:12:43 +0100
Message-ID: <CAGxU2F5o94ARkqZVf5FRMaZNET9X7M82kej7Od+mg3MQ7iJV3A@mail.gmail.com>
Subject: Re: [PATCH v2] vsock/virtio: fix kernel panic from virtio_transport_reset_no_sock
To:     =?UTF-8?Q?Adalbert_Laz=C4=83r?= <alazar@bitdefender.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandru Herghelegiu <aherghelegiu@bitdefender.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 11:13 AM Adalbert Lazăr <alazar@bitdefender.com> wrote:
>
> Previous to commit 22b5c0b63f32 ("vsock/virtio: fix kernel panic
> after device hot-unplug"), vsock_core_init() was called from
> virtio_vsock_probe(). Now, virtio_transport_reset_no_sock() can be called
> before vsock_core_init() has the chance to run.
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
>
> Fixes: 22b5c0b63f32 ("vsock/virtio: fix kernel panic after device hot-unplug")
> Reported-by: Alexandru Herghelegiu <aherghelegiu@bitdefender.com>
> Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
> Co-developed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>

Thanks, LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 3ae3a33da70b..602715fc9a75 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -662,6 +662,8 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
>   */
>  static int virtio_transport_reset_no_sock(struct virtio_vsock_pkt *pkt)
>  {
> +       const struct virtio_transport *t;
> +       struct virtio_vsock_pkt *reply;
>         struct virtio_vsock_pkt_info info = {
>                 .op = VIRTIO_VSOCK_OP_RST,
>                 .type = le16_to_cpu(pkt->hdr.type),
> @@ -672,15 +674,21 @@ static int virtio_transport_reset_no_sock(struct virtio_vsock_pkt *pkt)
>         if (le16_to_cpu(pkt->hdr.op) == VIRTIO_VSOCK_OP_RST)
>                 return 0;
>
> -       pkt = virtio_transport_alloc_pkt(&info, 0,
> -                                        le64_to_cpu(pkt->hdr.dst_cid),
> -                                        le32_to_cpu(pkt->hdr.dst_port),
> -                                        le64_to_cpu(pkt->hdr.src_cid),
> -                                        le32_to_cpu(pkt->hdr.src_port));
> -       if (!pkt)
> +       reply = virtio_transport_alloc_pkt(&info, 0,
> +                                          le64_to_cpu(pkt->hdr.dst_cid),
> +                                          le32_to_cpu(pkt->hdr.dst_port),
> +                                          le64_to_cpu(pkt->hdr.src_cid),
> +                                          le32_to_cpu(pkt->hdr.src_port));
> +       if (!reply)
>                 return -ENOMEM;
>
> -       return virtio_transport_get_ops()->send_pkt(pkt);
> +       t = virtio_transport_get_ops();
> +       if (!t) {
> +               virtio_transport_free_pkt(reply);
> +               return -ENOTCONN;
> +       }
> +
> +       return t->send_pkt(reply);
>  }
>
>  static void virtio_transport_wait_close(struct sock *sk, long timeout)
>


-- 
Stefano Garzarella
Software Engineer @ Red Hat
