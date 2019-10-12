Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E263C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C28F2067B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfJLWiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 18:38:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbfJLWiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 18:38:54 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8624EC049E10
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 22:38:54 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id z128so12959159qke.8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 15:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S0RIwai/cYE64lyIc+A9F/PqKRzGBKYVkHbCBiipZNM=;
        b=iQRdWhCBOHX67K/i39O5TR24ljxoM7jx9X/zSjjjKU/ig4CSGvTC8Knb774W+73lbZ
         q3lDqSz9MwRtaTGJTHh+9sByGUiqht1xn9gzGU/Xa5glWi10WgzdiTeoGZNND/o1n7+e
         89nPfChzY0oZvT2sagYMzf7dM7Mtg4s5RE6WmC2da7Us/bCxhdPIhBn8xBEX0geVxcz3
         h+latuBf3mXeI+p2mAFKZUfqBXTPDBacxF29SH75bDbvyi4f76agnxKipCLLi+6yr7Le
         T8y4JXfvZdDx/KI+22aYJeka0Cv3v6PgycQYXy0mEMr5MydLZv0q0m8+HPU8zLF2dEj/
         cWhQ==
X-Gm-Message-State: APjAAAX3la6vLVADvbI/fxGIuHUxemVn7bs+XhnwEVX0vzJZ1G7ouM7o
        FKKYLBlVoPiVGbQzJC2VUM3mRypdF1kdyB6r6mbmFUwBPkoHdoj8y55sQgWs66dWobTtwFqC36v
        4UQk8QEu+givFMuN5Ie5uEWay
X-Received: by 2002:aed:25af:: with SMTP id x44mr24961936qtc.64.1570919933842;
        Sat, 12 Oct 2019 15:38:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz0MjmCeNSh32vVCuUQMNhBZu1KOBCgrBIVtG1Hs9yeNlxecSX6iaR51H1qP+Z4lvase2/DGg==
X-Received: by 2002:aed:25af:: with SMTP id x44mr24961905qtc.64.1570919933558;
        Sat, 12 Oct 2019 15:38:53 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
        by smtp.gmail.com with ESMTPSA id 56sm11130495qty.15.2019.10.12.15.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 15:38:52 -0700 (PDT)
Date:   Sat, 12 Oct 2019 18:38:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        Jorgen Hansen <jhansen@vmware.com>,
        "David S. Miller" <davem@davemloft.net>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] vsock: don't allow half-closed socket in the
 host transports
Message-ID: <20191012183838-mutt-send-email-mst@kernel.org>
References: <20191011130758.22134-1-sgarzare@redhat.com>
 <20191011101408-mutt-send-email-mst@kernel.org>
 <20191011143457.4ujt3gg7oxco6gld@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011143457.4ujt3gg7oxco6gld@steredhat>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 04:34:57PM +0200, Stefano Garzarella wrote:
> On Fri, Oct 11, 2019 at 10:19:13AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Oct 11, 2019 at 03:07:56PM +0200, Stefano Garzarella wrote:
> > > We are implementing a test suite for the VSOCK sockets and we discovered
> > > that vmci_transport never allowed half-closed socket on the host side.
> > > 
> > > As Jorgen explained [1] this is due to the implementation of VMCI.
> > > 
> > > Since we want to have the same behaviour across all transports, this
> > > series adds a section in the "Implementation notes" to exaplain this
> > > behaviour, and changes the vhost_transport to behave the same way.
> > > 
> > > [1] https://patchwork.ozlabs.org/cover/847998/#1831400
> > 
> > Half closed sockets are very useful, and lots of
> > applications use tricks to swap a vsock for a tcp socket,
> > which might as a result break.
> 
> Got it!
> 
> > 
> > If VMCI really cares it can implement an ioctl to
> > allow applications to detect that half closed sockets aren't supported.
> > 
> > It does not look like VMCI wants to bother (users do not read
> > kernel implementation notes) so it does not really care.
> > So why do we want to cripple other transports intentionally?
> 
> The main reason is that we are developing the test suite and we noticed
> the miss match. Since we want to make sure that applications behave in
> the same way on different transports, we thought we would solve it that
> way.
> 
> But what you are saying (also in the reply of the patches) is actually
> quite right. Not being publicized, applications do not expect this behavior,
> so please discard this series.
> 
> My problem during the tests, was trying to figure out if half-closed
> sockets were supported or not, so as you say adding an IOCTL or maybe
> better a getsockopt() could solve the problem.
> 
> What do you think?
> 
> Thanks,
> Stefano

Sure, why not.

