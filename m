Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80242C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFB920851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoB5OG1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfCANdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:33:01 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46736 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfCANdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 08:33:01 -0500
Received: by mail-ed1-f67.google.com with SMTP id f2so19987216edy.13;
        Fri, 01 Mar 2019 05:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8uq/wMcFYQs+gVp4kdYwgE/5XLhXoJwwKfHFMkxwYXI=;
        b=OoB5OG1mQu6VINLmW2ag+MSb54n2b6VD1OZDD/fcztNk4eZ2Lj2U5pL7TGH22xf/BP
         ehFErmOG8nWGAKYhvcCxVVFWzW+wI37DanBMpVsdfy4iGTVKhE55nXejz5IJDcAkKxPN
         UWJl22Slfmk4UjOw8nBgWcsvnFhd0kAk7Xq8VdrKZu0vasFYK1JH28L3L95XYUyCPB7B
         Pgsa9u0peaGZZJ5yHDytnFICaLzJawjPwnJvk7TykSMp7JSF9cYWnh2f01lNgfwG3hkC
         al/AcUwXbZB+5cO9TsOp1hdFDUwwB1/menfxGZhuRHcLWPg7/oFNrbmqmrxA1HHY/FlB
         0BCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8uq/wMcFYQs+gVp4kdYwgE/5XLhXoJwwKfHFMkxwYXI=;
        b=iyS4ZF/7aUu5Ga6FtIs8BjdNVJ3yEfyUIteAd45PEkUCHRT3F46TOAYyuzYt8ALlBH
         jWKun06Q3ale2YwL+GLwsBmgToICZe2UVcXe+RVUHMbT07Pr/r7117ZUaczPlR+hr8QW
         YXPHAAbrXEEMyb2kNRtPXPf1HGa3Q3ROK7sXzjLN+HyaDgB0xCuKKI2KYhbBCww1qLGU
         wDuUmCL2BryGsww/wBPu84qZuO0WJhIy9UIYaa9IO+k1U1qbu1fIwjZ/8cb79rO5xwMd
         7qVFANaQbrjdYGo8YbD8c9wmpsGSaymQuCHeDVa7R4yURu6UyH0kML0BDpmiO2MRBoHh
         9iMA==
X-Gm-Message-State: APjAAAW2cDvSkU8r1MfnRofxcds83FgJlhcT2runvrF7dp3nvX1Z5zLa
        POnbhIFw3IhsY17DRr6JjRc=
X-Google-Smtp-Source: APXvYqwdBQDnLlpl3kiidCFHuvInhkW7SXDRf5AYTyykbHNXEVlT24uHmEJd9tCPKOgGxVBgdS5hQg==
X-Received: by 2002:a50:b639:: with SMTP id b54mr4167532ede.229.1551447179143;
        Fri, 01 Mar 2019 05:32:59 -0800 (PST)
Received: from dell5510 ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id f5sm2203633ejf.25.2019.03.01.05.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 05:32:57 -0800 (PST)
Date:   Fri, 1 Mar 2019 14:32:56 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Arseny Maslennikov <ar@cs.msu.ru>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>
Subject: Re: [PATCH] scripts/package/mkdebian: expose KCONFIG_CONFIG to
 debian/rules
Message-ID: <20190301133254.GA20771@dell5510>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20190221215901.23970-1-ar@cs.msu.ru>
 <20190221215901.23970-3-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221215901.23970-3-ar@cs.msu.ru>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> If KCONFIG_CONFIG is passed to `make deb-pkg` as a makeflag or
> environment variable, the source tarball produced contains whatever
> specified by that variable instead of the usual `.config'.

> While `make deb-pkg' yields a correct Debian binary package (at least
> on amd64), the generated source package's debian/rules does not pass
> KCONFIG_CONFIG to make(1), thus rendering the source package unable to
> be rebuilt.

> Steps to reproduce the kind of failure being fixed:
> 1)  Produce a source and binary package with:
> 	% KCONFIG_CONFIG=my.config make deb-pkg
> 2)  In the parent directory:
> 	% dpkg-source -x linux-*.dsc
> 3)  In the unpacked source directory:
> 	% debuild -i -us -uc

> Here is an excerpt from an example output of `debuild -i -us -uc':

> make[2]: *** No rule to make target '.config', needed by 'kernel/config_data.gz'.  Stop.
> make[1]: *** [Makefile:1043: kernel] Error 2
> make[1]: Leaving directory '/home/ar/linux-kernel/deb/linux-5.0.0-rc5-tks-gitd6ff78479ec5-57-5.0.0-rc5-tks-gitd6ff78479ec5-57'
> make: *** [debian/rules:4: build] Error 2
> dpkg-buildpackage: error: debian/rules build subprocess returned exit status 2
> debuild: fatal error at line 1182:
> dpkg-buildpackage -us -uc -ui -i failed

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>


Kind regards,
Petr
