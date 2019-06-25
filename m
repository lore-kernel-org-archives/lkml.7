Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59749C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9B520663
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DBNWTvbk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfFYUSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:18:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33017 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfFYUSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:18:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id x15so7895pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 13:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C3759lLg28N5SzA+DaR8TOro6guhAa3AkyxeMVNWlaA=;
        b=DBNWTvbkUEl+Q82QyMlUAQZxbfMrPJ21nxvTJc4A4oyXIBct+mV2AWriOS8GrtDjct
         fQ/AWfICuixUtS077KPF0Fam3new/bWEO5cg2HUyNMzH2e6PhYunULc3SmTZ4/V38o+3
         AV5a0gsaJhdI4JNfpn96j+xOPq6/exWqVlEf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C3759lLg28N5SzA+DaR8TOro6guhAa3AkyxeMVNWlaA=;
        b=seBF+Xjack9br3l8Uh4HOixqQuJf3LOdY2SZyMTYF0YnC9cyiOgrIjWuXLZ3RLvNkA
         ZVhiww1wZW5Gu/5JWKLgDMQ7PAfjLtBBbb95G1AUdagYq0OaQfGbkbHHX7qabGYJX6mk
         SJoMJdBxe0dUjLzOaQ1ieqrr9kQ7IgmRAekNoF5DThptuYbPvvGRJ/yiGTXSkoMvHakv
         eT9eEaZzjNY7hFoobSRk140eFrVlJVIfRh6iTKNRYHqu6NPscqVdkF5cJom/lopkOSw5
         CjmDAAkQpXN3HImktndVgNuflr2QZ68VNE+YnJ9wemo0Oqum5Gtqm/uifHfcN3yM/JLA
         rDtw==
X-Gm-Message-State: APjAAAU9XOr/4RA5gmMKMj+/o3TFpVctfeFbNP91pob2GsFzA6I5DfWb
        8p8H0Z66nk23mACdbXqezxC2Tg==
X-Google-Smtp-Source: APXvYqwGPlu4RGTZXOO9Hg/R9LKbkgnouJNijjTn5OH6GixTNWAzeh5U8DZXqqavq0InyO3HJemICA==
X-Received: by 2002:a65:42cd:: with SMTP id l13mr39845860pgp.72.1561493904625;
        Tue, 25 Jun 2019 13:18:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h62sm20824588pgc.54.2019.06.25.13.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Jun 2019 13:18:23 -0700 (PDT)
Date:   Tue, 25 Jun 2019 13:18:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH] video: fbdev: s3c-fb: Mark expected switch fall-throughs
Message-ID: <201906251312.5059C51334@keescook>
References: <20190625160103.GA13133@embeddedor>
 <2bdbbd7909c5c4ad96d32c0c5be4690292132a34.camel@perches.com>
 <201906251029.08B862130@keescook>
 <9c0d4ed622d6b8e47e040d398f764d52a9ac396d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c0d4ed622d6b8e47e040d398f764d52a9ac396d.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 10:49:01AM -0700, Joe Perches wrote:
> On Tue, 2019-06-25 at 10:31 -0700, Kees Cook wrote:
> > On Tue, Jun 25, 2019 at 09:52:23AM -0700, Joe Perches wrote:
> > > On Tue, 2019-06-25 at 11:01 -0500, Gustavo A. R. Silva wrote:
> > > > In preparation to enabling -Wimplicit-fallthrough, mark switch
> > > > cases where we are expecting to fall through.
> > > []
> > > > This patch is part of the ongoing efforts to enable
> > > > -Wimplicit-fallthrough.
> > > 
> > > Just enable the thing already.
> > 
> > Linus has been pretty clear about not wanting warning options enabled
> > without first fixing all the cases it warns about first.
> 
> Hey Kees.
> 
> I don't recall that particular tidbit.  Got a link?  

It was spread out over the discussion around removing __deprecated,
about enabling -Wvla, and in person at the kernel summit when asking
what approach to take for -Wimplicit-fallthrough.

-- 
Kees Cook
