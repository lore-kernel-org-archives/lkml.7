Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65843C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B8A20835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="n6zv1Zny";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mXTj1/NT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfD3GeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 02:34:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42243 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725554AbfD3GeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 02:34:07 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 86A42220E2;
        Tue, 30 Apr 2019 02:34:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 30 Apr 2019 02:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=5NmjIawd5LxDhUXwBKjmfIeG6PW
        W2x4Hz4B05t/pcXM=; b=n6zv1ZnynAx2mPLBWm1rFfyGP6eVJD+Gsl61VXgmFXR
        f1OyxNprq9uSujnzXlwfXJPMdKIHE/zV/KlsBIph8YJ/HkSdhVp0CJ2GABCMxN9s
        k3SgKbtv/LsYOFfRfF6LxC7RpnsXK0dggkq8OyyWSrfyc33rN+8wC0oYvjFFlwGF
        mydA7FJknk5CCaxeEkub3bfc7jrhT6ftpXIqCiWTQdYb7GBU9zoQlmanXEXxzsfc
        nmEAMJQoYQy+KqcVloXAIOsASc0H9M4twUIl3Sq1OgO0T5b6+oeQECdWdzmaDf9N
        omLvE5XhnpycjYTiCghUbjKb9XNqIvABmx+P7Sy3k2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=5NmjIa
        wd5LxDhUXwBKjmfIeG6PWW2x4Hz4B05t/pcXM=; b=mXTj1/NTxqd5Wt/OQm/B/7
        ctR+eUWatN1GFJwwdZHej6ps4xGLmu5az1x0rtEGdwaW+pwG3O+1gRMujDg+WxEw
        nnk6Jl0MsnR9nJ015+Y6NvtN5hq/gQ2HCYYYi2Vwg6pkAiyD5n3MJPkQ2xrMfp8q
        g93wLsekAMg6VHsSMQPOVzlpvutTOya2fj8JYTL9G42HettSe7aXHPo8uZAO7uo7
        zPDdbYBBC1zTHrp5WldSWB8LL/IodGLKxN8ODDQLp1XfEVwZrqQMqQMWHCX9tFUN
        4GbW72i4gB7VcYbK8QXmkZXkBdMwSuJL/wAMuHlSiTCb4cjNKSTpSk2E8zbuJ0OQ
        ==
X-ME-Sender: <xms:XuzHXPz_HxUts5e5Gk-1J2woYEpUs0vI7k5vCPLITlgjgX7AbBaw0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieefgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdludehmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvddurdeggedrvdeftddrudekkeenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:XuzHXC-fkrY1_FSs62YQEm7WZp48nBLGxQgPA2gSBvL5hTzPrL8K4g>
    <xmx:XuzHXFwCOymmfo08tM2xgSzogVxdvvbVP27N8FLn8vfBxioWnk6TGQ>
    <xmx:XuzHXCqBLOOkR5k-LaW9Qf3-b8TAKNtfpuM3ZoC1G5K9TdcRyHUCsA>
    <xmx:XuzHXLmOA2EEb-aqg0-UIPjmsqUISTw8qdDcWFofLrZpDJuLcnQEjg>
Received: from localhost (ppp121-44-230-188.bras2.syd2.internode.on.net [121.44.230.188])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3A4F2103CD;
        Tue, 30 Apr 2019 02:34:04 -0400 (EDT)
Date:   Tue, 30 Apr 2019 16:33:26 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, tobin@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Fix kobject memleak
Message-ID: <20190430063326.GC32393@eros.localdomain>
References: <815f7c7cea02e05c90d5bf678ea8717f01cc9f63.1556604312.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <815f7c7cea02e05c90d5bf678ea8717f01cc9f63.1556604312.git.viresh.kumar@linaro.org>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 11:35:52AM +0530, Viresh Kumar wrote:
> Currently the error return path from kobject_init_and_add() is not
> followed by a call to kobject_put() - which means we are leaking the
> kobject.
> 
> Fix it by adding a call to kobject_put() in the error path of
> kobject_init_and_add().
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Tobin fixed this for schedutil already.

For what its worth:

 Reviewed-by: Tobin C. Harding <tobin@kernel.org>

Thanks Viresh, one less for me to do!

	Tobin
