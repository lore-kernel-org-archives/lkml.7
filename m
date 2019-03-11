Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57ABC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857B620657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="WmDMnv+z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tT2jWnm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfCKGEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:04:45 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51165 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726070AbfCKGEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:04:43 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5F9BB21F75;
        Mon, 11 Mar 2019 02:04:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 11 Mar 2019 02:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=A53ynhKpBb5B67T3GkAqRrpBy8w
        A89nWoFI2UrtkrQ8=; b=WmDMnv+zWX7XLQbLSyWQkzcNHov0AwoOZQpl6e1dgMm
        baMCoAot9dPLfD2cpq5skh9JCLevp6N2KmuVIpvonQkUf8Yn0RVntI0IUyyCUxDY
        LnOrEX/dHA2isa/gctW7ijmYOXjdANFdxk0ND0u0e/ujqItP/BIVPZKQlv7G0plu
        CgOOtqTs7Xl46ShKXEN1Y4XN5EoZH0tXTGwqj25fxSdIHlT9jjX7jehRdAp+KT2W
        FBU3ILVwxLT6n++uESgv4oAk1gjVEAhMGQmvlThHNDYITyFtOSGttvXP5BnoO508
        8PLYJG7LOwM6NXl20eBCc8cDO4INF/VHU/gJSDGf4Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=A53ynh
        KpBb5B67T3GkAqRrpBy8wA89nWoFI2UrtkrQ8=; b=tT2jWnm6PsjLlZfoeo3Ct1
        h7E4kmqGYts7Nmi3oR2NBL24s4QKsXq2zla45AjlPR2RBFGI1chTQNRmgbts9dJz
        TcppwWYTaMvIMXCt4mAiuikG0bWVQbdedHZpzPLf5jwkZ3zBj7y5R4sOsnuRQiG9
        z6U+IsUDrsNm3zmTrlsdCx+yMnbtqzHeti64vKMcIB69n76sISBw33tZs3VrXhKd
        IYN1uCebWYUffqL8rF6iYQe1dK2Hmcn6T+CaQVJKrvGX7RLxf1NpxL3E1g4S0nHd
        acgIKF67yADsHnrh5qEU/qZamvY5BeZ63M2mlYE8mOf8+As6CLsnA1zPkx7hzKGA
        ==
X-ME-Sender: <xms:efqFXOGRGBcXaeLhosYuQcR90W-qyTSj3a-Ar9ydcy-bRWutKbx4oA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgeehgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddukedrvdduuddrudelvddrieeinecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:efqFXHydtcoUcjr73VnsbOVFVUKNSSWGhJ7k3qbpV7JSvLjAJQyFUA>
    <xmx:efqFXInlDhWYrwJeIkO1NfDl__f2WrmQX9QscN8wYRtF8fxdUwYcYg>
    <xmx:efqFXImgUii6jT6e6H2ZKDJAWYQo01SuNUOBtlHj2efxPdV_6-7K6Q>
    <xmx:evqFXBZf0Y4mpFb9wRTFq0GS7uCS8dyvRy02h-EPJnqv_Uule5BFXg>
Received: from localhost (ppp118-211-192-66.bras1.syd2.internode.on.net [118.211.192.66])
        by mail.messagingengine.com (Postfix) with ESMTPA id D47CC1030F;
        Mon, 11 Mar 2019 02:04:40 -0400 (EDT)
Date:   Mon, 11 Mar 2019 17:04:18 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christopher Lameter <cl@linux.com>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 07/15] slub: Add defrag_used_ratio field and sysfs support
Message-ID: <20190311060418.GA22772@eros.localdomain>
References: <20190308041426.16654-1-tobin@kernel.org>
 <20190308041426.16654-8-tobin@kernel.org>
 <20190308160151.GC373@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308160151.GC373@cisco>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 09:01:51AM -0700, Tycho Andersen wrote:
> On Fri, Mar 08, 2019 at 03:14:18PM +1100, Tobin C. Harding wrote:
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3642,6 +3642,7 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
> >  
> >  	set_cpu_partial(s);
> >  
> > +	s->defrag_used_ratio = 30;
> >  #ifdef CONFIG_NUMA
> >  	s->remote_node_defrag_ratio = 1000;
> >  #endif
> > @@ -5261,6 +5262,28 @@ static ssize_t destroy_by_rcu_show(struct kmem_cache *s, char *buf)
> >  }
> >  SLAB_ATTR_RO(destroy_by_rcu);
> >  
> > +static ssize_t defrag_used_ratio_show(struct kmem_cache *s, char *buf)
> > +{
> > +	return sprintf(buf, "%d\n", s->defrag_used_ratio);
> > +}
> > +
> > +static ssize_t defrag_used_ratio_store(struct kmem_cache *s,
> > +				       const char *buf, size_t length)
> > +{
> > +	unsigned long ratio;
> > +	int err;
> > +
> > +	err = kstrtoul(buf, 10, &ratio);
> > +	if (err)
> > +		return err;
> > +
> > +	if (ratio <= 100)
> > +		s->defrag_used_ratio = ratio;
>     else
>         return -EINVAL;

Nice, thanks.  I moulded your suggestion into

	if (ratio > 100)
		return -EINVAL;

	s->defrag_used_ratio = ratio;
	return length;


thanks,
Tobin.
