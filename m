Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C748C46470
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 05:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F1D27BA1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 05:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AuDvbJR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfFCFUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 01:20:48 -0400
Received: from mail-it1-f173.google.com ([209.85.166.173]:51952 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfFCFUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 01:20:48 -0400
Received: by mail-it1-f173.google.com with SMTP id m3so25348254itl.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 22:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WLqb9lzllH51vODwbKirEsKH2Zaem62+62kV1ROkpBk=;
        b=AuDvbJR+WQPLdfJ95q2QB4kr1wjZqpbRlfgEJ2k/jg6ey4Qz5EgaBXQ1j7gV39SKAn
         eoP00HQpDvbEt+ajoLB6kabXPL0llL99ikdbv8ZHd8+UxEgL1ciwSUVdko9NIGg74CSB
         JqLHR82cnNtAamTkNX80THJfnA4RaY/97+bXGybOKBfxL0HtIwgD+qjYBst+jIT+yeDb
         UU9EIMSIM++tPG8+HOunHKotL8MKGiSuP/KtYX0FnDIviZj5qDCP1SKbZg/YK1s5MNzp
         4X6Z04MjpOKVl3fMOIkdciMHMFWxf2hvqGuIYBFDeb11zOh08CKqWJ1aW2vQN6bLk2l5
         2y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLqb9lzllH51vODwbKirEsKH2Zaem62+62kV1ROkpBk=;
        b=MO4OeWS3Sv9w3g+jfBWCFGpX//lzYjvH+9ISjbUO5YcdEULvwANRcbXMKJm/SJB1RP
         AVX0GOHM42DxX+lUawqg9dLFJC8ybxzepXO3XDJrbA96XwK/VNo2gePMpzkwesUNyEum
         +IM0pk1VxNpjj2Gsv8qoYyMC3ztcTqqPf11zQ/mfLCyB6rCWXn5RkGUYFvAsM3sSsn0l
         4LmoQyJY8zXOz6yJNkGbGq1RW1magTtCNq9x/pVHRYJrhw5nJvwiwBsezArtECrNrR3K
         ASs225muJjiA6CmUoPgKYBqMxUKJFsodThYeKhwxTUjFIiCM2OlJbUdStaN61y3tizsg
         CwWQ==
X-Gm-Message-State: APjAAAV7KnqIt7syVKEPr8AhL3yonsAHjndhNstIKqu1HFE6NpvM3Ctp
        6j2h/y7Y2GGXxn2AKxfi2POAAup/QXzhhLJ/uIUWnA==
X-Google-Smtp-Source: APXvYqzcTIOOyY1SqkMZ7PLOyIMYJeR6UGPJ/82VlqIilUZqtVwvf4mcLy/2WuWN8lMk3O/Ef/H+g77Ik69S39VJ8d0=
X-Received: by 2002:a24:9083:: with SMTP id x125mr9248429itd.76.1559539246962;
 Sun, 02 Jun 2019 22:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000927a7b0586561537@google.com> <MN2PR18MB263783F52CAD4A335FD8BB34A01A0@MN2PR18MB2637.namprd18.prod.outlook.com>
In-Reply-To: <MN2PR18MB263783F52CAD4A335FD8BB34A01A0@MN2PR18MB2637.namprd18.prod.outlook.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 3 Jun 2019 07:20:35 +0200
Message-ID: <CACT4Y+aQzBkAq86Hx4jNFnAUzjXnq8cS2NZKfeCaFrZa__g-cg@mail.gmail.com>
Subject: Re: [EXT] INFO: trying to register non-static key in del_timer_sync (2)
To:     Ganapathi Bhat <gbhat@marvell.com>
Cc:     syzbot <syzbot+dc4127f950da51639216@syzkaller.appspotmail.com>,
        "amitkarwar@gmail.com" <amitkarwar@gmail.com>,
        "andreyknvl@google.com" <andreyknvl@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "huxinming820@gmail.com" <huxinming820@gmail.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "nishants@marvell.com" <nishants@marvell.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 1, 2019 at 7:52 PM Ganapathi Bhat <gbhat@marvell.com> wrote:
>
> Hi syzbot,
>
> >
> > syzbot found the following crash on:
> >
> As per the link(https://syzkaller.appspot.com/bug?extid=dc4127f950da51639216), the issue is fixed; Is it OK? Let us know if we need to do something?

Hi Ganapathi,

The "fixed" status relates to the similar past bug that was reported
and fixed more than a year ago:
https://groups.google.com/forum/#!msg/syzkaller-bugs/3YnGX1chF2w/jeQjeihtBAAJ
https://syzkaller.appspot.com/bug?id=b4b5c74c57c4b69f4fff86131abb799106182749

This one is still well alive and kicking, with 1200+ crashes and the
last one happened less then 30min ago.
