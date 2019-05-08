Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE94FC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6F5214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fs3H1cTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfEHPuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:50:16 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42955 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfEHPuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:50:16 -0400
Received: by mail-yw1-f65.google.com with SMTP id s5so10063784ywd.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 08:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0S+zoO0JL7uHrMtS1GsJOCpk/hVgr0z6SDfiCl07Zgk=;
        b=fs3H1cTM0ITjToFLU1xDqSVOL99TduMEWeopEP6QRabT5G6ZwJxqUu07gP1Ur7xMXn
         xPDVOhGoONA/xOaU6qBMutHH2xSnjeinE4axfGTyI/bfLdoy00wMEw9eCPOSeC+QMTcR
         r84SF3sVmnx8I4nimEsU3sJDkdhJJBuqRMIaSjP9bW6MhlZzy/4zaxorK3IbGEYoPRo0
         fCbOqNqe3CPVUTRb0GRuxpuugJQ2GUclYFxj98qin06nz6trYeOxaEyIm2+rtu2s506g
         BZgcoplAK+cyrA8IT0AuNRiYfJ7jjH6+bVxOKFIFUgzD0Q/7WGuMi87hdDyuYbKyV2E5
         MW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0S+zoO0JL7uHrMtS1GsJOCpk/hVgr0z6SDfiCl07Zgk=;
        b=QKcsDDtJfLB8yOR2YpWosCgNh13D88b8dEMbC/V4Yhp8vn0rLka99VrKSTueqb23km
         x41L3VAv9tGh3PjUOWJP1+lIDnUdeZlc76rdvrlg7EtJxhxVHp6y89JuEQxzZNpBtGow
         9VD1NBE81tRF2fnct52Ilq9DwjqmUCqajvYmqrli2KszdHVKIH4S/qzb80GQyVuibYPI
         wnqCHAmxTQcJGlv77ewQoXqeS4KSfTkV1MU/A0XaOR3sKt2VUlTdl54f89Pf2eQ4fsQM
         2FbKWR9y7oeGlNzqEE6KLzRQnJETLmIO6TZ4vKB/JpL328E0ZZiWHh9+3R9rV/Q55hqI
         ZC5Q==
X-Gm-Message-State: APjAAAW5d/SHPEdcISt3J+nDeVk4EVxz6E+3k6G39oNTK3vFKLn7y9CE
        Z9eFbutCcOo6dpFROSy63VBEuk2Buza+vsi5/i9OfA==
X-Google-Smtp-Source: APXvYqzmD1/Xf2VthDlMNjpVnRDC3707MF2BLO+fKxbTUtLlNciUvtnuGz8yWWKAPkxcO03Y76u67tzh/LhQiklOgrs=
X-Received: by 2002:a81:8a83:: with SMTP id a125mr13462467ywg.92.1557330614828;
 Wed, 08 May 2019 08:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190508153241.30776-1-yuehaibing@huawei.com>
In-Reply-To: <20190508153241.30776-1-yuehaibing@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 8 May 2019 08:50:03 -0700
Message-ID: <CANn89iLbFa2fbJ5zQ_BOWEMUbk1aSWQHHbdEBU7DdfvpvEOiDg@mail.gmail.com>
Subject: Re: [PATCH] packet: Fix error path in packet_init
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     David Miller <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, maximmi@mellanox.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 8:33 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
>  kernel BUG at lib/list_debug.c:47!
>  invalid opcode: 0000 [#1
>  CPU: 0 PID: 11195 Comm: rmmod Tainted: G        W         5.1.0+ #33
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.9.3-0-ge2fc41e-prebuilt.qemu-project.org 04/01/2014
>  RIP: 0010:__list_del_entry_valid+0x55/0x90
>  Code: 12 48 39 d7 75 39 48 8b 50 08 48 39 d7 75 1d b8 01 00 00 00 5d c3 48 89 c2 48 89 fe
>  31 c0 48 c7 c7 40 3a fe 82 e8 74 c1 78 ff <0f> 0b 48 89 fe 31 c0 48 c7 c7 f0 3a fe 82 e8 61 c1 78 ff 0f 0b 48
>  RSP: 0018:ffffc90001b8be48 EFLAGS: 00010246
>  RAX: 000000000000004e RBX: ffffffffa0210000 RCX: 0000000000000000
>  RDX: 0000000000000000 RSI: ffff888237a16808 RDI: 00000000ffffffff
>  RBP: ffffc90001b8be48 R08: 0000000000000000 R09: 0000000000000001
>  R10: 0000000000000000 R11: ffffffff842c1640 R12: 0000000000000800
>  R13: 0000000000000000 R14: ffffc90001b8be58 R15: ffffffffa0210000
>  FS:  00007f58963c7540(0000) GS:ffff888237a00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000056064c7af818 CR3: 00000001e9895000 CR4: 00000000000006f0
>  Call Trace:
>   unregister_pernet_operations+0x34/0x110
>   unregister_pernet_subsys+0x1c/0x30
>   packet_exit+0x1c/0x1dd [af_packet
>   __x64_sys_delete_module+0x16b/0x290
>   ? trace_hardirqs_off_thunk+0x1a/0x1c
>   do_syscall_64+0x6b/0x1d0
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Fix error handing path in packet_init to
> avoid possilbe issue if some error occur.

The trace is about rmmod, and the patch is in packet_init() ?

So I believe we need more explanations of why you believe this patch
is fixing the issue
the bot hit .

Thanks.

>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/packet/af_packet.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 90d4e3c..3917c75 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -4598,14 +4598,30 @@ static void __exit packet_exit(void)
>
>  static int __init packet_init(void)
>  {
> -       int rc = proto_register(&packet_proto, 0);
> +       int rc;
>
> -       if (rc != 0)
> +       rc = proto_register(&packet_proto, 0);
> +       if (rc)
>                 goto out;
>
> -       sock_register(&packet_family_ops);
> -       register_pernet_subsys(&packet_net_ops);
> -       register_netdevice_notifier(&packet_netdev_notifier);
> +       rc = sock_register(&packet_family_ops);
> +       if (rc)
> +               goto out_proto;
> +       rc = register_pernet_subsys(&packet_net_ops);
> +       if (rc)
> +               goto out_sock;
> +       rc = register_netdevice_notifier(&packet_netdev_notifier);
> +       if (rc)
> +               goto out_pernet;
> +
> +       return 0;
> +
> +out_pernet:
> +       unregister_pernet_subsys(&packet_net_ops);
> +out_sock:
> +       sock_unregister(PF_PACKET);
> +out_proto:
> +       proto_unregister(&packet_proto);
>  out:
>         return rc;
>  }
> --
> 1.8.3.1
>
>
