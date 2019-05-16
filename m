Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EB0C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1B920818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="DFhaGTaf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HXl/DnvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfEPMCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 08:02:08 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60915 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727015AbfEPMCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 08:02:07 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5307221B74;
        Thu, 16 May 2019 08:02:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 16 May 2019 08:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=DBtTXHVPA+Wr0ijtQc0zEOB0AeM
        Zi4CSX7Dpb4AW0zw=; b=DFhaGTaf/hl6uTF9m4xLBNx40lNXcprpqCpFTVCdr9x
        OUVEx5080VMabbpa9w8V4KVKRGpYAzVQjdJN60uKaogdjCcgsWWXxF3w1KZxD9s3
        +LMfcFZW/oqFSpJ+Y3v4UZj2CyXXylOtPgars1cM+mvEeW5VngkIx7m2MTeH/wGD
        gG0MByQogrj2jd111+/tdQTd153zbx6xWS2yjSbsBtI79IKOV/ada9mA8xuxqRLM
        YzNgQ6rH7F6SpGrcBFPget90kFwN7KA+BIRuZf/mrITNMEUK+jlud//rGG9DPo8v
        wolGNHP7g7BLFcaTeoJTv19wJmjLofCDDYqbS/2q+IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=DBtTXH
        VPA+Wr0ijtQc0zEOB0AeMZi4CSX7Dpb4AW0zw=; b=HXl/DnvSyee+swrOUuU+us
        oyIDnF/Pj/zrxB807cWEKmuNVx6Tf6XzGBDaQBoLbRnlM5OeeDLjK4e7QKPNjwDf
        wPjjl0Fwa8b4hll38EMUWTR2Ajv12Qio2xYdTVZjVm/3bHwxiisB+2vy/0YHmO95
        18rPpq48wXyZKxZoUvUXSBOtGTDeZEi2bzFmQ6RRVP6rINgawcgAB18QBoGkIG1K
        QL8dJ7Crkdlj5SkmUpTCXn35XvndVAMPvJGyRm03HlTbOH2bk+HeEyUnew7XJO/M
        2opsw1FZlWrpGy7bqSc2wzl0+gA4za2KGWpjX+i6x+I4Gigz4lSurua90PkYowUQ
        ==
X-ME-Sender: <xms:PVHdXHECre6Df3zFwE7gDL99KN_tQnST11LFQrLVeuH7GMp6ug-QbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddttddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdludehmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvddurdeggedrvddvkedrvdefheenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:PVHdXMsoTLg_gE63BGfYPq3SgIkzGnfqFytUYr8j8EOZr4Kv5Es6RA>
    <xmx:PVHdXLUY_LTh6ZXutakhyL2sLyH2NuXaX2lEO1HEdhoj-lJ8kxOLaQ>
    <xmx:PVHdXM5Uwzto_cf5WzMKmbsUPUVV8hCIXmqaerqYTXj3jQCHBQPEIA>
    <xmx:PlHdXF8NY5URtKP4-85OO7UIIHy5T6z1oGBzmPPFBdcTQUoMmNVriA>
Received: from localhost (ppp121-44-228-235.bras2.syd2.internode.on.net [121.44.228.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id F2912103D7;
        Thu, 16 May 2019 08:02:04 -0400 (EDT)
Date:   Thu, 16 May 2019 22:01:23 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] kobject: Clean up allocated memory on failure
Message-ID: <20190516120123.GA25202@eros.localdomain>
References: <20190516000716.24249-1-tobin@kernel.org>
 <20190516064029.GA17068@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516064029.GA17068@kroah.com>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 08:40:29AM +0200, Greg Kroah-Hartman wrote:
> On Thu, May 16, 2019 at 10:07:16AM +1000, Tobin C. Harding wrote:
> > Currently kobject_add_varg() calls kobject_set_name_vargs() then returns
> > the return value of kobject_add_internal().  kobject_set_name_vargs()
> > allocates memory for the name string.  When kobject_add_varg() returns
> > an error we do not know if memory was allocated or not.  If we check the
> > return value of kobject_add_internal() instead of returning it directly
> > we can free the allocated memory if kobject_add_internal() fails.  Doing
> > this means that we now know that if kobject_add_varg() fails we do not
> > have to do any clean up, this benefit goes back up the call chain
> > meaning that we now do not need to do any cleanup if kobject_del()
> > fails.  Moving further back (in a theoretical kobject user callchain)
> > this means we now no longer need to call kobject_put() after calling
> > kobject_init_and_add(), we can just call kfree() on the enclosing
> > structure.  This makes the kobject API better follow the principle of
> > least surprise.
> > 
> > Check return value of kobject_add_internal() and free previously
> > allocated memory on failure.
> > 
> > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> > ---
> > 
> > Hi Greg,
> > 
> > Pretty excited by this one, if this is correct it means that kobject
> > initialisation code, in the error path, can now use either kobject_put()
> > (to trigger the release method) OR kfree().  This means most of the
> > call sites of kobject_init_and_add() will get fixed for free!
> > 
> > I've been wrong before so I'll state here that this is based on the
> > assumption that kobject_init() does nothing that causes leaked memory.
> > This is _not_ what the function docs in kobject.c say but it _is_ what
> > the code seems to say since kobject_init() does nothing except
> > initialise kobject data member values?  Or have I got the dog by the
> > tail?
> 
> I think you are correct here.  In looking at the code paths, all should
> be good and safe.
> 
> But, if you use your patch, then you have to call kfree, and you can not
> call kobject_put(), otherwise kfree_const() will be called twice on the
> same pointer, right?  So you will have to audit the kernel and change
> everything again :)

Oh my bad, I got so excited by this I read the 'if (name) {' in kobject
to be guarding the double call to kfree_const(), which clearly it doesn't.

> Or, maybe this patch would prevent that:
> 
> 
> diff --git a/lib/kobject.c b/lib/kobject.c
> index f2ccdbac8ed9..03cdec1d450a 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -387,7 +387,14 @@ static __printf(3, 0) int kobject_add_varg(struct kobject *kobj,
>  		return retval;
>  	}
>  	kobj->parent = parent;
> -	return kobject_add_internal(kobj);
> +
> +	retval = kobject_add_internal(kobj);
> +	if (retval && !is_kernel_rodata((unsigned long)(kobj->name))) {
> +		kfree_const(kobj->name);
> +		kobj->name = NULL;
> +	}
> +
> +	return retval;
>  }
>
>  /**
> 
> 
> But that feels like a huge hack to me.

I agree, does the job but too ugly.

> I think, to be safe, we should
> keep the existing lifetime rules, as it mirrors what happens with
> 'struct device', and that is what people _should_ be using, not "raw"
> kobjects if at all possible.

Oh, I wasn't seeing this through the eyes of a driver developer, perhaps
I should have started in drivers/ not in fs/ 

> Yeah, I know filesystems don't do that, my fault, I never thought a
> filesystem would care about sysfs all those years ago :)

Tough business that, predicting the future.

Let's drop this and I'll keep plugging away.

Thanks,
Tobin.
