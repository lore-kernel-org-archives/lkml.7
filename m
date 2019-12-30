Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED11C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 20:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D588E20718
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 20:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DN3Iqa5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfL3UhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 15:37:14 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40842 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbfL3UhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 15:37:13 -0500
Received: by mail-ot1-f68.google.com with SMTP id w21so39869269otj.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 12:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N3dpJqjI0YwUjpo8var9eG+HiTs0fKSTa69wNvQw3Uk=;
        b=DN3Iqa5QLHZZygBT0FzEe8PKs1W4q7EGbHG7W5tTg298ZVAUmmzEEcFue0zrFgJxvj
         Ga0U28yoHfHefVfgMXSg4hoocDVsHjrhdCb19fMftsAhmyA61KA6iRPbAQvbf7PYFxP2
         3AG2HuQM5hryHKsCSyUgbaXi3dWQY1+rEAgWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N3dpJqjI0YwUjpo8var9eG+HiTs0fKSTa69wNvQw3Uk=;
        b=VmAflDvvtRSRNJD3gZOUon+f/anrZsoHKKKj6IMttU51T/nkzilOqcl82gp0CWdmtr
         eCtLHFY5LbAkVk0xHKlMNjSUQxqsTJnnDV8XPkVgHwUwd8bFm9VFP1hRW/nJOIS70XTA
         LqxM5qi0wI2xudtY4ZQnZSFPGhB2E832mDYzFgtke/3/jD/NBxHURH62rgIc9uin5gQ+
         0haiveDIxB4qeynTjKC4U2TZ+ZUt03GFx5BceUcr9ektY0Hlg6tbUMV3I+SCui12WZiE
         adBLyq3rZuZwhF2XwJXzJIADIm6wzUy0IhJgb3Xt+X7EM0boSFuaP7mNmZW3109niI84
         JFQA==
X-Gm-Message-State: APjAAAU/0D5C67rZZ3Yr+9uE/CePwZ7+XYSzpSj6imupsE8roBXnBANA
        KAMB4t+ekkGY6dsIlsmrIQfoZw==
X-Google-Smtp-Source: APXvYqzrX9H26dCG77JdRBA+uGbyVE9vWm06PPBlWMTzr5bFnHE/IcJebAYhczEaa2841osymtjqmA==
X-Received: by 2002:a05:6830:22e3:: with SMTP id t3mr72285522otc.193.1577738232581;
        Mon, 30 Dec 2019 12:37:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c7sm16202391otm.63.2019.12.30.12.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 12:37:11 -0800 (PST)
Date:   Mon, 30 Dec 2019 12:37:10 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nikolai Merinov <n.merinov@inango-systems.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        Aleksandr Yashkin <a.yashkin@inango-systems.com>,
        Ariel Gilman <a.gilman@inango-systems.com>
Subject: Re: [PATCH] pstore/ram: fix for adding dumps to non-empty zone
Message-ID: <201912301227.47AE22C61@keescook>
References: <20191223133816.28155-1-n.merinov@inango-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223133816.28155-1-n.merinov@inango-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 06:38:16PM +0500, Nikolai Merinov wrote:
> From: Aleksandr Yashkin <a.yashkin@inango-systems.com>
> 
> The circle buffer in ramoops zones has a problem for adding a new
> oops dump to already an existing one.
> 
> The solution to this problem is to reset the circle buffer state before
> writing a new oops dump.

Ah, I see it now. When the crashes wrap around, the header is written at
the end of the (possibly incompletely filled) buffer, instead of at the
start, since it wasn't explicitly zapped.

Yes, this is important; thank you for tracking this down! This bug has
existed for a very long time. I'll try to find the right Fixes tag for
it...

-Kees

> Signed-off-by: Aleksandr Yashkin <a.yashkin@inango-systems.com>
> Signed-off-by: Nikolay Merinov <n.merinov@inango-systems.com>
> Signed-off-by: Ariel Gilman <a.gilman@inango-systems.com>
> 
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 8caff834f002..33fceadbf515 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -407,6 +407,13 @@ static int notrace ramoops_pstore_write(struct pstore_record *record)
>  
>  	prz = cxt->dprzs[cxt->dump_write_cnt];
>  
> +	/* Clean the buffer from old info.
> +	 * `ramoops_read_kmsg_hdr' expects to find a header in the beginning of
> +	 * buffer data, so we must to reset the buffer values, in order to
> +	 * ensure that the header will be written to the beginning of the buffer
> +	 */
> +	persistent_ram_zap(prz);
> +
>  	/* Build header and append record contents. */
>  	hlen = ramoops_write_kmsg_hdr(prz, record);
>  	if (!hlen)
> -- 
> 2.17.1
> 

-- 
Kees Cook
