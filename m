Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811F0C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563A120679
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PC43vDQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfFUO4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:56:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38292 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfFUO4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:56:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id n11so7201905qtl.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 07:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R6wGdifeYAUiKIP0GGBLBBUmTIFn7pweCX0GnLETICU=;
        b=PC43vDQr0y9Pg1xdmHWeVytAX0ixGDJ2KVFtpgNjVmhFcr7lbZ/t7arGdgSs8On4Ak
         ohXY78wNEgZSyIcjb+KONvqeB3pqoKuDYW70mISNbDqa7lpE5pU4K3quOAsgO49Qywyv
         /Y+V1Au4AV7aqfEcLunnS5+kC4RjT1K+J/HNYLYNNNJ8knZASPBiDA5dSKl8/ubBkWfK
         CFCv6jpPDFaO7GdHIugMNa56NIMAf3wAjJhG3o9RBtaIwCLOxPpbHEQdK38zIy8t5lJt
         FK2vkXbIVTeXWMsQRMZB8VpadI3wrbanvwNdt65Chd6QoQlwOxyYaeUkJPH+6sSYCqmP
         KZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R6wGdifeYAUiKIP0GGBLBBUmTIFn7pweCX0GnLETICU=;
        b=aI47+SsvyvVODTcIQOV/J8PwF+J5i6E/JSJIPT82WeKwJz58lN5GLyVex+4ULCvCQX
         b3fZXuyQeCmJL2NnjUQUnmIYZmAvbbl0FCpdS3rZLCXHSnO+TPIKtuRAn+S46d0pCFNr
         Om95uklMVa9s4TYJoajO3rEUkjFsI2YFhQdZQipOAJYpHUwbUMtXBn8KpZxYuqlLq/8v
         ZT2br5wuiGPMTUYSTTbvSjZOTncwlQ4z0eWf+m3uHue85IttBSyywXqKZx4ow1LgzoPt
         ynC9qeViHZ0kO4lFhN5wCkVsWT9WO+fwjrnbrak8kgaklyaJ899T/KzXheBc+hDQkuwb
         nZ/A==
X-Gm-Message-State: APjAAAXDBBqqN0Vq62KxbLZqy6650CFd24ILQtAlYhj7Tja6kxvkyZ+A
        B/kEfJfR0qfKJikgujfk0OBWRA==
X-Google-Smtp-Source: APXvYqyAbsm7eaRgX9kud1TQA1Yyk/iFLRylWhqYxFe6R8hA4ojV40v1zXQ0PAw31WmaCEsLhCsTyg==
X-Received: by 2002:ac8:7349:: with SMTP id q9mr113636418qtp.151.1561128964914;
        Fri, 21 Jun 2019 07:56:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id y29sm1546916qkj.8.2019.06.21.07.56.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Jun 2019 07:56:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1heKxQ-00014G-1d; Fri, 21 Jun 2019 11:56:04 -0300
Date:   Fri, 21 Jun 2019 11:56:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dag Moxnes <dag.moxnes@oracle.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH] RDMA/core: Fix race when resolving IP address
Message-ID: <20190621145604.GS19891@ziepe.ca>
References: <1561126156-10162-1-git-send-email-dag.moxnes@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561126156-10162-1-git-send-email-dag.moxnes@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 04:09:16PM +0200, Dag Moxnes wrote:
> Use neighbour lock when copying MAC address from neighbour data struct
> in dst_fetch_ha.
> 
> When not using the lock, it is possible for the function to race with
> neigh_update, causing it to copy an invalid MAC address.
> 
> It is possible to provoke this error by calling rdma_resolve_addr in a
> tight loop, while deleting the corresponding ARP entry in another tight
> loop.
> 
> Signed-off-by: Dag Moxnes <dag.moxnes@oracle.com>
> Change-Id: I3c5f982b304457f0a83ea7def2fac70315ed38b4
>  drivers/infiniband/core/addr.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
> index 2f7d141598..e4945fd1bb 100644
> +++ b/drivers/infiniband/core/addr.c
> @@ -333,12 +333,16 @@ static int dst_fetch_ha(const struct dst_entry *dst,
>  	if (!n)
>  		return -ENODATA;
>  
> +	read_lock_bh(&n->lock)
>  	if (!(n->nud_state & NUD_VALID)) {
> -		neigh_event_send(n, NULL);
>  		ret = -ENODATA;
>  	} else {
>  		memcpy(dev_addr->dst_dev_addr, n->ha, MAX_ADDR_LEN);
>  	}
> +	read_unlock_bh(&n->lock);
> +
> +	if (ret)
> +		neigh_event_send(n, NULL);
>  
>  	neigh_release(n);

Can we write this with less spaghetti please, maybe:

static int dst_fetch_ha(const struct dst_entry *dst,
			struct rdma_dev_addr *dev_addr,
			const void *daddr)
{
	struct neighbour *n;
	int ret = 0;

	n = dst_neigh_lookup(dst, daddr);
	if (!n)
		return -ENODATA;

	read_lock_bh(&n->lock);
	if (!(n->nud_state & NUD_VALID)) {
		read_unlock_bh(&n->lock);
		goto out_send;
	}
	memcpy(dev_addr->dst_dev_addr, n->ha, MAX_ADDR_LEN);
	read_unlock_bh(&n->lock);

	goto out_release;

out_send:
	neigh_event_send(n, NULL);
	ret = -ENODATA;
out_release:
	neigh_release(n);

	return ret;
}

Also, Parav should look at it.

Thanks,
Jason
