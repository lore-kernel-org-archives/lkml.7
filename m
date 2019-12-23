Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A19C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 20:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E3820709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 20:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2HxwQKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfLWUND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 15:13:03 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39552 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfLWUNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 15:13:00 -0500
Received: by mail-yb1-f194.google.com with SMTP id b12so7464838ybg.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 12:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hq48wF9NhqAaFGpnbg5sjL9dGZLXnI5W9HK7qIe6Fno=;
        b=d2HxwQKDPzhGn2LHQszYi+myVQHBF/f7O1+oD/srE9zlKJbYChBdWFSWGz/jrChDv/
         /ju7o45CYz4mT397h8IRzn9nJ3bxyyEBaIaAHUOt0Zvf3EcC9ciTHndroYj+T/wGI2dO
         VvQsgjZro8k0VH/LfN5OiItrifUfdG83gsT05J9Lt/R3N1BhcFX9iQ8IHw18PuabckMV
         W/C+yY63gY2Vzv9nEuMRhhyWAfl2ARn2Uip36Pklgyrf+D+NiQ1jCmRENV/7HNd6c+oz
         /kAvoQAhoItS9PQOCU/nDgozgycTvrPE0CJGfY8FXWx6X3d/znr0618xY2KQqRJqWZou
         5p7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hq48wF9NhqAaFGpnbg5sjL9dGZLXnI5W9HK7qIe6Fno=;
        b=om0BgSyubkXfgtzjw7d5eCGlO33GqXfL0wJ+Byie85WQb6rNFYiVdFIHz4+ZXh7YS+
         fZZztSTMcLGDDOy9/LHJypNBwJhK9xBr7Vcjh53+lW52GEZPuCevpjkMNDwPY9k1B84S
         kZ/ECTLb3MN9/tlAh95PEGtv7m7DSK8jlCwwPZwX9jMryynol2tg58kz1A4/f5e4QrCs
         EURSCaE8TuZXF/fDDIzis3oR4k/zaxYrbr/UFqawuRAcX3cX7+ZMD+GXL1v+bRYIgR4v
         PlFtJL73J4G5SyZvuYkUpZPKY9PsJFkXmZpVVuM3d6qnU9xuq+gc+l2pjUzTDKKn5ZlG
         85FA==
X-Gm-Message-State: APjAAAWuEKc3O8Fsu+bIPTupJ8+cZJjom5QdUlbuUTogyGZ572nZpWdl
        xUgEJrRO3M2x6FVYB4Rz4v+HOJ35
X-Google-Smtp-Source: APXvYqz6tM7hinRBB24P+JHjmpbMPYN0Auth4ftlOq5Umhvu3kKUUFSyZmYQ5Pjrt0tv7GdCgkW77A==
X-Received: by 2002:a25:b810:: with SMTP id v16mr21746924ybj.98.1577131978352;
        Mon, 23 Dec 2019 12:12:58 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id d13sm8340706ywj.91.2019.12.23.12.12.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2019 12:12:57 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id w126so5578829yba.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 12:12:57 -0800 (PST)
X-Received: by 2002:a5b:c43:: with SMTP id d3mr22795971ybr.203.1577131976738;
 Mon, 23 Dec 2019 12:12:56 -0800 (PST)
MIME-Version: 1.0
References: <20191223140322.20013-1-mst@redhat.com> <CANDihLHPk5khpv-f-M+qhkzgTkygAts38GGb-HChg-VL2bo+Uw@mail.gmail.com>
 <CA+FuTSfq5v3-0VYmTG7YFFUqT8uG53eXXhqc8WvVvMbp3s0nvA@mail.gmail.com>
In-Reply-To: <CA+FuTSfq5v3-0VYmTG7YFFUqT8uG53eXXhqc8WvVvMbp3s0nvA@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 23 Dec 2019 15:12:20 -0500
X-Gmail-Original-Message-ID: <CA+FuTScwwajN2ny2w8EBkBQd191Eb1ZsrRhbh3=5eQervArnEA@mail.gmail.com>
Message-ID: <CA+FuTScwwajN2ny2w8EBkBQd191Eb1ZsrRhbh3=5eQervArnEA@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: CTRL_GUEST_OFFLOADS depends on CTRL_VQ
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Alistair Delva <adelva@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 2:56 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> 00fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  ? preempt_count_add+0x58/0xb0
> > >  ? _raw_spin_lock_irqsave+0x36/0x70
> > >  ? _raw_spin_unlock_irqrestore+0x1a/0x40
> > >  ? __wake_up+0x70/0x190
> > >  virtnet_set_features+0x90/0xf0 [virtio_net]
> > >  __netdev_update_features+0x271/0x980
> > >  ? nlmsg_notify+0x5b/0xa0
> > >  dev_disable_lro+0x2b/0x190
> > >  ? inet_netconf_notify_devconf+0xe2/0x120
> > >  devinet_sysctl_forward+0x176/0x1e0
> > >  proc_sys_call_handler+0x1f0/0x250
> > >  proc_sys_write+0xf/0x20
> > >  __vfs_write+0x3e/0x190
> > >  ? __sb_start_write+0x6d/0xd0
> > >  vfs_write+0xd3/0x190
> > >  ksys_write+0x68/0xd0
> > >  __ia32_sys_write+0x14/0x20
> > >  do_fast_syscall_32+0x86/0xe0
> > >  entry_SYSENTER_compat+0x7c/0x8e
> > >
> > > A similar crash will likely trigger when enabling XDP.
> > >
> > > Reported-by: Alistair Delva <adelva@google.com>
> > > Reported-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > > Fixes: 3f93522ffab2 ("virtio-net: switch off offloads on demand if possible on XDP set")
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >
> > > Lightly tested.
> > >
> > > Alistair, could you please test and confirm that this resolves the
> > > crash for you?
> >
> > This patch doesn't work. The reason is that NETIF_F_LRO is also turned
> > on by TSO4/TSO6, which your patch didn't check for. So it ends up
> > going through the same path and crashing in the same way.
> >
> >         if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> >             virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> >                 dev->features |= NETIF_F_LRO;
> >
> > It sounds like this patch is fixing something slightly differently to
> > my patch fixed. virtnet_set_features() doesn't care about
> > GUEST_OFFLOADS, it only tests against NETIF_F_LRO. Even if "offloads"
> > is zero, it will call virtnet_set_guest_offloads(), which triggers the
> > crash.
>
>
> Interesting. It's surprising that it is trying to configure a flag
> that is not configurable, i.e., absent from dev->hw_features
> after Michael's change.
>
> > So either we need to ensure NETIF_F_LRO is never set, or
>
> LRO might be available, just not configurable. Indeed this was what I
> observed in the past.

dev_disable_lro expects that NETIF_F_LRO is always configurable. Which
I guess is a reasonable assumption, just not necessarily the case in
virtio_net.

So I think we need both patches. Correctly mark the feature as fixed
by removing from dev->hw_features and also ignore the request from
dev_disable_lro, which does not check for this.
