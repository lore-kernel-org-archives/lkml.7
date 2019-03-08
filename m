Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE57EC10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907952146F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="SG7C/hir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfCHQWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:22:41 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34793 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfCHQWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:22:40 -0500
Received: by mail-yw1-f68.google.com with SMTP id u205so16745878ywe.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 08:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WzKuwNcoBCL9U3oKIOmrzCFFAxc+z1LWxRP1k9/QX/E=;
        b=SG7C/hirBfsngAx8tMYp7iQ2Mn1Ob3ERIllqoGDkUqsdKmlsr3niO9F1qYEdWlXJT5
         5huxqo+SBPoSaFESP33Fr+t4Rzc7tBcT53NFWE97GDftecwMEGLtMcJEKzTlYzhpLnjp
         PuLBtdeQPLuJdl/1xPm2jytSmlRCT7HODg/Q4SaxZOhoIjCr+nOrurOhGAUQvxjBushv
         VSshXN4DTpsbkqebvP8BaJ2f/1P8BVWJKOUfKhPy+hFhz8NyRj2qwYNuhG8S+244L3mg
         2rsJQLWJNet7OgegqzSPFhMr6SnTVwIdJM6Qx0Qe8hkfgjqe61Vb5dvKJ37kp0Yb39/1
         JBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WzKuwNcoBCL9U3oKIOmrzCFFAxc+z1LWxRP1k9/QX/E=;
        b=YO3tgHsi/hRF+3kdmu826iwARysWtSZggYfHoxPJsXEMuxziBbuHKiGOINlW0ZSBV6
         BDzqvNiH1mn8bp8oYRLlJg3gzMDm8ltLstLWfWYvc/Fg+V2DsW2lq6LzCqh4gjQWzD2a
         MxpJV8TYIbQ2iXnmqf5odIhTqOm3HFnco9NcptAi6hPqpcwgGBhnFY3OSZY5cezA3hdr
         AVLdGWQXf+luMDpc6+s8nOU1wPcthc8pecfTQhko6Ekq06M1+pDWmgHhUNKTO3AzjMvI
         28UGaGi5lw8dIBeoVLnynZwqpPB8nZdLVA73d6PCQh5olos3U/AgrwA+ZC/pE0jD5CKY
         jqWQ==
X-Gm-Message-State: APjAAAV6ZSLxafcX9aSwDz62R2QqxwpwW+1WlUitWPoL2lGY7vr4dv2f
        vDb75t89tDki5y3+FXSzp3Cx5tjnrRc=
X-Google-Smtp-Source: APXvYqybyQpoib8PQzxv71EAfMfQyD8hak5sv0O2aTEddKGWaVGDr90e5pRzxkWR369jDKk+hsc2Jw==
X-Received: by 2002:a81:78d6:: with SMTP id t205mr15398565ywc.181.1552062159853;
        Fri, 08 Mar 2019 08:22:39 -0800 (PST)
Received: from cisco ([2601:282:901:dd7b:316c:2a55:1ab5:9f1c])
        by smtp.gmail.com with ESMTPSA id h204sm3082190ywh.52.2019.03.08.08.22.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 08:22:39 -0800 (PST)
Date:   Fri, 8 Mar 2019 09:22:37 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christopher Lameter <cl@linux.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 02/15] slub: Add isolate() and migrate() methods
Message-ID: <20190308162237.GD373@cisco>
References: <20190308041426.16654-1-tobin@kernel.org>
 <20190308041426.16654-3-tobin@kernel.org>
 <20190308152820.GB373@cisco>
 <010001695e16cdef-9831bf56-3075-4f0e-8c25-5d60103cb95f-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010001695e16cdef-9831bf56-3075-4f0e-8c25-5d60103cb95f-000000@email.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 04:15:46PM +0000, Christopher Lameter wrote:
> On Fri, 8 Mar 2019, Tycho Andersen wrote:
> 
> > On Fri, Mar 08, 2019 at 03:14:13PM +1100, Tobin C. Harding wrote:
> > > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > > index f9d89c1b5977..754acdb292e4 100644
> > > --- a/mm/slab_common.c
> > > +++ b/mm/slab_common.c
> > > @@ -298,6 +298,10 @@ int slab_unmergeable(struct kmem_cache *s)
> > >  	if (!is_root_cache(s))
> > >  		return 1;
> > >
> > > +	/*
> > > +	 * s->isolate and s->migrate imply s->ctor so no need to
> > > +	 * check them explicitly.
> > > +	 */
> >
> > Shouldn't this implication go the other way, i.e.
> >     s->ctor => s->isolate & s->migrate
> 
> A cache can have a constructor but the object may not be movable (I.e.
> currently dentries and inodes).

Yep, thanks. Somehow I got confused by the comment.

Tycho
