Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD5BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752D3206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cF6XD1Wl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfDCPvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:51:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46982 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDCPvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b8EV1FU1KtxS5VUBJIw2LK74C68X9x+liGtGIWP4qkc=; b=cF6XD1Wl+rgdWAWivEAHb0F/D
        ptPjHdIEsXMVSi2kiUUTleE6jY8chPyaeXbo5x+RPtA5HVY4UJEvwexKs6b8NzkUJPdzLeRfLQ+i5
        70L223UWwEnMmEflTOznbhc4dxjYQqIkK3ZWIxo/s9D59Pnfb8+6AjsAQNWzAAgi7RXMWTphQEwOZ
        kF2Si5yEbaWrjBrdunVLdQKF3+WRI0MrbCEWr2zy3XOByoNsy5O70dX5Yeb/53a7dMKiwtrNw4obz
        4ls91P7LV7apCT9JwzUcCdf65Zt6BK3+gULXW2tdDKlV/QD+nh78rtM6pSNTTK4om3r8zO3+m/bv7
        OrBXJkqdA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBiAP-0004CK-1D; Wed, 03 Apr 2019 15:51:09 +0000
Date:   Wed, 3 Apr 2019 08:51:08 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Zev Weiss <zev@bewilderbeest.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kernel/sysctl.c: fix out of bounds access in fs.file-max
Message-ID: <20190403155108.GI22763@bombadil.infradead.org>
References: <20190328130306.25384-1-mcroce@redhat.com>
 <20190403140203.qq37rgcikvoawb5f@brauner.io>
 <CAGnkfhx+igF579dez6qwAxrtT-JrGSSEn-QmK+92447qBqXPpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGnkfhx+igF579dez6qwAxrtT-JrGSSEn-QmK+92447qBqXPpg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 05:24:26PM +0200, Matteo Croce wrote:
> On Wed, Apr 3, 2019 at 4:02 PM Christian Brauner <christian@brauner.io> wrote:
> > Yeah, maybe but it still feels cleaner and more obvious to just add:
> >
> > static long long_zero;
> >
> > given that most callers actually seem to want an (unsigned) int.
> >
> > I don't have a strong opinion though so if others feel that it's just a
> > waste of space consider it acked.
> >
> 
> Well, given that the value is zero, in this expectional case we could
> avoid duplicating the symbol and save 4 bytes.
> What the maintainers think?

If we care about saving four bytes, we could just pass the address of
ZERO_PAGE(0).
