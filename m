Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3CFC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB29D20851
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcbjuSre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfFND5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 23:57:42 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36422 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfFND5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 23:57:41 -0400
Received: by mail-ed1-f66.google.com with SMTP id k21so1442005edq.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 20:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gDNeDNC6IhsxAfX1pCDhnGOlsLviHqkXzki8BiuCzfE=;
        b=pcbjuSreld4Y706hdj8M6kKp4kLTEsk7/zmxxGr/PyJ4Q63Evk+mFr05ZIUVlmh+xk
         +0sSwQJsJ3jl8VYasKac8A3nGlVpbTvobhzfAiK9jP8FOJMCcOUv8sOB66NZKQ2jc1ck
         GvR1DksaU4g55K+AlRMkee6MvlDCf7T7s4cjPBY5LeQTIxuG1Ff18gGqyPfQJUkqLLbq
         INWo7KBa6PX+s490TnOJjOoqdA+X/uqRhysLgQWo1Fsn7nqPJy+Pgx/UrGrn4Pw5b9jD
         R3nbCobM8hgSagh2KXO9ItEJz9DkEBVoe3ICfHdk6TImZ5kG7CFqaccEAYkebncKR1Ao
         klMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gDNeDNC6IhsxAfX1pCDhnGOlsLviHqkXzki8BiuCzfE=;
        b=XKhHMRgYuNqf5qTnzRNUqoX56TrTnGjmffTi1Q3ngG3eA2aj0P7pqPgOQv1Ye3Fw3f
         eF/++JSTEAt4mnWoaIcoSWuO2b9F2ywmqkisGg2S6FwmFM0jRlHQyVCF/EzsKcWKOPJ5
         uz4d80cwvU0kCIJoqojTylAh0ZxXvj2r9p9I4QSLeBBWI+T0ZZ27AlKI5slfWzuuPVyM
         S6tXZbUrNUYWSxOoGzzIYgvT1AfP9DYQcBrmXpPNguK72zl4gZ+qeDQzE2lS37LlFAmc
         POOUNZ+MOFwHachhsUJsmJc9PQ7nPQ84XXvukdKBjIV/xBu+0FVulBN/9XrmtoaHf5Hr
         htOA==
X-Gm-Message-State: APjAAAVGu+HEtfmP9QvpQ+SSizjEy7BDhw6V4CtuQhPduvavGydkLlgO
        09KNK0ck+HPnXvNv4t4osmg=
X-Google-Smtp-Source: APXvYqzJURQRQFhk+6yXhETpK9HjQuPFeyc8sNjYHpDFcm1C735qDO8j/cj2/Vadm8ArJoVnhREYtQ==
X-Received: by 2002:a50:ac24:: with SMTP id v33mr72538475edc.30.1560484660031;
        Thu, 13 Jun 2019 20:57:40 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id m19sm332256eje.30.2019.06.13.20.57.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 20:57:39 -0700 (PDT)
Date:   Thu, 13 Jun 2019 20:57:36 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Amelie Delaunay <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] mfd: stmfx: Fix macro definition spelling
Message-ID: <20190614035736.GA57346@archlinux-epyc>
References: <20190511012301.2661-1-natechancellor@gmail.com>
 <20190513073059.GH4319@dell>
 <20190514183900.GA7559@archlinux-i9>
 <20190514185404.GP4319@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514185404.GP4319@dell>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 07:54:04PM +0100, Lee Jones wrote:
> On Tue, 14 May 2019, Nathan Chancellor wrote:
> 
> > On Mon, May 13, 2019 at 08:30:59AM +0100, Lee Jones wrote:
> > > On Fri, 10 May 2019, Nathan Chancellor wrote:
> > > 
> > > > Clang warns:
> > > > 
> > > > In file included from drivers/mfd/stmfx.c:13:
> > > > include/linux/mfd/stmfx.h:7:9: warning: 'MFD_STMFX_H' is used as a
> > > > header guard here, followed by #define of a different macro
> > > > [-Wheader-guard]
> > > > 
> > > > Fixes: 06252ade9156 ("mfd: Add ST Multi-Function eXpander (STMFX) core driver")
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/475
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > ---
> > > >  include/linux/mfd/stmfx.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > Applied, thanks.
> > > 
> > 
> > Hi Lee,
> > 
> > Thanks for picking it up. It seems this didn't make it into your MFD
> > pull request for 5.2, was that intentional? It would be nice to avoid
> > this warning.
> 
> Hmm... no it was not intentional.  Not sure what happened there.
> 
> I will pick it up for the -rcs.

Hi Lee,

Have you picked this up yet? I don't see it in -next or your public
tree.

Cheers,
Nathan
