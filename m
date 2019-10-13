Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202B7C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 19:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA34C20659
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 19:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570994582;
	bh=Wl8MCecFh3fO3yWh0Vof4cwurTTcU/DdJ88l648v/Fk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OA/cIWsQ9vnO4+rDlLdR4+aH28sCY2oN8dfKZn6kgn3ax/0uFc4sbZEgOl2D+JaBc
	 niY/4SQfydhbr6rrs94nWdXdsv4kPIDZOLZmXtD7HpoLApPCJYQU7TmD54enaFFku4
	 jZ5twVna7nNU1PC/xdH5bm/q5HQf9XT30uYCBwwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbfJMTXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 15:23:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36124 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729486AbfJMTW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 15:22:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so14499883ljj.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 12:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jcke8lUrtb8vhHtb5SzfvLcSsz8Joiz0psIhCZXHclw=;
        b=ALg9ZHg/wXXbWsRVKIX2Tj6yGXeSM+rooiwzW8dCPBNoVNlR1Pig56y9g/E4pjK0L+
         gu3SSubcXh8qX90I1wrsT/Wx79+uX7oPKjAxXF6b1oZab7+Q1pxPOfBG+7OPTSBYKtFP
         Decyu1cQ2EPt4/bb0wu/abfV/QsXzpoC8Lnzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcke8lUrtb8vhHtb5SzfvLcSsz8Joiz0psIhCZXHclw=;
        b=JXzmXczHHMZIP2ymxxvKrS3gTTf5npr9BLq2ukpiUl9YsmD6JDQV3if7UNCCYnMbI9
         gq6MXwAqAXdZW5IDK7ptCgPLwSQicJrpSWaWOervwKNJg2nnLLGvRE99HHvM37ET3rZy
         wsm9XaZoHOm7arDt+oIXENjLF1YySdCA6SlL+VZkFgI55pOayAHk6c3UadXNUvviDV4g
         mgcp9Mq9ib2qVsnmgPlhmrmvLE/oJ7l8Ts2ebWl3GPLYyPomKZEEEiOhx4kQSyJ4LabT
         bAjZa9tXPe3cl14g2GHI91JSZsV7c9fRq+brD3ybq/Zj6dplvaD5vfOTRn5JXuD3+20/
         vtrA==
X-Gm-Message-State: APjAAAUccRM3wanCaI7IWD/ag+y2QPNRLqmxlgTlBhEq6RKJSE6qyIbU
        fynmUOPmAa2tyCw+7FFNx+lzptEjzfA=
X-Google-Smtp-Source: APXvYqw6I+OwbUbvCuXO9HRe1T/d2fFgm2ALVTq3v9BNufnB31mMyAOBVV2a1FwIzsKZAhjuFbTuzw==
X-Received: by 2002:a05:651c:237:: with SMTP id z23mr16645880ljn.8.1570994576230;
        Sun, 13 Oct 2019 12:22:56 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id q5sm3766115lfm.93.2019.10.13.12.22.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2019 12:22:55 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id x80so10309699lff.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 12:22:55 -0700 (PDT)
X-Received: by 2002:ac2:5924:: with SMTP id v4mr15064721lfi.29.1570994574844;
 Sun, 13 Oct 2019 12:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
 <20191008032912.GQ26530@ZenIV.linux.org.uk> <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
 <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com>
 <20191010195504.GI26530@ZenIV.linux.org.uk> <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com>
 <20191011001104.GJ26530@ZenIV.linux.org.uk> <CAHk-=wgg3jzkk-jObm1FLVYGS8JCTiKppEnA00_QX7Wsm5ieLQ@mail.gmail.com>
 <20191013181333.GK26530@ZenIV.linux.org.uk> <CAHk-=wgrWGyACBM8N8KP7Pu_2VopuzM4A12yQz6Eo=X2Jpwzcw@mail.gmail.com>
 <20191013191050.GL26530@ZenIV.linux.org.uk>
In-Reply-To: <20191013191050.GL26530@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 13 Oct 2019 12:22:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJNE9hOKuatqh6SFf4nd65LG4ZR3gQSgg+rjSpVxe89w@mail.gmail.com>
Message-ID: <CAHk-=wjJNE9hOKuatqh6SFf4nd65LG4ZR3gQSgg+rjSpVxe89w@mail.gmail.com>
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

On Sun, Oct 13, 2019 at 12:10 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> No arguments re put_user_ex side of things...  Below is a completely
> untested patch for get_user_ex elimination (it seems to build, but that's
> it); in any case, I would really like to see comments from x86 folks
> before it goes anywhere.

Please don't do this:

> +       if (unlikely(__copy_from_user(&sc, usc, sizeof(sc))))
> +               goto Efault;

Why would you use __copy_from_user()? Just don't.

> +       if (unlikely(__copy_from_user(&v, user_vm86,
> +                       offsetof(struct vm86_struct, int_revectored))))

Same here.

There's no excuse for __copy_from_user().

           Linus
