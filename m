Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBEAC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA88A20652
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0zCLRj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388835AbfDRNgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:36:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41352 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRNgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:36:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so1211852pgs.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 06:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ymILwm9MmxZDpnzd2nM0Ue1TlfZZRNgyXaUYqNBALVU=;
        b=Y0zCLRj07pW72x5oMTYQTowNtoBmltVqMiXDQa+H4GjGYdodkfrTqD1aNVNb/l62Fb
         n3gA7z4WeexEAv1VI2bN+QK22Zx8sl4wn/SWp7/T1C6EmT3i7aepZOKPmaQU5D5jQ5zV
         ruUK79Eoa5eTYc1GO9LrGIDNWGWtn/Q9tzEv6p4rMzCUGUFuC/U0n6JdY1s9UEf87iYW
         sXmZ1ACjYlKFxfcn8V5+FoIEhro7zrKxifs4BLPjiqrWSdRS9LGpH3vEVLtJ265dpiRH
         6B8tEdoGB+SHj18UoLRex0lGK5yfjoq1e20N+L/f3NnmkYikFS0kj0lMq3t0+xg7wpR2
         sbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ymILwm9MmxZDpnzd2nM0Ue1TlfZZRNgyXaUYqNBALVU=;
        b=IWZc1KSxf7ncdJgn0si74lhB2XrjBwXj4HaJhb+eScDs7vLYYoQCgQmEKFjDzONeOV
         Xf6n0m3BxaWH267wWKKZUvTBIciUmsR61Ok5CbWjksOPwhFdyUV6q8df/EZM/gQOXjNk
         /POO3yR+bOKyq3QPVKBQFwtvlMg8ZvY44MIyCunyT1UpG0nZjBN3VDqxHTwa/qz8lu/s
         BUoOLwKqeOxHxztDSPIGhlD9Nj6BGq6+F2Q2FxNNAwnhUl1pnteIqaNgso1QwGRaegkm
         +h8ph0z/jPEPh6tZerSnJtAeWoJueoTnz5nhJhYI+VgMLIJuoBpCNJ1Xgy80gL+kTFGY
         aJFg==
X-Gm-Message-State: APjAAAUCIXILrKeDTjlYYlhPj2au0iTrA25dbsVPRPNh0ZjcUv2OasCQ
        OtTfHzqBDqrs3aTkYUNWLeg=
X-Google-Smtp-Source: APXvYqzp/8BzI4r33u6Rfk8uv4NxNKfJzBi0IIRsMU5s8Rnm02zSNXP/SkD7Tlj6nm6yAamOAkY1uQ==
X-Received: by 2002:a62:75cd:: with SMTP id q196mr87299559pfc.70.1555594581943;
        Thu, 18 Apr 2019 06:36:21 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id c18sm3940253pfc.0.2019.04.18.06.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 06:36:21 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 18 Apr 2019 23:34:31 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 07/10] vsprintf: Consolidate handling of unknown
 pointer specifiers
Message-ID: <20190418143431.GA16037@tigerII.localdomain>
References: <20190417115350.20479-1-pmladek@suse.com>
 <20190417115350.20479-8-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417115350.20479-8-pmladek@suse.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/17/19 13:53), Petr Mladek wrote:
> A reasonable compromise seems to be writing the unknown format specifier
> into the original string with a question mark, for example (%pC?).
> It should be self-explaining enough. Note that it is in brackets
> to follow the (null) style.

Hmm, seems that error string now sometimes try to `guess' what was the
error, but the guess can be misleading.

A very small example.
flags_string() can have a number of fmt specifiers - p, v, g.

        switch (fmt[1]) {
        case 'p':
                flags = *(unsigned long *)flags_ptr;
                /* Remove zone id */
                flags &= (1UL << NR_PAGEFLAGS) - 1;
                names = pageflag_names;
                break;
        case 'v':
                flags = *(unsigned long *)flags_ptr;
                names = vmaflag_names;
                break;
        case 'g':
                flags = *(gfp_t *)flags_ptr;
                names = gfpflag_names;
                break;
        default:
                WARN_ONCE(1, "Unsupported flags modifier: %c\n", fmt[1]);
                return buf;
        }

The new error message, however, will hint '%pG', which may or may not
be helpful.

> -char *flags_string(char *buf, char *end, void *flags_ptr, const char *fmt)
> +char *flags_string(char *buf, char *end, void *flags_ptr,
> +		   struct printf_spec spec, const char *fmt)
>  {
>  	unsigned long flags;
>  	const struct trace_print_flags *names;
> @@ -1760,8 +1767,7 @@ char *flags_string(char *buf, char *end, void *flags_ptr, const char *fmt)
>  		names = gfpflag_names;
>  		break;
>  	default:
> -		WARN_ONCE(1, "Unsupported flags modifier: %c\n", fmt[1]);
> -		return buf;
> +		return string_nocheck(buf, end, "(%pG?)", spec);
>  	}

Wouldn't it be better to use fmt[1] instead?

	-ss
