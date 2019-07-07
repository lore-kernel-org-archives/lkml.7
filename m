Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCF2C48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 14:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449B0206A2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 14:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CwB7zMo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfGGOYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 10:24:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33890 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfGGOYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 10:24:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so6889503plt.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 07:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RzgqI621aWGbDHGCfudOESl9Mn0+99CKDMGTJU72pEQ=;
        b=CwB7zMo8m+w+lYJl2AfFe4HLR6Af2kKEyirdj9kyWsC7IuEg47plHvVYVf7qJZN6zl
         WC15Aw1sKoacOYgHqBYdZDpY78sPn9+yY46HBFwrVctnLEODvL6dYPImuk1dhzlqyM6/
         LrJIonOcgzJRi8yLkivwfPhfI8s0uUdmlL2fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RzgqI621aWGbDHGCfudOESl9Mn0+99CKDMGTJU72pEQ=;
        b=CrK+DekTU3D4SJikA6ehhz209fwYX4YT3QU0W9Zy6BS19bHkK9DiDyVzNR/nXxuGZy
         +PKcpKHMF3Gw52YX9fxXZzLT3jfywlTOHr04XxEqHjCgavsIkzsuCRLCuXDsE0j7wXyW
         gGzLcjumQWQZhq8MdV2XgzYJOMIMFIYFRH1AjCIyec4IFyKXAx/VO33p9ecesGNUDwr2
         dasI01a9llB4f1f/eGbWjXpXZiYRJ6sKCpz4Tb4jFyTdAG95JLI2mPBXXh6aRW9uiW48
         W9IkU1kO+19xElX1kR3y2TiCStg7DDiog+yNK/gWuE/VTRn6dzAQOPBJoqmgunb+XUMK
         dj3g==
X-Gm-Message-State: APjAAAWEiyO6XaqeNB9c6P/pr+zoeeHbKOh/3YiJ23ki8frvsoO2RFL7
        3HaxW+UBBjwislKJHK0ydi2f+Lr8Yxk=
X-Google-Smtp-Source: APXvYqx/KLfLzgxok3IhCJQT8wSp+mQC4QkBTbVOByzEJOpol9aJ+serMXQ14efyX1cj2R2UxTTeNA==
X-Received: by 2002:a17:902:e40f:: with SMTP id ci15mr17885407plb.103.1562509485880;
        Sun, 07 Jul 2019 07:24:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b29sm30544119pfr.159.2019.07.07.07.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Jul 2019 07:24:44 -0700 (PDT)
Date:   Sun, 7 Jul 2019 07:24:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        fbuergisser@chromium.org, linux-kernel@vger.kernel.org,
        ZhiChao Yu <zhichao.yu@rock-chips.com>
Subject: Re: [PATCH v2 2/2] media: hantro: Add support for VP8 decoding on
 rk3288
Message-ID: <201907070704.D6C5A32D@keescook>
References: <20190702170016.5210-1-ezequiel@collabora.com>
 <20190702170016.5210-3-ezequiel@collabora.com>
 <1562164006.4604.7.camel@pengutronix.de>
 <20190704091934.3524f019@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704091934.3524f019@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 09:19:34AM +0200, Boris Brezillon wrote:
> Hm, I fear we have the same problem in other places (including the
> patch series adding support for H264). Kees, I wonder if there's some
> kind of safe array iterator macro, something like
> 
> #define for_each_static_array_entry_safe(_array, _iter, _max_user) 		\
> 	_max_user = min_t(typeof(_max_user), _max_user,	ARRAY_SIZE(_array));	\
> 	for (_iter = 0; _iter < _max_user; _iter++)

This seems like a good idea to add, yes. As you've hinted in the macro
name, it won't work for allocated arrays (though perhaps we could add
support for such things with some kind of new array allocator that
included the allocation count, but that's a separate issue).

I bet static analysis could find cases to use for the above macro too.

> The problem with this approach is that it's papering over the real
> issue, which is that hdr->num_dct_parts should be checked and the
> driver/core should return an error when it's > 7 instead of silently
> iterating over the 8 entries of the dct[] arrays. Static code analysis
> tools can probably detect such issues too.

To avoid the papering-over bit, the macro could be like this instead,
where the clamping would throw a WARN():

#define clamp_warn(val, lo, hi)	({		\
	typeof(val) __val;			\
	__val = clamp_t(typeof(val), lo, hi);	\
	WARN_ONCE(__val != val);		\
	__val })

#define for_each_static_array_entry_safe(_array, _iter, _max_user) \
	_max_user = clamp_warn(_max_user, 0, ARRAY_SIZE(_array)); \
	for (_iter = 0; _iter < _max_user; _iter++)

This does have the side-effect of clamping _max_user to
ARRAY_SIZE(_array), though that might be good in most cases?

(Also, is the "entry_safe" name portion the right thing here? It's not
doing anything "safe" like the RCU versions, and there is no "entry"
since the expectation is to use the _iter value?)

> Any advice on how to detect such problems early on?

Doing static analysis on this means a tool would need to know the range
of values coming in. I wonder if Coverity noticed this problem?

-- 
Kees Cook
