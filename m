Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06F3C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC3721881
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="v/h3Du2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbfFSPGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:06:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36995 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730134AbfFSPGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:06:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id 131so3630187ljf.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 08:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iYqw55Gz2MUp86I8nNBi2SjuahBkRXax37PIeqPVSUQ=;
        b=v/h3Du2aB9YVZbQNyAxCFdv0tsiThqy3T3FcJD8+BVI6tza94WcTK+xMOfKKJHYerA
         xj3cRmvinImLPU5+Bx/NlDJraHkhb3oCNHsa5iWUnaWIVo9ICCVSryZLgI7TDQmPQ8Hz
         ToeMQ5q2y0bQpNIcSEGfun9rztqMlkXyHLfDDb7JxYfAHYWWOLHFHDutamNY6iMV+0bM
         2PNVTeaLd0RbK4LxZbqGzCAgzxpAWe8z8QYpcDe5NvVFS7Ho2pxrMP/+mU0i3JlX+4jy
         UpGib1gTqN60b2McE2lfRbV3G6EyEwAnkOFCmYGIyc2kaovUN6NBuv8O7+CeS5y2VMcY
         tGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iYqw55Gz2MUp86I8nNBi2SjuahBkRXax37PIeqPVSUQ=;
        b=Ju/ADDoAw7HsxPL6ktk5ie74PkTpsU7CznYmsMfoHTr0IW+oIDW/pItxgf8BVyIMdA
         CDEgIv+kGpMn1gEqP2wcTBYt3jmwaoKEh8u5YAh3FXHTfjvio7uhnlML70i8ZJIEl1Xg
         Tow0NWj8Y22if+rRRGqWsjb8r0xdZ8+n2dQIdkBiBoE1C4JTgnKRQ9JKH5zoHfkmRS81
         fSEbvWlROTilX8+x6+i5dILyP2gr1awRQW7ndKHJjMrh41/fjSwyVuPnQti4e+F3qX81
         W+niSBWoxil/pUbk9SxR25BdseGOEupK4B/PsNBjy2w/q/9iWX3P8mapRypWbi04dZaa
         mVkQ==
X-Gm-Message-State: APjAAAUN596hSb0kYyh5J5nCATlVDKlrVF7sQ4MwE/hNpI1BSwQ//YF9
        ViC+58X8BdAtU0fBm+xMj/q/CQ==
X-Google-Smtp-Source: APXvYqzHV/RviCFvCfJMC5EWh1GWJAukNhuetdv46P5Iim7cEJv31N/o566CoYlfZtgdMaGywj7V+Q==
X-Received: by 2002:a2e:89d0:: with SMTP id c16mr56530310ljk.219.1560956765707;
        Wed, 19 Jun 2019 08:06:05 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id l1sm2744943lfe.60.2019.06.19.08.06.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 08:06:04 -0700 (PDT)
Date:   Wed, 19 Jun 2019 07:12:57 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     arm@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: defconfig: enable Lima driver
Message-ID: <20190619141257.6e7qacefrsubhnnb@localhost>
References: <20190606085645.31642-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606085645.31642-1-narmstrong@baylibre.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:56:44AM +0200, Neil Armstrong wrote:
> A bunch of arm64 boards can now use the Lima driver, let's enable it
> in defconfig, it will be useful to have it enabled for KernelCI
> boot and runtime testing.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied, thanks.


-Olof
