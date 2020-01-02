Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94FAC2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7539521655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="OXFQiSuv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgABHrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 02:47:09 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44846 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgABHrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 02:47:08 -0500
Received: by mail-lj1-f194.google.com with SMTP id u71so39853026lje.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 23:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UMsZF9sy1sW5J3kVgI/fUJy6gl0uFtVuKYIkDGAzFWk=;
        b=OXFQiSuvcrGsBxZPaeQirPMFrClNc9rDGbdyE6WGJrLnluSMK/JxkV6wp3qL3rrGcg
         0W9yJj/F/VsGBt1ubZQiz5WOVNVXq+K4JE9iUJHCTqRu2NPvcNHPkqF3HqMmEVTWLjdo
         eOuQVuA14rxB2aatZqQHIOTFs7x3bg6wO5LBoaMjaG7OBpLxL+HE6xUQcbuZYOVMOZVi
         tKCutxoMGHTdyMj7Bxfk9EZMInhx0rPic1cpynmCz0/B9rIU/S2YtffUNkjXm4t/UK5e
         whbNjDIPkHBZ7wO37ouNQgaJ/UvxTA49ndlm3LDOEoOY4nYBbAd2ejQdXoLAntOuqeIM
         Ergg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UMsZF9sy1sW5J3kVgI/fUJy6gl0uFtVuKYIkDGAzFWk=;
        b=a0cXByHH5JXCTJpVhiGDcpIM2ihGeZRs8oF05czhdJBxPtFwZrsA74UjlGmL4UZYD8
         O1C4qwqZLrtzHFNf+zSWxkaeUVs4/gHLmreSVcG60f7QCDu5IS3LrXzwTilHXObNxckR
         f9gZjqrMMewnI70Be6pupiklsNDz/VMc3+WmWWbNmxQ52OvcmPKV7zg8kCHWyTQEP2xS
         oDwbOA/a0Chy/9VRdxkQ7ZTkK7QuQ6NezCWS9HpTiPw6v/B10XxXQ/8LF5iEzHRCQ5Lb
         14Lni1WTZxxazGi4SzbYK7++4Ikg1mfPe2L0BSqbKtVSKGk96/tNkXZprZ+s0ZOAzIO+
         gjig==
X-Gm-Message-State: APjAAAXsO008LpVsD/9NxxUM64hiF/Fq4czU/mWth0MzY0O7jiK7mCl/
        HfhFXyV8dlgP91lNH+grLl4WVQ==
X-Google-Smtp-Source: APXvYqzXvJvrB746bC+D5/vKo4dprhrPwEdoz38wU1naeszOJA2/HlfkUqvs1vOG8GuyNYSLVhd1MA==
X-Received: by 2002:a2e:8651:: with SMTP id i17mr38826910ljj.121.1577951226498;
        Wed, 01 Jan 2020 23:47:06 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u16sm22081579ljo.22.2020.01.01.23.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 23:47:05 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id D26CE100528; Thu,  2 Jan 2020 10:47:05 +0300 (+03)
Date:   Thu, 2 Jan 2020 10:47:05 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v7 1/4] x86/insn-eval: Add support for 64-bit kernel mode
Message-ID: <20200102074705.n6cnvxrcojhlxqr5@box.shutemov.name>
References: <20191218231150.12139-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218231150.12139-1-jannh@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 12:11:47AM +0100, Jann Horn wrote:
> To support evaluating 64-bit kernel mode instructions:
> 
> Replace existing checks for user_64bit_mode() with a new helper that
> checks whether code is being executed in either 64-bit kernel mode or
> 64-bit user mode.
> 
> Select the GS base depending on whether the instruction is being
> evaluated in kernel mode.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

In most cases you have struct insn around (or can easily pass it down to
the place). Why not use insn->x86_64?

-- 
 Kirill A. Shutemov
