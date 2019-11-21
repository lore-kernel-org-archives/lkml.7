Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE932C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B13120658
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hG0sz14Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfKUR5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:57:39 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35872 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUR5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:57:39 -0500
Received: by mail-pg1-f194.google.com with SMTP id k13so1986593pgh.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 09:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BsdpXUBK/+PDo/bGd1kVifJ4d8KCjaa55rIEdqK/BXE=;
        b=hG0sz14Yni3p0qWbUJNX13B9DuEdfLpP+nS/rEmsrX4M5OTRctvejjuqOfyrYI9zQq
         RpGH7ur7MB1V7e9yxodQEa3kY26yeKYqW96dSDjOPOueXGKD1T+hMSHo1msATxMJokHy
         DwFCc3rTLf34Ino8r6gOOFxERJ57Y0oA23sms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BsdpXUBK/+PDo/bGd1kVifJ4d8KCjaa55rIEdqK/BXE=;
        b=U0bqd827umTrW/boWofMJQ8AT+WIUKl6hjfoNBiyQhVsKS6ORGYs3HSSzeiuXuIycq
         O20yTuslavdRLCxFYwkUEC9FjXwHAdQpCiBOFwYJCc7B5QWxlwIIkVZPzuKaJ9qNX1Im
         ks8cqUMxQT+1GkA7IwTk+sJmrrAeWWLxG+pa0znDZJl0oI4Jwg0T2j6THFjKZbHvWvCG
         suOwS/vwj582yHnLC23zBQHShGN8xgFKhmGcxNfa2TSJG6Q4FfGdBPFEqU5p+YVnZHZE
         hveVw6VR3ysg/KiyCIMitfDTgTiNjmbS7/3L2sd0gTdZN0PxFrdDZj3bWtVFUX+PJ0ot
         pJ1w==
X-Gm-Message-State: APjAAAXVnNl41y2PIrv23kqErf7aKpK+8zAAy4t34AnPo5bPAnCUmhek
        0MMzSI/Ekjo7BPrKoLK4+r8www==
X-Google-Smtp-Source: APXvYqyqyLTCo109VwURE2Z+5MDb30JwQiuSUJ4BxXSBWfsR0v3JOl8GeyYN9tpZZT008lgQyTI29w==
X-Received: by 2002:aa7:96c5:: with SMTP id h5mr12206977pfq.101.1574359057218;
        Thu, 21 Nov 2019 09:57:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k4sm4213316pfa.25.2019.11.21.09.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 09:57:35 -0800 (PST)
Date:   Thu, 21 Nov 2019 09:57:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Elena Petrova <lenaptr@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 1/3] ubsan: Add trap instrumentation option
Message-ID: <201911210942.3C9F299@keescook>
References: <20191120010636.27368-1-keescook@chromium.org>
 <20191120010636.27368-2-keescook@chromium.org>
 <35fa415f-1dab-b93d-f565-f0754b886d1b@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35fa415f-1dab-b93d-f565-f0754b886d1b@virtuozzo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 03:52:52PM +0300, Andrey Ryabinin wrote:
> On 11/20/19 4:06 AM, Kees Cook wrote:
> > +config UBSAN_TRAP
> > +	bool "On Sanitizer warnings, stop the offending kernel thread"

BTW, is there a way (with either GCC or Clang implementations) to
override the trap handler? If I could get the instrumentation to call
an arbitrarily named function, we could build a better version of this
that actually continued without the large increase in image size.

For example, instead of __builtin_trap(), call __ubsan_warning(), which
could be defined as something like:

static __always_inline void __ubsan_warning(void)
{
	WARN_ON_ONCE(1);
}

That would make the warning survivable without the overhead of all the
debugging structures, etc.

-- 
Kees Cook
