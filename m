Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AAAC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DE6217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564176947;
	bh=ZBcD0StVseEQ+q/uHLVW9n9ZoOlQoxaOqOKms7K98os=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OJJINSvH7dCl6/mARs0yqP8kZX3FxgxKg4bn7j5cetp7KLGnGTyamEcQ9jVpufu3I
	 GzvFBuwCopg/W1Hc0mSntK/1zryXrRNvkYuH731zPPb1zXMiMAPhDqNRFjlHl0Eq4/
	 NCnOjSkFrzBsB9lOAaZfl2K41zwfVEeRFuOBVEfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbfGZVfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 17:35:46 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40890 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387552AbfGZVfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:35:45 -0400
Received: by mail-lf1-f66.google.com with SMTP id b17so38047331lff.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 14:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cVmcZwFhu0VmRu42g2oqdHVRFxqVWleFTBghf3PdU0s=;
        b=auPaSao4Pu92MrHcL8ri0lwhHW+MxKtMjV1DpxAsA7pVZXiYOWxWxhMCN+yWqE/ApM
         N1RAQkb6zmoRJMBukop8ckoCwrxu+fdsXpdHaXZqjEngnR6ahHT+uJi/+bo3yEWp6UbC
         NE3E48fT2I4XCRhysWOc0g0KiUbHZXwqDqq8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cVmcZwFhu0VmRu42g2oqdHVRFxqVWleFTBghf3PdU0s=;
        b=ElF3HxidoFyqK3h/uW0gUIEMye5KO+y8WKI1qRKILXiQId+4MM+7kDl7Z32+RGw0ou
         IoCFQGTMcqw2Mxm63YnuCDUGTRJWHH2bAu0KkoQhFqPb3iX+86cFA4DWxd6JLUC41BwL
         DsH5Ae8h8qL0Ast1UX7sokhk5HC0MCFuKf//xnBO50y09gHWS9daR9toLb1SFOxcB0Nr
         CU4eSNWMpHH04nLvxilYfCvD9Cl5e5PjOAbxh+nvp9rAx4lu/+5OFNezKN1SJj72FjOZ
         PuLA+/tEaZEvB4Z3ASy6u4L6jvyhQNwmhcGkB/2KYjl4aYPDvA2UZOsGIuHr9OfNci2u
         Wa+Q==
X-Gm-Message-State: APjAAAUhv++FyBMkzVtrB7x0JXmCPrs4VHsQ8/VN20otcq95cwxdmm9z
        3FmhYEoMf9+nnM/dWlvN5dkCwU4ifXM=
X-Google-Smtp-Source: APXvYqwGp8t7UXgs1C+Dp89jFmvqopj1G0w4v/6l22JSVj1t/vGi+XhXHT6xPZp+3xO00keMsuLdfw==
X-Received: by 2002:a19:e008:: with SMTP id x8mr32697059lfg.103.1564176943005;
        Fri, 26 Jul 2019 14:35:43 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 11sm10398226ljc.66.2019.07.26.14.35.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 14:35:41 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id k18so52788343ljc.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 14:35:41 -0700 (PDT)
X-Received: by 2002:a2e:b003:: with SMTP id y3mr51555432ljk.72.1564176941127;
 Fri, 26 Jul 2019 14:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b4358f058e924c6d@google.com> <000000000000e87d14058e9728d7@google.com>
In-Reply-To: <000000000000e87d14058e9728d7@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Jul 2019 14:35:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnM5+FBJuVoxXELvFgecuc0+vW7ibWy4Gc5qJbW8HL2Q@mail.gmail.com>
Message-ID: <CAHk-=whnM5+FBJuVoxXELvFgecuc0+vW7ibWy4Gc5qJbW8HL2Q@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in vhost_worker
To:     syzbot <syzbot+36e93b425cd6eb54fcc1@syzkaller.appspotmail.com>
Cc:     Jason Wang <jasowang@redhat.com>, KVM list <kvm@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        michal.lkml@markovi.net, "Michael S. Tsirkin" <mst@redhat.com>,
        Netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        virtualization@lists.linux-foundation.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 8:26 AM syzbot
<syzbot+36e93b425cd6eb54fcc1@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 0ecfebd2b52404ae0c54a878c872bb93363ada36
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Jul 7 22:41:56 2019 +0000
>
>      Linux 5.2

That seems very unlikely. That commit literally just changes the
EXTRAVERSION part of the version string.

So even if something actually depended on the version number, even
that wouldn't have triggered any semantic change.

              Linus
