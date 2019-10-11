Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3F5C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D013B2190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfJKIwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:52:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbfJKIwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 04:52:03 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38420C049D59
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 08:52:03 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id m16so2499842wmg.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 01:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bm3aGONhK4qHoU5UjTbFZHuFrC1vqMKeEY0f1MpcuKs=;
        b=YLV3jsE+cey4K5N6zd1XULbOvmsCRx5YtwzTw7dX+FdH9dkrSnNwK/4a3Na8m1g8VN
         YA2AB2SG8CbRavcn2shnTRwhR4GvU/IRXKWIYssX/QfBXcjR8bz4OY8jJSjVN9U2tx5/
         clGVBiDvINWs7OAPlQxZjHPmHvvwjLnkB8rg1eqpX1LFd1Pdw22dyxDN97eqmkiKHg0+
         PHPko3XOxBnd85PPY3e+il8GYI7ej8N1d5nm2OKSJxturgvJkV+4rABaTQtWuKq+OJC7
         qZl7kOGcPrON1NZFk6xsxEAkP3lPy32qan+JXM3tcu63FMagyB/bG2+zblp7sJ/KBwhq
         HjRA==
X-Gm-Message-State: APjAAAWw1dkJQGZmIKreFg/+tX6BatMxuxbXXGSTEC+GJpSYdlk3ylra
        jKPxQE/0wVGFzXPc2PPuszkY+R5oSGbrSuTUvfCNlazPK0Bn0Nj+zFjgFhKLTYVVCSkVrYKl3Da
        rDTCIAtoX3nlbumupOK0Zlw/N
X-Received: by 2002:adf:f50b:: with SMTP id q11mr8542921wro.310.1570783921677;
        Fri, 11 Oct 2019 01:52:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy1tPYaVEApdDIIQuAyje0VVr9AdUGsps1WDvoQMdr3X8xYr+LiIbxou3tR8pwnY/h86mPFNQ==
X-Received: by 2002:adf:f50b:: with SMTP id q11mr8542895wro.310.1570783921424;
        Fri, 11 Oct 2019 01:52:01 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it. [79.52.200.174])
        by smtp.gmail.com with ESMTPSA id z189sm13295813wmc.25.2019.10.11.01.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 01:52:00 -0700 (PDT)
Date:   Fri, 11 Oct 2019 10:51:58 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@gmail.com>, netdev@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>,
        kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "David S. Miller" <davem@davemloft.net>,
        Jorgen Hansen <jhansen@vmware.com>
Subject: Re: [RFC PATCH 07/13] vsock: handle buffer_size sockopts in the core
Message-ID: <20191011085158.wiiv4av5fgipm4k7@steredhat>
References: <20190927112703.17745-1-sgarzare@redhat.com>
 <20190927112703.17745-8-sgarzare@redhat.com>
 <20191009123026.GH5747@stefanha-x1.localdomain>
 <20191010093254.aluys4hpsfcepb42@steredhat>
 <20191011082714.GF12360@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011082714.GF12360@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 09:27:14AM +0100, Stefan Hajnoczi wrote:
> On Thu, Oct 10, 2019 at 11:32:54AM +0200, Stefano Garzarella wrote:
> > On Wed, Oct 09, 2019 at 01:30:26PM +0100, Stefan Hajnoczi wrote:
> > > On Fri, Sep 27, 2019 at 01:26:57PM +0200, Stefano Garzarella wrote:
> > > Another issue is that this patch drops the VIRTIO_VSOCK_MAX_BUF_SIZE
> > > limit that used to be enforced by virtio_transport_set_buffer_size().
> > > Now the limit is only applied at socket init time.  If the buffer size
> > > is changed later then VIRTIO_VSOCK_MAX_BUF_SIZE can be exceeded.  If
> > > that doesn't matter, why even bother with VIRTIO_VSOCK_MAX_BUF_SIZE
> > > here?
> > > 
> > 
> > The .notify_buffer_size() should avoid this issue, since it allows the
> > transport to limit the buffer size requested after the initialization.
> > 
> > But again the min set by the user can not be respected and in the
> > previous implementation we forced it to VIRTIO_VSOCK_MAX_BUF_SIZE.
> > 
> > Now we don't limit the min, but we guarantee only that vsk->buffer_size
> > is lower than VIRTIO_VSOCK_MAX_BUF_SIZE.
> > 
> > Can that be an acceptable compromise?
> 
> I think so.
> 
> Setting buffer sizes was never tested or used much by userspace
> applications that I'm aware of.  We should probably include tests for
> changing buffer sizes in the test suite.

Good idea! We should add a test to check if min/max are respected,
playing a bit with these sockopt.

I'll do it in the test series!

Thanks,
Stefano
