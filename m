Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4645BC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 19:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F56E208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 19:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PMBL5EB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbfFUT17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 15:27:59 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35135 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfFUT16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 15:27:58 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so209219ioo.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 12:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vgNmp5vgEU3rAhixaVZBAVG/jZQe0nnZZmn89Y6ROOU=;
        b=PMBL5EB9hYeXfWjwjHLH+cq/MAI59cWGMboU3RV/osmS7BQI4sRYs6aYaTanGlalHX
         tIpSCrVAj7AQa5/F4xZHrX9VASbjutks5ySA6mYQq2NX0iSEfvgeuT0I9i9MG/tOxb1A
         bP60UPJDIQNxjOElRHl7AjJh1ttBX+0C3Z3DYehZsJO2Il9Pme+wAeHTftopa2Af9t9+
         MvCW90YoMiv0MB6oLhnacMv/hvgXnw4fHeVw8v5dEFs6qGsEiVEstqKdhE+IaCXoG3xT
         XREfXN82lzggbYkTcpkev7sXPFUmZsZk9lX3ILxYTnrRuCmjoneT7UI1Z3SuCdAOZT6z
         p9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vgNmp5vgEU3rAhixaVZBAVG/jZQe0nnZZmn89Y6ROOU=;
        b=SwBy11GJ8PX+crsbcwjtwBXfdus6BGo1Z6fZDcHviLmNbdB9Lz75PIPz4CZCT0Xkm8
         depUkHSvjY2UkAJdGm4luamsDv5JTT/FMFpnOOxddIPIN3MeGVRwE1flUInbMfe6fOeM
         Z+VNsdzhP/1g1SdW80GeHoV3Ir+s0X9z87dkpyaK9hRcwflY5qi50cZF6uUa+YG61vJM
         5koHyI0ND9Mg2Srk71GQvPTRrE23wePiQF7ZjwDu5QqoeSEGwrEfptaC6Mw40Pw/jRBO
         +bNoHN2IY125FE3sDZopGaYIgUnUAEZjg7WNX26Un27VTpvOlth7Pu42nVpMiYPksZOC
         qzJQ==
X-Gm-Message-State: APjAAAV/Wkv6MhH9rcbQe0OWsgFWv5BQaGPQI/Al5vwkRYJa3bcBgw/i
        u1AeWjhA/CBMf5jxA5UL7JH+FcYLTBt465/6wdZYjw==
X-Google-Smtp-Source: APXvYqw85TXju4YL5DKRr8WddespTjK8zo6WjUenDASpEA1OS7EZ7BtksYwmtBqKGL6SHzGK1Cj7RhQ7HqvyLJha2yk=
X-Received: by 2002:a6b:8dcf:: with SMTP id p198mr36443852iod.46.1561145277675;
 Fri, 21 Jun 2019 12:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
 <20190621011941.186255-2-matthewgarrett@google.com> <CALCETrX87W4FE1xHF_W4=Do25Ci=LJxnvxNHMs9CTOFo4988aw@mail.gmail.com>
In-Reply-To: <CALCETrX87W4FE1xHF_W4=Do25Ci=LJxnvxNHMs9CTOFo4988aw@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 21 Jun 2019 12:27:46 -0700
Message-ID: <CACdnJusxhsYenacOEJkDXqVC13qoEd5eNXDgxWT_x8tz4bV5cQ@mail.gmail.com>
Subject: Re: [PATCH V33 01/30] security: Support early LSMs
To:     Andy Lutomirski <luto@kernel.org>
Cc:     James Morris <jmorris@namei.org>, linux-security@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 10:23 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Thu, Jun 20, 2019 at 6:22 PM Matthew Garrett
> <matthewgarrett@google.com> wrote:
> >
> > The lockdown module is intended to allow for kernels to be locked down
> > early in boot - sufficiently early that we don't have the ability to
> > kmalloc() yet. Add support for early initialisation of some LSMs, and
> > then add them to the list of names when we do full initialisation later.
>
> I'm confused.  What does it even mean to lock down the kernel before
> we're ready to run userspace code?  We can't possibly be attacked by
> user code before there is any to attack us.

Certain kernel parameters can be disabled by lockdown, so we want to
have policy available before that parsing happens.
