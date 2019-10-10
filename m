Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1DCC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA90820679
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387925AbfJJNEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:04:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387624AbfJJNEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:04:43 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1DD814ACA7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 13:04:43 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id o10so2718260wrm.22
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 06:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2MtH4zvS+teTx0r1qM2asg1XxOF0qUFTTboopmawOE4=;
        b=QgvRUVFKG6WC1nOg7m8pG8MF9rqokdvTGOYi3lXVI5ZAelZk0KiAbTME3Z/mIoItvL
         MEv1m1UQ8Q0QJr9v3eiXsRGQ/DDotB9EVZ0p18gwwQnISHkPfB9ZYwVpPG+aY8CM0WNf
         villHGSN66NjNCpbOn82MzxMx65cJ4RcS8bYZkVGHp37m8ClbU5vDNYkwlL/fNeBCpgQ
         WMkePPsHzIZOe9j3Ldmebcz+DK2eYxv6H2r2Uy6LYKVzJSI9Rxfv2wdZJA3y2s427PQU
         +EyQhI+HbiQgy9VclZGB6ej2FckKyArlsE4AwBRTChaUBQlzZ2THbLd0sMdDOuvJOxhB
         HpFg==
X-Gm-Message-State: APjAAAX5YlKWaIbPT6H82+p/h0CasPiWSwW1MsscnJAYJpz538zIopFn
        R7nFxoRMVURp9b1UgvuPN16fwc8S9je50ENIc3DNKPi/bdj6xy36IM7WlszotSBMHhRnrGRKR5i
        1dIGi9aBFzBDtScJY2kOXooRz
X-Received: by 2002:a05:600c:2549:: with SMTP id e9mr7070288wma.74.1570712681809;
        Thu, 10 Oct 2019 06:04:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyKWS9Yagf4LaasayMPOMgQigEaVeXAInUpVNhLSOAsaDv27fYHGGISL/SEaullOo401iX5OQ==
X-Received: by 2002:a05:600c:2549:: with SMTP id e9mr7070261wma.74.1570712681580;
        Thu, 10 Oct 2019 06:04:41 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it. [79.52.200.174])
        by smtp.gmail.com with ESMTPSA id r7sm4504378wrt.28.2019.10.10.06.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 06:04:40 -0700 (PDT)
Date:   Thu, 10 Oct 2019 15:04:38 +0200
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
Subject: Re: [RFC PATCH 11/13] vsock: add 'transport_hg' to handle g2h\h2g
 transports
Message-ID: <20191010130438.3hbv33fgslmlprtf@steredhat>
References: <20190927112703.17745-1-sgarzare@redhat.com>
 <20190927112703.17745-12-sgarzare@redhat.com>
 <20191009131643.GL5747@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009131643.GL5747@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:16:43PM +0100, Stefan Hajnoczi wrote:
> On Fri, Sep 27, 2019 at 01:27:01PM +0200, Stefano Garzarella wrote:
> > VMCI transport provides both g2h and h2g behaviors in a single
> > transport.
> > We are able to set (or not) the g2h behavior, detecting if we
> > are in a VMware guest (or not), but the h2g feature is always set.
> > This prevents to load other h2g transports while we are in a
> > VMware guest.
> 
> In the vhost_vsock.ko case we only register the h2g transport when
> userspace has loaded the module (by opening /dev/vhost-vsock).
> 
> VMCI has something kind of similar: /dev/vmci and the
> vmci_host_active_users counter.  Maybe we can use this instead of
> introducing the transport_hg concept?

Yes, maybe we can register the host in the vmci_host_do_init_context().

I also don't like a lot the transport_hg concept, so I'll try to found
an alternative.

Thanks,
Stefano
