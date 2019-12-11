Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D3CC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 02:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72FE205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 02:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlUENcu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfLKCBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 21:01:52 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35373 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfLKCBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 21:01:52 -0500
Received: by mail-pl1-f196.google.com with SMTP id s10so752754plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 18:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z1y/LTXMqZQ7+fbUeIxen+lHLUxUeQ6tnCSwfKzyG/M=;
        b=qlUENcu0E0Q9DLS7cfJlDkXjHaDctO9pXEp/m8Ll6UVPyzHzjS8G6sHF4FhvrNiqQ8
         eLseGys7dWSaxlj/2YZOROOTrx6XX0dcOV8XoEcRtEB47TvgzZoaxUjLtOLRw/sHnkzK
         BlsiQA8MfBEgQ/dlOQTIHtWvw3NjxFK1j6HAYYpFDlqaaC9udPapLmcfR/I3abK+XUEb
         iEeOeAS25uN9TVQ1aDzOYY26VPRUi640Rp9eNzVupyMPYKHYWCo5JvuiK64gVCycyGuM
         3NVzT1FSO69jgn4wl45z9ikbIdmpaulQ6XXfuHC5MzaGNjALunj15nlxGJlb7vdtsIvg
         48/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z1y/LTXMqZQ7+fbUeIxen+lHLUxUeQ6tnCSwfKzyG/M=;
        b=lg0Sil/KvdzZyJuAM774e1g6768jNV3kj655IFERjYeovN0JqZl3wDku3acs9F57/i
         WacemaF//VNKTebTsN0yKSnkZZZtkxq9QPPx8vu78gxgZEk6oYg3FhXl0/SMft7uj3kk
         xXlBgoCHLKp782E0g58StAL2+0w74XbsRTydN5oD5Dp8TJp4MEZjf/ZteBp3q8VbPB3u
         0/ABDuP/SUk+JhfTUKRRscaJm8aa5YatnAWMpKYPQ1msw5O29E2HszXfvVOvNm6ilNod
         qsOUp6eHXbKz5EQnzoi8cSgHqIyYchGVJtsAzA6lP1oFhhBdQSmIHxsX9KgAWnCtudWa
         Sfwg==
X-Gm-Message-State: APjAAAU+OMeu1JO9z+JJsHsKxPBEPb3eGaUeewnNCf8VmVvZyDQv19hF
        P24HfaTOw2C1ZyFuvs4TlW8=
X-Google-Smtp-Source: APXvYqz8XeHXRQ9xOYxzySujw7BiUgaSGG0Z3Ie2DUqY0b4OF07uw8hWBSjjxrAEzytnkWCRsl/SDw==
X-Received: by 2002:a17:902:fe8b:: with SMTP id x11mr604022plm.83.1576029711685;
        Tue, 10 Dec 2019 18:01:51 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id c18sm295405pgj.24.2019.12.10.18.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 18:01:50 -0800 (PST)
Date:   Wed, 11 Dec 2019 11:01:49 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH] printk: Fix preferred console selection with
 multiple matches
Message-ID: <20191211020149.GN88619@google.com>
References: <b8131bf32a5572352561ec7f2457eb61cc811390.camel@kernel.crashing.org>
 <20191210080154.GJ88619@google.com>
 <98df321d16adb67c5579ac4b67d845fc0c2c97df.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98df321d16adb67c5579ac4b67d845fc0c2c97df.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (19/12/11 09:26), Benjamin Herrenschmidt wrote:
[..]
> No not exactly. Architectures/platforms use add_preferred_console()
> (such as arm64 with ACPI but powerpc at least does it too) based on
> various factors to select a reasonable "default" for that specific
> platform. Without that the kernel will basically default to the first
> one to register which may not be what you want.
> 
> The command line ones however want to override the defaults (provided
> they exist, ie, it's possible that whever is specified on the command
> line doesn't actually exist, and thus shall be ignored. That typically
> happens when there is either no match or ->setup fails).
> 
> > Hmm.
> > 
> > The patch may affect setups where alias matching is expected to
> > happen. E.g.:
> > 
> > 	console=uartFOO,BAR
> > 
> > Is 8250 the only console that does alias matching?
> 
> Why would the patch affect this negatively ? Today we stop on the first
> match, mark the driver enabled, and make it preferred if the match
> index matches preferred_console.

As far as I know, ->match() does not only match but also does ->setup().
If we have two console list entries that match (one via aliasing and one
via exact match) then the console driver is setup twice. Do all console
drivers handle it? [double setup]

If we could perform simple alias matching, without ->setup() call, and
exact matching (strcmp()), and then, if newcon would match two entries,
we would pick up the last matching entry and configure newcon only once.

This changes the order, tho.

[..]
>  - Another match that is marked preferred_console, in which case in
> addition to being enabled, the newly registered console will also be
> made the default console (ie, first in the list with CONSDEV set). This
> is actually what we want ! IE. The console matches the last specified
> one on the command line.

Well, it still looks to me that what you want is to "ignore alias
match and prefer exact match".

	-ss
