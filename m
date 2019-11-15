Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284A9C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE84920723
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RgkFP3a9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfKOQtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:49:05 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35022 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfKOQtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:49:04 -0500
Received: by mail-pg1-f196.google.com with SMTP id k32so553833pgl.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 08:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VLpzj5GM/mlBjL0K2sCFmpTMFSROa82RYmL4861eSc0=;
        b=RgkFP3a9s426OYYkZ7W21MD1zAotJvoKIJcOx8fEGlAapE+TfvDLycmtw0489eXEiW
         Fl4qZmK8/64lup/wMwN3kesYT96O/AbpCg4kKCpfpZNM3t0JygH/7aRhN85B9VNN+TOD
         1U2MWrHiTYG9FXUsiFNTenULOK35swEYq9okE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VLpzj5GM/mlBjL0K2sCFmpTMFSROa82RYmL4861eSc0=;
        b=aN4fIyNCNwCH/aAyyrDSmW/BCHbkx9TMgyoU6RgR/5VZHwqO9L+DKAmOe6XIqHIcxI
         ov7cjgAugDCzpe9ZnAUB/cP6BKL8P5e9GIwTBnIH9y2HrXMhAmjhZKPSC0ValZzOvWej
         rYjsY44aypipd4PGkdLwNSxnsWZdRxgTpDiNTIhF5RiB4PH/QmXTS5KXjpvFy8FpQWW/
         dl00EJYDrMprUJUd3yKuyvneVXxHg9euyJRLacXMGtHaE+3NXruv6hXyeqgo9TcbjDUL
         ElD+yLBRm8rAhKQayw6pKXzOy2G2thmctMDzY0Y5QpsdAzd8P7I1n6oRQIl6hXH2SZNu
         9gbA==
X-Gm-Message-State: APjAAAWGMAlF6Q3lf1QILRy6n2aSLGepKwh01YYtyKUeQ//6ezV3VP4F
        zNCskQgD6A2tmtyHllB6q+fm/A==
X-Google-Smtp-Source: APXvYqzK/lcD05IQBl/MSOo179tz+tQRcqFgCWgHTRpFQFjaLXWwuRaGkmv3yTQ5UcYy81I/Mzn1Vw==
X-Received: by 2002:a63:4961:: with SMTP id y33mr2498326pgk.264.1573836543743;
        Fri, 15 Nov 2019 08:49:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v15sm11235459pfe.44.2019.11.15.08.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 08:49:02 -0800 (PST)
Date:   Fri, 15 Nov 2019 08:48:55 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        Romain Perier <romain.perier@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] staging: rtl*: Remove tasklet callback casts
Message-ID: <201911150848.12F713465F@keescook>
References: <201911142135.5656E23@keescook>
 <20191115074003.GB19101@kadam.lan>
 <20191115074235.GJ19079@kadam.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115074235.GJ19079@kadam.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 10:42:35AM +0300, Dan Carpenter wrote:
> On Fri, Nov 15, 2019 at 10:40:03AM +0300, Dan Carpenter wrote:
> > On Thu, Nov 14, 2019 at 09:39:00PM -0800, Kees Cook wrote:
> > > In order to make the entire kernel usable under Clang's Control Flow
> > > Integrity protections, function prototype casts need to be avoided
> > > because this will trip CFI checks at runtime (i.e. a mismatch between
> > > the caller's expected function prototype and the destination function's
> > > prototype). Many of these cases can be found with -Wcast-function-type,
> > > which found that the rtl wifi drivers had a bunch of needless function
> > > casts. Remove function casts for tasklet callbacks in the various drivers.
> > > 
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > 
> > Clang should treat void pointers as a special case.  If void pointers
> > are bad, surely replacing them with unsigned long is even more ambigous
> > and worse.
> 
> Wow...  Never mind.  I completely misread this patch.  I am ashamed.

Okay, whew. I was starting to try to wrap my brain around what you
meant and was failing badly. :)

> The patch is fine.
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks!

-Kees

> 
> regards,
> dan carpenter
> 

-- 
Kees Cook
