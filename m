Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1912C606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845D2217D8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PcWw+/z2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403977AbfGHTiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:38:16 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44093 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731628AbfGHTiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:38:16 -0400
Received: by mail-qk1-f193.google.com with SMTP id d79so9959659qke.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 12:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TylGuspNeCUoW8nua4Sr0QWN1QxRHrGILCPTzFyGjF4=;
        b=PcWw+/z2WHLQiOeNrbXf/1WeVVGWBkKKh4TOwzFaP3xI1R52FemdlSxUyfeSEGKHRG
         BR4TQ+KjWlm1+fndB0979LrQAHfyEKQDrp4GPMXvH4+ezBUZaPcFsSWdlsOz7QLU+drT
         2rh3GD3k+eXKyfnpI44JzhUYTULeEtssA011xCfOkqx4OECoy4VbWXbvlRFcCvdLeMMD
         G5nDmtJ1HlcXNgweqYcWf+akG7KG3x/lPOSu71NqC0AOD7a9mbf4hCmW4Tca+fiFhVqF
         KNF8tWiHmTz2C6af/yTHJY3M5fsUKArdwpE8YScZKt8zEFhsFMircsg2A2XYFAIKGAtJ
         HnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TylGuspNeCUoW8nua4Sr0QWN1QxRHrGILCPTzFyGjF4=;
        b=eSgxmrFlYt+Np6hkk3yx0mtlWPwMfKwPeD8Luwo9Ww4R67o0g5jaeXNYq5G07GmQUK
         Hwe539HwD/PLY+3H6xv5arXOSrOoI92nbvKmMjIiT/zTY0xOgNumQGiPyqLskRBG1+2r
         Ib/jhVGaKvDob3vJvOmxT/nZEWDbuXR5v0uK3UU/9LFGnfKkKcC8KmeRMU5aNxqYuouE
         qIlbWpof7xgVd+tWaPkQYnY15DB11bwRfrhd5Hvz6PgjMnS8AzcgeiTQrSNQEP7xCzQ3
         yFqpvmOujSrZyWO2rg76IHUrPsG5gq9XQwu7W5kFQaXljGFvId0x6d4QtIkQbeFlECGo
         +NyQ==
X-Gm-Message-State: APjAAAX67+e+D7upF4YdT5Xzf7FG/N/TH7bPohbFGB+zw7rS0JWspaUQ
        TRltc2Fh8WPUC9wTS5uUM1LRBA==
X-Google-Smtp-Source: APXvYqzoODXNa9c/vhGSXNm25Zh7L06C3wnVFa/2fmDj+Mm+Xr6Elcl1puBJDlDWMb4tqDNAH6pPlQ==
X-Received: by 2002:a37:62ca:: with SMTP id w193mr14360785qkb.363.1562614695570;
        Mon, 08 Jul 2019 12:38:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id t2sm10048103qth.33.2019.07.08.12.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 12:38:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hkZSo-0006yC-Dz; Mon, 08 Jul 2019 16:38:14 -0300
Date:   Mon, 8 Jul 2019 16:38:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mark Bloch <markb@mellanox.com>
Cc:     Dag Moxnes <dag.moxnes@oracle.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] RDMA/core: Fix race when resolving IP address
Message-ID: <20190708193814.GF23996@ziepe.ca>
References: <1562584584-13132-1-git-send-email-dag.moxnes@oracle.com>
 <20190708175025.GA6976@ziepe.ca>
 <4b9ae7b8-310c-e0b6-7a8e-33e6d5bef83d@oracle.com>
 <63b9d2cb-f69c-d77c-7803-f08e2a6f755d@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63b9d2cb-f69c-d77c-7803-f08e2a6f755d@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 07:22:45PM +0000, Mark Bloch wrote:
> 
> 
> On 7/8/19 11:47 AM, Dag Moxnes wrote:
> > Thanks Jason,
> > 
> > Regards,
> > Dag
> > 
> > Den 08.07.2019 19:50, skrev Jason Gunthorpe:
> >> On Mon, Jul 08, 2019 at 01:16:24PM +0200, Dag Moxnes wrote:
> >>> Use neighbour lock when copying MAC address from neighbour data struct
> >>> in dst_fetch_ha.
> >>>
> >>> When not using the lock, it is possible for the function to race with
> >>> neigh_update, causing it to copy an invalid MAC address.
> >>>
> >>> It is possible to provoke this error by calling rdma_resolve_addr in a
> >>> tight loop, while deleting the corresponding ARP entry in another tight
> >>> loop.
> >>>
> >>> This will cause the race shown it the following sample trace:
> >>>
> >>> rdma_resolve_addr()
> >>>    rdma_resolve_ip()
> >>>      addr_resolve()
> >>>        addr_resolve_neigh()
> >>>          fetch_ha()
> >>>            dst_fetch_ha()
> >>>              n->nud_state == NUD_VALID
> >> It isn't nud_state that is the problem here, it is the parallel
> >> memcpy's onto ha. I fixed the commit message
> >>
> >> This could also have been solved by using the ha_lock, but I don't
> >> think we have a reason to particularly over-optimize this.
> 
> Sorry I'm late to the party, but why not just use: neigh_ha_snapshot()?

Yes, that is much better, please respin this

Thanks,
Jason
