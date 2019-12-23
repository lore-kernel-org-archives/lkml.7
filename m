Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F290C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 23:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEA120709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 23:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="ENaOhOXp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfLWXI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 18:08:56 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39039 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfLWXIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 18:08:55 -0500
Received: by mail-lf1-f67.google.com with SMTP id y1so13779398lfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 15:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dJj8UD70GwxXWa9YUhL0bVthLy3tnHrg0xwCxYlzeBs=;
        b=ENaOhOXpvnq2cr59bvyj3Km0bdwCcxWo+oRmMYTBpSrjglnFZ0Ti5zOO3vGxMhxk40
         wA5kN/0JV/7pVqYYwC5NNQ/OuvcjVTKgiu9iXm5hCIfVH4j+T2upWB7lFy0Ruzml/RH4
         CEScneRodaA73kLb2zVz4swAcK8vasGBrJd2BscziCVYPv+jOorQZzZpWFsTPWteSzjV
         IdRXeCKHHPCR3q5fRuwvAsV02Dzp5wSQyb6zn2pNHOvbH7AtZRNFsvqDleUzOeY5uegg
         2EvwQMOWcr23VXKFRB+H19vpzq2pt2OA3P/26PRCy7Y4PVv0/CN+0AhZNSjpTwHvgPUD
         89/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dJj8UD70GwxXWa9YUhL0bVthLy3tnHrg0xwCxYlzeBs=;
        b=iMutp9pGN87sGv6dNumgP4jJR+oh6cv6B5SuSOYk2wF7ldhZFh/GqyNWDWoo+5OKdI
         NaXn8YKk22s/rFgrqezD65fGyONs0wPfIpM0LcvZWUBdtVDooquQc2VxxydaYbcy/nFz
         c80orPqSI0FOaWfaXBosKxvIScY2ZUiY8j05zlaInIfNpjyEQi/ZU5Zba6HjluDBxjt5
         imwP7o15BROzvtPl8gVib0Ov3Kx2ziSMn420sDHoXf7hWwHWllgA5OXR8WVk/omyBLtA
         tPrRKoj7yLfaoBgo9rLrrhY9+o80icyoh9WLC/L8zD+o4wXPlo19ov3YzeFOr2Cib8eS
         puiA==
X-Gm-Message-State: APjAAAXwd+LFlRJJceCgrPHrfas8KcsJ9mk88fuSosgjoyoEBX5kd/29
        nX5n4NoJpa0A3aNhJYKCGXFopg==
X-Google-Smtp-Source: APXvYqxXFYki4BhloU2RIPFHrR6RqU/atTEf+XWv0Xw1vlKuTqjeU0Q+1HBc8JYkCUvofE2W5lvCog==
X-Received: by 2002:ac2:41c8:: with SMTP id d8mr17863821lfi.65.1577142533486;
        Mon, 23 Dec 2019 15:08:53 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id l64sm9013758lfd.30.2019.12.23.15.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 15:08:52 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 9CD0B10133D; Tue, 24 Dec 2019 02:08:57 +0300 (+03)
Date:   Tue, 24 Dec 2019 02:08:57 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Khem Raj <raj.khem@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] x86/boot/compressed/64: Define __force_order only when
 CONFIG_RANDOMIZE_BASE is unset
Message-ID: <20191223230857.eafab52y5erfmgab@box>
References: <20191221151813.1573450-1-raj.khem@gmail.com>
 <20191223171043.g54secptjtqkhuve@box>
 <CAMKF1sqvEH94Abv2Ptz3XTCg6hGk9tQ1Dr86RwYn+bpSLQVyxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMKF1sqvEH94Abv2Ptz3XTCg6hGk9tQ1Dr86RwYn+bpSLQVyxg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 02:25:02PM -0800, Khem Raj wrote:
> On Mon, Dec 23, 2019 at 9:10 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Sat, Dec 21, 2019 at 07:18:13AM -0800, Khem Raj wrote:
> > > Since arch/x86/boot/compressed/Makefile overrides global CFLAGS it loses
> > > -fno-common option which would have caught this
> >
> > If this doesn't cause any visible problems, why bother?
> >
> 
> it does break builds with gcc trunk as of now e.g.
> 
> > Hopefully, we will be able to drop it altogether once we ditch GCC 4.X
> > support.
> >
> 
> gcc10 is switching defaults to -fno-common so we need to solve this one way or
> other, I am not sure if gcc 4.x will be dropped before gcc10 release
> which would be
> in mid of 2020

Okay, it makes sense then. Please include this info into the commit
message.

Also, I wounder if it would be cleaner to define both of them as __weak?

-- 
 Kirill A. Shutemov
