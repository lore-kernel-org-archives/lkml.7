Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00944C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6863206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bm2Q7yg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfLSP2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:28:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38666 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfLSP2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 10:28:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so6420963wrh.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 07:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i3mTBRS7AQPPgtvaPLT01gq1ez3hV630kHrfvTiVFPY=;
        b=bm2Q7yg+XRagohMcZJ+2XrM/uCM9GAtEzSd4ya8LC/HNvy5X+Bd0n2QownQFzu+gaG
         082Spvr/Qi1OVjiUgfOhT9A/dLFbCHIN9w+0oWh7CPTPrQWXW+4zOSt4NBto0qZWhBCU
         jYxG4PamMc0zwTV3GzSdyH7hWpopVt7qIhLs/NwbPOGL5bybP8W/2RtSYmeg7Caagr70
         dIWDkg3A4LDmm7zCPBCPDGWIGpF3ZWps3uWLTkrdN5U3Q2nTNKTsn8mDsp78F3AY1Ypg
         Y9Qk4tCc5N6wd/qHToksiQZ9unnQ4nC42T8Zbx23aOdOpnaYIgv+Ou9/3/Kx6aHuSuoo
         mQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i3mTBRS7AQPPgtvaPLT01gq1ez3hV630kHrfvTiVFPY=;
        b=Bfm2vPD+C4jgB3UdEpAB8S2lMQKBo28ngobjgTHMdEGxEBip/2q0j4JgDp5913cKLP
         UD8d219zXK/YV0JmBFTJX1WEM1uliVX/5HbDX/2rYysJwAIO/chxNsulb/Dx8dHIKBCH
         tGc0D6+CWdLX8wS5zTTLz4QEX+EGkY4AU3YNcLd4S8oE9dZWwJfsKXp93NAoCfSQ7YeB
         J7Ie8VisdKgL3Fh1N4BQ937RutmpsmeQMrqzE0xOZLdrPtjyGWR0jmXOODCRuvJqLT6+
         pnIsfI/wT5FAQEnf7fCz38SKj5CI5a2bbaggOCKrnxlIT2CMXd/PhMh2aWeEN9RyD2Dz
         bBLQ==
X-Gm-Message-State: APjAAAXS1H1DG8lkF+TEtDOXHDIa5JxWPf5A/e18uid3yJFsLE4gn8RS
        l5UbAGCOIuJTT3rH2C9YsQLeWw==
X-Google-Smtp-Source: APXvYqziKLCATaCMCodRy6HwZfmyktzfE1GJqDQbMRumFaq9FlvUFmD50TLTlNoKXZl+bbctvtlFvg==
X-Received: by 2002:adf:ffc7:: with SMTP id x7mr10016255wrs.159.1576769325750;
        Thu, 19 Dec 2019 07:28:45 -0800 (PST)
Received: from apalos.home (ppp-94-64-118-170.home.otenet.gr. [94.64.118.170])
        by smtp.gmail.com with ESMTPSA id t190sm6506919wmt.44.2019.12.19.07.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 07:28:44 -0800 (PST)
Date:   Thu, 19 Dec 2019 17:28:41 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        lirongqing@baidu.com, linyunsheng@huawei.com,
        Saeed Mahameed <saeedm@mellanox.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next v4 PATCH] page_pool: handle page recycle for
 NUMA_NO_NODE condition
Message-ID: <20191219152841.GA6889@apalos.home>
References: <20191218084437.6db92d32@carbon>
 <157665609556.170047.13435503155369210509.stgit@firesoul>
 <20191219120925.GD26945@dhcp22.suse.cz>
 <20191219143535.6c7bc880@carbon>
 <20191219145206.GE26945@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219145206.GE26945@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 03:52:06PM +0100, Michal Hocko wrote:
> On Thu 19-12-19 14:35:35, Jesper Dangaard Brouer wrote:
> > On Thu, 19 Dec 2019 13:09:25 +0100
> > Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > > On Wed 18-12-19 09:01:35, Jesper Dangaard Brouer wrote:
> > > [...]
> > > > For the NUMA_NO_NODE case, when a NIC IRQ is moved to another NUMA
> > > > node, then ptr_ring will be emptied in 65 (PP_ALLOC_CACHE_REFILL+1)
> > > > chunks per allocation and allocation fall-through to the real
> > > > page-allocator with the new nid derived from numa_mem_id(). We accept
> > > > that transitioning the alloc cache doesn't happen immediately.  
> > 
> > Oh, I just realized that the drivers usually refill several RX
> > packet-pages at once, this means that this is called N times, meaning
> > during a NUMA change this will result in N * 65 pages returned.
> > 
> > 
> > > Could you explain what is the expected semantic of NUMA_NO_NODE in this
> > > case? Does it imply always the preferred locality? See my other email[1] to
> > > this matter.
> > 
> > I do think we want NUMA_NO_NODE to mean preferred locality.
> 

Why? wouldn't it be clearer if it meant "this is not NUMA AWARE"?
The way i see it iyou have drivers that sit on specific SoCs, 
like the ti one, or the netsec one can declare 'NUMA_NO_NODE' since they 
know beforehand what hardware they'll be sitting on.
On PCI/USB pluggable interfaces mlx5 example should be followed.

> I obviously have no saying here because I am not really familiar with
> the users of this API but I would note that if there is such an implicit
> assumption then you make it impossible to use the numa agnostic page
> pool allocator (aka fast reallocation). This might be not important here
> but future extension would be harder (you can still hack it around aka
> NUMA_REALLY_NO_NODE). My experience tells me that people are quite
> creative and usually require (or worse assume) semantics that you
> thought were not useful.
> 
> That being said, if the NUMA_NO_NODE really should have a special
> locality meaning then document it explicitly at least.

Agree, if we treat it like this we have to document it somehow

> -- 
> Michal Hocko
> SUSE Labs

Thanks
/Ilias
