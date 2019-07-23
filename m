Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE937C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4B9218F0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lt80K4Z+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392134AbfGWVer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 17:34:47 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:39029 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729084AbfGWVeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 17:34:46 -0400
Received: by mail-pf1-f182.google.com with SMTP id f17so15782134pfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 14:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VWIEpkB+n44qq++ScgWqxmeSI/uO47Tg9yPkq7RW5zM=;
        b=lt80K4Z+V8K9yGobfELvvO6KN7cDAATkM5sB7/0W8IECrsCK4UHj1uU0WAdzz/ZO26
         r/HOZ8OnsLZP/RZkGSvpfHuHv524maccj1Ez/vGHlwE2piDXhMMnNArlJD3hYEWLROca
         3AUzSTQir2yk7D3E4PR+ub3J5xlSjQq2S2e2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VWIEpkB+n44qq++ScgWqxmeSI/uO47Tg9yPkq7RW5zM=;
        b=uCyu6cGZgedtlQWqzmJkCFh3DQecxKZteKaPYZCYfETu6B43oh+0AEposT9D36QfWG
         UyXU2QWneOTHV6gCNooICxhjAyThL+T4oqLRBB50Ba7be4zxxIDYiAP5O34m4I+atgUd
         E2l+TN7sFlEMN/6HekCSJZZ3MRJZPk2e1bBjVIY955Zgl1/maMMja3FzHYioHjbuI6BE
         BI+qmlDXtYIuiBxBVC3HEEC9NiH/K5CyQooQ4r4kV3IL30u42IXFIOsOiblwLBPEAwOo
         Jg1Gn3UjXbkKm5GvW/h2X5dw2WXwywZJ5Awm57x1TnjVbga1/gC9dO/A9zvYsMgczj9I
         APgw==
X-Gm-Message-State: APjAAAV3mhK8+91scJZvaW7uon8eFGJOrtK9vi3fr86nZ4OcpA9Usg5b
        /mvt1+f73KEB8fqicVt8noxWQQ==
X-Google-Smtp-Source: APXvYqyxvdPPh9QAyeti89rkI4S8NU/d5TsJiHGgO3K6q0Ueyy23O+JaTEclPIDV2V5HehfwXgHf1g==
X-Received: by 2002:aa7:9afc:: with SMTP id y28mr7646026pfp.252.1563917686160;
        Tue, 23 Jul 2019 14:34:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 196sm46955301pfy.167.2019.07.23.14.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 14:34:45 -0700 (PDT)
Date:   Tue, 23 Jul 2019 14:34:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Rasmus Villemoes' <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Stephen Kitt <steve@sk2.org>,
        Nitin Gote <nitin.r.gote@intel.com>,
        "jannh@google.com" <jannh@google.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] string: Add stracpy and stracpy_pad mechanisms
Message-ID: <201907231430.C679A37EC@keescook>
References: <cover.1563841972.git.joe@perches.com>
 <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
 <eec901c6-ca51-89e4-1887-1ccab0288bee@rasmusvillemoes.dk>
 <5ffdbf4f87054b47a2daf23a6afabecf@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ffdbf4f87054b47a2daf23a6afabecf@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 03:41:27PM +0000, David Laight wrote:
> From: Rasmus Villemoes
> > Sent: 23 July 2019 07:56
> ...
> > > +/**
> > > + * stracpy - Copy a C-string into an array of char
> > > + * @to: Where to copy the string, must be an array of char and not a pointer
> > > + * @from: String to copy, may be a pointer or const char array
> > > + *
> > > + * Helper for strscpy.
> > > + * Copies a maximum of sizeof(@to) bytes of @from with %NUL termination.
> > > + *
> > > + * Returns:
> > > + * * The number of characters copied (not including the trailing %NUL)
> > > + * * -E2BIG if @to is a zero size array.
> > 
> > Well, yes, but more importantly and generally: -E2BIG if the copy
> > including %NUL didn't fit. [The zero size array thing could be made into
> > a build bug for these stra* variants if one thinks that might actually
> > occur in real code.]
> 
> Probably better is to return the size of the destination if the copy didn't fit
> (zero if the buffer is zero length).
> This allows code to do repeated:
> 	offset += str*cpy(buf + offset, src, sizeof buf - offset);
> and do a final check for overflow after all the copies.
> 
> The same is true for a snprintf()like function

Please no; I understand the utility of the "max on error" condition for
chaining, but chaining is less common than standard operations. And it
requires that the size of the destination be known in multiple places,
which isn't robust either.

The very point of stracpy() is to not need to know the size of the
destination (i.e. it's handled by the compiler). (And it can't be
chained since it requires the base address of the array, not a char *.)

-- 
Kees Cook
