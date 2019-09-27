Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD67FC388F3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB83A217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mp3UDsZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfI0SKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 14:10:38 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:36104 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbfI0SKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:10:38 -0400
Received: by mail-io1-f53.google.com with SMTP id b136so18672059iof.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYk9mRIq/jh9VV5noRENjJQsBnI4Smg5QE7TL9jRjao=;
        b=Mp3UDsZOTz8bsKP10tTFd6YfBAMN8ENDSpF6d8hkAB4m0QJGlsP6hQAuwAC4KqqO/A
         +G2OHxdppJ2FsJ92wdtJqi40gnR1ZVo4z0O9vgxlvkssW6XlSQdkW8se/QQK8bKobCx0
         MZzzIyIHv/1BYixVnxckE+DmM4+t/1eQdjJZ2pGL24yIz86Q2AOMg7Fc7Mds25n+fWel
         pVNqBYTP5IHK5FoQ0QiBcev3eBc7B1ZMM8XfAg0uJ4xBmgSzQkvI/gkcC8NSzznsul2Y
         kcpbIs7xzjp8p644iEeOKZ0AkynXv8zofY2JDTMYh4yvPWXdN9Kid5z8c/jMGsx6UWul
         s+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYk9mRIq/jh9VV5noRENjJQsBnI4Smg5QE7TL9jRjao=;
        b=JZu+Xt+mZCJ/981ItzbEyNIPAcxTJ9SDvAx6QF+UfH7M6QFQIfehldQajSzba3oZ/w
         RS6fWJWx+zQJvLBvtbCbB8dbRsEZMFJrAubKsMJrxSGvlRMxsCDxEJPY56b7Zj73PK9w
         +rwnPvhBmBfV/ZcchWSlW5daCgPB6vAXQsc2xeHjoOs7EeKKl0x/5+0sFBTKy9NBipki
         ojj+Qd1FEf7iI3SQ0DKBH0SDWXMGe1sX8jqpDTiDjNforGmf9+gHRmxP5YaQmra5hF8h
         jquNKHGNgxfQe4e0OAQl4uhVgJ/d2dckuWBwpr7IM8kYsS2SKqurKrJ/qKJLBZAI8dRq
         wxmw==
X-Gm-Message-State: APjAAAXDkB4KQUTP92OJjj5y/xt93noPhHlDjtGO5x/J1kAW927RZy+P
        4cfQB38Cu+l3K8bwpBowstI9PR1m/FZReYtiL0gP0nRX
X-Google-Smtp-Source: APXvYqzYtIW8RWj3bdieK8wgYSUW8tStp9tdO2aVLkSp/Y2NjItqiRAPv6GUjiQP7REWRp4BXNbGPS/VLlsVe37Kc1E=
X-Received: by 2002:a6b:720a:: with SMTP id n10mr9320899ioc.64.1569607837423;
 Fri, 27 Sep 2019 11:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1909101402230.20291@namei.org> <nycvar.YEU.7.76.1909251652360.15418@gjva.wvxbf.pm>
In-Reply-To: <nycvar.YEU.7.76.1909251652360.15418@gjva.wvxbf.pm>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 27 Sep 2019 11:10:26 -0700
Message-ID: <CACdnJuvi=MgSxatpKOrENzU-By0T3_dxGV6Gb2qEQuhb+B1B8A@mail.gmail.com>
Subject: Re: [GIT PULL][SECURITY] Kernel lockdown patches for v5.4
To:     Jiri Kosina <jikos@kernel.org>
Cc:     James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 7:54 AM Jiri Kosina <jikos@kernel.org> wrote:
> Seems like this didn't happen (yet) ... are there any plans to either drop
> it for good, or merge it?

rc1 isn't out yet, so I'm just waiting to see what happens.
