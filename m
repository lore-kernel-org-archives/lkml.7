Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4869C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBFE206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V8X9HHxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKLXop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 18:44:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46716 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLXop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:44:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id 193so210449pfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 15:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EcHuuFp0uXLbkkRAA858XYtBunr2zA+LeQirH7UYVa4=;
        b=V8X9HHxHiG0Is+chnq9hKdAdntFAww1rSfsLxVyiP7E6i67FTXBjLe2zS+ZMOC8b1k
         Dx0K/KLvXeHKck7H32Glr39l0lktqFgwNo89bALI4mv0oKnxAMk8fH/ycmz15f5xUEiI
         MHSQl1bOX0rd1bQotssKgZXS0uaqqO2dwUxpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EcHuuFp0uXLbkkRAA858XYtBunr2zA+LeQirH7UYVa4=;
        b=qGxQb7283D0oA01fJJJNCe8sylDsHVBhZ/hY2K0afcCi2crDzIRupCDX9uB2ZvyGym
         DekDVqOjsfxkndjO09GYznW4blqf4oJoDFyTTHGwyoMAS9UZWJ9xWeDXy7p8iky42BIP
         y8EEQOq3QG6RhVci52ICLZBwjIhOdiNjkaSLnWTwgBuGV3aXGjw2Evm+C0n8tnPFiIcR
         3a98+FbqSjuTGbGYyqOCwj6txracOHCVmJgLqItZwhRmoWd4px6jwWuaFuX+SvVLq5lw
         pKCV7X+k+waThvsBDEEEx+DCFoBcdccbYFLVEqgp8Dg9OpbqXJmcKr4AtbZNXnfr2yFf
         6PvA==
X-Gm-Message-State: APjAAAVtPWtzwN9E2WI5dRncd420ksEx1ZqyO740m8dE/1Uek+/Ou6fg
        PBL0rdtQXol1cKjRgjp/lhx8Ig==
X-Google-Smtp-Source: APXvYqy2qGlhbJhYD2XTlLrDucG7ETmNR5WevbQ8m/DZKdYkJBrkAiHNHZ0RU582wg1P7ojJiuH82g==
X-Received: by 2002:a65:6149:: with SMTP id o9mr186489pgv.228.1573602284496;
        Tue, 12 Nov 2019 15:44:44 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v10sm86650pfg.11.2019.11.12.15.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:44:43 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:44:42 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/14] add support for Clang's Shadow Call Stack
Message-ID: <201911121530.FA3D7321F@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191105235608.107702-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105235608.107702-1-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 03:55:54PM -0800, Sami Tolvanen wrote:
> This patch series adds support for Clang's Shadow Call Stack
> (SCS) mitigation, which uses a separately allocated shadow stack
> to protect against return address overwrites. More information

Will, Catalin, Mark,

What's the next step here? I *think* all the comments have been
addressed. Is it possible to land this via the arm tree for v5.5?

Thanks!

-- 
Kees Cook
