Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1718CC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEA02081C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wpd7rWQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfE1M75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:59:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49922 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfE1M75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l65emkDB6YfIx5Ve1iueFrhApsDtoK/gPzAciJVNODE=; b=wpd7rWQeLaPU+zoeaHpc2R9x80
        +3n5d3y2iBXjQIhbfzoz+jRn55C6z21KQ/A9RLFH59jMY6+GCMobkLkzOr6PTIbIrRMdlINMJFKaO
        xuj5mjx1OyUKDQHVQ5D3IJ6cQ4HUQNAajZUTKTFLowP13NP8cBJBcIxZCF2kmNjSzPRGFcSPhCtO7
        5P/Sd7W3JCL1KBX6dVxX/hV3SqnJD9af2qwwkswJ2292lg3ORsdhLYNDtsaLs7CwiKraVa4s1aF26
        7uCWimLss7oL7zTu6Q4i27/3m08Wiue4QRox84Z+UInIVCZV7dMJQqG6JFPmaMnJpoWj1jZ2HXB0K
        1yVSSrQQ==;
Received: from [54.239.6.185] (helo=u9312026164465a.ant.amazon.com)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVbhk-0003wi-Rj; Tue, 28 May 2019 12:59:49 +0000
Message-ID: <f8fccc5745755e92077306189577da2fe591f586.camel@infradead.org>
Subject: Re: [PATCH] virtio_console: remove vq buf while unpluging port
From:   Amit Shah <amit@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>, amit@kernel.org,
        zhenwei pi <pizhenwei@bytedance.com>
Cc:     arnd@arndb.de, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 28 May 2019 14:59:46 +0200
In-Reply-To: <20190524185132.GA10695@kroah.com>
References: <1556416204-30311-1-git-send-email-pizhenwei@bytedance.com>
         <20190524185132.GA10695@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-24 at 20:51 +0200, Greg KH wrote:
> On Sun, Apr 28, 2019 at 09:50:04AM +0800, zhenwei pi wrote:
> > A bug can be easily reproduced:
> > Host# cat guest-agent.xml
> > <channel type="unix">
> >   <source mode="bind" path="/var/lib/libvirt/qemu/stretch.agent"/>
> >   <target type="virtio" name="org.qemu.guest_agent.0"
> > state="connected"/>
> > </channel>
> > Host# virsh attach-device instance guest-agent.xml
> > Host# virsh detach-device instance guest-agent.xml
> > Host# virsh attach-device instance guest-agent.xml
> > 
> > and guest report: virtio-ports vport0p1: Error allocating inbufs
> > 
> > The reason is that the port is unplugged and the vq buf still
> > remained.
> > So, fix two cases in this patch:
> > 1, fix memory leak with attach-device/detach-device.
> > 2, fix logic bug with attach-device/detach-device/attach-device.

The "leak" happens because the host-side of the connection is still
connected.  This is by design -- if a guest has written data before
being unplugged, the port isn't released till the host connection goes
down to ensure a host process reads all the data out of the port.

Can you try similar, but also disconnecting the host side and see if
that fixes things?

> Amit, any ideas if this is valid or not and if this should be
> applied?

This had indeed been missed, thanks!


			Amit

