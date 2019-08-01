Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEF9C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B0720838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZkklR3uF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388896AbfHAUOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 16:14:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40836 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfHAUOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 16:14:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so32626322pla.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 13:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ijIfaB/u8ohpmn4mM5slg76T9xTiwfAQK+gE07HS2Gs=;
        b=ZkklR3uFxHP6Y8XTx6VYhj4O+6IWJ8wZ86vYmsLdLmL9Kl9ScF36BtA/WhBpEYQrP+
         MWMssjtZ2f8XwT3s1JU8L4q/1Y9Sq9fJvEklvCBLMowpUpIAQEsMTJ1/QuOD8zGMDjgy
         OSpC84q4u6JX0fauLOvOvcFmIWe96B95fH8BM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ijIfaB/u8ohpmn4mM5slg76T9xTiwfAQK+gE07HS2Gs=;
        b=Rt7Y9yvufYwjNd6gR6IuK2Z5nRqYBve+/8dp4Ms9II8R3kv6/QaABYjpGha1h4AA0X
         uG0Mk/jbx+ZhOJYr0DaV5YcAagUwZmohHXe7y4pKMcfSo3mSV6GR4jMpBXqPX/Io9Kzm
         ROOh8IgE7OXLERfDsS+4bMnRup3QTwQ6gU75nxIufKO4K9L/oMKThfNjLe670UQ7+nn3
         wlHrXt4xO+ngRbDMoTUmRH4Vcqn3BWmqe2F8VpVxPPinTzrMYzqAG5Lzw9Wi1Gx0c3Mq
         +oKhFT0bFc9r1bGjZM9MCAKJ+B/iX3J5f1N7E+iRJHKr8ie7k4tf0l5aoZLqzaN0ON7v
         AXow==
X-Gm-Message-State: APjAAAXAm97c3wK9DCO5PIZSCpf3W/Ermd9e2TUQmp93EGdXHimJgLHs
        yF3g5Rko+LVvaV8XDmiGob8dLg==
X-Google-Smtp-Source: APXvYqw6KayZdXN0sKQZvPI5VVbd86mPViT8uDgiznq11fw4KURCPEvYA4XepGza1hvaDP9r3y3Uvw==
X-Received: by 2002:a17:902:9307:: with SMTP id bc7mr123619972plb.183.1564690485486;
        Thu, 01 Aug 2019 13:14:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t10sm5741928pjr.13.2019.08.01.13.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Aug 2019 13:14:44 -0700 (PDT)
Date:   Thu, 1 Aug 2019 13:14:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Robin Lindner <robin.lindner1@t-online.de>
Cc:     re.emese@gmail.com, kernel-hardening@lists.openwall.com,
        Alexander Popov <alex.popov@linux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation patch (gcc-plugins kernel)
Message-ID: <201908011311.A06FB03C6C@keescook>
References: <ebb6d995-a356-bc01-074b-6154a283e299@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebb6d995-a356-bc01-074b-6154a283e299@t-online.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 09:30:58AM +0200, Robin Lindner wrote:
> Cleaned documentation comment up. I removed the "TODO" because it was very old.

Hi, please send these patches "normally" (cc maintainers, include lkml,
inline not attachments, etc):
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

> ---
>  scripts/gcc-plugins/stackleak_plugin.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
> index dbd37460c573e..d8ba12c3bb238 100644
> --- a/scripts/gcc-plugins/stackleak_plugin.c
> +++ b/scripts/gcc-plugins/stackleak_plugin.c
> @@ -144,8 +144,6 @@ static unsigned int stackleak_instrument_execute(void)
>  	 *
>  	 * Case in point: native_save_fl on amd64 when optimized for size
>  	 * clobbers rdx if it were instrumented here.
> -	 *
> -	 * TODO: any more special cases?
>  	 */
>  	if (is_leaf &&
>  	    !TREE_PUBLIC(current_function_decl) &&

As to the content of the patch, let's also CC Alexander...

Are there no more special cases?

-- 
Kees Cook
