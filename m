Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4609C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBBA20830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbfCZIU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:20:58 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46156 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfCZIU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:20:58 -0400
Received: by mail-qt1-f194.google.com with SMTP id z17so13478205qts.13;
        Tue, 26 Mar 2019 01:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01AgOD1FiCLKydD75Ls4KyfhgM8ZPlrxuRYuNZhSbKQ=;
        b=EE1eCYXL/+0kQkWh/mZW4sUnKJmdEUyAchKybHCSUZ0J5dVwXgj2bXV54j79Uw/POH
         hMFBBDwEsChI997LGvYh2oDkSC04EDWuJ4bYibXJAU7G4/zPXQerPaelBqjmRH/+HVt6
         DlGP42p1mSfrFdjii1/Nr34o8bnASz3aU9cRaxQzjM7FSUwPRwPgoaF8SJ5ESuyZ/Blo
         CTDaiKz3zpWoBGfGCafUZBfFNZ349J/HT57oXeSMsGnkcuVDUGZSL5sIbG7dcNGkiLso
         EzbWDNAho3FW6slYCZXSoYaI7Jvca+LEOh1oQpXx+6P8L2f6F9MU8iFFunxzk9hQ5eqO
         0L3w==
X-Gm-Message-State: APjAAAXkkuOWmgTfVGqzttZlPkmZzdXAebQV3K/rVdVzTJPeShsvK9l5
        bNOmKQ39TC9h049M1oU1LaJvM/th21ajeakNqME=
X-Google-Smtp-Source: APXvYqxDn3JoS0wBdQHJaiDBxxOTEI6L/B7mKWWAO6MWPzivdQEVF+jYX6kcpCo5jMoKleOvkOitJcGLpFHXwQJUpsc=
X-Received: by 2002:a0c:b501:: with SMTP id d1mr24804782qve.115.1553588457049;
 Tue, 26 Mar 2019 01:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190322154425.3852517-1-arnd@arndb.de> <20190322154425.3852517-5-arnd@arndb.de>
 <20190326011319.GC29420@kroah.com>
In-Reply-To: <20190326011319.GC29420@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Mar 2019 09:20:40 +0100
Message-ID: <CAK8P3a1u_2gz=UieoNT7yOqSKFvFOXA34CAs7w+qouoQTjqDgQ@mail.gmail.com>
Subject: Re: [BACKPORT 4.4.y 04/25] USB: iowarrior: fix oops with malicious
 USB descriptors
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "# 3.4.x" <stable@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Ralf Spenneberg <ralf@spenneberg.net>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@spreadtrum.com>,
        Baolin Wang <baolin.wang@spreadtrum.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 2:23 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Mar 22, 2019 at 04:43:55PM +0100, Arnd Bergmann wrote:
> > From: Josh Boyer <jwboyer@fedoraproject.org>
> >
> > The iowarrior driver expects at least one valid endpoint.  If given
> > malicious descriptors that specify 0 for the number of endpoints,
> > it will crash in the probe function.  Ensure there is at least
> > one endpoint on the interface before using it.
> >
> > The full report of this issue can be found here:
> > http://seclists.org/bugtraq/2016/Mar/87
> >
> > Reported-by: Ralf Spenneberg <ralf@spenneberg.net>
> > Cc: stable <stable@vger.kernel.org>
> > Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > (cherry picked from commit 4ec0ef3a82125efc36173062a50624550a900ae0)
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/usb/misc/iowarrior.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
>
> This commit has been in the tree for a long time.  It was in the 4.4.7
> release, back in April 2016.  And then it was reverted in commit
> b7321e81fc36 ("USB: iowarrior: fix NULL-deref at probe") as it broke
> systems.  So why add it back, the correct functionality should be there
> today, right?

Sorry I missed that history. The script I used to identify patches noticed
that this patch was not applied, but I did not have a check for already-
reverted patches.

Chunyan, Baolin: it seems the spreadtrum 4.4 kernel got this wrong
as well, by backporting the patch again on top of 4.4.172. Can you check
the latest internal version for this?

       Arnd
