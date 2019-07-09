Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4ADC73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C0D2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IqFeC6lq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfGIT25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 15:28:57 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38821 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfGIT25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 15:28:57 -0400
Received: by mail-qk1-f195.google.com with SMTP id a27so14177qkk.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 12:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qFPYMlatRmetzjaVywzD1EkupZI+i6KZ4Te6RX2Ssgg=;
        b=IqFeC6lqXbdZ3dpbNj3MGYkWGyiAaZVTE68AzWEvPyH4U3Si1l43DWpa2CyOJzFxaD
         MTb7VJKkn6UIHASdo7JQ9V9d4c1ythaZULvzJt7fggl/SvsAjJsRptHHGmEtgUTHnR+6
         OATTQitRgXk6Rn1E3BoFgh0xNdo7Re5Rs+5ktOVDwndn3TPrmKBOVlsNXgxnxW9UnPPg
         s71UovCRFpFCjJLBLX/b51pywqQafrbHj0UL9RUuvxaQ0hDEl8tPG6RBpvpnjQWJ1Zxu
         j3l7IdDnFpLWU/SRTHiSySFYCwaTXSZqw1SI1koykt9u+S0WhVWFWLzl+KUSEZtqMue2
         WVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qFPYMlatRmetzjaVywzD1EkupZI+i6KZ4Te6RX2Ssgg=;
        b=ZkXfvllwIowa/6+iIax7/1+uuf6+6JZoh5EZIHE82HmLnD/YGwGzk2YFM0VCdSi4oS
         U8qTZ1gPEln6ZpVQt+ae1VySePPTvoEQbjr7eYJLqPskRt7OTihOI4o19UCgcccBt4lp
         ymsh98dwG0GxVYW37bdqLx2wYFRiH4HCcdvPPUGc2iEaf6Ydl/n2HW8WsSEYYwxUlSDR
         +cjErbKd2OE23WovozC4YiKORh4MBK97jxuAM9rUGbUWiUrc1f80V7kPBSCAa4f5DjVX
         XThKAaSxgrpbQfGbOy/BIcmzNHNnJU3LeSGT+Jb/ddwRdSuDIqjczscIc+SacRnB97Vj
         qGng==
X-Gm-Message-State: APjAAAU9OYUPZoTFqOZF+P5T0r8FHsK9BXdD8y2HjcQp/wyvyUdNL6EJ
        IECSzcC6ghX0ASZbCRIwD7xHog==
X-Google-Smtp-Source: APXvYqydueDl0D/JjLFTX2AApJcCgVVN/PpcndLlhFoKS7FDyH88DTIHJqagcA0jndtpPm4ifnljYg==
X-Received: by 2002:ae9:f809:: with SMTP id x9mr20461177qkh.86.1562700535890;
        Tue, 09 Jul 2019 12:28:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id c82sm8224941qkb.112.2019.07.09.12.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Jul 2019 12:28:55 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hkvnK-0003m5-Te; Tue, 09 Jul 2019 16:28:54 -0300
Date:   Tue, 9 Jul 2019 16:28:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dag Moxnes <dag.moxnes@oracle.com>
Cc:     dledford@redhat.com, leon@kernel.org, parav@mellanox.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] RDMA/core: Fix race when resolving IP address
Message-ID: <20190709192854.GA14462@ziepe.ca>
References: <1562673026-31996-1-git-send-email-dag.moxnes@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1562673026-31996-1-git-send-email-dag.moxnes@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 01:50:26PM +0200, Dag Moxnes wrote:
> Use the neighbour lock when copying the MAC address from the neighbour
> data struct in dst_fetch_ha.
> 
> When not using the lock, it is possible for the function to race with
> neigh_update(), causing it to copy an torn MAC address:
> 
> rdma_resolve_addr()
>   rdma_resolve_ip()
>     addr_resolve()
>       addr_resolve_neigh()
>         fetch_ha()
>           dst_fetch_ha()
> 	     memcpy(dev_addr->dst_dev_addr, n->ha, MAX_ADDR_LEN)
> 
> and
> 
> net_ioctl()
>   arp_ioctl()
>     arp_rec_delete()
>       arp_invalidate()
>         neigh_update()
>           __neigh_update()
> 	    memcpy(&neigh->ha, lladdr, dev->addr_len)
> 
> It is possible to provoke this error by calling rdma_resolve_addr() in a
> tight loop, while deleting the corresponding ARP entry in another tight
> loop.
> 
> Fixes: 51d45974515c ("infiniband: addr: Consolidate code to fetch neighbour hardware address from dst.")
> Signed-off-by: Dag Moxnes <dag.moxnes@oracle.com>
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/core/addr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
