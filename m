Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C42DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70377218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbfJJJw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 05:52:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727330AbfJJJwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:52:55 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C03F80F83
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 09:52:55 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id n3so2501274wrt.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 02:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TqIbFc3q/Gn71WMn1cgD1WOyhahKFHqycUgmiD17c60=;
        b=EuGu427IDiAUTOr/IDLGe6M3SNMh6lG3ugDoBlqjUBjH+N9MwyXcURlFndNTHV2nlb
         dD4JAWt+2WpnaKiUJVaBmYW+89ClNQZKjsnKLIvri3BXse915gn4iKuW27sDnSeHR+VM
         k2VlYZhZmDrbUsoLpTa7+TAlYKIQobtFjKP0Nu7x6xjeuz4azXc7WuMlt13Sx1Een1Ra
         ScsHx5hzg6Sw1cFjTIVfmpIiZMOX21AIwSHyCNTsZ3JDvcaKd3GfgEcu/2ESabiGABhp
         gDUQ+YulbileK2dfvX4gdPJXL4s/+E3OTRNEVpztU7k5xx2DGp/tc4r+CPEk1dWlj85t
         FW0g==
X-Gm-Message-State: APjAAAUZKtMHvqaNyMiqiNUo7ey8IopeBTFp++//Z207VLqyKTrOOoUm
        w6Snd1WT0FlWUc75fbqHQre3fz3zreQacioHodwtHnQhaDfKXU4p1SHx9DTYZjYpUo8FMRDyLVF
        2n/9bsibUqw6tMG0oaNgseecI
X-Received: by 2002:a05:600c:28d:: with SMTP id 13mr198473wmk.100.1570701173969;
        Thu, 10 Oct 2019 02:52:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqypapq2mOJT0UwRrfDwUNCu9powWRCw63cVBYVEzLpMWYF3N5fg0WGtA5sfkqGUCAP/OmrMBQ==
X-Received: by 2002:a05:600c:28d:: with SMTP id 13mr198456wmk.100.1570701173753;
        Thu, 10 Oct 2019 02:52:53 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it. [79.52.200.174])
        by smtp.gmail.com with ESMTPSA id c6sm5901462wrm.71.2019.10.10.02.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 02:52:53 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:52:50 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     netdev@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>,
        kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jorgen Hansen <jhansen@vmware.com>
Subject: Re: [RFC PATCH 08/13] vsock: move vsock_insert_unbound() in the
 vsock_create()
Message-ID: <20191010095250.zmwmce7bgqgf3nv4@steredhat>
References: <20190927112703.17745-1-sgarzare@redhat.com>
 <20190927112703.17745-9-sgarzare@redhat.com>
 <20191009123423.GI5747@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009123423.GI5747@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 01:34:23PM +0100, Stefan Hajnoczi wrote:
> On Fri, Sep 27, 2019 at 01:26:58PM +0200, Stefano Garzarella wrote:
> > vsock_insert_unbound() was called only when 'sock' parameter of
> > __vsock_create() was not null. This only happened when
> > __vsock_create() was called by vsock_create().
> > 
> > In order to simplify the multi-transports support, this patch
> > moves vsock_insert_unbound() at the end of vsock_create().
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  net/vmw_vsock/af_vsock.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> Maybe transports shouldn't call __vsock_create() directly.  They always
> pass NULL as the parent socket, so we could have a more specific
> function that transports call without a parent sock argument.  This
> would eliminate any concern over moving vsock_insert_unbound() out of
> this function.  In any case, I've checked the code and this patch is
> correct.

Yes, I agree with you, I can add a new patch to do this cleaning.

> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks,
Stefano
