Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3346CC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E5A21783
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="Ah3bR/1G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mGuPJmU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfD3WzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 18:55:00 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:44607 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbfD3WzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 18:55:00 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 627B723376;
        Tue, 30 Apr 2019 18:54:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 30 Apr 2019 18:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=xbt1TKoKoLotpSf2hKRbnmk6Mej
        LdRsCBZ711ujjQ0I=; b=Ah3bR/1GWrHGRzCJljWDgbZH2sJYUIJuoPQD/WMt+3k
        pSn9PzirnbRj5B6KjHk1c7lc7YpITYSsqfcA+bHdQuyga483ScmGsAOpyXmderLS
        UFNxkcRntk/8RF3Z+rfPwDWGbSbQhpvRsG1I1KE0RnDb5yPWJyfimLUWL7Layinu
        igDt1UA19Uxk951AgX6xFoWNm60nsedcoS+EQxBXS3SFAIEtOu9QGkqxblT053ox
        urZEf2cmNLe3kXvqSlZPAejOjSJwii0df2nPc2JK+d4RzXTVfryFbJNAzmhQ2whp
        vmSbzs6RJF42DdoLAHyAWAnxTaJ3B305TNHJDNs1BfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=xbt1TK
        oKoLotpSf2hKRbnmk6MejLdRsCBZ711ujjQ0I=; b=mGuPJmU8rWlq5p9iDDswfg
        qb0uyN30bpfJNc69sRApK+Y4e+cNuYLdzQq0G5Zci3r9gxMhtaJtuSiO/aymjR+d
        PhxRnWeqLhrL0edSljJXiOrUv49coIwFnj6E3rHtj/WCGFWhGnfms6DHxUlBoggE
        hkarPWI1mhwaTn2wQy6opz6cTXp3vN4BygzJsOi8sOM39LzYiK1SKy1+L7bOS0sX
        UtVzKR6JwjAOCZ0tFbonCe389e5/tYytuWpvbRnM9FieY9tUs4eVdFTOdf+Rc6/x
        JJrAoa4QgMmPeoTjSzdwErSzG8lo+7Tkp3IU9CyxeaqsNok9Hjf6WnzGaHi1U/zQ
        ==
X-ME-Sender: <xms:QtLIXC6uvXn_-MF8jKiJGEFlhq-2y49Xt4wcRzI0lp0Yqxu9yGtbPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieeigdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdduhedmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddvuddrgeegrddvtdegrddvfeehnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:QtLIXFOYMuE7jGcijSRcZww1kTaH1gl3ZJMKjSzF-w1AND5tAB9NrQ>
    <xmx:QtLIXN0sL77vbItsrgakOPBgw1VLMzTZOY_GACPhioIwE08fM3-wTw>
    <xmx:QtLIXGvI6PlL7YN0E54D7xDdMMMcUJ3ca1saHAuxtrDjlzOrpAfnRg>
    <xmx:Q9LIXBoh-gllT6pgdki7OJeAxnmhXeoCrxWLNU_f_O-g7jpZ9vV9WQ>
Received: from localhost (ppp121-44-204-235.bras1.syd2.internode.on.net [121.44.204.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id A7F8DE44B6;
        Tue, 30 Apr 2019 18:54:56 -0400 (EDT)
Date:   Wed, 1 May 2019 08:54:18 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Fix kobject memleak in SLUB
Message-ID: <20190430225418.GA10777@eros.localdomain>
References: <20190427234000.32749-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427234000.32749-1-tobin@kernel.org>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 09:40:00AM +1000, Tobin C. Harding wrote:
> Currently error return from kobject_init_and_add() is not followed by a
> call to kobject_put().  This means there is a memory leak.
> 
> Add call to kobject_put() in error path of kobject_init_and_add().
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  mm/slub.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index d30ede89f4a6..84a9d6c06c27 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5756,8 +5756,10 @@ static int sysfs_slab_add(struct kmem_cache *s)
>  
>  	s->kobj.kset = kset;
>  	err = kobject_init_and_add(&s->kobj, &slab_ktype, NULL, "%s", name);
> -	if (err)
> +	if (err) {
> +		kobject_put(&s->kobj);
>  		goto out;
> +	}
>  
>  	err = sysfs_create_group(&s->kobj, &slab_attr_group);
>  	if (err)
> -- 
> 2.21.0
> 

This patch is not _completely_ correct.  Please do not consider for
merge.  There are a bunch of these on various LKML lists, once the
confusion has cleared I'll re-spin v2.

thanks,
Tobin.
