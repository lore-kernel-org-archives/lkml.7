Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DE1C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185292071F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574268868;
	bh=v9K2RREq+epE3/QQtTe5wMvG9+gFaXJj3kHR9nFJMqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ItGgV443zUXH14yoFk9g9E6NY6VjIAQcXLUDwSH/dL4IJF8KhlHdvqnEDK4oZiuWA
	 MNqyIQ3BD+1OmwLihSm7dYxfwioc8lMrO0+iai9PQoBt3W6efajo98hSSnRjqcTeOA
	 zIvq4cyPlWDAWmWOyV+tsWzd5V4bmSyZwT8pZy2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732894AbfKTQy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:54:27 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38765 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731995AbfKTQy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:54:26 -0500
Received: by mail-lj1-f196.google.com with SMTP id v8so28315069ljh.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 08:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yl/io6zu7qIXmXnHQ/CHwQbhCv2/KHgSYlmLHi4gHj4=;
        b=OrdylVenp1hrzGi9xP9N6Ny5Y4SJ+klzwy7eSqlFKUXk85bhpAOndMra9MpG8P7iSd
         h39hquiHnufr6mmbsANbTeZG+JPIObfeMQg9aFigyICwPP81zn3qjOLp9A2hoiEDLmNJ
         MvkOz1pMb2CztPZWWi/Ox0n2mbxO/cgbtKIBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yl/io6zu7qIXmXnHQ/CHwQbhCv2/KHgSYlmLHi4gHj4=;
        b=GXiPO+V+YBQQOlyOb3PgsUh7VV5ngT2evrsDNZ6U/Gtw3/3zkomMUIL6x1L+30On0H
         QD5IWVbcfBGI6ffcosjE1EXxOXDMRBPW4Rn9S2QYSSvipuIvTQ+ayrjUp7qH1U4h88mC
         +Fa2tX3q7UF1qQU2hVkTiivuWP4ieg/l8p1fVJ7krWGn3MlBvm36uB9IJDR7OqrPgy27
         Up00Hjf4pM3E9vSZEOwYen1XttDLpydud32zu2k/JR0LR7fIYnjCAD0hmd3z0wrl6HAg
         DYRYMyQh8EMHdxRReu6WM1Ql68MoHToklHtfcZsOYCrAN18jLusWFtNhKXQh3KWUJnYI
         LZsQ==
X-Gm-Message-State: APjAAAV1tjadbQI90/ORHYBniqdpKWfEry8/B2+DRM2jl98/+kflnke0
        5ClkJoGJzV+h5D12TijgUkuq4WbHeWg=
X-Google-Smtp-Source: APXvYqyK9mJPTaql1HMPsTan0eV7PCcKAluszHxfqbKMShmUaQVEiyRvLgsieQ1mC9DYlnV9dyYAoA==
X-Received: by 2002:a2e:b0d9:: with SMTP id g25mr3545588ljl.176.1574268864283;
        Wed, 20 Nov 2019 08:54:24 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id c19sm11894513ljj.61.2019.11.20.08.54.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 08:54:20 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id l14so83747lfh.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 08:54:20 -0800 (PST)
X-Received: by 2002:ac2:5a08:: with SMTP id q8mr3781555lfn.106.1574268859986;
 Wed, 20 Nov 2019 08:54:19 -0800 (PST)
MIME-Version: 1.0
References: <000000000000bf6bd30575fec528@google.com> <000000000000e2ac670597ad2663@google.com>
 <CAHk-=wjg0JXgwb6rkFK0q_JvW7YdGpiPtMVWe=YhFK1y_2-F7Q@mail.gmail.com> <14e1a22937ce5a54d94dab04a103e159215fb654.camel@kernel.crashing.org>
In-Reply-To: <14e1a22937ce5a54d94dab04a103e159215fb654.camel@kernel.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Nov 2019 08:54:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgR=8QX6A6iPAzsD-E38t6Uesa45yWLmeTWZTnK0GbRow@mail.gmail.com>
Message-ID: <CAHk-=wgR=8QX6A6iPAzsD-E38t6Uesa45yWLmeTWZTnK0GbRow@mail.gmail.com>
Subject: Re: general protection fault in kernfs_add_one
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     syzbot <syzbot+db1637662f412ac0d556@syzkaller.appspotmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Tejun Heo <tj@kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 8:04 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Could this be what was fixed by:
>
> ac43432cb1f5c2950408534987e57c2071e24d8f
> ("driver core: Fix use-after-free and double free on glue directory")
>
> Which went into 5.3 afaik ?

Hmm. Sounds very possible. It matches the commit syzbot bisected to,
and looking at the reports, the I can't find anything that is 5.3 or
later.

I did find a 5.3.0-rc2+ report, but that's still consistent with that
commit: it got merged just before 5.3-rc4.

So I think you're right.

I forget what the magic email rule was to report that something is
fixed to syzbot..

              Linus
