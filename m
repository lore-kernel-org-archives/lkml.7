Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9B5C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 12:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2BE2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 12:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jrDdmOLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfECMJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 08:09:39 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39187 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbfECMJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 08:09:38 -0400
Received: by mail-ed1-f67.google.com with SMTP id e24so5729355edq.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 05:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=S4dUYvdv3n+Bba45FIMfVM65qgsyOxnhGJChibzqN60=;
        b=jrDdmOLqPgT269Ux3Ti6Ab8JHcj7LLbFX43fyq0OzF8wPEtpJ0dO22tKhM3wi0IduX
         U1Yn+VxM34ZWbPwXaZd23V0NxQhtN1WWHx8SIPPdiDgpTMGTkpZVVlcrlA4V/So7djwc
         Pmy/BtwrIQ9KvEsdrRxatfFdvK+car/jY9724=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=S4dUYvdv3n+Bba45FIMfVM65qgsyOxnhGJChibzqN60=;
        b=A5JjGnQRUmVZauGjsOlMPQlPjRX7ZmvIEi4mk0J0aMFAEdOTAyl5POEPyJVAJRJFoP
         07W83s6fUsmByX1r2Me8+4Hw+ioKdPMfhXZkiilatzgB22dG6WggAdqx5BzS8Hd0q3or
         /J4KUdLdpxRUEE6DCHjz8micg9enKeJ7FEDcFC06ehMDDY/TWZSW01Bw3eXk/iwzDMJQ
         IosdyySnYacMUVp1NmzAmGQ+rSJIP7KYpVyyBOPC7wRxLco93x4IVllA21AQcpOgxWFY
         Wau9D3JPRIQq4S8yuzt4MVK5yeeZrjOgrW4kBZkM3scYaf07p886NySW43nj5DocYrdB
         sdIg==
X-Gm-Message-State: APjAAAVQR0tcXlTD/14r4DkKRq9RoB/TfHGasTgT2UBoB0vMZ19zfItw
        vM+ThCy+kQePkll0sANSiS9r3g==
X-Google-Smtp-Source: APXvYqzutv0kBeLPRSf1mYqF7ThJDw1eInlX1KNGRL/6/Tt5e7oryS7GRROhuh60qmoGV8akzi+19Q==
X-Received: by 2002:a17:906:59c3:: with SMTP id m3mr5824761ejs.167.1556885376639;
        Fri, 03 May 2019 05:09:36 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id i61sm536332edi.5.2019.05.03.05.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 05:09:35 -0700 (PDT)
Date:   Fri, 3 May 2019 14:09:33 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     christian.koenig@amd.com
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        maxime.ripard@bootlin.com, dri-devel@lists.freedesktop.org,
        digetx@gmail.com, sumit.semwal@linaro.org,
        m.szyprowski@samsung.com, devel@driverdev.osuosl.org,
        sstabellini@kernel.org, arnd@arndb.de, jonathanh@nvidia.com,
        tomi.valkeinen@ti.com, xen-devel@lists.xenproject.org,
        linux-media@vger.kernel.org, pawel@osciak.com,
        intel-gfx@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        boris.ostrovsky@oracle.com, mchehab@kernel.org, jgross@suse.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        kyungmin.park@samsung.com
Subject: Re: [Intel-gfx] [PATCH] dma-buf: add struct dma_buf_attach_info v2
Message-ID: <20190503120933.GL3271@phenom.ffwll.local>
Mail-Followup-To: christian.koenig@amd.com,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        maxime.ripard@bootlin.com, dri-devel@lists.freedesktop.org,
        digetx@gmail.com, sumit.semwal@linaro.org, m.szyprowski@samsung.com,
        devel@driverdev.osuosl.org, sstabellini@kernel.org, arnd@arndb.de,
        jonathanh@nvidia.com, tomi.valkeinen@ti.com,
        xen-devel@lists.xenproject.org, linux-media@vger.kernel.org,
        pawel@osciak.com, intel-gfx@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, boris.ostrovsky@oracle.com,
        mchehab@kernel.org, jgross@suse.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, kyungmin.park@samsung.com
References: <20190430111002.106168-1-christian.koenig@amd.com>
 <20190430173127.k5ivpaz6ktbfecgo@shell.armlinux.org.uk>
 <cbcbb076-a8b0-67b0-8c16-daf1d060fc1d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbcbb076-a8b0-67b0-8c16-daf1d060fc1d@gmail.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 02:05:47PM +0200, Christian König wrote:
> Am 30.04.19 um 19:31 schrieb Russell King - ARM Linux admin:
> > On Tue, Apr 30, 2019 at 01:10:02PM +0200, Christian König wrote:
> > > Add a structure for the parameters of dma_buf_attach, this makes it much easier
> > > to add new parameters later on.
> > I don't understand this reasoning.  What are the "new parameters" that
> > are being proposed, and why do we need to put them into memory to pass
> > them across this interface?
> > 
> > If the intention is to make it easier to change the interface, passing
> > parameters in this manner mean that it's easy for the interface to
> > change and drivers not to notice the changes, since the compiler will
> > not warn (unless some member of the structure that the driver is using
> > gets removed, in which case it will error.)
> > 
> > Additions to the structure will go unnoticed by drivers - what if the
> > caller is expecting some different kind of behaviour, and the driver
> > ignores that new addition?
> 
> Well, exactly that's the intention here: That the drivers using this
> interface should be able to ignore the new additions for now as long as they
> are not going to use them.
> 
> The background is that we have multiple interface changes in the pipeline,
> and each step requires new optional parameters.
> 
> > This doesn't seem to me like a good idea.
> 
> Well, the obvious alternatives are:
> 
> a) Change all drivers to explicitly provide NULL/0 for the new parameters.
> 
> b) Use a wrapper, so that the function signature of dma_buf_attach stays the
> same.
> 
> Key point here is that I have an invalidation callback change, a P2P patch
> set and some locking changes which all require adding new parameters or
> flags. And at each step I would then start to change all drivers, adding
> some more NULL pointers or flags with 0 default value.
> 
> I'm actually perfectly fine going down any route, but this just seemed to me
> simplest and with the least risk of breaking anything. Opinions?

I think given all our discussions and plans the argument object makes tons
of sense. Much easier to document well than a long list of parameters.
Maybe we should make it const, so it could work like an ops/func table and
we could store it as a pointer in the dma_buf_attachment?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
