Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D63FC2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68538206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jG7CSNuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfL3TCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:02:11 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36414 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfL3TCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 14:02:10 -0500
Received: by mail-ot1-f66.google.com with SMTP id 19so34850069otz.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 11:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lc8hqJlG4Fl7spByFbCsc4Qw8nhBbPP2L4M2JhEsKq8=;
        b=jG7CSNuXqyRrqwd8edy01miTukkvnvZk0/DAPKg6FTQNAIYvoZI3pgVdZonoL7ZwoH
         snnGb6NKU6ADc1ljX/QPjqaa8zaQUeWzNJM926M7jFQO0UteO1wsCd1rDnDvKd0CpMoy
         gjOhNKZttyY8hYS/OQT6cbiyNWtqHYOBibuvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lc8hqJlG4Fl7spByFbCsc4Qw8nhBbPP2L4M2JhEsKq8=;
        b=K430aOFwxYCBcDsoVT+Aug2xHchyegjSvw1WO6A38mcp9d7hotqX/SCQptbnzwKOje
         lnKfgDNi6KVtJG0wowr5ExMuMxU4QFSHlAOqUoftV2jptffKqL0aE64WjuNw1DlQsCSU
         SEVD7rs7HZxXvH+QTUfqu3mWrLj2ZFOSpLBh3H8F4wFJdDcrfszunokQPgGQH7Gj0w9A
         RXcnar2mWXPC4Amq+B3tBePeH56hOWdJ7Ql8GzwOTCixPJLza2Mnkowo/O4GuDr2V8wF
         dBawOLRADUwvcSK9fC3XDmmo72vuaZqzX+8rZBtYrRsJkp+1DB76aRPVAOJ3x0vV6ycb
         LTZg==
X-Gm-Message-State: APjAAAU8dS/IOw/7KhwttmbwJpssS/CdUwm0XLbERod4T+ke5KVARAPb
        Q3FfLlmGfZ4ad8aNgFdibySnFA==
X-Google-Smtp-Source: APXvYqwQrEkoXFADJgIJtisfcrTml3NDaG7oGpNhn5ebG8qd+4X41OYxQS7xoaiFacPQzshD8CBAtA==
X-Received: by 2002:a9d:222f:: with SMTP id o44mr62760252ota.51.1577732529981;
        Mon, 30 Dec 2019 11:02:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 67sm8016137oid.30.2019.12.30.11.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 11:02:09 -0800 (PST)
Date:   Mon, 30 Dec 2019 11:02:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nikolai Merinov <n.merinov@inango-systems.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        Aleksandr Yashkin <a.yashkin@inango-systems.com>,
        Ariel Gilman <a.gilman@inango-systems.com>
Subject: Re: [PATCH] pstore/ram: fix for adding dumps to non-empty zone
Message-ID: <201912301100.473042C@keescook>
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

Can you describe the real-world problem you're fixing here? Dumps should
be appended as new records. Are you saying that once the circular list
is full, it blocks future dumps?

-Kees

> 
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
