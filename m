Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492A6C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 15:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC1A2133F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 15:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pVH267jY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfHXPev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 11:34:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbfHXPeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 11:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W1bsgj1Sca3htwVdYIWXqEWmqM9LY1dN32Kg3V5BUGw=; b=pVH267jYHrY9C0dLkasvLQUnv
        XRUmXAshW9tv13hBRLy6H/LTmuONxFCE1hCZ7p0i6yViURRqo1N1o/+7MCuRv79mXq0MXoJMxo31y
        emLqD40QOZAgz/bhxWHJN8Fp1B/S5AkjLnLQo0mpSHgzfKfTASJruuOTG0q9z7HWlqmn6YB1iHq6s
        ZBcRwJ2QjQ1ZWnOAeKpRof+T3azgnSHinCmKikmWMjJK/NgvkObBUBilSHC0OtoIV8UeWh+Lp/caq
        9yxJLeTNvkDCfA8LzBRE7YeJ06G8VItQoaUth8bBNK39VMuZRr6YwuQx/q7mC5kz2WFK7BzVS4e+V
        bWcJxPprw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i1Y3y-00048Y-Gc; Sat, 24 Aug 2019 15:34:46 +0000
Date:   Sat, 24 Aug 2019 08:34:46 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 2/2] fbdev: fbmem: allow overriding the number of bootup
 logos
Message-ID: <20190824153446.GB28002@bombadil.infradead.org>
References: <20190823084725.4271-1-peda@axentia.se>
 <20190823084725.4271-3-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823084725.4271-3-peda@axentia.se>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 08:47:47AM +0000, Peter Rosin wrote:
> +++ b/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -56,6 +56,9 @@ EXPORT_SYMBOL(num_registered_fb);
>  bool fb_center_logo __read_mostly;
>  EXPORT_SYMBOL(fb_center_logo);
>  
> +unsigned int fb_logo_count __read_mostly;
> +EXPORT_SYMBOL(fb_logo_count);

Why does this symbol need to be exported?  As I read the Makefile, fbcon
and fbmem are combined into the same module, so while the symbol needs
to be non-static, it doesn't need to be exported to other modules.

