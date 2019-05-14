Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCB7C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAB92084F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tlYGPpce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfENSyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 14:54:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34770 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfENSyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:54:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id f8so2555340wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VCAQGz8qjml6ASU2OK1LEnrW5ChvncfEkzJRDaJ9AfM=;
        b=tlYGPpceDt4GjqHqn8XvdeH7oSM4djD9WBPrOe1X0oZ0wDG5pryX0rfiv5SFEB76LU
         JF8LJ6bu8T4YJ78yelc8P/8CAQXBiiY4sQb5MN0t2afe+OrgCaooEL+PBudgmZk3lZLa
         Z0RZOdsq8VBwI8pemYXk/7gNDSyGmcPFvDhPdEQ/3xefc2UwmmiquzJ2SHSkDvz+Tz/T
         Yrwc9WSg1emsJwcguVZ/NnVSIeCVPmK5JFqaL8uiMElLtPsdYvUlCPN+1RvBJklEk4/w
         lJ9WBrUsU19nQ8Xb6Sgezkr3UWCPjyiVX9vc/+AjdkufhHjZ/QboyUGR//IqfzGnbQbX
         I7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VCAQGz8qjml6ASU2OK1LEnrW5ChvncfEkzJRDaJ9AfM=;
        b=Vn5o8fRKgN2Di3VQGmedgdADWD3F0+XxTEnrbLwwIYDgLbc5jejlggxjX24MzlXA+O
         YdpYG16UBQg2ftZOKXwYl6qR73irHCMNWmdDqBOKyOSfd5CArRpbDKfEVVz+tLvy7p1a
         loL94k2XQ4l8zE7Ygo4HxhR4X0++TAZAfcC3CO/CQMZbjzOgB0jZEaZw1ZfzfJU33VJm
         JvlAVcyCDA33BMoM5n76W5bloZE9ds4qYnRGMsY8se5SDt4IexYy5a7JAfvJTdDYxzbB
         DXUNGbaEdBz2hnTrAdeIrBkR6yOeALw/UunWq0bIN9Rv25bqTGZZTFNaXcAq8A2ESE6f
         IFrQ==
X-Gm-Message-State: APjAAAUrM9ZdhMVaQChjjBiAwY2CPdFqBTels6GgT4ywkjFDgVj2uh4q
        H67DKsxMmVQT4tBu2hX5YvQgbA==
X-Google-Smtp-Source: APXvYqyXK6O0Aqh/1goILlJaZM+s8rUCdPYL1LSk9ZSGB1TPgYZuXHgOORUbKQn4wE9vtJIsBxrKSw==
X-Received: by 2002:a5d:4b07:: with SMTP id v7mr12420510wrq.106.1557860046921;
        Tue, 14 May 2019 11:54:06 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id s22sm5469199wmh.45.2019.05.14.11.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 11:54:06 -0700 (PDT)
Date:   Tue, 14 May 2019 19:54:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Amelie Delaunay <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] mfd: stmfx: Fix macro definition spelling
Message-ID: <20190514185404.GP4319@dell>
References: <20190511012301.2661-1-natechancellor@gmail.com>
 <20190513073059.GH4319@dell>
 <20190514183900.GA7559@archlinux-i9>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190514183900.GA7559@archlinux-i9>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2019, Nathan Chancellor wrote:

> On Mon, May 13, 2019 at 08:30:59AM +0100, Lee Jones wrote:
> > On Fri, 10 May 2019, Nathan Chancellor wrote:
> > 
> > > Clang warns:
> > > 
> > > In file included from drivers/mfd/stmfx.c:13:
> > > include/linux/mfd/stmfx.h:7:9: warning: 'MFD_STMFX_H' is used as a
> > > header guard here, followed by #define of a different macro
> > > [-Wheader-guard]
> > > 
> > > Fixes: 06252ade9156 ("mfd: Add ST Multi-Function eXpander (STMFX) core driver")
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/475
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >  include/linux/mfd/stmfx.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Applied, thanks.
> > 
> 
> Hi Lee,
> 
> Thanks for picking it up. It seems this didn't make it into your MFD
> pull request for 5.2, was that intentional? It would be nice to avoid
> this warning.

Hmm... no it was not intentional.  Not sure what happened there.

I will pick it up for the -rcs.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
