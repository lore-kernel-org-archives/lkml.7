Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57E8C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB21217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbfDEHtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:49:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37158 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfDEHtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 03:49:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so6797287wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 00:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U8q/dV+jUyLM8P4IzxbEg7fTh9kBuUuI18cx/4ZklsM=;
        b=n1Y2ZsRzUxCq6gLS6TxCBqgR3BPEpgnhVi8DmYQzSzKg5NH84CKXWOaOrydop/5qpx
         lMINDFYxYmdUs9lWKiEp9RhihvVU6E54A1Reu+d+GaAWBbejsrY3pajYeQ7DUAct6L57
         y5ULuUMntKYsfSR1W/me/dQefyPGE3fwRyIYgb3LGhwBSo72h58+33BwR0OaKWZ216eM
         Stzxo5BCTbUT4Wy0UEVRlLEpBHLqxui0sid3KkZGSaTYOjNCvv8ZVuFAK0DKK033VEa6
         7Kvg7JE/d4oBz77J+4CgPCZncJ/+xhNgpKw6WRNj0BpRgQtYfbFVCijq5A0cXwzp47e9
         xWdA==
X-Gm-Message-State: APjAAAXUi7iRiFY1Yo0ChrYoYs6JMcnfDlbzvoFlbLucG1hub4ZI1iqp
        brbgOPsfRTG5E5WGw2Q8/FCkyw==
X-Google-Smtp-Source: APXvYqyqeoNmMQ7J44y2LQjEeu6SgtcE8ycj3r91YErfV/9hNc17FDEY2Zios7sL8s1ylZy+pfKLew==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr7107520wrw.301.1554450560539;
        Fri, 05 Apr 2019 00:49:20 -0700 (PDT)
Received: from steredhat (host35-203-static.12-87-b.business.telecomitalia.it. [87.12.203.35])
        by smtp.gmail.com with ESMTPSA id d17sm29653957wrw.88.2019.04.05.00.49.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 00:49:19 -0700 (PDT)
Date:   Fri, 5 Apr 2019 09:49:17 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC 0/4] vsock/virtio: optimizations to increase the
 throughput
Message-ID: <20190405074917.ooftpalmploq6x3b@steredhat>
References: <20190404105838.101559-1-sgarzare@redhat.com>
 <20190404114643-mutt-send-email-mst@kernel.org>
 <20190404164715.sycigtccwq2rziuz@steredhat>
 <20190404140345-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404140345-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 02:04:10PM -0400, Michael S. Tsirkin wrote:
> On Thu, Apr 04, 2019 at 06:47:15PM +0200, Stefano Garzarella wrote:
> > On Thu, Apr 04, 2019 at 11:52:46AM -0400, Michael S. Tsirkin wrote:
> > > I simply love it that you have analysed the individual impact of
> > > each patch! Great job!
> > 
> > Thanks! I followed Stefan's suggestions!
> > 
> > > 
> > > For comparison's sake, it could be IMHO benefitial to add a column
> > > with virtio-net+vhost-net performance.
> > > 
> > > This will both give us an idea about whether the vsock layer introduces
> > > inefficiencies, and whether the virtio-net idea has merit.
> > > 
> > 
> > Sure, I already did TCP tests on virtio-net + vhost, starting qemu in
> > this way:
> >   $ qemu-system-x86_64 ... \
> >       -netdev tap,id=net0,vhost=on,ifname=tap0,script=no,downscript=no \
> >       -device virtio-net-pci,netdev=net0
> > 
> > I did also a test using TCP_NODELAY, just to be fair, because VSOCK
> > doesn't implement something like this.
> 
> Why not?
> 

I think because originally VSOCK was designed to be simple and
low-latency, but of course we can introduce something like that.

Current implementation directly copy the buffer from the user-space in a
virtio_vsock_pkt and enqueue it to be transmitted.

Maybe we can introduce a buffer per socket where accumulate bytes and
send it when it is full or when a timer is fired . We can also introduce
a VSOCK_NODELAY (maybe using the same value of TCP_NODELAY for
compatibility) to send the buffer immediately for low-latency use cases.

What do you think?

Thanks,
Stefano
