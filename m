Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7F1C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3918E20989
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m25/WGY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbfC3Syk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:54:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40091 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730713AbfC3Syj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:54:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id c207so2567719pfc.7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 11:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=esc4CjHwaC8VKiuRtjJ2gZJ9Lzz3ctfyaXcczK2u/Qg=;
        b=m25/WGY/eP2TCv9WeWNMz4uIlNq4mnYK5LA4cJpwGUdoJnwfdWQEN1djRsrTRZ9h9F
         AA4URLu//uRSXs7QNNLt5UTUJPGLnRa9Y1Ozq/KYjA7JxhV0St6TksVdPeqITe2T/KPq
         Okv+BeT7JBkUmzNr25HwTfpAjunWX7YJ8Hd3X4Lum6QKN5j1z7bn9de4Kbs3AfQZOMx4
         0Bsx25Pn9XyXuCc9F+x8Q6cEfydd4pSUjyei6bMweWB+gfAjCxzWFzQOsu1ipvZQvwUH
         B8hW9+aUAhCcki9hO2euunzbV+7qqr6QuSM7VZ33thunjlk/riXhb4cpfW2qw+Cn5WxK
         36+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=esc4CjHwaC8VKiuRtjJ2gZJ9Lzz3ctfyaXcczK2u/Qg=;
        b=jg9ce0Nn9F4ALqvOSIuZZgZlCcy9AP5IGbWufyCfBc2FU9hGoVunDeblSyjXYkJuc5
         KNfUusmeiRViYc83i8nJ/Se+3+VTNWxAPqzvZ641V39IK7VWlCBx6qmTUwi75EaQqkxD
         YqK12BPcZ5BSvTodUj2rsjk1jYdh1mnanHLL/lNkg7Wi1Lv7loif4GRpU8W1Pnv9lrea
         QVQVzw59ee/ZNH/5QkiD2xINM5+/1szy41kTpZrP2drYr2N55vJ+AgzspgEaTuo8D+V1
         XksArvKsuxGaCt+10bEJ2+CdZystymz2Ct00WKsaMgnt9iOz0EFa5hSqBEATWgbAywrZ
         9oaQ==
X-Gm-Message-State: APjAAAW/JFnuvXhlf6ydIy5kOC0mh1rn2MmJ5V9rtPD5E8v3UpCDsZdD
        b6DQi4nnnrgOLvhtZT/B7WM=
X-Google-Smtp-Source: APXvYqyGnU2EA95DxWNJJLRUi4hWvPWhbw+XHj1i0Uxt3wh5Ig6GWXngl2U9UQqtRMMEIMO9Z49tgw==
X-Received: by 2002:a63:581c:: with SMTP id m28mr14694777pgb.332.1553972078568;
        Sat, 30 Mar 2019 11:54:38 -0700 (PDT)
Received: from localhost ([2601:648:8303:5c60:e1e9:c2a0:71d2:46f])
        by smtp.gmail.com with ESMTPSA id u62sm10636178pfa.124.2019.03.30.11.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 11:54:37 -0700 (PDT)
Date:   Sat, 30 Mar 2019 21:54:36 +0300
From:   Yury Norov <yury.norov@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        Yury Norov <ynorov@marvell.com>
Subject: Re: PATCH 2/2] lib/bitmap.c: guard exotic bitmap functions by
 CONFIG_NUMA
Message-ID: <20190330185436.GA19813@yury-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus!

> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Sent: Saturday, March 30, 2019 12:53:51 AM
> To: Rasmus Villemoes; Andrew Morton; Andy Shevchenko
> Cc: Yury Norov; linux-kernel@vger.kernel.org
> Subject: [PATCH 2/2] lib/bitmap.c: guard exotic bitmap functions by CONFIG_NUMA
> 
> The bitmap_remap, _bitremap, _onto and _fold functions are only used,
> via their node_ wrappers, in mm/mempolicy.c, which is only built for
> CONFIG_NUMA. The helper bitmap_ord_to_pos used by these functions is
> global, but its only external caller is node_random() in lib/nodemask.c,
> which is also guarded by CONFIG_NUMA.

Nice catch. I think you should protect declaration of those functions
in include/linux/bitmap.h as well.

I'm concerned about pollution of such a generic portion of code with
subsystem-related #ifdefs. Would it make more sense to move numa-specific
stuff to lib/bitmap_numa.c and include/linux/bitmap_numa.h (or *_nodemask.h,
or whatever)?

Yury

> For !CONFIG_NUMA:
> 
> add/remove: 0/6 grow/shrink: 0/0 up/down: 0/-621 (-621)
> Function                                     old     new   delta
> bitmap_pos_to_ord                             20       -     -20
> bitmap_ord_to_pos                             70       -     -70
> bitmap_bitremap                               81       -     -81
> bitmap_fold                                  113       -    -113
> bitmap_onto                                  123       -    -123
> bitmap_remap                                 214       -    -214
> Total: Before=4776, After=4155, chg -13.00%
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  lib/bitmap.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 66421f304f7d..3f3b8051f342 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -649,6 +649,7 @@ int bitmap_parselist_user(const char __user *ubuf,
>  EXPORT_SYMBOL(bitmap_parselist_user);
> 
> 
> +#ifdef CONFIG_NUMA
>  /**
>   * bitmap_pos_to_ord - find ordinal of set bit at given position in bitmap
>   *     @buf: pointer to a bitmap
> @@ -952,6 +953,7 @@ void bitmap_fold(unsigned long *dst, const unsigned long *orig,
>          for_each_set_bit(oldbit, orig, nbits)
>                  set_bit(oldbit % sz, dst);
>  }
> +#endif /* CONFIG_NUMA */
> 
>  /*
>   * Common code for bitmap_*_region() routines.
> --
> 2.20.1
> 
