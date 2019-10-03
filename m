Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C20C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B12221D81
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTJpoTkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfJCHtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 03:49:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39632 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfJCHtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 03:49:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so1827532wrj.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 00:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=tfJ+fSjVM6aGp3m7YJqRWw/1V9xilNyc1D283NJsKpw=;
        b=dTJpoTkrUan/y6Rx0W44iWGEbiExxF+eE+IL+jJhOy1GKC5ePlp/aMhwkaMc9B0Xm4
         oXDI2FGnI0ETOVKeEmCEkQWzIV7JRkBmPuf1kFcFpR+n3TOLhGMsR8sdiXTbi/S6f+WS
         0ucRV4toDwJwm0pCFd6VImVkV4ZV3evRiqVnTftAWpN2fFDcUP2X7Cl5bnXjFmoTlY3H
         rUtQ68zUQbwxkBf8wCDIYqezlaYDItXx6uhXOHLFSaZhNAQEE2YAZOc0LHT5wNSymtXt
         ZFzDkg/0k2LF9ZVKy5Km2oXIAd60tQsBHAnFYXulLRNOyHAaMr4nhkcJ/SDw/1uhf/tV
         gBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=tfJ+fSjVM6aGp3m7YJqRWw/1V9xilNyc1D283NJsKpw=;
        b=f9+uKn05CeYm0DKlu8L61bSElxrmGA50LoA5pfU2X4k76Mwp45z2vOWv3LqS9kpX1y
         Vhog8WHi+yrE4ntIXMKm4+rpLyda+gOdX0Jei5vQYiW6lVj9kGxIjuDXi4dRYtja15a5
         XLq9dOCbOVYO2TpPwTmEF2jXkMqFnpGeBj7Vj4/VkKUKwxtx2KIufFcz5faiPs2KXB7x
         OtlMIQncRH0wdO2oY+5NxGQVAwALxN+27X8+HmJ3TveR19Xrjk1YjB/HRFDwIt+zJ6mN
         tyAMFEN/35E1Oolfl6auBB3h47Bb5GP5H3n7hOD1ACy+jW0jl08MMf8WtsiUedAfaXk0
         7Ruw==
X-Gm-Message-State: APjAAAVUE0xg0bfh/UtWcjeHeHIV1H4Xtd2/qWyzOVLumIf3HmM9tkat
        8i+9UiHCFLcuNvVMD/5n100vGNbkoltVf/sSMc7Sat8A
X-Google-Smtp-Source: APXvYqyJDhbxsS56svW3J2fJELUnQ3s9zwduff5RYiGWYXaWydqn6wqhI+nyALkIxnJoJgxPQ/H9Yq2PjTRNN4HJbnQ=
X-Received: by 2002:a5d:5229:: with SMTP id i9mr5940537wra.76.1570088978264;
 Thu, 03 Oct 2019 00:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUW9wrOAtEEXUNjHetq238D86c9c_Cf0iKQGiD+CH5bJrg@mail.gmail.com>
 <20191003074119.GA1815771@kroah.com>
In-Reply-To: <20191003074119.GA1815771@kroah.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 3 Oct 2019 09:49:27 +0200
Message-ID: <CA+icZUWPkK8vsR_Wm6v=+davoFAaOsEay_siVj2BZjmnVioCjw@mail.gmail.com>
Subject: Re: [Linux-5.3.y] Versions in stable.git and stable-rc.git
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 9:41 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 03, 2019 at 09:38:27AM +0200, Sedat Dilek wrote:
> > Hi Greg,
> >
> > I see two commits with "Linux 5.3.2" - in [1] it is tagged but there
> > is a second one in [2] - both in stable.git.
> >
> > In stable-rc.git I see a commit "Linux 5.3.4-rc1" and there was no
> > v5.3.3 released before.
> >
> > Can you look at this?
>
> Known issue, please see the announcement I made where I messed this all
> up:
>         https://lore.kernel.org/lkml/20191001070738.GC2893807@kroah.com/
>
> thanks,
>

I have re-read this announcement but did not get it.
Will there be a v5.3.3 or do you jump directly from v5.3.2 to v5.3.4?

- Sedat -
