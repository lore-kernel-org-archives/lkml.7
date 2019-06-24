Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D45C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15BA213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TvXMMqyn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfFXMvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 08:51:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40331 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbfFXMvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:51:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so13239663wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 05:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=V3PN7+Kr/tucktHOq459ffhVuFT8vFVeNdn3CWQcOqs=;
        b=TvXMMqynMJ9F3R8PSllCw3D53Zv+6ul3QP1YWFwld//r+zWK/6tW2Cg1h4EEU5f2az
         na4AjvEKtFLrIPOSdpBSAGuAgvhEeRkZ7S/iQlwZ1vFDkqqgfvOZ+FLpkHVwgj6nC7pU
         nuL/7FbuLNJ514VttRDd9EvuasI4d1R7u+5vz0gEjKWjANT2gVGfOcxe07DIG2e7w+q0
         4o8hgviHyZN9wIXbr63XDzpmLEvB8p+ffPJiRKyr6ci7o2jM3nEg5OmlvOOCnwXvMzW+
         /tK/hki6IwlCPeqrFvT6/a+BbGyewJWs561wIY77L7lA1zWMJhdGlyjVbT5eCwlcSOPF
         +A7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=V3PN7+Kr/tucktHOq459ffhVuFT8vFVeNdn3CWQcOqs=;
        b=RxWMEyrM/lVzkZqv+QdXjm9RVJ+CcuWWbYg8xKsTj1JpF1DDZOU8TVy20PldzAo266
         IrWFo913oJDUPn5aoF2k85yzuRWP23GMZDQ2PilNWqo6ReUNyZRgOuGv29k1xNcAlR4b
         J7Y+9/HxndazU2x3XWi9rF8OjyDsC5tHgiCbW+Mriw8afjOJIawNjzyQL0+1Jc8zk99I
         7XKLfrxMJjGsZUSjncs1PmeudPcsXB4yukPFeTCkDj15Km8hdVDoRcNwsKEr5xVUOk3s
         6m3L3pStR/k3MWYpUzYnPQjtA8Z8XbNw1RtPtBhUk7Dg5GpNcCOJawSNxd9GHkbooTFR
         sFKw==
X-Gm-Message-State: APjAAAWO+NNVSPY9mPA26nNtXPSbVLf/bUn2bbs6nzUjf1FBX6lPWNEr
        27jTeqnes40qguj+EFvpqqXQoQ==
X-Google-Smtp-Source: APXvYqzSzSl6fHZHf0Jw53i1jb2T7E8JBP2SWlv/T63vVd+AKTU/rUYev6uqlIbbsKy+8FkpZfvlqQ==
X-Received: by 2002:a7b:c748:: with SMTP id w8mr15115318wmk.36.1561380701751;
        Mon, 24 Jun 2019 05:51:41 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id 203sm7917884wmc.30.2019.06.24.05.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 05:51:40 -0700 (PDT)
Date:   Mon, 24 Jun 2019 13:51:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] pinctrl: qcom: sdm845: Fix CONFIG preprocessor guard
Message-ID: <20190624125126.GF4699@dell>
References: <20190621202043.95967-1-natechancellor@gmail.com>
 <CAKwvOdnP+XMn4BMHRcFeO=TCLxjhKk5NBrpmSyZnsAtwFj+gTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdnP+XMn4BMHRcFeO=TCLxjhKk5NBrpmSyZnsAtwFj+gTw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019, Nick Desaulniers wrote:

> On Fri, Jun 21, 2019 at 1:21 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns when CONFIG_ACPI is unset:
> >
> >  drivers/pinctrl/qcom/pinctrl-sdm845.c:1320:5: warning: 'CONFIG_ACPI' is
> >  not defined, evaluates to 0 [-Wundef]
> >  #if CONFIG_ACPI
> >      ^
> >  1 warning generated.
> >
> > Use ifdef instead of if to resolve this.
> >
> > Fixes: a229105d7a1e ("pinctrl: qcom: sdm845: Provide ACPI support")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/569
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Thanks for the patch.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Interesting.  Thanks for fixing.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
