Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D42BC47404
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 00:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555B6222C8
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 00:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570320423;
	bh=y6LnQpxxpKAvVv80uNIyvQzHSDSplm9Tq5cs5I531ZI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=r+NPbzs16oGJW8OzWVIUcsmgtlLCRzAlWoz01XPjtJy2Sf3PGUeqyW8scalkM2eh1
	 +BNo4U9wj063Lz6O+uXWE7mftu3WrQAxl9WTQQoy9gEI5h6XuUuPRz81xoe8GLqzWG
	 IXHxq2y9BL4tgdqGyoC7HcAyf/pYOwH9c0sCtQ0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfJFAHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 20:07:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35621 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfJFAHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 20:07:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id m7so10054413lji.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 17:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJ0vvkhrhw2X6n/kDoFhkGHBcz5tnb8C5tNHlfE7BeU=;
        b=SfGlFFoyKKUI8igiv5lDWCKr3UL3AjRt/lV+7TxAWQ0zrg2aZKr9szbeAEDx1WvDSg
         ex5t+wvF42EA1RdR97sdtfv067dP5Ii5YCN7oQxiXQAjbhsLfNdk7I6Z2mu1txBKJTSr
         djuKiXJmWD/WaOcuEGu6i0/a+BJ1hMdC0yLII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJ0vvkhrhw2X6n/kDoFhkGHBcz5tnb8C5tNHlfE7BeU=;
        b=EOIeDZH8H+IvO8CVSrdX6kQs5oWxqSe9Y9ACs68truWzoK5vHrOsJYe/r7EkZ+st/n
         43yDgGYnrDwRODc27+lSvbkemj2dnNsANVlvfMcxTK5x61FqcyLgfVZCpv2iGwzFxtso
         d1yCFm7U2lPzXj9NlaPJhSyA9bfDKbI1a9OUoQNMZR/NdOPfHDJaDMKB2sebA62KPS0I
         JqFmg1z9nQAiacGScyKF9pTXmpePdvz/w33ndGNmaWbBCI9uym8Zv1BSUV6EzJDly2D8
         t15TgtfULBVcfmWJpBkwL5iPskd0wij9WFb3YHRT6lXanzQvWuX2AbqI3ULA2YY4WNB0
         ApRg==
X-Gm-Message-State: APjAAAVWdHeBzznjYn9R4LQfmd2oUS2v4WUUbG89hsDufwdNavz0c7Oj
        04GexO5LIAUgIzV1U+b4L8/paJQlRJ4=
X-Google-Smtp-Source: APXvYqxqLqWtGFGXOcnFtGGO+UBpIrUwqT/mKJl18S0JiVvLmhXFlDaXbN2RJLeAYzFvd7yMFzWCiQ==
X-Received: by 2002:a2e:4e12:: with SMTP id c18mr13494324ljb.47.1570320418361;
        Sat, 05 Oct 2019 17:06:58 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id q14sm2138801ljc.7.2019.10.05.17.06.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2019 17:06:57 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id v24so10045122ljj.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 17:06:57 -0700 (PDT)
X-Received: by 2002:a2e:2e17:: with SMTP id u23mr14140095lju.26.1570320416860;
 Sat, 05 Oct 2019 17:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191005233227.GB25745@shell.armlinux.org.uk>
In-Reply-To: <20191005233227.GB25745@shell.armlinux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Oct 2019 17:06:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjS5uyVNR23sWFk6a1nOXO0wkLh3qttoKNmkGAcV1hOXw@mail.gmail.com>
Message-ID: <CAHk-=wjS5uyVNR23sWFk6a1nOXO0wkLh3qttoKNmkGAcV1hOXw@mail.gmail.com>
Subject: Re: MAP_FIXED_NOREPLACE appears to break older i386 binaries
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 5, 2019 at 4:32 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> Under a 4.19 kernel (debian stable), I am surprised to find that some
> previously working i386 binaries no longer work, whereas others are
> fine.  ls, for example, dies with a SEGV, but bash is fine.

Hmm. Is this with some recent stable kernel update? Or has it been
going on for a while and you only noticed now for some reason?

If it's recent, I'd be inclined to blame bbdc6076d2e5 ("binfmt_elf:
move brk out of mmap when doing direct loader exec") which afaik made
it into 4.19.75 and might be in that debian-stable.

And if it's that, then I think that it should be fixed by 7be3cb019db1
("binfmt_elf: Do not move brk for INTERP-less ET_EXEC") which is in
the current queue.

Adding Kees to the cc, in case he goes "No, silly Linus, you're being
stupid", or can confirm that yeah, that was the behavior for the
problem case.

Kees, original report with more information at

   https://lore.kernel.org/lkml/20191005233227.GB25745@shell.armlinux.org.uk/

And if that isn't the case, maybe you can send over one of the broken
binaries in private email for testing?

                       Linus
