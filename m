Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9026ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 16:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FCC20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 16:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mHXoFaiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfJJQn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 12:43:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40218 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfJJQn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 12:43:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so4256857pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 09:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WcFO8qPZ/AFTCPgcIosbPBf6WzJZhu5LC0txwMdDqq0=;
        b=mHXoFaiWr2KtDyo6AUfULISKrSL60dcxTqzjwiK6Uaub6ukWcxzvR35aRbJ/vlu4UK
         btOqmAHm7PlUoeM5gAlSvg067gi9jVrpkKoXlKtP6V0vU2ST37HIbIHFg92Bf8qEYVHH
         +sfpnRnP7n2dw4DiSrshnBTPiQgOvR4ZRzhEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WcFO8qPZ/AFTCPgcIosbPBf6WzJZhu5LC0txwMdDqq0=;
        b=CKP9q1YEGDkxm3tQgkDMWyMAiL4bTM0qGorHa+GZm5FQpO74G6zlZdR+UwNR44Inja
         dVfnzvWG/BmIWEoz06fSFVOWw5+xndbnuIXu9kuRfQPbroF91JlDADa3vq49HhhYXojm
         K3Jin8fDGOsndKSUEJ84Rw94o1AumlC3BpjQKcQ+Gv+AgRZoUcyTzJ8ORd1I+ACWoagg
         wq4DohyzXjfr1ff/Q/9JKSVmrn+YVXXxzY373G+B326nkgjaNeWLyBKz7ZchhVfVF6Qx
         OJN/2av7lku3GyftDfP9+SRcWnYqQd0d4CgVzWQie0HxSpKSeQ7FrpjU2iNySfdyUee6
         WsXA==
X-Gm-Message-State: APjAAAUH9Qa7Y74zFw9FdDOhhICIcNyW7WcsqHMQ/PPBVTpV0Pndbjyj
        xWL0Pl/j6w4mDnE3ZAzbhEvRfA==
X-Google-Smtp-Source: APXvYqxsqHZmX3PXU0VomobcpD35C37svv1v7Kpb0+mVbvks+MlYD9SD3jPPE8rJ5DviVJ/s9RX1pQ==
X-Received: by 2002:a62:ed01:: with SMTP id u1mr11730140pfh.122.1570725808519;
        Thu, 10 Oct 2019 09:43:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l62sm8332515pfl.167.2019.10.10.09.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 09:43:27 -0700 (PDT)
Date:   Thu, 10 Oct 2019 09:43:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] lib: introduce copy_struct_from_user() helper
Message-ID: <201910100943.4C6AB66@keescook>
References: <20191001011055.19283-1-cyphar@cyphar.com>
 <20191001011055.19283-2-cyphar@cyphar.com>
 <87eezkx2y7.fsf@mpe.ellerman.id.au>
 <20191010114007.o3bygjf4jlfk242e@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010114007.o3bygjf4jlfk242e@yavin.dot.cyphar.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 10:40:07PM +1100, Aleksa Sarai wrote:
> Yeah, it takes about 5-10s on my laptop. We could switch it to just
> everything within a 4K block, but the main reason for testing with
> 2*PAGE_SIZE is to make sure that check_nonzero_user() works across page
> boundaries. Though we could only do check_nonzero_user() in the region
> of the page boundary (maybe i E (PAGE_SIZE-512,PAGE_SIZE+512]?)

Yeah, I like this idea: just poke at the specific edge-case.

-- 
Kees Cook
