Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C056AC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB418206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gLQ0w0Ix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfKMSdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:33:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37257 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfKMSdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 13:33:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id z24so1897888pgu.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 10:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OhPSTTe4Xdz6gOjsaJlaEdC5pAfYubYxDCg4SrgVoSo=;
        b=gLQ0w0IxUEQnchYuilJR1nbU4m7SgY//cNaWQR/mt0lvyefOxSBkOsqifZytiwFIh0
         GkBnn3qUVJAEMrTsVlq+svxxCP/slE/95ux0WpqRsVgnTHuEvwwCdJWa6c+0L9ne+iP7
         6ydiQoWKF8IYJkGO42ArzjKHFxLH3sDY6CwOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OhPSTTe4Xdz6gOjsaJlaEdC5pAfYubYxDCg4SrgVoSo=;
        b=GM1uOAgdvomErxWelaiyHhJMeHevzv3Ww1GQwoz1Wemo6H0mqM3nCrvYXnzG1CvyK0
         Hl/cZLcNPVGfvhxZLacar/5dAqS9E8auhoTKM0YgwxLYV3vHkGWN7r1lbkK7u+Ka92+z
         sRvUz5W3y+rX1VfsOswJeHkUjdFbNYLWifnDbRjwN1Qlq1EGd/5HApszFRWWGsrkOdvc
         5cogW106KyYTPlgUgHxl8EkBhlC661ypJWq/Q1A1y5C/0Q3e+dQeRuaLeaEzLMFfSHY4
         mWxRdbBY5UIlP/uztLS3KMppxmb4rCt/VbCot7VDBXo/FhDhWywlZfMZmbg7kA2+i8a6
         GG/w==
X-Gm-Message-State: APjAAAWGpmMaAs8NToUw83mfDvvNxddks/vZ1/6RVre5mM7jZHr7xol3
        Qgfw7FrnEq6CTaWqmUrUZFwyNA==
X-Google-Smtp-Source: APXvYqyLkzEBHbWiCqJacPQ3CBKaBpCEr8iph2zitT6ozdOmqjw+YxPYFt/3IfvrDawkJj7K8FBEVg==
X-Received: by 2002:a62:20e:: with SMTP id 14mr6074555pfc.153.1573670020389;
        Wed, 13 Nov 2019 10:33:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k84sm5150717pfd.157.2019.11.13.10.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 10:33:39 -0800 (PST)
Date:   Wed, 13 Nov 2019 10:33:38 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
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
Message-ID: <201911131033.435C8F77D@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191105235608.107702-1-samitolvanen@google.com>
 <201911121530.FA3D7321F@keescook>
 <20191113120337.GA26599@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113120337.GA26599@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 12:03:38PM +0000, Will Deacon wrote:
> On Tue, Nov 12, 2019 at 03:44:42PM -0800, Kees Cook wrote:
> > On Tue, Nov 05, 2019 at 03:55:54PM -0800, Sami Tolvanen wrote:
> > > This patch series adds support for Clang's Shadow Call Stack
> > > (SCS) mitigation, which uses a separately allocated shadow stack
> > > to protect against return address overwrites. More information
> > 
> > Will, Catalin, Mark,
> > 
> > What's the next step here? I *think* all the comments have been
> > addressed. Is it possible to land this via the arm tree for v5.5?
> 
> I was planning to queue this for 5.6, given that I'd really like it to
> spend some quality time in linux-next.

Sounds fine to me; I just wanted to have an idea what to expect. :)
Thanks!

-- 
Kees Cook
