Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4CAC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 22:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4312081C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 22:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l6Twn3Uj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfEVWUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 18:20:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42181 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfEVWUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 18:20:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id e17so1861174pgo.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 15:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zKpoS8ChVauG/b5jE7jdGLek9tzNeFPqv0E/OMjWjmE=;
        b=l6Twn3UjulqQqYjQ1sV1Om600H5NzmMO9lU7YFqwo77Q3wEt3NpC2jGlLXf606OARJ
         u5179gymw9vrMKnbwCTv3rehfAly651iOeW71m1DadeWX4CicN1zq9VWAolyQFIs7fHo
         Av9uo86ofFN6IiAIpEWhPjsElNYdgRQbdvBI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zKpoS8ChVauG/b5jE7jdGLek9tzNeFPqv0E/OMjWjmE=;
        b=Z7zJpk3Xw9IEy5Pe3glLZS3ZqSO2JEBej7psvCIaX/3sBKlMv0E49hvSUex1ddvQP5
         eMlWZGQDd4fFTzfRQwkAOl+s8cOCyGUsqjsWeesnk9kPDAcj4L8lWEuoq3KLqt6GxORz
         ub6mag8AJ+A08ggOZaXV6UCXPnTLKeWonkklcVxQbK/QT1IrvZj5DTykI35scRcEFIkn
         3gdogl8B0ivpvF7KlYvKxyn5agg2lBzUHpXLuv/4dp4diP20bRyv9uPKLSIFKsPDMZAI
         J8R+JEkf8mVcW+gAlT+2yTJVFqgMfoO4maDTW4FzQkWHU0Iy5lwSRjHfL4JqNzrEK3sA
         Yqrg==
X-Gm-Message-State: APjAAAVS0rzk2is7fYG0SmeMOOBfHea9QxfWF8EK6NZJPi7x+LlUtrK4
        MqTLHt4/VgJw/EAdcVqbqqqpwQ==
X-Google-Smtp-Source: APXvYqw7vBRQoH+FD/trwikHaC065wEINOozIgtwVa9U9ZyvIo0eWI2fuUR7x4j3CWWXadtR698Bjg==
X-Received: by 2002:a63:ed03:: with SMTP id d3mr92213341pgi.7.1558563608854;
        Wed, 22 May 2019 15:20:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x16sm28300353pff.30.2019.05.22.15.20.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 15:20:07 -0700 (PDT)
Date:   Wed, 22 May 2019 15:20:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: onenand_base: Avoid fall-through warnings
Message-ID: <201905221519.88B9364E@keescook>
References: <20190522180446.GA30082@embeddedor>
 <201905221403.642AF6092@keescook>
 <20190522235738.68059906@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522235738.68059906@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 11:57:38PM +0200, Boris Brezillon wrote:
> All this look suspicious, and even if the fall through logic
> has no side effects in practice (which I'm still not sure is the case),
> I think it'd be better to explicitly set the flags that have
> to be set in each case statement and add breaks.

Yeah, totally agreed. :)

-- 
Kees Cook
