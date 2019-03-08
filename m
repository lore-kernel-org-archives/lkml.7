Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F31C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CAC22064A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfCHXR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 18:17:28 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41388 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfCHXR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 18:17:27 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2BA081479DBE8;
        Fri,  8 Mar 2019 15:17:27 -0800 (PST)
Date:   Fri, 08 Mar 2019 15:17:26 -0800 (PST)
Message-Id: <20190308.151726.1373226353046701716.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: silence an unused-variable warning
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190306110602.2529137-1-arnd@arndb.de>
References: <20190306110602.2529137-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 08 Mar 2019 15:17:27 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed,  6 Mar 2019 12:05:49 +0100

> On some architectures, the MMU can be disabled, leading to access_ok()
> becoming an empty macro that does not evaluate its size argument,
> which in turn produces an unused-variable warning:
> 
> drivers/vhost/vhost.c:1191:9: error: unused variable 's' [-Werror,-Wunused-variable]
>         size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
> 
> Mark the variable as __maybe_unused to shut up that warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I'll apply this, thanks Arnd.
