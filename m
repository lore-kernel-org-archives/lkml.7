Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709DDC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391792087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555337520;
	bh=gcig8tQvuJQ2Zaq4gjMVfhh1z+am7vushJ9UuXuTnKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u9UaIZ43bHj3l7oD+PQXCV68CjE9hwiwE5Pu30UKBP6tpIdMzJpN5MCZhQjhZbDfs
	 qWmQyh017vLXVenbHiFZV/2OrSe5dfmoZ1cLUqzqohqKY/YizmnCHADuQUDX8QErt1
	 vF6ocH9H3wwADcdRPnZ7JetZFbFrjFj72ImeQNj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfDOOL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:11:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43311 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfDOOL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:11:58 -0400
Received: by mail-lf1-f67.google.com with SMTP id i68so2293472lfi.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 07:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a/Cm9bjo/9gQ+7QGLIjN6MIP4REU5IXwrX9H2jwE70M=;
        b=jHseaBJx2gAGN8DwALlUiHVECI+ethPep3QQp+x/9rQ4C+OY6GoxyowO1+0xcITyQD
         psGRta+zMgZx/FL0BXKNtQszz/VX+GJr4TTr9ZnVrTapVApkeOV38/RCWe4ia3JPGVSV
         Vyu3v6CAi0Gop1A0RHRbxEiRXi39QG6VcCW1g4hwfn/VNFA5Dij5gqpFkaC/X1NReUmn
         ePdgcps3dq42kz1ph+52uFFP0wFhLaFggAW9bOKyTGdvTlywEbEJ1ssky3dTeC+ov5dx
         X0bZiEvSxgYERglejuEqVjsX5VsSDfPxO9qI5u5FMK0ZbLk5vWVjKj9bTAD3oQ6XHe0W
         dJ+Q==
X-Gm-Message-State: APjAAAU/4iEPycQ7vf7maUcXGAkF5wxG8J8Nbq1m8WISM1UBB/MbIyvb
        GwQ0BqekdH+kFw2RfAR4VK0=
X-Google-Smtp-Source: APXvYqx09vmJttxorV9vWpoRcom+6wOMscpA3d8SjAyp+uYWcgYfbXJZ3wAR2Pouj9ksj0W+z9tERQ==
X-Received: by 2002:a19:ae0a:: with SMTP id f10mr38570223lfc.118.1555337517026;
        Mon, 15 Apr 2019 07:11:57 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id c17sm2835575lfm.42.2019.04.15.07.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:11:55 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hG2L3-0002py-1k; Mon, 15 Apr 2019 16:12:01 +0200
Date:   Mon, 15 Apr 2019 16:12:01 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        devel@driverdev.osuosl.org, elder@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org
Subject: Re: [PATCH] Staging: greybus: Cleanup in header file control.h
Message-ID: <20190415141201.GD775@localhost>
References: <20190405201437.3689-1-madhumithabiw@gmail.com>
 <20190415131002.GC775@localhost>
 <20190415133357.GP6095@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415133357.GP6095@kadam>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 04:33:57PM +0300, Dan Carpenter wrote:
> On Mon, Apr 15, 2019 at 03:10:02PM +0200, Johan Hovold wrote:
> > On Fri, Apr 05, 2019 at 03:14:37PM -0500, Madhumitha Prabakaran wrote:
> > > Fix a blank line after function/struct/union/enum
> > > declarations. Also, convert to_gb_control()  macro into an inline
> > > function in order to maintain Linux kernel coding style based
> > > on which the inline function is preferable over the macro.
> > 
> > There are about 1200 macros wrapping container_of() in the kernel, so
> > this is a common pattern which does not need to be changed (by contrast,
> > only a handful container_of are wrapped by functions).
> > 
> 
> A handful?
> 
> $ git grep "return container_of" | wc -l
> 1856
> 
> I'm like Donald Trump because I must have really small hands compared
> to the rest of y'all.

Heh, you're right, my grep-fu failed me.

Ok, so both styles are roughly as common (and a non-trivial portion of
those 1800 also are not simple wrappers).

> I would prefer to apply these sorts of patches unless it causes an
> issue...  Functions *are* better than macros.  It's a minor improvement,
> but this is staging and we make tons minor style changes.  It's part of
> the blessing and curse of being in staging...

While I agree functions are generally preferred, container_of() is
special as it includes type checking.

And again, using container_of() like this is a common pattern in the
kernel.

Johan
