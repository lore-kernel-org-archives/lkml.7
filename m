Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F08C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABF9208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="UMf5oONS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="24W6q/NP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfEMKtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:49:00 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:47599 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728133AbfEMKtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:49:00 -0400
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 May 2019 06:48:59 EDT
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 4C01C30D;
        Mon, 13 May 2019 06:40:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 13 May 2019 06:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=WApew/vuxJIVZtbLL/hzndegcPF
        zwFvShwAPmp+eSVw=; b=UMf5oONS/DFmzS5SYtP1oefeJJtM75U5GxD1sqM8G36
        Ssd+pl3UkYGqMtVK1wGA4W7fm6eaRYv4wSo4234Pby9eppUqXk3na7zS75Bx9i3I
        IYlsZGNMi3se89ciebk5i0O2Q9zycJWtRmZZth2wVIjadbheztqCZGfUUJbUvrWJ
        KGuUCHLc2XS2DaPd8ufTVQwaqcKMdrIw/CHQWG5i6vYjzn8m6r5xKVumjEyUDGsy
        KOS/ugG4lSwdtjwYUVutVmqG/oQZwHRFXLB+wJybshUlAXJ83keLWLeAxqxJaNLd
        sExE+oFqAYaf9TLh514XjBou61y7YAEkBfuFK1kSusw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=WApew/
        vuxJIVZtbLL/hzndegcPFzwFvShwAPmp+eSVw=; b=24W6q/NP/SFakj5ZCoiGVv
        SEdjFX1uZ/mBVHoSbdp5gK1h6IjeJwq2n0X9ZCJALxSZMiEvF9W+bnVpxbpj0aJ+
        qOTWF3Ltogn09ptqVyKRgxPNt2PeKRbTnU0Bg+Pab975sMY9y6f4kFe/dyNmeoNM
        TZZ8TuRbGHJXSdRi3ekmdj7Re5lOODWFqrOMUwvsBhwSU3n5PlEwhqdfmwKZGtU1
        eHXh/tOE8af+mFWxAdX+XFG3hsZIhSQFEjYfEJXZ0NZQDkgWh7M6R6OGBBWCqPVx
        ZRYfFem/MkYG5qqwXEsH/t58tnnnXh0UzmYg1TnlpMZB4kkkznXXsXFtAtT93y/g
        ==
X-ME-Sender: <xms:oEnZXGJBEYRY3jLjzBu_7d93obVCWIoxjD40Ad0bGwjcvZjdRTeCsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleeggdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdduhedmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddvgedrudeiledrudeirddukeehnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:oEnZXE4rpE1JjAe9wFG_jPXkjsmajRj4XqNfes1Z53jmQE4WRGsnYg>
    <xmx:oEnZXPiQFp6beyvTFhkCumt-pM5rBhXanuNBO04tGmezRPSfuKWaRg>
    <xmx:oEnZXAG3-60dlihvqnuEOg-CiHcXY7HcWk4SwPa_au2jRqTorT7FRw>
    <xmx:oEnZXOpmeuZHjYu2KPeZPJ7q7mXJ-MyD-HJLX8Dlm8n2V_7g_Z1jwg>
Received: from localhost (124-169-16-185.dyn.iinet.net.au [124.169.16.185])
        by mail.messagingengine.com (Postfix) with ESMTPA id C537F80063;
        Mon, 13 May 2019 06:40:31 -0400 (EDT)
Date:   Mon, 13 May 2019 20:39:36 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gfs2: Fix error path kobject memory leak
Message-ID: <20190513103936.GA15053@eros.localdomain>
References: <20190513033213.2468-1-tobin@kernel.org>
 <20190513071405.GF2868@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513071405.GF2868@kroah.com>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 09:14:05AM +0200, Greg Kroah-Hartman wrote:
> On Mon, May 13, 2019 at 01:32:13PM +1000, Tobin C. Harding wrote:
> > If a call to kobject_init_and_add() fails we must call kobject_put()
> > otherwise we leak memory.
> > 
> > Function always calls kobject_init_and_add() which always calls
> > kobject_init().
> > 
> > It is safe to leave object destruction up to the kobject release
> > function and never free it manually.
> > 
> > Remove call to kfree() and always call kobject_put() in the error path.
> > 
> > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> > ---
> > 
> > Is it ok to send patches during the merge window?
> > 
> > Applies on top of Linus' mainline tag: v5.1
> > 
> > Happy to rebase if there are conflicts.
> > 
> > thanks,
> > Tobin.
> > 
> >  fs/gfs2/sys.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> > 
> > diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
> > index 1787d295834e..98586b139386 100644
> > --- a/fs/gfs2/sys.c
> > +++ b/fs/gfs2/sys.c
> > @@ -661,8 +661,6 @@ int gfs2_sys_fs_add(struct gfs2_sbd *sdp)
> >  	if (error)
> >  		goto fail_reg;
> >  
> > -	sysfs_frees_sdp = 1; /* Freeing sdp is now done by sysfs calling
> > -				function gfs2_sbd_release. */
> 
> You should also delete this variable at the top of the function, as it
> is now only set once there and never used.

Thanks, I should have gotten a compiler warning for that.  I was feeling
so confident with my builds this morning ... pays not to get too cocky
I suppose.

> With that:
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks, will re-spin.

	Tobin.
