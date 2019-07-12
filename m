Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A547DC742D1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F47204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFUccy8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfGLRls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 13:41:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35825 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfGLRlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 13:41:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id y4so10816293wrm.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 10:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8Sk2j8JpiarrHH+mMpLn0vCmOZd+7aDxp+pTPPJ43ek=;
        b=BFUccy8iETEi2uMeYIpxn10y3rySO8OyrV5VMo1hakzUJLJX0P8JoUOJofwMHzOlao
         pxnfv8gznNh7bTOJqBbJjr89a2f6GqNNPjK+tus/pRVmZdy2sK5yDlPbuXd+O4gdZ/xg
         MlikeshPkF5f65cittRNUFaRq1c0xpOF24m+pgo2//tNLdeWOJkxdTkJm6cm60HjdgHD
         zUPSA5EvpBI+Vv2EIlehfUsY3FZOiXMmrKC30SLRAoA1awpVOqgi8+W+6qHoGn68I3/i
         IJDuVEP9rpREEyuWV/ikn+jwkJ/Pq4vgAK8kxubDv8Op0+0nW1/S4rxYEIok9G3Zj5oW
         MYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Sk2j8JpiarrHH+mMpLn0vCmOZd+7aDxp+pTPPJ43ek=;
        b=YXT+6c+af9EpjpgD67e3sOxy6+z0eHKBnmEM35W9xm7r6c6W2l0mJJ6FciNOGDcCmo
         OH3u/MAyt8JPUYy9UB0EmDcxa/tr3EgM0Zct0BmvxnM50Ud+hT+7DOoqL83nshR1YB8B
         nerYuPQhF/V8AWvh7IwpWWslPz9MCWo3M24EWNJULm9pqba3mEE9teV1ih+XC5OChA6B
         J9CKnTZQan8hpGXDR82M5fEPbW+2pIk1aPcIOHtaScR6EXjufY9i+XHGq9cQlY4D92RX
         cClC2BM3WArXymMvi6R1OrNp9ZLf5H4vPpeO1C6Ta7rqspPrAycUtjfa9sFrhlbY9zVE
         gHxQ==
X-Gm-Message-State: APjAAAXnFNoyeQq6oz5vGwU5H775Wolt8wJng9s9DXXRNZkALQGlEQOM
        SVAc4RG8ygEeZPx8cUqxWjU=
X-Google-Smtp-Source: APXvYqw9PWTYBtpUXytLl1AD7R8fhesxJYUO9/lt5TBIRnZCI37eIQh14YFIFKgnPlbqNv3c7MYNjQ==
X-Received: by 2002:a5d:4e06:: with SMTP id p6mr13041320wrt.336.1562953304940;
        Fri, 12 Jul 2019 10:41:44 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id y10sm6656269wmj.2.2019.07.12.10.41.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 10:41:44 -0700 (PDT)
Date:   Fri, 12 Jul 2019 10:41:42 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Petr Mladek <pmladek@suse.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] xen/trace: avoid clang warning on function pointers
Message-ID: <20190712174142.GB127917@archlinux-threadripper>
References: <20190712085908.4146364-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712085908.4146364-1-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 10:58:48AM +0200, Arnd Bergmann wrote:
> clang-9 does not like the way that the is_signed_type() compares
> function pointers deep inside of the trace even macros:
> 
> In file included from arch/x86/xen/trace.c:21:
> In file included from include/trace/events/xen.h:475:
> In file included from include/trace/define_trace.h:102:
> In file included from include/trace/trace_events.h:467:
> include/trace/events/xen.h:69:7: error: ordered comparison of function pointers ('xen_mc_callback_fn_t' (aka 'void (*)(void *)') and 'xen_mc_callback_fn_t') [-Werror,-Wordered-compare-function-pointers]
>                     __field(xen_mc_callback_fn_t, fn)
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/trace/trace_events.h:415:29: note: expanded from macro '__field'
>  #define __field(type, item)     __field_ext(type, item, FILTER_OTHER)
>                                 ^
> include/trace/trace_events.h:401:6: note: expanded from macro '__field_ext'
>                                  is_signed_type(type), filter_type);    \
>                                  ^
> include/linux/trace_events.h:540:44: note: expanded from macro 'is_signed_type'
>  #define is_signed_type(type)    (((type)(-1)) < (type)1)
>                                               ^
> note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
> include/trace/trace_events.h:77:16: note: expanded from macro 'TRACE_EVENT'
>                              PARAMS(tstruct),                  \
>                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/tracepoint.h:95:25: note: expanded from macro 'PARAMS'
>  #define PARAMS(args...) args
>                         ^
> include/trace/trace_events.h:455:2: note: expanded from macro 'DECLARE_EVENT_CLASS'
>         tstruct;                                                        \
>         ^~~~~~~
> 
> I guess the warning is reasonable in principle, though this seems to
> be the only instance we get in the entire kernel today.
> Shut up the warning by making it a void pointer in the exported
> structure.
> 
> Fixes: c796f213a693 ("xen/trace: add multicall tracing")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Nick suggested this as well, I think it's reasonable to work around it
in this one location since this is indeed the only instance of this
warning that I see in the kernel tree across all of my builds.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
