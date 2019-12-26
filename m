Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB10C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 23:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD74D2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 23:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfLZXQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 18:16:45 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:44484 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfLZXQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 18:16:45 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BE1B81539419A;
        Thu, 26 Dec 2019 15:16:44 -0800 (PST)
Date:   Thu, 26 Dec 2019 15:16:44 -0800 (PST)
Message-Id: <20191226.151644.93658401366332934.davem@davemloft.net>
To:     pdurrant@amazon.com
Cc:     xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wei.liu@kernel.org, paul@xen.org
Subject: Re: [PATCH net-next] xen-netback: support dynamic unbind/bind
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191223095923.2458-1-pdurrant@amazon.com>
References: <20191223095923.2458-1-pdurrant@amazon.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 26 Dec 2019 15:16:45 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Durrant <pdurrant@amazon.com>
Date: Mon, 23 Dec 2019 09:59:23 +0000

> By re-attaching RX, TX, and CTL rings during connect() rather than
> assuming they are freshly allocated (i.e. assuming the counters are zero),
> and avoiding forcing state to Closed in netback_remove() it is possible
> for vif instances to be unbound and re-bound from and to (respectively) a
> running guest.
> 
> Dynamic unbind/bind is a highly useful feature for a backend module as it
> allows it to be unloaded and re-loaded (i.e. updated) without requiring
> domUs to be halted.
> 
> This has been tested by running iperf as a server in the test VM and
> then running a client against it in a continuous loop, whilst also
> running:
> 
> while true;
>   do echo vif-$DOMID-$VIF >unbind;
>   echo down;
>   rmmod xen-netback;
>   echo unloaded;
>   modprobe xen-netback;
>   cd $(pwd);
>   brctl addif xenbr0 vif$DOMID.$VIF;
>   ip link set vif$DOMID.$VIF up;
>   echo up;
>   sleep 5;
>   done
> 
> in dom0 from /sys/bus/xen-backend/drivers/vif to continuously unbind,
> unload, re-load, re-bind and re-plumb the backend.
> 
> Clearly a performance drop was seen but no TCP connection resets were
> observed during this test and moreover a parallel SSH connection into the
> guest remained perfectly usable throughout.
> 
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>

Applied, thank you.
