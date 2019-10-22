Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589B2CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308AF2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Akp0RE/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbfJVQ1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:27:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45789 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731132AbfJVQ1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:27:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id b4so2040835pfr.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 09:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yCqef9gQT6nmyTqqGL+wlHZ1CGtJs3cHNc9rYV1fhGQ=;
        b=Akp0RE/L/DluE7lJNU+chwNolLm4k9jsXnFTp9tcKG5xdcIVWiC2r0h9i0cwWyG7m7
         1M0XchljXyxrcF5F3z8kYQRl4stUEGdCXI7OA+TvymmMfiDz9QjnwWIItRChIyof8pgy
         LqJ1hg3+WyGv6FMYaKq9RKP9Q3ZF+joMQTEmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yCqef9gQT6nmyTqqGL+wlHZ1CGtJs3cHNc9rYV1fhGQ=;
        b=YBkjz2rOt13LoUTuJq+nXithA73ElzIeETrJ9I6ceqhA6ygnNXGjbOAtaCRIqgZYIL
         JlKrYLcXgPQRqrdWHHHE57ihmPhfFMEaYe4qf4vWJiaKhnYIXkuCqDD36lAB5LMfUBHZ
         xE92JmV9m5JMPZa6TO+zwsbuYtSjI5EAmIVyd8xc/lrabgjDiRzoAKp6oprBlUZbaa1v
         iss9wUv+gmQpNXDxz250RmiyLraduPSqBbENNI+Lpl1miWopwcf6d6pWPKOJ20pB3L4R
         d+NhKmkMQHklgLSWoboyQEbshP5grfOhLNa1ljefqFVHPet/bNr3ukhR4UTwj/BdgvUL
         lWvA==
X-Gm-Message-State: APjAAAUjyQ6oaduvykwtDzYFMjBXwTL279sSIHNnV0vI0bm+V4x/R0FL
        RWZ548loH6VKJjEh5F02VHoD6w==
X-Google-Smtp-Source: APXvYqy0V08cVd3k9DTb6b5fAVT9pV7tar1OJtZIZQ+pxwtsG2Lik9okZfxhxg4bRHHBWocLCOzgYQ==
X-Received: by 2002:a63:68c8:: with SMTP id d191mr4555216pgc.197.1571761662807;
        Tue, 22 Oct 2019 09:27:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r30sm20868424pfl.42.2019.10.22.09.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 09:27:42 -0700 (PDT)
Date:   Tue, 22 Oct 2019 09:27:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/18] arm64: reserve x18 only with Shadow Call Stack
Message-ID: <201910220926.B78C4D88@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-13-samitolvanen@google.com>
 <CAKwvOd=rU2cC7C3a=8D2WBEmS49YgR7=aCriE31JQx7ExfQZrg@mail.gmail.com>
 <20191022160010.GB699@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022160010.GB699@lakrids.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 05:00:10PM +0100, Mark Rutland wrote:
> If we wanted to, we could periodically grep for x18 to find any illicit
> usage.

Now we need objtool for arm64! :) (It seems CONFIG_HAVE_STACK_VALIDATION
is rather a narrow description for what objtool does now...)

-- 
Kees Cook
