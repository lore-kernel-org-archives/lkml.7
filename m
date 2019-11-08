Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE9FC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48B4206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573234756;
	bh=9+XypJzcXuWZ9IZHORgHVbOUGiNiPdtVfZoUTZCouOo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zTSoLC2Q/Fvkdg55doCSrOdhTd740QQfchzPg52dvCYRS/tUDVwI8v7yLpBlHePCE
	 OM4TpA4Z7kJqVtcERy4aGtgc5+37+RufWqmKehDycOUPl2WgGMJj72wByG7ShY8ogB
	 Qn9CXlcCDZpdjxy3MfVzQz2oz+QIvSp7u6/mLpss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfKHRjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:39:14 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37527 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfKHRjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:39:14 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so5085279lfp.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 09:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X0HyUPs5wRItBK7m6Cq2qgQoPBnwk/wYZPQ6kr3orrA=;
        b=cNIrikGewcX3TfzGA7DTIDVQAsE0zbz7keQN8vCX7RCd/Hv905PLymolBEW+BYQraJ
         sWDYisbWpxTssmp2D2YezzJf3kW7bs+FdM4VtnlBu+i15ynPCQAQkhBEXHKASRmGjNQF
         u2eTspzbiv17j9VBNXqDv9laIVCLfAQXMtCS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0HyUPs5wRItBK7m6Cq2qgQoPBnwk/wYZPQ6kr3orrA=;
        b=JKOGKYXtPuBmwLD+48tw6RG22hiHuj1jLB+JSHMP2tpHqwH2CSe6So4hc5Qj8ZBl8g
         ytGE//abWx+NOpDti2a++hzd6yck4Lx4HK8LpbGAsrK7urbtzu1j9eangYAaJ6de6yjy
         F2rRM+/xV2zcQFOoOumNh6+Q6V/anQMn5djyyu6ISvzYVMJ2PHGrxfqHahdHZW+AZixU
         m0Zg3Wwljn9JYk7DWsXvzcoXdsS/zFY7Bljcd+V/mj1obnQQrfEjL/hDHaj1jIKBXW1T
         eiwadYCiFUPxzQA+xvP9zDyTTkLnDKKGIq/BMAPtNmYd7CPLLbpP/b9DlhfA5WzNoDv2
         Ue+w==
X-Gm-Message-State: APjAAAW9WaJuRH+J/uSjfnM+84daDN/jo3dKjSTuO71iDZeeBI7Y+X1x
        MUdJdhmz6pR+mKv4/60EWDiJykTQz9Y=
X-Google-Smtp-Source: APXvYqyvL/HsydHeRTameY+WAIou/saAYnsFKpAyRk71SMAl6OLJ7NwEhRkoSnbXyLtRFV71TnYlgw==
X-Received: by 2002:a19:fc1c:: with SMTP id a28mr7410747lfi.170.1573234752109;
        Fri, 08 Nov 2019 09:39:12 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id w11sm5024953lji.45.2019.11.08.09.39.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 09:39:11 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id j14so5064594lfb.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 09:39:10 -0800 (PST)
X-Received: by 2002:ac2:5587:: with SMTP id v7mr7485443lfg.79.1573234750371;
 Fri, 08 Nov 2019 09:39:10 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
 <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com> <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com>
In-Reply-To: <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Nov 2019 09:38:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com>
Message-ID: <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Eric Dumazet <edumazet@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        Marco Elver <elver@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 9:22 AM Eric Dumazet <edumazet@google.com> wrote:
>
> Ok, so what do you suggest next ?
>
> Declare KCSAN useless because too many false positives ?

I'd hope that there is some way to mark the cases we know about where
we just have a flag. I'm not sure what KCSAN uses right now - is it
just the "volatile" that makes KCSAN ignore it, or are there other
ways to do it?

"volatile" has huge problems with code generation for gcc. It would
probably be fine for "not_rcu" in this case, but I'd like to avoid it
in general otherwise, which is why I wonder if there are other
options.

But worst comes to worst, I'd be ok with a WRITE_ONCE() and a comment
about why (and the reason being KCSAN, not the questionable
optimization).

           Linus
