Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BFDC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C66217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555518406;
	bh=uhCs5fQUMZ0rVnDPOCU6Ro2yijGt9lAcVU0da6+Lzeo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rqQagUreaTisC4h4YNP2MJnaoD8sXuIhNx8qNHjr9gPgL5qePxdKeAQH/38kcFrDU
	 ULSPBBmZntMVyz4x8QSQo5drYPrEMKLKzkgD/2ClM7VXmWXl7Copr95rHoQdBjt2Ra
	 DuYDwjoR5v22ClVLsxOD6F9+2fCeUSvHwY6yLm34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732850AbfDQQ0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:26:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39676 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732305AbfDQQ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:26:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id l7so23028566ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wChfyQTAbvryumr6zF7nkNmxcRt9It4g5lAGMC7l5oU=;
        b=c/fQSweIqeUYL1mjaVUYIXsobTzGCW7C1Xztds/ja59seYw7SAEghDJAksAk2JwNKc
         kO43JQPNLOwPdSFwyPNPlWjeLMMEXby8pPxVnv+FWKoH8fqa2jG9SfSWETFgss6PzREj
         4MMHcvXfVLXCeskeSJa94P+cKPgdquwsy+eGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wChfyQTAbvryumr6zF7nkNmxcRt9It4g5lAGMC7l5oU=;
        b=hg5++Vhk6VeKb1Ed97nSmpUl7259VZDY8LJwUVb3sNWmVkJv0IZR7Wer8TVtMltbaD
         lMyLiw5lABAEXlROFefKz21dcjXnPnIy3aZ/JTySpwD2Ek58DMINe8DqPoWz9oM0gX6Y
         0z89OlwAQNJ2KfWYOVStYUPAgPmu4F6ieSX0QtXrDt6Ue1LVo87ax8BoKaN44reSjLOA
         YJeuaKP766gljKytvUh0FD0mjqe/BYOHG2hydx4FfDUqsQrtQ2FzqLzeoCrcuqESJXI8
         t3HeymBCrLuvdyVCCBg029EiuhdCBqqNjzAITP6FVhuQDl8j1GsOmcL0QoR+nLaZ/+8R
         PurQ==
X-Gm-Message-State: APjAAAW1T83s1I09lwDFiN8kZI76Z976RGgSiOvt6Vq9TR5GrgG1oTcr
        3K4sdnGxU5aeMKJj0LOf4r7FAs8+4gg=
X-Google-Smtp-Source: APXvYqyhhZUpU1EOFG4Vzl8FIqkxzYUZPrtkSvd47aKGfPXgEIuOAbmLg9MLz/l4TCv/yZsA+Jv1eQ==
X-Received: by 2002:a2e:910b:: with SMTP id m11mr51006380ljg.14.1555518401126;
        Wed, 17 Apr 2019 09:26:41 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id z206sm988063lfa.53.2019.04.17.09.26.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 09:26:40 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id y6so23001960ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 09:26:39 -0700 (PDT)
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr47000871lji.94.1555518399723;
 Wed, 17 Apr 2019 09:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190417085008.GB20492@zn.tnic>
In-Reply-To: <20190417085008.GB20492@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Apr 2019 09:26:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjazpzX=Y==69hfafDpcgcrwaNcZ-XdJnoVXX8+iy3zLA@mail.gmail.com>
Message-ID: <CAHk-=wjazpzX=Y==69hfafDpcgcrwaNcZ-XdJnoVXX8+iy3zLA@mail.gmail.com>
Subject: Re: [PATCH] asm/io: Correct output operand specification of the MMIO
 write* routines
To:     Borislav Petkov <bp@alien8.de>
Cc:     Michael Matz <matz@suse.de>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 1:50 AM Borislav Petkov <bp@alien8.de> wrote:
>
> I'm looking at
>
>   c1f64a58003f ("x86: MMIO and gcc re-ordering issue")
>
> and trying to figure out was there any particular reason the address to
> the MMIO write routines had to be an input operand?

It doesn't have to be an input operand, but as long as it's a "asm
volatile" it simply doesn't matter, and it won't be re-ordered or
optimized wrt other mmio accesses (that are also "asm volatile").

The memory clobber we have is to make sure that it's not re-ordered
with non-mmio accesses to other addresses (and thats' true for reads
_or_ writes, so both mmio read and mmio write have the memory
clobber).

So changing the input "m" to an output "+m" simply shouldn't matter.
There's no upside. You can't remove the memory clobber anyway, and you
can't remove the "asm volatile".

The "__" versions lack the memory clobber and aren't ordered wrt
normal memory (but are ordered wrt other mmio due to the "asm
volaile").

So I see no upside to changing it.

                  Linus
