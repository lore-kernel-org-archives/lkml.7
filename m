Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C192C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B75320663
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lXXWzyMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfHLR6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 13:58:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45352 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfHLR6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:58:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id o13so49853648pgp.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 10:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1erNNaRmZnyWkQt/DrclmgvWnql7ho7Foo2FJUHD6as=;
        b=lXXWzyMjDH5TeHtbdRFhkEjkV47HTYV3Vf7/YAcY2UCGzLQu8E5YZKbOSBBFievTjb
         ruCp9bs6dq2WGfKVAjLkHHlc+CeX9kn/s6gzt3o6JhIP4qyV518mmIWUMrVCikmgwII1
         2Lzno6qbDQW1yuALyl/iUbEeshVBxQnaVlCxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1erNNaRmZnyWkQt/DrclmgvWnql7ho7Foo2FJUHD6as=;
        b=MRTUonJMnAhg4VlDAiZ7Hn2m45EjCzTylOSWcXAhK3rtx3htF8M7paQsdv0aAMItjt
         Z45TukIrTQJv2wZSDR31F45J34yqomjzNKXRQgeNEqjRspVfPWRLCRlJ+XnL089ZNm7+
         ukqPt3M1j1gti6LlnheOBG5owr9EdH/kCVI7dNjQfifC323WEEXB5TBDFtVB2/m0TfaS
         Fx/wWNSkNpWZ7qezF+dFD8tNQyqWJkpyzO55LUgixpRh8sLA6y3bugPhZAD48GoryN5r
         AzW3F2yysZ+yM9mB3RbhYdUnX8iiX2/MN+F7BE8g23A+4tO+zYeD/0EgloT/ho7xVH3b
         yQbw==
X-Gm-Message-State: APjAAAXjsjWmHH4zDB2imsq1LsbJkMgkLboc4P/48h7ELGggSCTtD6u5
        dr8/3RMntuOjAIATkMLU4Qjlbg==
X-Google-Smtp-Source: APXvYqzIL/ii78dQ8BFRBPLdJqqMoMehADxBmc3BeycFVL6zPCWpdl1sOBjIrPBoPs6B/tqvTB0XmA==
X-Received: by 2002:a63:5f09:: with SMTP id t9mr31418071pgb.351.1565632693539;
        Mon, 12 Aug 2019 10:58:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n5sm113918495pfn.38.2019.08.12.10.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 10:58:12 -0700 (PDT)
Date:   Mon, 12 Aug 2019 10:58:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     akpm@linux-foundation.org, joe@perches.com,
        johannes@sipsolutions.net, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: Re: [PATCH v3 0/3] Add compile time sanity check of GENMASK inputs
Message-ID: <201908121055.7DC9244@keescook>
References: <20190801230358.4193-1-rikard.falkeborn@gmail.com>
 <20190811184938.1796-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811184938.1796-1-rikard.falkeborn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 08:49:35PM +0200, Rikard Falkeborn wrote:
> Hello,
> 
> A new attempt to try to add build time validity checks of GENMASK (and
> GENMASK_ULL) inputs. There main differences from v2:
> 
> Remove a define of BUILD_BUG_ON in x86/boot to avoid a compiler warning
> about redefining BUILD_BUG_ON. Instead, use the common one from
> include/.
> 
> Drop patch 2 in v2 where GENMASK arguments where made more verbose.
> 
> Add a cast in the BUILD_BUG_ON_ZERO macro change the type to int to
> avoid the somewhat clumpsy casts of BUILD_BUG_ON_ZERO. The second patch
> in this series adds such a cast to BUILD_BUG_ON_ZERO, which makes it
> possible to avoid casts when using BUILD_BUG_ON_ZERO in patch 3.
> 
> I have checked all users of BUILD_BUG_ON_ZERO and I did not find a case
> where adding a cast to int would affect existing users but I'd feel much
> more comfortable if someone else double (or tripple) checked (there are
> ~80 instances plus ~10 copies in tools). Perhaps I should have CC:d
> maintainers of files using BUILD_BUG_ON_ZERO?
> 
> Finally, use __builtin_constant_p instead of __is_constexpr. This avoids
> pulling in kernel.h in bits.h.

Cool; I like this. I spent some time convincing myself that the
side-effects really aren't double-evaluated, and it looks fine to me. :)

For the series:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

