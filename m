Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CCAC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382AE21473
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCj6ARw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfENSjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 14:39:06 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36261 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfENSjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:39:05 -0400
Received: by mail-ed1-f67.google.com with SMTP id a8so335942edx.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 11:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zbQPQaaby+KlyxId7O5QJocsqofQF1fdS7ooQBqTlW8=;
        b=CCj6ARw9oyqJuC5ug0nu+zWpYTTdWJ6wJMtW9rF0/8KKRyAKJ2CYcWp1lYtf/nbIdZ
         iXFtrn9BO5wDu4sDeyyWkyrktH0y9kNNBMgXPcSiWMC7yRPjXQF6rSx/MrNgFlVGWOaw
         /zMU2CM/l7YHa1oSzX8g198XzkUmC2+xA4PMcJJ9yDkXeE/R1ZVCU9O2k3Bn51Hdr73D
         valCo0p7kxQjsJ3FgAReWUp16OnJmpN6y4gO3VHnpAqXTxnbHUgZVjpXC3sNn12b36mc
         yKr25r1yXucKTSm/IuCFKHuwNrUI6Bw01Bp91kfYI+FalBk9vUnivZWuVuylm/eyeJCO
         hMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zbQPQaaby+KlyxId7O5QJocsqofQF1fdS7ooQBqTlW8=;
        b=j3z6c3vGB3Jtc8CBCT+GhXdnvlsCrfFwagFRmjuHujZcOWPc7+hkoO0NsEckaTHLua
         1iDQZ92sVmD7tYKMN7W2EedPDf0acX0W2/SkbFNrjD5qCLhnLe39qtKQW+XJOKJDC9Nq
         sIBOCoTOrkExzZM0DSs9Q/jnnbWmv3LOokd4fexOAo4yr/PXwAs4cg5RfQ16pBrKBIye
         aoLwavKn6p+aaCHfIyejE0I/P56qr68Mk6OnRQLq3xO/AKlwLc7MHbQ6ewC9h7S7t0R+
         5bj+/bUROi44x00uvRHQWGXAiJ5pnoLT1YT2m5VFOyXQHII7d9rIxvwV0E9MlAVRVBgl
         /B4Q==
X-Gm-Message-State: APjAAAUgc8UDdrSVvMII7WQpHu0UsGRP7V2CXRbKeIvkBcX0QQAYuqGX
        tf2r3wJYYLMi/sMr90w/55I=
X-Google-Smtp-Source: APXvYqy0qvzGEjq1y48Okv+3jHOz8HFzZ2WmeJBsHys55evhDE3EUT9InoSURjcnwGMUN9OwBSov7Q==
X-Received: by 2002:a50:fd0a:: with SMTP id i10mr37752734eds.117.1557859143820;
        Tue, 14 May 2019 11:39:03 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id p52sm4738334eda.79.2019.05.14.11.39.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 11:39:02 -0700 (PDT)
Date:   Tue, 14 May 2019 11:39:00 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Amelie Delaunay <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] mfd: stmfx: Fix macro definition spelling
Message-ID: <20190514183900.GA7559@archlinux-i9>
References: <20190511012301.2661-1-natechancellor@gmail.com>
 <20190513073059.GH4319@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190513073059.GH4319@dell>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 08:30:59AM +0100, Lee Jones wrote:
> On Fri, 10 May 2019, Nathan Chancellor wrote:
> 
> > Clang warns:
> > 
> > In file included from drivers/mfd/stmfx.c:13:
> > include/linux/mfd/stmfx.h:7:9: warning: 'MFD_STMFX_H' is used as a
> > header guard here, followed by #define of a different macro
> > [-Wheader-guard]
> > 
> > Fixes: 06252ade9156 ("mfd: Add ST Multi-Function eXpander (STMFX) core driver")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/475
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  include/linux/mfd/stmfx.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Applied, thanks.
> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

Hi Lee,

Thanks for picking it up. It seems this didn't make it into your MFD
pull request for 5.2, was that intentional? It would be nice to avoid
this warning.

Thanks,
Nathan
