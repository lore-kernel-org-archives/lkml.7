Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ACFC282DC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 01:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378F527878
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 01:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfFCBDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 21:03:36 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50546 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfFCBDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 21:03:36 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2F5E113407F4E;
        Sun,  2 Jun 2019 18:03:35 -0700 (PDT)
Date:   Sun, 02 Jun 2019 18:03:34 -0700 (PDT)
Message-Id: <20190602.180334.1932703293092139564.davem@davemloft.net>
To:     sgarzare@redhat.com
Cc:     netdev@vger.kernel.org, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v3 2/5] vsock/virtio: fix locking for fwd_cnt and
 buf_alloc
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190531133954.122567-3-sgarzare@redhat.com>
References: <20190531133954.122567-1-sgarzare@redhat.com>
        <20190531133954.122567-3-sgarzare@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 02 Jun 2019 18:03:35 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 31 May 2019 15:39:51 +0200

> @@ -434,7 +434,9 @@ void virtio_transport_set_buffer_size(struct vsock_sock *vsk, u64 val)
>  	if (val > vvs->buf_size_max)
>  		vvs->buf_size_max = val;
>  	vvs->buf_size = val;
> +	spin_lock_bh(&vvs->rx_lock);
>  	vvs->buf_alloc = val;
> +	spin_unlock_bh(&vvs->rx_lock);

This locking doesn't do anything other than to strongly order the
buf_size store to occur before the buf_alloc one.

If you need a memory barrier, use one.
