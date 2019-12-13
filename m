Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295D4C2D0BF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001D5206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B7sZGUc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfLMJFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:05:25 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42093 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfLMJFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:05:24 -0500
Received: by mail-qk1-f194.google.com with SMTP id z14so1122899qkg.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 01:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h8q9Wm8aWVtXxqEWvO1buQUPSO+i3sBYZTuEX4LXTnk=;
        b=B7sZGUc8JMAembbK0ltQ8ygFW5+jdF27WXh6jv4xGx0+SQH8pPq60FfC1rxPPNFSWM
         ynlfSsLwdeE44UAoRgY5Wx9AdrNkg6MAI+FNvmEjDg5BNR10MCd4Hmh/jdZg6Y8Uxjqg
         iKcCDOf3npPlr60ooocTqEfv2KvAicMmKNyP6kZEhZ12i3gnz7yBR881B8lImFTrNiC+
         jGkt+YX8msoEdB9UzmMCcQ6/1jXSFAtsj3Y3fgwEPt+oPfu4WbMR4KoJmdKkTYxbt10Z
         zVx5EYTTNftyuxVnD1xxZi9Lclm/Ka5x1XOXojG35QNi51E25KSUGsdkeKK9W5K9103I
         pswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h8q9Wm8aWVtXxqEWvO1buQUPSO+i3sBYZTuEX4LXTnk=;
        b=qIY1Y1Nttvr3wUZlJ37Wzo4Coekgea7JfEbPNotUAzjsH6X2F+6OFFEi9GVooq4aoZ
         9VfYOlYUXWw/B2ryCd3jgYT3DdhGI8WtjL3RBj0Rh/BJhoPV9/vuJjsgloxvc//bsgpj
         a9ckpNdJpzcv+9SKJrchrElkkxBF9tVF039FQy5QmhAFjDc8h9gDyqV4pAEPS5htRzeK
         fNtPx5lMgpLzs2Ts6fdyw1Z5JlK5s/CeBD1njxVd78kvIe7iHiq/HsqoLuISVfOttD5w
         jQSEr/K+kOzx/T2N8D0rOo9jW11lqdAFxILQEpVvJTkqXitVv2ratZE56rRYXNGP7HWp
         FYhQ==
X-Gm-Message-State: APjAAAUqxq56StYHjI5wenOHfaX5vi1Rej7cvR5gRnM4EVK3kzqBzvLN
        5w2Ji2IY5/E+ynbtU727n9DfoKAx/hoGEJ6z55mCfQ==
X-Google-Smtp-Source: APXvYqwucBZ+KePWjNxfbIQ0iGzvUQbCnGpqVbIzovLpVsu/xVnANjMnnkecD2sqjMx92nOXSoJwmkoHly3Hn7ULSJo=
X-Received: by 2002:a37:e312:: with SMTP id y18mr12834178qki.250.1576227922838;
 Fri, 13 Dec 2019 01:05:22 -0800 (PST)
MIME-Version: 1.0
References: <00000000000044a65205994a7e13@google.com> <00000000000003cc8505994f9036@google.com>
 <20191212105754.GC1476206@kroah.com>
In-Reply-To: <20191212105754.GC1476206@kroah.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 13 Dec 2019 10:05:11 +0100
Message-ID: <CACT4Y+amUGgm178SkrDHef9As5WkNHAyx5U9OdjgkFd-wY2ZqA@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in mem16_serial_out
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     syzbot <syzbot+92f32d4e21fb246d31a2@syzkaller.appspotmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        asierra@xes-inc.com, Jonathan Corbet <corbet@lwn.net>,
        ext-kimmo.rautkoski@vaisala.com, Jiri Slaby <jslaby@suse.com>,
        kai heng feng <kai.heng.feng@canonical.com>,
        Linux API <linux-api@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        mika.westerberg@linux.intel.com, paulburton@kernel.org,
        Peter Hurley <peter@hurleysoftware.com>, sr@denx.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        yegorslists@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 11:57 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 09, 2019 at 05:38:01PM -0800, syzbot wrote:
> > syzbot has bisected this bug to:
> >
> > commit bd94c4077a0b2ecc35562c294f80f3659ecd8499
> > Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Date:   Wed Oct 28 03:46:05 2015 +0000
> >
> >     serial: support 16-bit register interface for console
>
> That would be because that is when this function was added to the kernel
> :)
>
> Again, you are asking the kernel to write to a bad place in memory, and
> then crash when that happens.  That sounds like the correct
> functionality to me...

This looks like:

#syz dup:
BUG: unable to handle kernel NULL pointer dereference in mem_serial_out

Let's continue in that thread.
