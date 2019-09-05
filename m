Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9DDC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3302070C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rd8Syujr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388459AbfIEL3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 07:29:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38677 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731402AbfIEL3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:29:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id h195so1561457pfe.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 04:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dwvIUziP4fafPY2JOrWPat/xl7RaGutjpB8YJJC4H/U=;
        b=Rd8SyujrfWfPhmweQ/RJpVjX7e1PVKJ0VbLka9+S335G3HYRFRoBxdeY1BkSk7d56l
         CpSzg4J/QPMDvXevEgvsbeIm2Zcw4AK9XCKCvTQoszi1k2GHkvtc2ZaKSgceUELVOMSO
         HiNAdx2jqp0qcdFzYitX2LA7VBvHqTP/cLYzAC+xSvOXDt6CzB/wXIUbu8/tKHVtWAeu
         qndhi9r7KxCR6gq/NoBh1NftR0yqbfYgluIX/MAqTmdNIZ0iQ2WzgioJ4ktpk61A8e3C
         fIreFqJnN3harixIOCjxhHoUwnSUa5GY/AoTZlkYJnKPw/1Ct29Lw3fYX+uMIqvTD9Y/
         4CMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dwvIUziP4fafPY2JOrWPat/xl7RaGutjpB8YJJC4H/U=;
        b=UN/iTwE6NsqmQ1Vx+0CkIJ8wPJWL+C+X7/gRbkPxUmLQqVeZMWyXkONAFIrz8KVxgi
         1+K66e8t8z6DzdqhoIxfttIOFBrqTSsYyoZnMevoNtMTPMWEFWZqx+JNwjd+h7AOMblz
         BRg45vmoC87T7+eO3YErATRiXMaZo0WyLhA+NWD1/UHOJiZMeHQBxXsUdIxLlhLRATQ3
         t0D3P5sndXlqwZ371KGBif3No+r4NaBVyhJiK4HgdxOGmLPsFIW9hxbI1his/Uzug+JB
         snET8a1Xx+vnDMnyjd6j+WFrQRXFOQ2+B2+KoiXMZXJUf3D+ePMq8EhOgH9VaYGszZmG
         FjFg==
X-Gm-Message-State: APjAAAWsrH5OSfKGFR+XfJvag2o5/1tKXlkVaq3fDybSR9jY3mBzRuk3
        2K0pP/fgEaUDtLfnBtm9cXi4DfJZdbHfVesmZDZWJg==
X-Google-Smtp-Source: APXvYqwnHdnf6mymYYDnuovI2OIh+2HMDn+StpZViGrapDrf3a2ZOlbCfC6vrMHEwUlGjl1xvu5Ub0MThTVq0k0Lh94=
X-Received: by 2002:a65:4b8b:: with SMTP id t11mr2697306pgq.130.1567682948307;
 Thu, 05 Sep 2019 04:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAAeHK+xJrv1hCbO5qOGTBu=c8STo+-obatOGZ4cHkbuhqmEvrg@mail.gmail.com>
 <000000000000a2044d0591cc99b2@google.com>
In-Reply-To: <000000000000a2044d0591cc99b2@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 5 Sep 2019 13:28:57 +0200
Message-ID: <CAAeHK+xVqvBGJ9dXTijuHusJr6vq85DVnKZbHsdyE8-pbWf-9Q@mail.gmail.com>
Subject: Re: WARNING: ODEBUG bug in usbhid_disconnect (2)
To:     syzbot <syzbot+14b53bfeb17f2b210eb7@syzkaller.appspotmail.com>
Cc:     Roderick.Colenbrander@sony.com,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 1:27 PM syzbot
<syzbot+14b53bfeb17f2b210eb7@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger
> crash:
>
> Reported-and-tested-by:
> syzbot+14b53bfeb17f2b210eb7@syzkaller.appspotmail.com
>
> Tested on:
>
> commit:         eea39f24 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d0c62209eedfd54e
> dashboard link: https://syzkaller.appspot.com/bug?extid=14b53bfeb17f2b210eb7
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=12b6944e600000
>
> Note: testing is done by a robot and is best-effort only.

Nice! Let's mark this one as fixed:

#syz fix: HID: sony: Fix memory corruption issue on cleanup.
