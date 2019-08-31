Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B0BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 19:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BF221874
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 19:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dlgvG8eY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfHaTCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 15:02:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47103 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbfHaTCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 15:02:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id o3so4789039plb.13
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 12:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZfFm6r3JOqEydofTNyuh4bAPJtkbL/0OkBXvCDSO3i0=;
        b=dlgvG8eYRMaMeM92iutmfwBcjfRYro/1023f7K2yZK8fcKRkSCxKCaHdRZ16zEzF4G
         +KlLBV6odsSkUE6iKg4fSNPoqYhWboYSJB2Dl32u40X0wFcQBp67hauNSNcqrMRAVCW+
         j3E0VlIHJm1fFgBg80Ky9mAFfCmCQ88m1+cWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZfFm6r3JOqEydofTNyuh4bAPJtkbL/0OkBXvCDSO3i0=;
        b=jGS/WUJbmX48cTcLjosddvZ6qfQr+VoHIXLXYgRSRxQetSQoYa11M2cA17ElCgtXo9
         7pRsOv28qvDBBxbx8cNAszpEKxuaeGlDZalKYckIGisCYC2tqzf6+Kca/0iL8ne5MCvb
         kE6ruwTRkoNDjLZEb42UEQq5TxkgGQsgaPHpcosRLSyajw0/QPzunu+WvBs0zFGhxOKv
         32PPxK5lB6idicYWolftY8iVYYm/R2IPwyoccizAiTdCefL/XnMmZjZqx0S/OOM+1+4d
         71kQ4peI4aPCIOYexwOYfG8R7HLszNQagU08O1f+wbFPj9IZZlzwDkGasWOaYnMUMCwd
         esLg==
X-Gm-Message-State: APjAAAU3VwZxVCToE5YQeMBFdoXPeVUFaathvaoqwirgPxC2YUyK7eGw
        bNzV+/W3P/34l0ByLngm73EzPg==
X-Google-Smtp-Source: APXvYqx0FbDpX+TZ/mbXiMkb0KXQX/S/FzklqT0mSbAfZd2tUbgpog6PC5lMVjZaNcpadM2AFbsCLA==
X-Received: by 2002:a17:902:e83:: with SMTP id 3mr20781319plx.319.1567278165861;
        Sat, 31 Aug 2019 12:02:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l6sm12626662pje.28.2019.08.31.12.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 12:02:44 -0700 (PDT)
Date:   Sat, 31 Aug 2019 12:02:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH v2 0/6] Rework REFCOUNT_FULL using atomic_fetch_*
 operations
Message-ID: <201908311200.926B5C0F@keescook>
References: <20190827163204.29903-1-will@kernel.org>
 <20190828073052.GL2332@hirez.programming.kicks-ass.net>
 <20190828141439.sqnpm5ff4tgyn66r@willie-the-truck>
 <201908281353.0EFD0776@keescook>
 <CAKv+Gu_Q=o_6xDW_7YTd3J6psqs-o+qBxW4r9MXCBwjmsGpTbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_Q=o_6xDW_7YTd3J6psqs-o+qBxW4r9MXCBwjmsGpTbQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2019 at 08:48:56PM +0300, Ard Biesheuvel wrote:
> It's been ~2 years since I looked at this code in detail, but IIRC, it
> looked like the inc-from-zero check was missing from the x86
> implementation because it requires a load/compare/increment/store
> sequence instead of a single increment instruction taking a memory
> operand. Was there more rationale at the time for omitting this
> particular case, and if so, was it based on a benchmark? Can we run it
> against this implementation as well?

It was based on providing a protection against the pre-exploitation case
(overflow: "something bad is about to happen, let's stop it") rather
than the post-exploitation case (inc from zero, "something bad already
happened, eek") with absolutely the fewest possible extra cycles, as
various subsystem maintainers had zero tolerance for any measurable
changes in refcounting performance.

I much prefer the full coverage, even if it's a tiny bit slower. And
based on the worse-case timings (where literally nothing else is
happening) it seems like these changes should be WELL under the noise.

-- 
Kees Cook
