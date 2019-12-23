Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D24C2D0D2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 19:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F13206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 19:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yl084XD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfLWT52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 14:57:28 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45448 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfLWT50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 14:57:26 -0500
Received: by mail-yb1-f196.google.com with SMTP id i3so7438647ybe.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 11:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bb0+CNEtJ6KzyS3XvioZczGP2IemYKNu32wQAAEeIB8=;
        b=Yl084XD682EiZs1AIWmB7fpotrIpfWyb7NpNE13yI5PFnb6G9qiBMQnkvnnH9x60pn
         /4pB4HLcZ4d4nXqAs1Ln570UVdpINIwDpJllGfkvgbjKOIFf+gH0LQn7m/r6QKgg3tLe
         thKS93BdFAkhh8yrejEu0K4eIkb6wW3XiiVUpx1oq1JA3fhRwHgATHTrqdUKLbW2i+F3
         e54zL1rdaOl7Mf8m3jqLcqnpx03vch9VBhKB7bYfeX4qIsoQlGK0zHIoH90Eole8B2sz
         JXC4jRWnxQhG1QO6Sup1fSYaGzVSQpLknqZSWct0a8yWswXmvV8wA/BSiVKsFBFLLgGU
         akNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bb0+CNEtJ6KzyS3XvioZczGP2IemYKNu32wQAAEeIB8=;
        b=FRICnuOOBFHy+CC0EExSVvCjbe0gEt7gGCNQPqe4iQSlJ/QulVk51hK/TcHdhHWN5g
         q7xEZtIrVPB1Wsshe6fI121wdRp/dDC4+Avxj9uRLGBlpxBKa1Sw1q+0NuCxuIMqP05a
         4ZGyUP8PpAyJoV/IY10w4zWWsde52cFyUWvKqoITTf/EJMZbWs4xkq9gHG2Vbs4C7d+D
         +wRnQe4R51+QSUeJvcImjasRcC/naZCx55boZH7puP3vXukWVktGB7Pd6Ge/zCmodgDB
         YqdCwk+qS1zcoTsSIcPtA8ccDkJ7WDrySUmOQk3kXR5d6JG2relOZpbxM2ZlNYw+XSXk
         Q1dA==
X-Gm-Message-State: APjAAAXGH3UoTNRgQArxk2nMKhT+OgGwgqDvlF6iw7ToDX5DAEn1IIP0
        M+1wrPIOZeXJoPAwiO0XEnFHBJrj
X-Google-Smtp-Source: APXvYqwxez0jcpJoYCJNX1Y5Oh+9t0BMKlpD2B2WQFr85aeeTiou/JR8vfBmibnyYnF2V+F373z1iA==
X-Received: by 2002:a25:b108:: with SMTP id g8mr22630130ybj.518.1577131044696;
        Mon, 23 Dec 2019 11:57:24 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id o4sm8456459ywd.5.2019.12.23.11.57.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2019 11:57:24 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id f136so4326149ybg.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 11:57:23 -0800 (PST)
X-Received: by 2002:a25:d117:: with SMTP id i23mr16560523ybg.139.1577131043349;
 Mon, 23 Dec 2019 11:57:23 -0800 (PST)
MIME-Version: 1.0
References: <20191223140322.20013-1-mst@redhat.com> <CANDihLHPk5khpv-f-M+qhkzgTkygAts38GGb-HChg-VL2bo+Uw@mail.gmail.com>
In-Reply-To: <CANDihLHPk5khpv-f-M+qhkzgTkygAts38GGb-HChg-VL2bo+Uw@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 23 Dec 2019 14:56:47 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfq5v3-0VYmTG7YFFUqT8uG53eXXhqc8WvVvMbp3s0nvA@mail.gmail.com>
Message-ID: <CA+FuTSfq5v3-0VYmTG7YFFUqT8uG53eXXhqc8WvVvMbp3s0nvA@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: CTRL_GUEST_OFFLOADS depends on CTRL_VQ
To:     Alistair Delva <adelva@google.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

00fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  ? preempt_count_add+0x58/0xb0
> >  ? _raw_spin_lock_irqsave+0x36/0x70
> >  ? _raw_spin_unlock_irqrestore+0x1a/0x40
> >  ? __wake_up+0x70/0x190
> >  virtnet_set_features+0x90/0xf0 [virtio_net]
> >  __netdev_update_features+0x271/0x980
> >  ? nlmsg_notify+0x5b/0xa0
> >  dev_disable_lro+0x2b/0x190
> >  ? inet_netconf_notify_devconf+0xe2/0x120
> >  devinet_sysctl_forward+0x176/0x1e0
> >  proc_sys_call_handler+0x1f0/0x250
> >  proc_sys_write+0xf/0x20
> >  __vfs_write+0x3e/0x190
> >  ? __sb_start_write+0x6d/0xd0
> >  vfs_write+0xd3/0x190
> >  ksys_write+0x68/0xd0
> >  __ia32_sys_write+0x14/0x20
> >  do_fast_syscall_32+0x86/0xe0
> >  entry_SYSENTER_compat+0x7c/0x8e
> >
> > A similar crash will likely trigger when enabling XDP.
> >
> > Reported-by: Alistair Delva <adelva@google.com>
> > Reported-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Fixes: 3f93522ffab2 ("virtio-net: switch off offloads on demand if possible on XDP set")
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >
> > Lightly tested.
> >
> > Alistair, could you please test and confirm that this resolves the
> > crash for you?
>
> This patch doesn't work. The reason is that NETIF_F_LRO is also turned
> on by TSO4/TSO6, which your patch didn't check for. So it ends up
> going through the same path and crashing in the same way.
>
>         if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>             virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
>                 dev->features |= NETIF_F_LRO;
>
> It sounds like this patch is fixing something slightly differently to
> my patch fixed. virtnet_set_features() doesn't care about
> GUEST_OFFLOADS, it only tests against NETIF_F_LRO. Even if "offloads"
> is zero, it will call virtnet_set_guest_offloads(), which triggers the
> crash.


Interesting. It's surprising that it is trying to configure a flag
that is not configurable, i.e., absent from dev->hw_features
after Michael's change.

> So either we need to ensure NETIF_F_LRO is never set, or

LRO might be available, just not configurable. Indeed this was what I
observed in the past.
