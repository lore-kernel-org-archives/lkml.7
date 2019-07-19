Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CB2C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB402186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmoQqm+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbfGSQFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 12:05:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34791 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfGSQE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 12:04:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id 31so32831738wrm.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 09:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dFBxfHIIkZj/vVsiAN1B0GaZv4SmAdgmjXZzJQqEU9A=;
        b=qmoQqm+cm8JfhVK79rrK6WKEFVwdHw5UMzQlgGas2DvO+CQh+qaY1lTjbUZU1NdNQ4
         FCpmcyM9xNz1HPnLZ4+xP7ohF8nB2LYRg7FTY2XRs9EbNsZ0An77ewLdygagKZ3wUVPc
         RiIj6qSNa7xXNiwu9sqea7JakIQpg6BrpR95hI4Mj3hnogY6a0TjHASmZ/L5hT25CYT2
         lVfXRK1f/iqX1s6ca9/Xo3lWb8Ju3N3evwKoHm+CybJS1oKxl7NqO/XaaA3An5B9CyKI
         xCZwUKkUojZRzqKwlA/KnihZMio2IO9lZWWbZvzalJvAwIvXSi2XQtA/6GynByXLk19G
         hmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dFBxfHIIkZj/vVsiAN1B0GaZv4SmAdgmjXZzJQqEU9A=;
        b=NnFgaNesKLTiD3psxEgh9BdAsTMKOrC5IfcIggT5Co2CHrjJJe3V3DWUq9SHyT6tsP
         pMye03JHVd3U0K8W1CvG3t0ixk86pPM0w+DbxCFnWe7YppZRwpYGJUuwWNhtAZCyrROh
         fnDgdwyLyfdUiiCdNO24NNMBUmiW1AM44NtY7LblPZtTK0eYuequ3EP62NKXW2Z1efFT
         ZelUIQrLv9T63V9K14L+458QbwPf4HME3NkDb0Ztrs1C+qG+D9+on7/AlW60DSWSFRO8
         ZRNgnQ5C1lNDmxK3kOrJsjuXNWFv3B5Z6wTh0lpJbuu+woQGRqjhTYCgGBgXps7J8m6S
         KQPQ==
X-Gm-Message-State: APjAAAUINUtJEdWk/qw63YZN3xPWDy+mEMaEP2QI8SjfjT9g+Q3WgE6C
        xUu6xwnlm1IGvw2tmNmVtsA=
X-Google-Smtp-Source: APXvYqxu5WOesyzz5zUnwrOhjaRHG/mzN5sPCvIO9i605E3qpYbn5r5l0Q6NmAQCIxHKCne2lg4wTA==
X-Received: by 2002:adf:f005:: with SMTP id j5mr12593107wro.251.1563552297446;
        Fri, 19 Jul 2019 09:04:57 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id y24sm22398788wmi.10.2019.07.19.09.04.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 09:04:56 -0700 (PDT)
Date:   Fri, 19 Jul 2019 09:04:55 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] powerpc: slightly improve cache helpers
Message-ID: <20190719160455.GA12420@archlinux-threadripper>
References: <c6ff2faba7fbb56a7f5b5f08cd3453f89fc0aaf4.1557480165.git.christophe.leroy@c-s.fr>
 <45hnfp6SlLz9sP0@ozlabs.org>
 <20190708191416.GA21442@archlinux-threadripper>
 <a5864549-40c3-badd-8c41-d5b7bf3c4f3c@c-s.fr>
 <20190709064952.GA40851@archlinux-threadripper>
 <20190719032456.GA14108@archlinux-threadripper>
 <20190719152303.GA20882@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719152303.GA20882@gate.crashing.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 10:23:03AM -0500, Segher Boessenkool wrote:
> On Thu, Jul 18, 2019 at 08:24:56PM -0700, Nathan Chancellor wrote:
> > On Mon, Jul 08, 2019 at 11:49:52PM -0700, Nathan Chancellor wrote:
> > > On Tue, Jul 09, 2019 at 07:04:43AM +0200, Christophe Leroy wrote:
> > > > Is that a Clang bug ?
> > > 
> > > No idea, it happens with clang-8 and clang-9 though (pretty sure there
> > > were fixes for PowerPC in clang-8 so something before it probably won't
> > > work but I haven't tried).
> > > 
> > > > 
> > > > Do you have a disassembly of the code both with and without this patch in
> > > > order to compare ?
> > > 
> > > I can give you whatever disassembly you want (or I can upload the raw
> > > files if that is easier).
> > 
> > What disassembly/files did you need to start taking a look at this? I
> > can upload/send whatever you need.
> 
> A before and after of *only this patch*.  And then look at what changed;
> it maybe be obvious what is the problem to you, as well, so look at it
> yourself first?
> 
> 
> Segher

Thanks, I will go ahead and disassemble the full kernel given that those
helpers are everywhere and see what I can find. I'll reach out again if
I can't come up with anything.

Thanks for the advice!
Nathan
