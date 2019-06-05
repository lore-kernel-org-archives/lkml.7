Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11C6C28D18
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 18:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950BE20866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 18:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DlN1Tsnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFESQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 14:16:10 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:35624 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfFESQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 14:16:09 -0400
Received: by mail-pf1-f178.google.com with SMTP id d126so15323506pfd.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 11:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yy1+cFmii2s5Isli128YJK+bYVGL0e3pwrahCX2MG48=;
        b=DlN1TsnbsswLEz2RIlZoUU7bZzZiNk5nIu/5BXDfQsEC8J95oBMJ3ND4+PV2HOyATr
         AX30/lSOkXW5Qa76cUMRCpwyYOUfnNJhdgn8heG0L+oSDjw5K2DUIG/52D7Ei5By4cdg
         aJW2tjhAZYrBHj6xaEuCy2qAH0+lHLNUpXWs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yy1+cFmii2s5Isli128YJK+bYVGL0e3pwrahCX2MG48=;
        b=UjkuG/G/tWmvNy4r26dtSzwnPbPVjghHnUGgWBUidnhhZe0pC3+SYVma6UJiXA4iNP
         qJbClZktnA4R2oz+Hx+84qZD7MLxya7L9WSlUPYNcOgrPr/es5gT0uTn4ZhPJw1yj89H
         gWRFEzqapw6dsTKWXs5+J7OQvwSihyv0FFBHTofSaPR0Cr6bl+55hMVxEZiDL5XNPpi2
         GpDL+WGw0lsuxlVRB/U84AcbdwDjPBjcrc+Q2MRYU+5ILoFOz/H7V1tsoHca3hhlbiKx
         TfRRnQTn0g9PHufRRH06/G/EP7flV+kgXvyjYaTvC8yjO5YEcoeRA8+DWdxxduUAgDkf
         bgxg==
X-Gm-Message-State: APjAAAW+lNitVzkZfp10Zx1mTs4v1vWcazYcGYB8IURYhpAsy/dVrkNn
        An8/3P2QveF19edn/i37T3ILTA==
X-Google-Smtp-Source: APXvYqwFyG6F43gVKfokn6PrM6BmtUpQvZrdyq2Ph68qWEkbMC1zvAMl/ICXYwcz8ET5o3bvaXtdJw==
X-Received: by 2002:a17:90a:d803:: with SMTP id a3mr46216673pjv.48.1559758568849;
        Wed, 05 Jun 2019 11:16:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f21sm3575655pjq.2.2019.06.05.11.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 11:16:08 -0700 (PDT)
Date:   Wed, 5 Jun 2019 11:16:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alec Ari <neotheuser@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] x86/build: Move _etext to actual end of .text
Message-ID: <201906051114.6DEF834@keescook>
References: <CAM5Ud7NhtKDCMnf+zbsRH1N8V6=kCpEJ5NCmJ4mOQSdVA_noMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM5Ud7NhtKDCMnf+zbsRH1N8V6=kCpEJ5NCmJ4mOQSdVA_noMA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 11:08:13AM -0500, Alec Ari wrote:
> I'm having this problem too, build is failing:
> 
> Invalid absolute R_X86_64_32S relocation: _etext
> 
> I stayed on the 4.14 branch to help prevent these kind of breakages,
> so much for that idea. Gentoo GCC 8.3.0.

It seems to be a problem with the Gold linker. Using ld.bfd appears to
work. I haven't narrowed down the problem, unfortunately.

Greg, given that this change was only for special situations (Clang
CFI), can you revert this for the stable trees?

-- 
Kees Cook
