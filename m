Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A482DC2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F512053B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jFRSyWF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfLPMed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:34:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34904 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbfLPMec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:34:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so6511212wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 04:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LjylN+xwqpiOEYUIAODHdEfp1RhameawFOEhG12zND4=;
        b=jFRSyWF7g1/v+4v//G0uoZDanZOM2kJxBdkXAujWQvGnkoP7v3ZjK4EpK2FMC6rNQ5
         vp1ei7epaGKOmRpyWvuOUafQzaywC6xwVDScrZp9rPr6BMNDqZFgNr0RGCfvnsWvfS42
         ryHFmNhyMAR8uYYN5oopDB0Uf+ICk5Qh+YIKRfHsX5TeJP+pMXWClTWK5tatrLRV9tXX
         VmG+atszLRnaImUy8ORIT75JrIBTittbvgtwSlNcsK0vgE/zpw2ZEH/35L2Wnarh4Dmb
         vymkSlc5XqbZ6GBrvXwJklUtyioHhpaMChwE2B8WVt9ky5mjJuCgYOQZ40T75mGIUfPH
         MENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LjylN+xwqpiOEYUIAODHdEfp1RhameawFOEhG12zND4=;
        b=gZnZA8lK/sD08WkX4Liw/Zx9Rm4FcV+EDs8TOsq36LHtruoWOAn74RYZfG/DGwT/Xw
         CDZ4CjsRHqHB+f6AAN5xGU0vvvf6YpK6fr8vZ/QdVZIdUSzxCyqtpmND0BNh2VmhF9Y4
         D7L8dJZpDbDJ+E4Z0qaxobZl2A1CU6Fl32S3SpEnAchwGuekHhPN4mHelKHhJrCapFIn
         N0hakQSv4nX64UkRyqiULftsValY+9yr+3H0p21KyW42mzIlD3Cb7iWr+Ukh0efwj1en
         Qi5fSThkxlEAJOEj+32E35g9asnLDqxg0OeziLadWYPAc+XSkt9I1dWq4ewMGBH8GsbU
         3zCQ==
X-Gm-Message-State: APjAAAVPqOEynNZj+GWJpoi8B86gav7ijbVZmlyXvORmmb7MV9C8nhCj
        LQJVKzgvRPzMdUjZsPt6Gt4l/Q==
X-Google-Smtp-Source: APXvYqzIJepKT6pt/cHMDxWVpvUc6YXMm8GATaacHLho3xvEAB4sBIZqdQ0fdQu01iS0K+YFibon+g==
X-Received: by 2002:a7b:c957:: with SMTP id i23mr10195380wml.49.1576499670297;
        Mon, 16 Dec 2019 04:34:30 -0800 (PST)
Received: from apalos.home (ppp-94-66-130-5.home.otenet.gr. [94.66.130.5])
        by smtp.gmail.com with ESMTPSA id k4sm21382343wmk.26.2019.12.16.04.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 04:34:29 -0800 (PST)
Date:   Mon, 16 Dec 2019 14:34:26 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "brouer@redhat.com" <brouer@redhat.com>,
        "jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
        Li Rongqing <lirongqing@baidu.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        peterz@infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        bhelgaas@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][v2] page_pool: handle page recycle for NUMA_NO_NODE
 condition
Message-ID: <20191216123426.GA18663@apalos.home>
References: <1575624767-3343-1-git-send-email-lirongqing@baidu.com>
 <9fecbff3518d311ec7c3aee9ae0315a73682a4af.camel@mellanox.com>
 <20191211194933.15b53c11@carbon>
 <831ed886842c894f7b2ffe83fe34705180a86b3b.camel@mellanox.com>
 <0a252066-fdc3-a81d-7a36-8f49d2babc01@huawei.com>
 <20191216121557.GE30281@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216121557.GE30281@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal, 
On Mon, Dec 16, 2019 at 01:15:57PM +0100, Michal Hocko wrote:
> On Thu 12-12-19 09:34:14, Yunsheng Lin wrote:
> > +CC Michal, Peter, Greg and Bjorn
> > Because there has been disscusion about where and how the NUMA_NO_NODE
> > should be handled before.
> 
> I do not have a full context. What is the question here?

When we allocate pages for the page_pool API, during the init, the driver writer
decides which NUMA node to use. The API can,  in some cases recycle the memory,
instead of freeing it and re-allocating it. If the NUMA node has changed (irq
affinity for example), we forbid recycling and free the memory, since recycling
and using memory on far NUMA nodes is more expensive (more expensive than
recycling, at least on the architectures we tried anyway).
Since this would be expensive to do it per packet, the burden falls on the 
driver writer for that. Drivers *have* to call page_pool_update_nid() or 
page_pool_nid_changed() if they want to check for that which runs once
per NAPI cycle.

The current code in the API though does not account for NUMA_NO_NODE. That's
what this is trying to fix.
If the page_pool params are initialized with that, we *never* recycle
the memory. This is happening because the API is allocating memory with 
'nid = numa_mem_id()' if NUMA_NO_NODE is configured so the current if statement
'page_to_nid(page) == pool->p.nid' will never trigger.

The initial proposal was to check:
pool->p.nid == NUMA_NO_NODE && page_to_nid(page) == numa_mem_id()));

After that the thread span out of control :)
My question is do we *really* have to check for 
page_to_nid(page) == numa_mem_id()? if the architecture is not NUMA aware
wouldn't pool->p.nid == NUMA_NO_NODE be enough?

Thanks
/Ilias
> -- 
> Michal Hocko
> SUSE Labs
