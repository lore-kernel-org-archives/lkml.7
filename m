Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1EFC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36BA9206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="W7fvN+Ky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfJBIbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 04:31:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45823 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfJBIbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 04:31:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id r5so18521071wrm.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 01:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=L6SP0vqjKrW+FVAFxIiwO3RwzJwaNXeSjRExagYIpuM=;
        b=W7fvN+Ky7UHVSbFx5n/tY6kfReYFnLnduYisWrWwJA2GBuuzWHwkROiiXrlun1H0SK
         gaZJr7lTz5GZo/5RGO8r3724zPUgRBXSCCrtQRFUKCkAqRkkgQ9pQ0F+0zUuqMqvq/ct
         AmXFvE/Lpgzx1JXJOaoNaffMGigI1hn4jaaQP0kHrbHhf848QcJJqdodYU4gKO3Zkpu+
         5gtj2jdwV0iupHfuvqIJFFfecH+HH/v4cbEUf1M1owI2rEHrpQokiiO71pD/RO/nmGPK
         o16hBWwnzbMLtx0g27ezvij4khkt+20EJBoayMXKTaILfLEvPxklyCkLZB6vfQHhdbmR
         81Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=L6SP0vqjKrW+FVAFxIiwO3RwzJwaNXeSjRExagYIpuM=;
        b=MIDyrYjXeK0eUoFzBa8FpQwjWjqHL9DyeD+mWyZoRJAwRiTWA7y1vheGCg21Pjj9Gd
         Gj2QS28UJs+QygSHL3AGISIwgkYnYb9sIpGnOb5hrpTSd7hmad+O255W4i/icZ0rKhmJ
         nCRUoSe/izh+lm2MTL7DR7y2w/h02KpYarkZRtQ+pYRQ10iETs0CUOc72UZVvFeotJZl
         GilPbIDjMfaxnz2iwCBI76xDU+ePY+3EsQdvImUvx+MJNmS8zGGq+Qvo4McA+xkZTc5A
         aWR9QzjiLc+ldtLNbrmGWIL9d9PvEzlginSMGQreGCDjvsEHXVVi2nCAWijQUgnv4B5O
         8Grg==
X-Gm-Message-State: APjAAAWmG0S9vXB0VkGm2FK9ZvMrptZuqZqM4Bn1XWgQjEp1dyoSvDkO
        XxcEqRUOnuf8XTL1pmqJP01vsw==
X-Google-Smtp-Source: APXvYqyeMcDgVfoQfkR6WdR0dH8rFRK/tUkB6hVm0yjtMO3SLWPRdnVVBKHJOSSLNw0AwxMLvfDVug==
X-Received: by 2002:adf:eb42:: with SMTP id u2mr1635257wrn.307.1570005108065;
        Wed, 02 Oct 2019 01:31:48 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e6sm16712621wrp.91.2019.10.02.01.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 01:31:47 -0700 (PDT)
References: <20191001174439.182435-1-sboyd@kernel.org>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] clk: Don't cache errors from clk_ops::get_phase()
In-reply-to: <20191001174439.182435-1-sboyd@kernel.org>
Date:   Wed, 02 Oct 2019 10:31:46 +0200
Message-ID: <1jd0ffr1jh.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 01 Oct 2019 at 19:44, Stephen Boyd <sboyd@kernel.org> wrote:

> We don't check for errors from clk_ops::get_phase() before storing away
> the result into the clk_core::phase member. This can lead to some fairly
> confusing debugfs information if these ops do return an error. Let's
> skip the store when this op fails to fix this. While we're here, move
> the locking outside of clk_core_get_phase() to simplify callers from
> the debugfs side.

Function already under the lock seem to be marked with  "_nolock"
Maybe one should added for get_phase() ?

Also the debugfs side calls clk_core_get_rate() and
clk_core_get_accuracy(). Both are taking the prepare_lock.

So I don't get why clk_get_phase() should do thing differently from the
others, and not take the lock ?

>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>
> Resending because I couldn't find this anywhere.
>
>  drivers/clk/clk.c | 44 +++++++++++++++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 1c677d7f7f53..16add5626dfa 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2640,14 +2640,14 @@ EXPORT_SYMBOL_GPL(clk_set_phase);
>  
>  static int clk_core_get_phase(struct clk_core *core)
>  {
> -	int ret;
> +	int ret = 0;
>  
> -	clk_prepare_lock();
> +	lockdep_assert_held(&prepare_lock);
>  	/* Always try to update cached phase if possible */
>  	if (core->ops->get_phase)
> -		core->phase = core->ops->get_phase(core->hw);
> -	ret = core->phase;
> -	clk_prepare_unlock();
> +		ret = core->ops->get_phase(core->hw);
> +	if (ret >= 0)
> +		core->phase = ret;
>  
>  	return ret;
>  }
> @@ -2661,10 +2661,16 @@ static int clk_core_get_phase(struct clk_core *core)
>   */
>  int clk_get_phase(struct clk *clk)
>  {
> +	int ret;
> +
>  	if (!clk)
>  		return 0;
>  
> -	return clk_core_get_phase(clk->core);
> +	clk_prepare_unlock();
> +	ret = clk_core_get_phase(clk->core);
> +	clk_prepare_unlock();
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(clk_get_phase);
>  
> @@ -2878,13 +2884,21 @@ static struct hlist_head *orphan_list[] = {
>  static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
>  				 int level)
>  {
> -	seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu %5d %6d\n",
> +	int phase;
> +
> +	seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu ",
>  		   level * 3 + 1, "",
>  		   30 - level * 3, c->name,
>  		   c->enable_count, c->prepare_count, c->protect_count,
> -		   clk_core_get_rate(c), clk_core_get_accuracy(c),
> -		   clk_core_get_phase(c),
> -		   clk_core_get_scaled_duty_cycle(c, 100000));
> +		   clk_core_get_rate(c), clk_core_get_accuracy(c));
> +
> +	phase = clk_core_get_phase(c);
> +	if (phase >= 0)
> +		seq_printf(s, "%5d", phase);
> +	else
> +		seq_puts(s, "-----");
> +
> +	seq_printf(s, " %6d\n", clk_core_get_scaled_duty_cycle(c, 100000));
>  }
>  
>  static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
> @@ -2921,6 +2935,7 @@ DEFINE_SHOW_ATTRIBUTE(clk_summary);
>  
>  static void clk_dump_one(struct seq_file *s, struct clk_core *c, int level)
>  {
> +	int phase;
>  	unsigned long min_rate, max_rate;
>  
>  	clk_core_get_boundaries(c, &min_rate, &max_rate);
> @@ -2934,7 +2949,9 @@ static void clk_dump_one(struct seq_file *s, struct clk_core *c, int level)
>  	seq_printf(s, "\"min_rate\": %lu,", min_rate);
>  	seq_printf(s, "\"max_rate\": %lu,", max_rate);
>  	seq_printf(s, "\"accuracy\": %lu,", clk_core_get_accuracy(c));
> -	seq_printf(s, "\"phase\": %d,", clk_core_get_phase(c));
> +	phase = clk_core_get_phase(c);
> +	if (phase >= 0)
> +		seq_printf(s, "\"phase\": %d,", phase);
>  	seq_printf(s, "\"duty_cycle\": %u",
>  		   clk_core_get_scaled_duty_cycle(c, 100000));
>  }
> @@ -3349,10 +3366,7 @@ static int __clk_core_init(struct clk_core *core)
>  	 * Since a phase is by definition relative to its parent, just
>  	 * query the current clock phase, or just assume it's in phase.
>  	 */
> -	if (core->ops->get_phase)
> -		core->phase = core->ops->get_phase(core->hw);
> -	else
> -		core->phase = 0;
> +	clk_core_get_phase(core);

Should the error be checked here as well ?

>  
>  	/*
>  	 * Set clk's duty cycle.

