Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5398FC28EB7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF6B20883
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gG2yjrz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfFFLXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 07:23:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41035 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfFFLXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 07:23:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id q17so1314934pfq.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 04:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1KX7rxOBTJggZ5Jpw+qh5GOtx+SmZ2NeqPrKujmHVXQ=;
        b=gG2yjrz9nmCeQyrmhMmRh9xpLACVxI0SQnFgixzlkVCHwGHCVt+jCkpoRnvYc+D0Bd
         fYtE+LEVpv9F+PopmdWzS5GsTBmMIxYA3I0qUCmXrEp7hiD2zItouldYgHzwI74+8GwI
         wNgpYz120bfi7s8aXy05syqZ84zGpByWBI1gYlnhVZkYgW241nx7JI/L5TZpwHu507Ms
         clNLOdHUFICBqdy62YJQyZ1ISIqoPmy1ffimErgixoUfV43nIByo3+g2WgXgPiWdyBkc
         ttFoa1Uy4ejcTj2G6AvswEvJ2kSAQq/zF7ns9rk76JRIKjtI9sCYUfBswAmXp+mkDMLN
         1jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1KX7rxOBTJggZ5Jpw+qh5GOtx+SmZ2NeqPrKujmHVXQ=;
        b=cpKpyJdAH6FGn2/iRanMl9UldufY6x89Xeqi3ZfCBkJ6aeJ+QglffFEmHFcXA9iakJ
         5XBYSljh4RUC71bPz7BTaDaWYCUOPxc+BgPKOJaV4fSXarazfoYyTsdEEvIEM2Qn9mg1
         12084c4OfXaX4sz5kFe+vQ9+rBFrVqfeL62EDPv5KUNZT9cZmB8E6WyrwdryIxP1ADNK
         6ts2kKEtmYfXVAkNMuQOJFvATipAGqf2OlOCOARGGn66ip6Llx6f4/mXxnxKMeeDyu5D
         jjGnEORZ3kwyIjyMiMriyXhjqS2HqcJ18NPwd7xxINSgUEqoTTE8HLiBI0jwgudVFIwM
         V5+g==
X-Gm-Message-State: APjAAAVrSK6H9af9Jy4zsBMGytoRHiITYmIQaeKNuqEBKKHKBe9z6wzJ
        X82DxPuNX3uLG0q4jpLfDTpR2L5i6YX0F9C/hv/jrQ==
X-Google-Smtp-Source: APXvYqydFREgMEMU+AQn3IiEa3czoGuVJrp1IkkDDa66+PMnGnH78dQEzKVhHerbCfURBGvH+0a/triro4n5Xwf8nyQ=
X-Received: by 2002:a65:64d9:: with SMTP id t25mr2933936pgv.130.1559820210239;
 Thu, 06 Jun 2019 04:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000fa11f3058a69d67b@google.com> <1559811234.21928.9.camel@suse.com>
In-Reply-To: <1559811234.21928.9.camel@suse.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 6 Jun 2019 13:23:18 +0200
Message-ID: <CAAeHK+xGsOfKHdW8h5NQs-DQKXUUQW92ERnj5m7P=tvui-ZPuQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in device_del
To:     Oliver Neukum <oneukum@suse.com>
Cc:     syzbot <syzbot+93f2f45b19519b289613@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 6, 2019 at 10:54 AM Oliver Neukum <oneukum@suse.com> wrote:
>
> Am Montag, den 03.06.2019, 04:41 -0700 schrieb syzbot:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    69bbe8c7 usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1684d87ca00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=193d8457178b3229
> > dashboard link: https://syzkaller.appspot.com/bug?extid=93f2f45b19519b289613
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
>
> Will this do?

Hi Oliver,

Unfortunately there's no reproducer for this bug. I've looked at the
fix, but I'm not sure I understand what it does. Perhaps expanding the
patch description would help, as it doesn't make the patch any more
clear for me. But I'm not familiar with this code, so if you think
this change makes sense and supposedly fixes this bug, then please
post it.

Thanks!

>
>         Regards
>                 Oliver
