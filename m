Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A52C2D0DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 03:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2120A20863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 03:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DU3WNvMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgABDJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 22:09:49 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:47095 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgABDJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 22:09:49 -0500
Received: by mail-io1-f68.google.com with SMTP id t26so37123219ioi.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 19:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/zRNoVfSQWIdIGqBkho+JgQAlRaLk3kS8yRXPy7McZQ=;
        b=DU3WNvMDy2db71Veo5NgVm3w4ZSMD8E8gUt2aobpSnwYCLbyOHwuMLqHKGQJXdWJMA
         IieFfcNunORIvOd6IH/0yoGeIQyBYnimTQIpS+EAcQoYkx0Lt582MknRkuASULzfKQaz
         Gb2LjWAnmNA0KZdvhRvAQaxBrYvNR33G7HSl2SRknrVT6ayz6HAvDoImVuS4CNjpaJPQ
         es6iN69EpEHKuSskJtwt5iTo9Z7q0kHUC3gKxQo1XJW6DIOzPeORgZavaEjmJrQp78F9
         rE83vbA1UVGJywd90dv9RmuGEXTVpZZDbvk7ls6l+SuXUwWP9N/DwycR4CnVPIftyL2Q
         PbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/zRNoVfSQWIdIGqBkho+JgQAlRaLk3kS8yRXPy7McZQ=;
        b=Sl8zslDfqScFogrRiDF4A+1UYsLtvn2YlJq8xkrxIPm/MWeWjendEySRABNiIo5B8+
         TNHsp/FZTuOl8rwaSl6x9eRuc2ex9uioG9ms9CmRLW3KvTl5o1Pl0NQN/41YJNPCBtJJ
         GJ9KU0x/e7lSCLVQrnA20qRnkzWzohcnCwHr2Ot+ClNeUrLDbxHT8iIVej4LbQkbNW8r
         kLoazlsLc7WcA/sMahHo/W4Mxa+bxI6jY6ygTeahL8R5d/2Ih3YURTDcqGek/TzT6U7N
         fh0nSd6D8qSfhEihq1MHEX0H1eLoMB6Hr06kjYV7NLQMWQXyfFxgeOHQOYTD1xb1f0s5
         1oQw==
X-Gm-Message-State: APjAAAU7cGARdByJinMOWj3vmQ7jz3rLGp0rbCyOY++ZAsOAKRzGehY8
        7CQAcm+Am99NuJL0CqlySC5s+RzJ9/JIROdHp64=
X-Google-Smtp-Source: APXvYqwZ5nPNbLirYyrEHYOMdTDqv88ox3on5l6T/Qzo7gN41nhvmAUNtFBmmRFBsCrpPWyrBI6OEk9k0nf+VmOS6cs=
X-Received: by 2002:a02:780f:: with SMTP id p15mr62360863jac.91.1577934588859;
 Wed, 01 Jan 2020 19:09:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac0:9191:0:0:0:0:0 with HTTP; Wed, 1 Jan 2020 19:09:48 -0800 (PST)
In-Reply-To: <CAHk-=whzgLPi4szh8xOKysuS9CKaQESngc=n0omBVpwdQ822aw@mail.gmail.com>
References: <20191231150226.GA523748@light.dominikbrodowski.net>
 <20200101003017.GA116793@rani.riverdale.lan> <20200101183243.GB183871@rani.riverdale.lan>
 <CAHk-=whzgLPi4szh8xOKysuS9CKaQESngc=n0omBVpwdQ822aw@mail.gmail.com>
From:   youling 257 <youling257@gmail.com>
Date:   Thu, 2 Jan 2020 11:09:48 +0800
Message-ID: <CAOzgRdYqqYNU8jyXCu88RLstWhQUANUroQDz71fEjfDoEg-VqQ@mail.gmail.com>
Subject: Re: [PATCH] early init: open /dev/console with O_LARGEFILE
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020-01-02 5:39 GMT+08:00, Linus Torvalds <torvalds@linux-foundation.org>:
> On Wed, Jan 1, 2020 at 10:32 AM Arvind Sankar <nivedita@alum.mit.edu>
> wrote:
>>
>> Also, this shouldn't impact the current issue I think, but won't doing
>> filp_open followed by 3 f_dupfd's cause the file->f_count to become 4
>> but with only 3 open fd's? Don't we have to do an fd_install for the
>> first one and only 2 f_dupfd's?
>
> I think *this* is the real reason for the odd regression.
>
> Because we're leaking a file count, the original /dev/console stays
> open, and we end up never calling file->f_op->release().
>
> So we don't call tty_release() on that original /dev/console open, and
> one effect of that is that we never then call session_clear_tty(),
> which should make sure that all the processes in that session ID have
> their controlling tty (signal->tty pointer) cleared.
>
> And if that original controlling tty wasn't cleared, then subsequent
> calls to set the controlling tty won't do anything, and who knows what
> odd session leader confusion we might have.
>
> youling, can you check if - instead of the revert - this simple 'add
> an fput' fixes your warning.
>
> I'm not saying that the revert is wrong at this point, but honestly,
> I'd like to avoid the "we revert because we didn't understand what
> went wrong". It would be good to go "Aaaahhhh, _that_ was the
> problem".
>
>                  Linus
>

test this patch.diff, no the system/bin/sh warning, fixed.
