Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97456C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E322184C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGbcHo/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfKLBAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:00:19 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34000 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfKLBAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:00:16 -0500
Received: by mail-io1-f67.google.com with SMTP id q83so16815022iod.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 17:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BmeFNsqyXUE+qNZ7+qHePLXkAJYxgUfqMhS7bAy0fP0=;
        b=VGbcHo/QbPPyVfJFqB644O8UZsmTtHDwtBCJjpG0X3Be1IGn8yLkYoGttzovAfRhG5
         fFzwYt85Xvz97ZKx4dzm7WOYaKmCYAhRmJAfmVUn40XWXYGvVtaTZQBtQBTrG6sPcMDL
         Mv/BMPi8XlHS/0zNpYjQw1kmSGaK1YWr9QkrWw6TiFWcw9M7a7AOkXAzd5IoTwLKsZBJ
         9mzYG+nGeD9UVrwhmxRC1RGMojoGqRFvaCr4E1ofeQSk9UwC526J1f56zxHow1kFXMVb
         Ky9W5aqx9mmzqpaGIPQpgJwjK7OfgNPuNQDnwaEgJivTZdk7upK/1lnUEGsAk93BEEqU
         ZLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BmeFNsqyXUE+qNZ7+qHePLXkAJYxgUfqMhS7bAy0fP0=;
        b=aLMjGMyThNdD9ufkkeTyA5FxoVxLHmAEVeMdzwxRY5CmO9FI5ig05rfq08aq+3X4HR
         REmk4kjBkgF24cS/PfQxgr4LnqFdEKOWYAnllul4Z98nWFD9/ZmeUYL+0PBMZVWYPVDu
         +HdKNrnDROQgjdwtran8LDbzIgcRqtcZWW9tifKBSPb8Yj1PGDVpnhlLpOA2qK6+ngne
         N4LN7x3UfnHYqqwLVjG/8niX9GMiItnGQtlgdAl9p17sU88c/U6IIJG/QKDNie1EtGLg
         FUiXrUIn7AMvL1JzpjC/G4awCE7FCqwL69XFGMDTpbEoJKp0vPydVCiVF3ywQjB0zQVj
         a9lQ==
X-Gm-Message-State: APjAAAU1y4MRf1ULQOPk7+R8b44Qb6kh4nJHLACXbxGewOkY8ObFbY/A
        C4SaWD1Fn1vxjlU+ODAzzxg1euK4vIGT8l5PNOw=
X-Google-Smtp-Source: APXvYqwloHifXEJBotkB2F6siswodOLIuBFbfqLPQLrhIzQf+534WX5jtdBvKxYDdk888iYYGfXfSUkmkY+A4D69za8=
X-Received: by 2002:a5d:94cf:: with SMTP id y15mr2188977ior.268.1573520415892;
 Mon, 11 Nov 2019 17:00:15 -0800 (PST)
MIME-Version: 1.0
References: <1573089948-5944-1-git-send-email-cs.os.kernel@gmail.com> <20191111142720.GA587381@kroah.com>
In-Reply-To: <20191111142720.GA587381@kroah.com>
From:   Cheng Chao <cs.os.kernel@gmail.com>
Date:   Tue, 12 Nov 2019 09:00:04 +0800
Message-ID: <CA+1SViCyCb9OPsRpL_4CrkRjcMJeV08298XxAOeb8_hyT_11Ug@mail.gmail.com>
Subject: Re: [PATCH] tty: fill console_driver->driver_name
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jslaby@suse.com, nico@fluxnic.net, textshell@uchuujin.de,
        sam@ravnborg.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        mpatocka@redhat.com, ghalat@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank greg k-h.
1. I guess nothing is going to break with this change, I'm not sure about that
2. why does it need to be changed?
    "unknown" confuse us a little, and we want to know the reason: bug
or some else.
    In fact, it is a known tty driver.
3. finally, I also consider this patch is trivial, but I just expect
"cat /proc/tty/drivers" to be better.

thanks,
Cheng

On Mon, Nov 11, 2019 at 10:27 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Nov 07, 2019 at 09:25:48AM +0800, Cheng Chao wrote:
> > cat /proc/tty/drivers
> > ...
> > unknown              /dev/tty        4 1-63 console
> >
> > ----------------------------------
> > after this patch:
> >
> > cat /proc/tty/drivers
> > ...
> > console              /dev/tty        4 1-63 console
>
> What is going to break with this change?  It's a user visable thing, why
> does it need to be changed?
>
> thanks,
>
> greg k-h
