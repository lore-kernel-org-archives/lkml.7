Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCABC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B51204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JmSzOXhD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732390AbfHHM2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:28:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41430 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbfHHM2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:28:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so33648038pgg.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 05:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i/W3w/wF9Y9te3JMoVhcMehzwVrt1opOlejjt4rI4AE=;
        b=JmSzOXhD6xc1Qb7v1wEp0V2tWsNPh5fGFF88h2zu1ElMyG3KgLjylsdyOnqWGZcItc
         tP4YvMgsCHqHZw69kNyc6Rx5xdexwEjo/lVa3NrHAjIz+jGBsC7JjYHIXPlqH00+U9Rj
         vo4g0Iy6lZlXwSvj1LG4dxvGz4gc/mh0fkZaFnckVQDHcmWHPqGX2C9hM5/PiFpv+9tp
         uqJiPobqcNkiB2JdQ5mmWLwuAideQaaIl7SelOD5YfUny7fvj7TURoAR9qIxlNXNxy5x
         HT8InMsW/bOjtbJ9dH1E+229QEILOJtHjCeDt0Xh5O0NaoD+C/jOboe4sQj6NhekP3zc
         yxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i/W3w/wF9Y9te3JMoVhcMehzwVrt1opOlejjt4rI4AE=;
        b=W2Z0Sca3CZ+xmNsy3pHV2n7p9rhEIbIsJ+Rub2qEjJ5FOyqRaqyfzICWJIQZOTp+d3
         rzIvnIxnP5BgJoRm5v+5DFSkIQ93gcnO7+dtMKPTPPGyuOZou87o9cXyVkfP31l2ikUU
         9t/ovZ1sO+RtwOXenVhhlFP3TXUW8ysUhphdBJZcuqe6m8unr2ePYUSgdB8A1oEUiOg9
         Z8NhrE/5Twn3svMy2hOEowve5YkygJudFoBogPuN/Od2Cvo0Cyeu7t3W86r4DOeVYKT7
         int+DcGN3p4m6WTZLUHcn8GmAF8t37x/ydiwDCwLa5Rb/hPuY8F5efHQbDyMhQFyXhtx
         u/Pw==
X-Gm-Message-State: APjAAAXT+Qas01TqCm0C0PaIF9ITtIAb1Z1Ph5IL1U92K+BOhlc9+hAN
        6Agt1kLWh0Hv0+EF7m/8YCOaB+p0z8lEPa1bmWjKSA==
X-Google-Smtp-Source: APXvYqwBefv4nXxVQmf02Ua1Yjn/KM4I7FhvNpXklH3IAgqyIJc+slSG3DgWRSLRO89JnCmOD5IciFA0UJhEIpUeIl8=
X-Received: by 2002:aa7:9e9a:: with SMTP id p26mr15547168pfq.25.1565267285478;
 Thu, 08 Aug 2019 05:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f365b6058f8b07ca@google.com> <Pine.LNX.4.44L0.1908071431050.1514-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1908071431050.1514-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 8 Aug 2019 14:27:53 +0200
Message-ID: <CAAeHK+xh6h=HBEpwPB7g2=a07+zZ9zS5Cuk0Tpo_+70Bf5j9Tw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in device_release_driver_internal
To:     Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 8:31 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, 7 Aug 2019, syzbot wrote:
>
> > Hello,
> >
> > syzbot has tested the proposed patch and the reproducer did not trigger
> > crash:
> >
> > Reported-and-tested-by:
> > syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com
> >
> > Tested on:
> >
> > commit:         6a3599ce usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > patch:          https://syzkaller.appspot.com/x/patch.diff?x=132eec8c600000
> >
> > Note: testing is done by a robot and is best-effort only.
>
> Andrey, is there any way to get the console output from this test?

Dmitry, would it be possible to link console log for successful tests as well?

>
> Alan Stern
>
