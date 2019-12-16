Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2CCC2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48ACE206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AP+6nl7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfLPO7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:59:16 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:41387 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbfLPO7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:59:16 -0500
Received: by mail-pf1-f173.google.com with SMTP id s18so5723210pfd.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 06:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XzX7HvMfI+FbqPlfhV2QEZ5DIKSU6MexUmhq7WHK0dY=;
        b=AP+6nl7PXq2jPyHPmfVoAai/3dvZ2JGyHbWEgYA57PvuUUSNGrk9aiHkCoGvOMjEA0
         7EAhnsqCTnRXchkXmlN7Ql5FE994ua5b2QJuWKTZbLN9R7YSN7F6LboUuZvCNvQawF/z
         8jsgPl3quzgQzmwCHbJRpWeiruGAFCVBl9cZXV4nQ1L1dyGKgEStEsdhx9VsCS6t+eFA
         uijFdZcAWu3UEIjszbUfp8XHQA4MmEkzJmBFGwsv0FJZqEWbCWrb3vtk/tPPA3nDha4H
         dm79PR0l44gSvyyB2kusAPzCDCw4wnfiMdXV+teaCfhrZjAa++jIMtqUpeuH50+rdNY5
         i7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XzX7HvMfI+FbqPlfhV2QEZ5DIKSU6MexUmhq7WHK0dY=;
        b=lGxeukaqrPvUbJEAv6667kYtoTDv21rO4tU8jgThDXkpn4x3g/9l1HLr6dpu0a7dSh
         M6WvQ5IqyQniQLCa821RCcHdv0pYt172x0ev8JxWC6n6QFU7dmKJiQkn1bmeIESny6DN
         hYVXWoUQdT66FyryxX+7MbkCDDwYEOC0drXUtebUfkp77ZpCcCJb9LBNZ4vNCYRSEA7f
         4IK+KCzuuC9gqF70qzBGaW+gw1J5eMqjzxlzk8rGfsVjQQwx3s3N58pzZ3/OlkBV8zXL
         s8WAmndF7FgEcpJuCGJl92JbJ95MqqgZRm76l5KrtL1IzWBTo8QIRYu4yO+oUudug5c2
         QAbg==
X-Gm-Message-State: APjAAAX2X8F64XaHtp8YLBfhxR6+P4G9uwl0H+g/U7fijwwAbwkCAGN1
        wUaOptSWsr95NFslctInE060Y1leiGMKhQ8usMHdNOq8
X-Google-Smtp-Source: APXvYqzAWcJn/GX3RpowzTZXhFl+J7gwVSc0Vb1CNqW2dSxEB0yUnbpdoQqq1NY4OZ+rgF482f6/S7WksE+b5zSKIz4=
X-Received: by 2002:a62:1d90:: with SMTP id d138mr16122258pfd.93.1576508355707;
 Mon, 16 Dec 2019 06:59:15 -0800 (PST)
MIME-Version: 1.0
References: <CAAeHK+xSWEFUA7DQyhm90uiwggx60gYa8q7QqzOWp7DX_xWSWg@mail.gmail.com>
 <Pine.LNX.4.44L0.1912131448080.1332-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1912131448080.1332-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 16 Dec 2019 15:59:04 +0100
Message-ID: <CAAeHK+yz3dtfx0Jfd4sbOcN8tSxp8+qAvW609sP_yJC5q6vq8A@mail.gmail.com>
Subject: Re: Re: general protection fault in usb_set_interface
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+7fa38a608b1075dfd634@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>, mans@mansr.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 8:51 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, 13 Dec 2019, Andrey Konovalov wrote:
>
> > > > Let's retry here:
> > >
> > > > #syz test: https://github.com/google/kasan.git f0df5c1b
> > >
> > > This bug is already marked as fixed. No point in testing.
> > >
> >
> > Hm, that explains some of the weirdness. It doesn't explain though
> > neither why the patch was actually tested when Alan requested it nor
> > why syzbot sent no reply.
>
> In the meantime, is there any way to get syzbot to test the new patch
> with the old reproducer?  Perhaps tell it to re-open this bug?

No, we can only test this manually now. I can run the reproducer for
you. Should I revert the fix for this bug and then apply your patch?
What's the expected result?
