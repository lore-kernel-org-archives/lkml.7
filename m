Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9BDC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BFA2186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554447639;
	bh=Ie30lCRXiYZhrOWNXO5GOBb0ompZrFhf/1u8XKrTd2k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zPZ31/j/ZGcfefx5MUOv+N6+2Ya+lpt9UP8EyxlM1cURzUNiGWNdt3fJ8UxFjpX+S
	 7R66FUzJg9uJKtXaty638du2l5hxgpaDESU2e2NEtNJRTf8m33g3AZY3X7xDaVaFY+
	 wl+KsRUpYrTTLLoPLZaRi6mK0ynvtERhWJ20wdrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfDEHAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:00:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfDEHAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 03:00:37 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29E482186A;
        Fri,  5 Apr 2019 07:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554447636;
        bh=Ie30lCRXiYZhrOWNXO5GOBb0ompZrFhf/1u8XKrTd2k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I3Yn4mkZhHcIEsfQ0wibIbyDVwZpDJHKD8WK1f3UBSh0tJ1iMG07+RhoxjvxrAr8G
         O9uwEfmMO7Y/nL5uKhluJ5UDyICAlPEOhCzd0Xty8M2wrPZwqSxRso9YpPwJaDlwlw
         6dv1fkEZfqXW7AfyHNdTYO+3p+LSXa70/Lh0VhRQ=
Received: by mail-lf1-f42.google.com with SMTP id 5so3572565lft.12;
        Fri, 05 Apr 2019 00:00:36 -0700 (PDT)
X-Gm-Message-State: APjAAAUW6jNUQ4Lw8qK2zf1qWUgPmbHbxQbVll90UImb5wcGqx0CNdQm
        6PDso4Gs6GRIdrBoCUMVkBs3IsugQv2FoWMSWvs=
X-Google-Smtp-Source: APXvYqy7Is9MCRmuZrBdZNrnxcuZ2fx1UJRgezzDdyo0cGs8iGhc1NFvRl/Xb+rdVJjHT7tKZ1x25WsVjeD4CJepCLQ=
X-Received: by 2002:ac2:5110:: with SMTP id q16mr5934298lfb.44.1554447634382;
 Fri, 05 Apr 2019 00:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000e02450058593df62@google.com> <000000000000db3c59058595f0ac@google.com>
In-Reply-To: <000000000000db3c59058595f0ac@google.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 5 Apr 2019 09:00:23 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcrimyMrK7LBbZLaqHGhS5dSCcBC1X01_pRY5evCD7n5Q@mail.gmail.com>
Message-ID: <CAJKOXPcrimyMrK7LBbZLaqHGhS5dSCcBC1X01_pRY5evCD7n5Q@mail.gmail.com>
Subject: Re: BUG: using __this_cpu_read() in preemptible code in ip6_finish_output
To:     syzbot <syzbot+51471b4aae195285a4a3@syzkaller.appspotmail.com>
Cc:     alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, ecree@solarflare.com, fw@strlen.de,
        idosch@mellanox.com, jiri@mellanox.com, kafai@fb.com,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        lirongqing@baidu.com, netdev@vger.kernel.org, petrm@mellanox.com,
        sd@queasysnail.net, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019 at 03:14, syzbot
<syzbot+51471b4aae195285a4a3@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 97cdcf37b57e3f204be3000b9eab9686f38b4356
> Author: Florian Westphal <fw@strlen.de>
> Date:   Mon Apr 1 14:42:13 2019 +0000
>
>      net: place xmit recursion in softnet data

I am seeing this as well on ARMv7 board booted from NFS root (exynos_defconfig):

[ 30.221238] BUG: using __this_cpu_read() in preemptible [00000000]
code: systemd-network/236
[ 30.228576] caller is ip6_output+0x68/0x3e8
[ 30.232578] CPU: 1 PID: 236 Comm: systemd-network Not tainted
5.1.0-rc3-next-20190405 #2
[ 30.240657] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[ 30.246719] [<c011238c>] (unwind_backtrace) from [<c010df50>]
(show_stack+0x10/0x14)
[ 30.254447] [<c010df50>] (show_stack) from [<c0a87270>] (dump_stack+0x98/0xc4)
[ 30.261638] [<c0a87270>] (dump_stack) from [<c0494a94>]
(__this_cpu_preempt_check+0x124/0x128)
[ 30.270238] [<c0494a94>] (__this_cpu_preempt_check) from [<c08e486c>]
(ip6_output+0x68/0x3e8)
[ 30.278730] [<c08e486c>] (ip6_output) from [<c08e52ac>]
(ip6_send_skb+0x30/0x1d0)
[ 30.286180] [<c08e52ac>] (ip6_send_skb) from [<c0912798>]
(rawv6_sendmsg+0x824/0x9c0)
[ 30.294005] [<c0912798>] (rawv6_sendmsg) from [<c07d8ff8>]
(sock_sendmsg+0x14/0x24)
[ 30.301628] [<c07d8ff8>] (sock_sendmsg) from [<c07d97cc>]
(___sys_sendmsg+0x230/0x244)
[ 30.309514] [<c07d97cc>] (___sys_sendmsg) from [<c07da9f8>]
(__sys_sendmsg+0x50/0x8c)
[ 30.317316] [<c07da9f8>] (__sys_sendmsg) from [<c01011ac>]
(__sys_trace_return+0x0/0x14)
[ 30.325376] Exception stack(0xe79f9fa8 to 0xe79f9ff0)
[ 30.330377] 9fa0: 00000000 b6f3da58 0000000b beeb2a6c 00000000 00000000
[ 30.338560] 9fc0: 00000000 b6f3da58 004015ce 00000128 004b10c8
00000000 020d28f9 00000000
[ 30.346708] 9fe0: 004aeee0 beeb2a40 0047cbdc b6d27684

Full log:
https://krzk.eu/#/builders/22/builds/1055/steps/13/logs/serial0

Best regards,
Krzysztof Kozlowski
