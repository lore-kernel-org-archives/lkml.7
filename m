Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AB5C04AB1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 02:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F6C217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 02:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0TSM8lH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfEJC0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 22:26:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35244 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfEJC0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 22:26:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id h1so2209244pgs.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 19:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kqXfDpbTjqq2D4rvj6MIi1/UVJIivtHB0dzUZsY2dwQ=;
        b=T0TSM8lHwOYmmlWwit8HH7VnToZLALBZmnddnQhdn7c7ah33bZTGIP1/Fzye0FSoE3
         3t+zn6PcJfaFk08ed1z/PN7F6wPk+FSJ7N9cCnqDwHI1RyzaT2K5U0VoyxnjUeVT2jUB
         rpjR1Je7HAJfoptSm99PInaFjkRrxMQaQ7sBYmVBdG4g5arimNr/IKj2lIBWY0wmCOhA
         AUmeHo4Jl1Ba5uBbRrcUuzfAaCZXB4P3zRF/c7fRj0KfUouJVx0FD961uhiLfBPpI9te
         58AS/p5WQrdl0BTz3fYt10Ho7tnVJtKD3bTpoF51TbHiHUoodtFO67XNrpz+OMKK8IOq
         BZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kqXfDpbTjqq2D4rvj6MIi1/UVJIivtHB0dzUZsY2dwQ=;
        b=a+o5/mwd1gm364/vTIvu83Y/dlPgFgrGfAk0BcXgYeF02iSogdekW591Nd7aa56cvm
         4SSz1h8uzVsNAhoionJgZ3yVU5OEI7sFgXnP2cKwrPj07BSdw+x6KkwvRAYSSa3yM+wO
         Yg+kWd1lv0+o5Zjfl3IYiCEeY/AWxCWT5smWaI/+OhJtiCz6I6e9Z5Y4hxGRUqqwSXq2
         dsfJse/ZJdTzhDN4HWIYlnLQrD8vnP4UOSY10o85IShlyABczokYxBGL9hc6FRCJ0Ys+
         Kc62RhAlOkZ5/YsJwUv8YgfnESjAZfQEXvKWZcZ1huLMmyKXDdfVffn5NWj2jbsdK0H2
         7E6g==
X-Gm-Message-State: APjAAAUfLaLU44FtyEAtbon7WhawN+69GVtIv2eJQMcYhrZUYA3g0+pF
        cNwOrjss141ID9E05Vc6lVg=
X-Google-Smtp-Source: APXvYqxZtm6Qj331uV4FLMUOA8xU39DHgobQ3xvpfyUPo0++XTme0diAS2/eVuOoxULozb+gjdk9gQ==
X-Received: by 2002:a63:1604:: with SMTP id w4mr10477318pgl.148.1557455195993;
        Thu, 09 May 2019 19:26:35 -0700 (PDT)
Received: from localhost ([2601:640:6:ef4d:19d3:11c4:475e:3daa])
        by smtp.gmail.com with ESMTPSA id v81sm8664018pfa.16.2019.05.09.19.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 19:26:34 -0700 (PDT)
Date:   Thu, 9 May 2019 19:26:33 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, Yury Norov <ynorov@marvell.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH 5/7] lib: rework bitmap_parse()
Message-ID: <20190510022633.GA30629@yury-thinkpad>
References: <20190501010636.30595-1-ynorov@marvell.com>
 <20190501010636.30595-6-ynorov@marvell.com>
 <20190508084632.GY9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508084632.GY9224@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for thorough review.

On Wed, May 08, 2019 at 11:46:32AM +0300, Andy Shevchenko wrote:
> On Tue, Apr 30, 2019 at 06:06:34PM -0700, Yury Norov wrote:
> > bitmap_parse() is ineffective and full of opaque variables and opencoded
> > parts. It leads to hard understanding and usage of it. This rework
> > includes:
> >  - remove bitmap_shift_left() call from the cycle. Now it makes the
> >    complexity of the algorithm as O(nbits^2). In the suggested approach
> >    the input string is parsed in reverse direction, so no shifts needed;
> >  - relax requirement on a single comma and no white spaces between chunks.
> >    It is considered useful in scripting, and it aligns with
> >    bitmap_parselist();
> >  - split bitmap_parse() to small readable helpers;
> >  - make an explicit calculation of the end of input line at the
> >    beginning, so users of the bitmap_parse() won't bother doing this.
> 
> > +static inline bool in_str(const char *start, const char *ptr)
> > +{
> > +	return start <= ptr;
> > +}
> > +
> 
> The explicit use of the conditional is better.
> 
> -- 
> With Best Regards,
> Andy Shevchenko

I still think that is_str() is more verbose, but it's minor issue
anyways, so I obey. Below is the patch that removes the function.
It's up to Andrew finally, either apply it or not.

Thanks,
Yury

From 7438c15a0b165032a3e5a6d87daabe877dc8cbc8 Mon Sep 17 00:00:00 2001
From: Yury Norov <ynorov@marvell.com>
Date: Thu, 9 May 2019 17:54:23 -0700
Subject: [PATCH] lib: opencode in_str()

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 lib/bitmap.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index ebcf4700ebed..ecf93d2982a5 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -454,11 +454,6 @@ static inline bool end_of_region(char c)
 	return __end_of_region(c) || end_of_str(c);
 }
 
-static inline bool in_str(const char *start, const char *ptr)
-{
-	return start <= ptr;
-}
-
 /*
  * The format allows commas and whitespases at the beginning
  * of the region.
@@ -473,7 +468,7 @@ static const char *bitmap_find_region(const char *str)
 
 static const char *bitmap_find_region_reverse(const char *start, const char *end)
 {
-	while (in_str(start, end) && __end_of_region(*end))
+	while (start <= end && __end_of_region(*end))
 		end--;
 
 	return end;
@@ -618,7 +613,7 @@ static const char *bitmap_get_x32_reverse(const char *start,
 
 		ret |= c << i;
 
-		if (!in_str(start, end) || __end_of_region(*end))
+		if (start > end || __end_of_region(*end))
 			goto out;
 	}
 
@@ -653,7 +648,7 @@ int bitmap_parse(const char *start, unsigned int buflen,
 	u32 *bitmap = (u32 *)maskp;
 	int unset_bit;
 
-	while (in_str(start, (end = bitmap_find_region_reverse(start, end)))) {
+	while (start <= (end = bitmap_find_region_reverse(start, end))) {
 		if (!chunks--)
 			return -EOVERFLOW;
 
-- 
2.17.1

