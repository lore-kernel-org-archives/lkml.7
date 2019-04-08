Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4D8C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6FC21473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfDHO5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:57:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34664 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfDHO5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:57:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id k2so15803777qtm.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 07:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Byy5kOClraa0aVDJor2uBGEK9eh4qRTjGxN6KzyCkbA=;
        b=OBEhu8vmu72INrKPgDRr6QOfoMtH5B1KvG4NBiAGU6pgDkYS1MyAuhUwdhckzAjpcV
         RbUMQ6sRRY5zsglTj1pXbQ/B6XeNUTs6jHG9UxLqnOLXf8MiU4gpgKLP6QHspwMqwcIG
         u2b25BzH7KdZeulEmChI3qNojI2jBKd6ViI6+sUKi6hf5uRYJBn9P+wMkdJx0VULdWUP
         SCm3JWGQwKkFe4OKnRCqJM/PSgNghlyac6VjqWVNvpsMMtkQ314t9VgS54GTKf1zC63b
         2bQvU9qj/NRnOM3PzesMMDjTlhydX/YeEOXMJsIu4o2tKDmtxpzu+feBCp9J1KXe8rDj
         IRgw==
X-Gm-Message-State: APjAAAXEb69RFm6aycu7TMOcBXnKEAUVc4OJw9qYhcCqItKi6po2o60U
        7TgZi/XNTst8u9EgQn3j30QJwQ==
X-Google-Smtp-Source: APXvYqytXyZi7S3Ec3t8HAc5kUisuxJn8sFPXae8p6zhfrFh0MfT9lu6WiaV8i8hT7XKfbpKMd++wA==
X-Received: by 2002:a0c:d2fa:: with SMTP id x55mr23378285qvh.161.1554735467361;
        Mon, 08 Apr 2019 07:57:47 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id n184sm15313931qke.29.2019.04.08.07.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 07:57:46 -0700 (PDT)
Date:   Mon, 8 Apr 2019 10:57:44 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Stefan Hajnoczi <stefanha@gmail.com>, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC 3/4] vsock/virtio: change the maximum packet size
 allowed
Message-ID: <20190408105619-mutt-send-email-mst@kernel.org>
References: <20190404105838.101559-1-sgarzare@redhat.com>
 <20190404105838.101559-4-sgarzare@redhat.com>
 <20190405082447.GD25152@stefanha-x1.localdomain>
 <20190405100747.dbwi3sjaudp3d2wa@steredhat>
 <20190408093723.GP15001@stefanha-x1.localdomain>
 <20190408145531.yreyawkn5vjqj7sl@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408145531.yreyawkn5vjqj7sl@steredhat>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 04:55:31PM +0200, Stefano Garzarella wrote:
> > Anyway, any change to this behavior requires compatibility so new guest
> > drivers work with old vhost_vsock.ko.  Therefore we should probably just
> > leave the limit for now.
> 
> I understood your point of view and I completely agree with you.
> But, until we don't have a way to expose features/versions between guest
> and host,

Why not use the standard virtio feature negotiation mechanism for this?

> maybe is better to leave the limit in order to be compatible
> with old vhost_vsock.

-- 
MST
