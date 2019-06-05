Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22DAC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69C2206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E94e8Jwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfFEWEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 18:04:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43750 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfFEWEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 18:04:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so84255pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 15:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z9pLT8wo4kRTr+gtCA1M1Ly0FQFsqlnRs1HGSmoPjII=;
        b=E94e8JwgQ1kjzgi3CKj3KO4Qd7M8QoL1kgN7bbFarmoeIjauidKKrEvWajXojiYvQ/
         mHIfWo89t6E1p1YP5+1JmZD2CGUB6k9L9m6EsRQC1PazIM8rW/MDn7SUjLgIMcuKKHwh
         I3kjpWYZ5nH/3EkDoehZP0AFenDdcZAi5161Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z9pLT8wo4kRTr+gtCA1M1Ly0FQFsqlnRs1HGSmoPjII=;
        b=AU3MS9zRnOh2NcoqYIOLeGEOMglbo8SAc+e3yZkqX0QC3uW0WFTezb1QNiVsiAGUsQ
         66nCfpjKTSDEShWG2WzDXq3QARKAgZAK/vcBCuvjOk9bC/cgOjca3WvW51ZCXyTQTkq5
         s/8XjmjWoGgh7rZrkYW9tOMS5c3CQLUEjOJWh/Q5hnK9Uj6ydegzenxETvJnF5WRA+2z
         oQ69x2JHjWHvzb7fFOxP38PPBb3EdtHduZ2/iFNbjcHFEOlLNoZZE5kn2x5kFBvEkdd6
         TfF9eNobo4UyoxNi2kDiAL+oEXcE6rwMf6eD+lN5H3BPDpEpH0YJDeYuBQW/App/0iAM
         x6KA==
X-Gm-Message-State: APjAAAVhev3YKESRXMYAbPlcrjgpCqUz2r+r/wx+rtkhr9Sj5XacWPGd
        qVoYjTqJcvWihdIQbnuYtbFxTA==
X-Google-Smtp-Source: APXvYqygxgCCFNGSe8MQ3vUVRmt6rBIiTDwLWg2bJm+/6PKlMLuvNBmD/F/ExTPEkkybIRsB1JGNnA==
X-Received: by 2002:a63:e358:: with SMTP id o24mr68099pgj.78.1559772249489;
        Wed, 05 Jun 2019 15:04:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m11sm3969pjv.21.2019.06.05.15.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 15:04:08 -0700 (PDT)
Date:   Wed, 5 Jun 2019 15:04:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "George G. Davis" <george_davis@mentor.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Jiri Kosina <trivial@kernel.org>,
        Julien Grall <julien.grall@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] ARM64: trivial: s/TIF_SECOMP/TIF_SECCOMP/ comment
 typo fix
Message-ID: <201906051503.010FF2AF@keescook>
References: <1559766612-12178-1-git-send-email-george_davis@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559766612-12178-1-git-send-email-george_davis@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 04:30:09PM -0400, George G. Davis wrote:
> Fix a s/TIF_SECOMP/TIF_SECCOMP/ comment typo
> 
> Cc: Jiri Kosina <trivial@kernel.org>
> Signed-off-by: George G. Davis <george_davis@mentor.com>

Sneaky missing "C"! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm64/include/asm/thread_info.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index eb3ef73e07cf..f1d032be628a 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -75,7 +75,7 @@ void arch_release_task_struct(struct task_struct *tsk);
>   *  TIF_SYSCALL_TRACE	- syscall trace active
>   *  TIF_SYSCALL_TRACEPOINT - syscall tracepoint for ftrace
>   *  TIF_SYSCALL_AUDIT	- syscall auditing
> - *  TIF_SECOMP		- syscall secure computing
> + *  TIF_SECCOMP		- syscall secure computing
>   *  TIF_SIGPENDING	- signal pending
>   *  TIF_NEED_RESCHED	- rescheduling necessary
>   *  TIF_NOTIFY_RESUME	- callback before returning to user
> -- 
> 2.7.4
> 

-- 
Kees Cook
