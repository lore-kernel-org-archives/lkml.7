Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE12C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A938920B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qp4Qkf6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfJJPjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:39:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33708 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfJJPjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:39:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so4168904pfl.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JwdlgT8hDAqNnvsbqVOgYcsV//b7oTzDiaICevRMAZs=;
        b=qp4Qkf6UajxvdDRvinUc90yAtXwFc46gs1Wuf8ED91eEP20YKAQnI3j4i2AK1O4tji
         KEq1bwkYRgc3Frpn/qJWtCZpGfxqsrHZ/9ibYaSelAK1KYZu+J9MRuCf49oA++W21p9B
         69j6tC/ALqhDfcTKsaAc8git9bEtQhTpm6SxgrW+W2mM8WCzd/2K/s6Ij6lhD8BdEq+K
         rmMdn5q4fFF6euUh6T9QMKVRYFyZANB7fM+ljcuSa9qS/1f2p2d+yf6YvyGXOBNP8J8x
         V8QOdLAP58XwqQ1mPn0K3P1r2jCnlHeO5O/LQbhFN+8XpQ5o2G+6ZBkQX1a0Z6Va3qx+
         oroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JwdlgT8hDAqNnvsbqVOgYcsV//b7oTzDiaICevRMAZs=;
        b=sFnIIaRoxunoJuGD+wXjPReRnusCWHsEyJHoYSlHcP2TRCIeolWdwBxnV0RaXw5lGD
         /Q6JEhOGEnISWFzb7JX04ZeahmRWLD0DH39ynWq0fvJZdGsuUYT1VxDSdTehrK/Sq65P
         V1CZ7UWGWcv5sETitxGOdXnveGhm+BYNBW6ntTJicPXbTqwwepRDannvPOy2kfIrP/W+
         V/x4ouftfj/MrApaheUyWQDiICw4+1Y8uFp5XbqSdk3IpewGhw7XCzMp9qLswuXt5gsx
         b186UvOvlLThr3F2B23+JBCSdJH7rne3REXvQzi6eCA8BU7wStC+9zFn4439keQ9Z8Re
         VyLw==
X-Gm-Message-State: APjAAAXlYqLPm19YAyUaumoat8WETiAERZkD1WglQp8qTj2tC8D13RRd
        bxMtgsIAfG55Cwjm6kvlRUIfkriah67vS84CqI3EXQ==
X-Google-Smtp-Source: APXvYqw+JkpVmRn96tTeYYk+vPQV8eH0uQ37XfYipDQdUqOxhO2+fBUA7TpKmtXOohbzHWV15NvBj4eLKg1WtPjIMxY=
X-Received: by 2002:a65:4c03:: with SMTP id u3mr11798981pgq.440.1570721973285;
 Thu, 10 Oct 2019 08:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <Pine.LNX.4.44L0.1909191639240.6904-100000@iolanthe.rowland.org> <000000000000f8d8a10592eed95f@google.com>
In-Reply-To: <000000000000f8d8a10592eed95f@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 10 Oct 2019 17:39:22 +0200
Message-ID: <CAAeHK+zRkoOje-irNLB-_0Vtgr1_Af-rxPv+=_8P3pqNd+YHQw@mail.gmail.com>
Subject: Re: KASAN: invalid-free in disconnect_rio (2)
To:     syzbot <syzbot+745b0dff8028f9488eba@syzkaller.appspotmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Cesar Miquel <miquel@df.uba.ar>,
        rio500-users@lists.sourceforge.net,
        Alan Stern <stern@rowland.harvard.edu>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 11:44 PM syzbot
<syzbot+745b0dff8028f9488eba@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger
> crash:
>
> Reported-and-tested-by:
> syzbot+745b0dff8028f9488eba@syzkaller.appspotmail.com
>
> Tested on:
>
> commit:         e0bd8d79 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8847e5384a16f66a
> dashboard link: https://syzkaller.appspot.com/bug?extid=745b0dff8028f9488eba
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=15b3efc3600000
>
> Note: testing is done by a robot and is best-effort only.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000f8d8a10592eed95f%40google.com.

#syz fix: USB: rio500: Remove Rio 500 kernel driver
