Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CA9C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D692084B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="UhkhtqBa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="whCZ2VBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfDIUH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:07:27 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:39519 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726512AbfDIUH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 16:07:26 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 21F62271E;
        Tue,  9 Apr 2019 16:07:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 09 Apr 2019 16:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=uNPq5bpauKJEYBLZHCcbi44o0QY
        1Z6szsBpVJ4N9HTc=; b=UhkhtqBasH3JCFeeVRuGX6I8I1n5ITF/gy6ZxbQYjaX
        v+bUlPbgCUPIESkgF9rMZV7BQVXfYkgt3lEWhhWV8P73kA7eaXPxg9GF4w/iAR5B
        jAT/KiLCoxNETTsW9Y4VEk+qStRWp//+nYKQ94rWBWfhvmULnnVxWuCYIt0dOAXX
        xGUZTzdHcQ8MWKP7/ebdJfPgSBxFtJsTrzZvfCmMP0JjgmoaMzXNARpvONoNRMnY
        9MRwmJssBPKSoqtVoYJSwnFmhPqnIURfrKrQH5TRz1ewzAHscAt95AUZssKLCOBI
        PQl7FZ4Xd6HeX6/7285kSOvoX9m/SNnDnfxHcIBDFVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=uNPq5b
        pauKJEYBLZHCcbi44o0QY1Z6szsBpVJ4N9HTc=; b=whCZ2VBsHqOBeUQattF/3t
        ZWnGdPxqkVlNBeanDtvSYngJNjoC1FgixnmlMQEOsKmTkey8U5BvBf3ge/Dkoh2S
        UrT4/Xnld5s4BW0tZD0ZkUga0+AdPN5oSTYnBShgeRokJKQoZnHV2h/eEi8xS56S
        iwIFK6yhOZafrrca7W5hl5TyxjKX8d+oeNduwB1w9zZsmoecrODP++QL3zgkevc3
        gFbKsduxFG9EvuGCxIRcxvNrPPR0IfgOlUxCw5raOjqqaxZpEH514rchhsFMja0c
        VrvxOFABB4jV47DPUAE7hp9Iag2TmEKu4yDw6pehVNJfUtczfA2983bMGCtCohew
        ==
X-ME-Sender: <xms:ePusXJB1uKL3VT5Rg_L-6NvcxxW88_KoQFa8Lt5IXLkbAi-mm5aXvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudehgddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvdegrddujedurdduledrudelgeenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:ePusXFL5nl8Jv1o9uyT8x4VlSZ6Gh03V0yjFNjLEjxJ_eGQPEG3R3A>
    <xmx:ePusXKKZvtUK6vLiWq0klSxSt3rbX-2TXyjSVAb9lSWN6tJtONfqEQ>
    <xmx:ePusXHYJZBQlR0p7AWfwK_aSZqrOMd9VL9034A58UKaG5zO4BEoiUw>
    <xmx:e_usXMeqTy_xj851DrUUeJ78k5b18UIOYBcAo-Jescq8Q0y-NBtlrg>
Received: from localhost (124-171-19-194.dyn.iinet.net.au [124.171.19.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id 374ED1039F;
        Tue,  9 Apr 2019 16:07:18 -0400 (EDT)
Date:   Wed, 10 Apr 2019 06:06:49 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <guro@fb.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/7] slob: Respect list_head abstraction layer
Message-ID: <20190409200649.GD19840@eros.localdomain>
References: <20190402230545.2929-1-tobin@kernel.org>
 <20190402230545.2929-3-tobin@kernel.org>
 <20190403180026.GC6778@tower.DHCP.thefacebook.com>
 <20190403211354.GC23288@eros.localdomain>
 <63e395fc-41c5-00bf-0767-a313554f7b23@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63e395fc-41c5-00bf-0767-a313554f7b23@suse.cz>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 02:59:52PM +0200, Vlastimil Babka wrote:
> On 4/3/19 11:13 PM, Tobin C. Harding wrote:
> 
> > According to 0day test robot this is triggering an error from
> > CHECK_DATA_CORRUPTION when the kernel is built with CONFIG_DEBUG_LIST.
> 
> FWIW, that report [1] was for commit 15c8410c67adef from next-20190401. I've
> checked and it's still the v4 version, although the report came after you
> submitted v5 (it wasn't testing the patches from mailing list, but mmotm). I
> don't see any report for the v5 version so I'd expect it to be indeed fixed by
> the new approach that adds boolean return parameter to slob_page_alloc().
> 
> Vlastimil

Oh man thanks!  That is super cool, thanks for letting me know
Vlastimil.

	Tobin
