Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35467C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FD72077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578397434;
	bh=1j+UxKz7dqhiKpF1JjsOky8D5Km/ZHINtsX3lKlGj90=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RwIKSS9KkRhCxvxLIfYIBxk1t+9tKqKMogx1QtUJFrD/+FzEdP6B2zlmY2iQfwOt+
	 sxzDA0hlx3OJ5eCo4KkxGlVigDZmap6bajN5jkVrRGRXyVozGQu3Wo/suo5TfyAlJQ
	 CaJSEVvTcOYJX5TkiXuEwih4yCD/6QT16LP054OI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgAGLnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:43:53 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34422 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgAGLnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 06:43:53 -0500
Received: by mail-ot1-f68.google.com with SMTP id a15so76062126otf.1;
        Tue, 07 Jan 2020 03:43:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zJ7Soe4Ipf76O97lFC/HUE2dza3yg3mUCQ8NQLtNlnw=;
        b=lkgZ8aa1AIVKUV2EGHcXkmkOU5S/2wz3ZW5rrb87BOb3AxAFphlRRcxrC3HpqO3l1q
         8/WNh/leB1S1V1de/kaAfmGAC0xYsn28nUU6EHUfe1NMxjcKAmiewE/TJWRLqztI6uWZ
         hMOlKMGV3mpnyskM4Hxu5abiwq8cSR8gl3566R1DHEhfg93KOYAEkXQX3vfbJhUtIsRC
         lQS0D425axUl3EmRKZFZeigpH5i0qbzWPeMBIwyqmhlXzHaUHftqS7p38GB+SU0oNmGZ
         PG9Uwpok6ux4/20izCbMb1domRr3vbtzvsDtdFNQGmNLG4VduzGYsFv3IkZpxuxVon5M
         tLnw==
X-Gm-Message-State: APjAAAWii/xo/5G34xH/DfjHW3k0+bUiJFNhAZQFOHbS5m+bvleRDDkj
        fgTeWACCbRahtGpSftaep6yv20HNYGSXx6RmQKBiUBYR
X-Google-Smtp-Source: APXvYqwJHuZIOtRj1OEJTcGQRETFctkZnZR8kHx+hRWaSra/ov5lEOtxzfZcq5CbtlubpiBfAtssc1Qokba+aMrab8I=
X-Received: by 2002:a05:6830:3003:: with SMTP id a3mr15682871otn.118.1578397432443;
 Tue, 07 Jan 2020 03:43:52 -0800 (PST)
MIME-Version: 1.0
References: <20200103155458.21707-1-wenyang@linux.alibaba.com>
In-Reply-To: <20200103155458.21707-1-wenyang@linux.alibaba.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Jan 2020 12:43:41 +0100
Message-ID: <CAJZ5v0j_0iW5k2GJGZ=REYiR29W1BGmNi-7TiXz5jwZ80+FxpQ@mail.gmail.com>
Subject: Re: [PATCH] kernel/power/snapshot.c: improve arithmetic divisions
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 3, 2020 at 4:55 PM Wen Yang <wenyang@linux.alibaba.com> wrote:
>
> do_div() does a 64-by-32 division. Use div64_u64() instead of
> do_div() if the divisor is u64, to avoid truncation to 32-bit.
> This change also cleans up code a tad.
>
> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/power/snapshot.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 26b9168..8a6eaf7 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1566,9 +1566,7 @@ static unsigned long preallocate_image_highmem(unsigned long nr_pages)
>   */
>  static unsigned long __fraction(u64 x, u64 multiplier, u64 base)
>  {
> -       x *= multiplier;
> -       do_div(x, base);
> -       return (unsigned long)x;
> +       return div64_u64(x * multiplier, base);
>  }
>
>  static unsigned long preallocate_highmem_fraction(unsigned long nr_pages,
> --

Applied as 5.6 material under a new subject ("PM: hibernate: improve
arithmetic division in preallocate_highmem_fraction()"), thanks!
