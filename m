Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76F8ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2D421721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570453788;
	bh=tNJqbGDD5bXMEiZco7aZkgdmJBKjg8cGXw+vZxty1Cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NqohXGSRlWlhWeoSbMM1eATup/syHMVb3y/Jz+Lcgf8XQQPGC2Fm95flgrLONeWrn
	 PfY45XotiV7fqanenk5LfNRqc9WQtbsb9YBR+iXD2vYUmP1bRnegQKZx5klkK33jZL
	 CmEeGN3AHG4m0QPoY4HKB6oD+3drxsZlxkLi9jrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfJGNJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:09:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51717 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfJGNJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:09:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so12627259wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 06:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XjT8McG+M3DOFHsSH6tpy4432eLM//ayruzTzMzk+UA=;
        b=dHW/vQ4GMmCvxW+W+7HUnpYTdw7+N7RYtcHrdlwDY0QaBGcl+oet1+igFtmeuLlamT
         EadzQhER1t7M3JNYXScNLM+t+dJLTWo0xB6j+W5DkaZtOBYJWAy8/OeS8Y1r11w0fhj9
         mFKZ5urPHw+cvzwgbspXDUeOmNd9bdk4MTYzS+UAogEGY9bzuxTG9fAc2T0mOzxjZd2d
         NdragkvA+wQCxX8XNdfz2R4d5frS0p/JUXKIYCoZfUVKO/Uhz2oG83Xp9dyoRucL0u+w
         AKzBY1c72iFQLiy5V+QWlGxdhkZF08WbZicvVM241ZKs0RUdsjf4FwTgl6Fjzue+xtTH
         OXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XjT8McG+M3DOFHsSH6tpy4432eLM//ayruzTzMzk+UA=;
        b=ZnjqgmEs5k7gC03l68AmfRHLZVeDgkEZFG76omfTjFh3qL+0jrS626KXskVUKrafF0
         ZwkHKMlmi3ZONqcP9uAGQvWetqpIohzLsKjYnWMNgQAcqEiAT3WAS64RUjcbMCdaSPM9
         jtA7TrpCrk/lQGJ8iXd1Hy4I1g11vHwGJhtogCzAnNukqK0RB1ugXjEV6Et59AQ+lsuN
         tIrgDgx0zoMeGjiPj2qGcqAFSqyMo1gb4U0jYmhz/e4RFAhoUkGEefoBxJpyuPn5EI6p
         so5AHtOgW+/xs9QLOShsWGJiyWBa3GNeSQ2h6VJ518ZRSlaMu3NU9canz98ztvuac07q
         XFiw==
X-Gm-Message-State: APjAAAVFstpBJSRy5yHX0pNGVE/xpj2CyrUwdXXqNrpmj831AMbOmYX/
        Z7iIN/gJlWcELyr6F8+S/m0=
X-Google-Smtp-Source: APXvYqxphiGM4g6+s8FF6k/91gH1+oL/z7kjGpjFhV5jjBi/5sguBzGZRBZEcwJ2GnNgVWE3AoCpsw==
X-Received: by 2002:a1c:544e:: with SMTP id p14mr19606688wmi.72.1570453785442;
        Mon, 07 Oct 2019 06:09:45 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q124sm26547015wma.5.2019.10.07.06.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 06:09:44 -0700 (PDT)
Date:   Mon, 7 Oct 2019 15:09:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: kexec breaks with 5.4 due to memzero_explicit
Message-ID: <20191007130942.GA82950@gmail.com>
References: <20191007030939.GB5270@rani.riverdale.lan>
 <28f3d204-47a2-8b4f-f6a7-11d73c2d87c8@redhat.com>
 <0f083019-61e8-7ed5-dde7-99e1aa363d9c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f083019-61e8-7ed5-dde7-99e1aa363d9c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 07-10-2019 10:50, Hans de Goede wrote:
> > Hi,
> > 
> > On 07-10-2019 05:09, Arvind Sankar wrote:
> > > Hi, arch/x86/purgatory/purgatory.ro has an undefined symbol
> > > memzero_explicit. This has come from commit 906a4bb97f5d ("crypto:
> > > sha256 - Use get/put_unaligned_be32 to get input, memzero_explicit")
> > > according to git bisect.
> > 
> > Hmm, it (obviously) does build for me and using kexec still also works
> > for me.
> > 
> > But it seems that you are right and that this should not build, weird.
> 
> Ok, I understand now, it seems that the kernel will happily build with
> undefined symbols in the purgatory and my kexec testing did not hit
> the sha256 check path (*) so it did not crash. I can reproduce this before my patch:
> 
> [hans@shalem linux]$ ld arch/x86/purgatory/purgatory.ro
> ld: warning: cannot find entry symbol _start; defaulting to 0000000000401000
> ld: arch/x86/purgatory/purgatory.ro: in function `sha256_transform':
> sha256.c:(.text+0x1c0c): undefined reference to `memzero_explicit'

I've applied your fix, but would it make sense to also integrate this 
linker test in the regular build with a second patch, to make sure 
something similar doesn't occur again?

Thanks,

	Ingo
