Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B0AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157FA20882
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731844AbfG3JkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:40:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34583 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfG3JkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:40:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so65027709wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 02:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fQg1192WhNDyv6FjBGie6urrqGv9zjrLIH2bCUp56uc=;
        b=Fe2zoBCE8MtA2ErAN6i2pIjsGmlKNhdwaiTig230LGMoViR20Ss6l0tOGVii9opfMj
         RG5rdbTkINshD2Em+n81hkpuJ4DdRJL5zII7GNSykDuQhB46h2o8gQPE5azIeX19d+yZ
         BtjK8Ci0nimgAAiBxC1YWu5iiow+lJrRQ12QCnhpggJUZ6oRIvRQ/+sdzmhZgRjY2F3m
         YFPizpvlP75mTfIVZNDjroy0vlRHR3cHfgvNDVGROaM3kQdjNUUiKC8BsRhgp35CXx5X
         TI9Rff25xlnhPr2/lJHhE7JTI00IlpN69zPpLt2zyyZjObSLaaoCMcdLMYGJwvAJyrv7
         A8sw==
X-Gm-Message-State: APjAAAXnGc8vgFcFy3l7Y05aHLGge7Q5IR43Yqe/9XWvkTFeuUfWzwQ0
        nfQoXmJg918jSiET3AP2NUmjqQ==
X-Google-Smtp-Source: APXvYqwQrJXSgJVI83eo1dkA3KRV/8pRzTuIDgoLCeF0kh3lvGAFxSVFdhlDZkRo9pud0n2msXMp9A==
X-Received: by 2002:a5d:50d1:: with SMTP id f17mr72705216wrt.124.1564479615723;
        Tue, 30 Jul 2019 02:40:15 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it. [79.13.201.122])
        by smtp.gmail.com with ESMTPSA id r12sm77203676wrt.95.2019.07.30.02.40.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 02:40:15 -0700 (PDT)
Date:   Tue, 30 Jul 2019 11:40:13 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 0/5] vsock/virtio: optimizations to increase the
 throughput
Message-ID: <20190730094013.ruqjllqrjmkdnh5y@steredhat>
References: <20190717113030.163499-1-sgarzare@redhat.com>
 <20190729095743-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729095743-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 09:59:23AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 17, 2019 at 01:30:25PM +0200, Stefano Garzarella wrote:
> > This series tries to increase the throughput of virtio-vsock with slight
> > changes.
> > While I was testing the v2 of this series I discovered an huge use of memory,
> > so I added patch 1 to mitigate this issue. I put it in this series in order
> > to better track the performance trends.
> 
> Series:
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Can this go into net-next?
> 

I think so.
Michael, Stefan thanks to ack the series!

Should I resend it with net-next tag?

Thanks,
Stefano
