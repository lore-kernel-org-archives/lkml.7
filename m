Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4562C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 07:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7C92084D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 07:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfJGHn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 03:43:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbfJGHn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 03:43:57 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79F8D859FB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2019 07:43:57 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id t25so5078885qtq.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 00:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lXk6nBFGAT4BSmxIglRrQ4LU7TGp8TlXjdfd6qKXf1s=;
        b=XcWuYVefLKnU+7afHdwZ4/KSsmIqE+fIgBlRFh3zOKG4u8CEQfQHSkNSO5ItE2mRuP
         5ipgTDvSrg/wOxyiI+KADJroz8a0agO8whhWcvQACnI5YhweOYR/WxHf9EtmbmxP/gG9
         CmjHr5ftCHDtZ3KePHv7xS1za5ak3TMeFXKg4XiV3akeAfi1s/GdFzCS339sauTyw6Vd
         8e+WFJSSfM3pSVMUeTRaVWJ6V3WMKAFjoDCfC7iXLjauanUtMvg+JJ13ABUgUUKADi6p
         yJys6p0H3FPZz3ERGSCvveU78kQune/9TkBd0J6Fm1lmz6xz89SF75FlIsnlwUsfkYuH
         QcYg==
X-Gm-Message-State: APjAAAW8378yPDHyMyEkgwVgaKzOZbRBH2orraZ1H6RGDLjjjQw5CXwx
        yNo6y/0iivQ28lF4tJNAjRlDwK0uZ7BRDGnkLGv6w0t0hJ2pw8LTtnZXXZVcZtyycVCa3CHIINP
        JdZ7ImG2BrOGQ7jmcp7uo1BZk
X-Received: by 2002:a37:8f86:: with SMTP id r128mr11730770qkd.392.1570434236764;
        Mon, 07 Oct 2019 00:43:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwkDu5dwf58X+8XqrTkuWmYKPmGulasUqtYDa0HzyNEwPsxZficIEoe2hRrlOTxmgzFj1vQuA==
X-Received: by 2002:a37:8f86:: with SMTP id r128mr11730756qkd.392.1570434236539;
        Mon, 07 Oct 2019 00:43:56 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
        by smtp.gmail.com with ESMTPSA id w11sm9017122qtj.10.2019.10.07.00.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 00:43:55 -0700 (PDT)
Date:   Mon, 7 Oct 2019 03:43:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     jcfaracco@gmail.com
Cc:     netdev@vger.kernel.org, jasowang@redhat.com, davem@davemloft.net,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dnmendes76@gmail.com
Subject: Re: [PATCH RFC net-next 0/2] drivers: net: virtio_net: Implement
Message-ID: <20191007034208-mutt-send-email-mst@kernel.org>
References: <20191006184515.23048-1-jcfaracco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006184515.23048-1-jcfaracco@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2019 at 03:45:13PM -0300, jcfaracco@gmail.com wrote:
> From: Julio Faracco <jcfaracco@gmail.com>
> 
> Driver virtio_net is not handling error events for TX provided by 
> dev_watchdog. This event is reached when transmission queue is having 
> problems to transmit packets. To enable it, driver should have 
> .ndo_tx_timeout implemented. This serie has two commits:
> 
> In the past, we implemented a function to recover driver state when this
> kind of event happens, but the structure was to complex for virtio_net
> that moment.

It's more that it was missing a bunch of locks.

> Alternativelly, this skeleton should be enough for now.
>
> For further details, see thread:
> https://lkml.org/lkml/2015/6/23/691
> 
> Patch 1/2:
>   Add statistic field for TX timeout events.
> 
> Patch 2/2:
>   Implement a skeleton function to debug TX timeout events.
> 
> Julio Faracco (2):
>   drivers: net: virtio_net: Add tx_timeout stats field
>   drivers: net: virtio_net: Add tx_timeout function
> 
>  drivers/net/virtio_net.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> -- 
> 2.21.0
