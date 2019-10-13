Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8771BC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 18:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573CB20659
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 18:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570992259;
	bh=lIz6Bj4zHDbehPaJilDT734wjuynvbjwl1WKxwiMso0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=edREwc5PTAJxxla6ToHhp2EfwPwmTfgd/XVBri23Ie6YtPnfYVO6bbf2g7XAjO5pE
	 FaGaBXDgr6FULL2iUQuye3P0Dmg/fypEZ1nNaLKNKeH4doCMtDu9GYYQ8RPp5pspLH
	 ZIWV4AFOcWywhi4GqE8jpTagb9GRuhhTC5Trr8h8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbfJMSoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 14:44:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43482 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfJMSoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 14:44:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id n14so14407868ljj.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 11:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L8HGIEbrDSNPBNz7JZoslo//D+Z+JzvW8skzuFZjDGQ=;
        b=f9i6bWjbBXi5YmlUV3DTVdezpTlauLxUBUjXqJYCSgalQknuScN0wHySkl2SSeu9XB
         GOpYTJ00altZjFy1bQvCrvWsJGmDkqUcWgEW6wUohQtZAxESLOgQ/vblEwHGQMuSn3GI
         ehtFlVmKVpewR97jYh5+IGyYqOVdYNxr5pT4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L8HGIEbrDSNPBNz7JZoslo//D+Z+JzvW8skzuFZjDGQ=;
        b=ok0Lez0ikdzGh3DSVQkxVbYZD7YQKXWj2AVtYe4PW/YoAijKJeikbe1tVCAcF3sTiB
         cFs9ln5Ya80kSm9VY8Y1Qq/HbdqDjldDxlLFCu1aIAEq/KpzF+zgr4gdO4aV1ivcaVNy
         n/55Vj6ruSJj/j24kvVCNN83WxGKTWKixLNP6r0LWK5vM4DjPkPFOtgx0Gc+WlKBk/X+
         wV4xawTacaTPgd974VCBmlO26NpnZLaUytoUHjJjQJBohAvLQQpvh7qO5DZof37s0BUw
         dY7n3RRfNDO9BbV6JAPwpPtUrh74+dAamGtn4wBuw7hVgZhLMH3KI9nll3WNsXbyiYJe
         e9vQ==
X-Gm-Message-State: APjAAAXQLc2MahhFzQipKcChm3YVTUX8OY0MzOif0D/J/lylKgAwvNsL
        R+by1dRNtiF97BygYvi3Ly1GsVaRojI=
X-Google-Smtp-Source: APXvYqwEkgYcuQdnXsmT3fmdqtGBdyfn8bx4gd+ETIFx4LVwZrEVVQed1Qygzuq2qMyr0BA9RrKrJQ==
X-Received: by 2002:a2e:5354:: with SMTP id t20mr14532026ljd.44.1570992255380;
        Sun, 13 Oct 2019 11:44:15 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id v22sm3559439ljh.56.2019.10.13.11.44.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2019 11:44:14 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id y23so14403963lje.9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 11:44:14 -0700 (PDT)
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr16095288ljc.97.1570992253891;
 Sun, 13 Oct 2019 11:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191007025046.GL26530@ZenIV.linux.org.uk> <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
 <20191008032912.GQ26530@ZenIV.linux.org.uk> <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
 <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com>
 <20191010195504.GI26530@ZenIV.linux.org.uk> <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com>
 <20191011001104.GJ26530@ZenIV.linux.org.uk> <CAHk-=wgg3jzkk-jObm1FLVYGS8JCTiKppEnA00_QX7Wsm5ieLQ@mail.gmail.com>
 <20191013181333.GK26530@ZenIV.linux.org.uk>
In-Reply-To: <20191013181333.GK26530@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 13 Oct 2019 11:43:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgrWGyACBM8N8KP7Pu_2VopuzM4A12yQz6Eo=X2Jpwzcw@mail.gmail.com>
Message-ID: <CAHk-=wgrWGyACBM8N8KP7Pu_2VopuzM4A12yQz6Eo=X2Jpwzcw@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2019 at 11:13 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Umm...  TBH, I wonder if we would be better off if restore_sigcontext()
> (i.e. sigreturn()/rt_sigreturn()) would flat-out copy_from_user() the
> entire[*] struct sigcontext into a local variable and then copied fields
> to pt_regs...

Probably ok., We've generally tried to avoid state that big on the
stack, but you're right that it's shallow.

> Same for do_sys_vm86(), perhaps.
>
> And these (32bit and 64bit restore_sigcontext() and do_sys_vm86())
> are the only get_user_ex() users anywhere...

Yeah, that sounds like a solid strategy for getting rid of them.

Particularly since we can't really make get_user_ex() generate
particularly good code (at least for now).

Now, put_user_ex() is a different thing - converting it to
unsafe_put_user() actually does make it generate very good code - much
better than copying data twice.

               Linus
