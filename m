Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BC6C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 03:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6B820717
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 03:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uE5pe7sO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfE1DJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 23:09:55 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:57641 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfE1DJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 23:09:55 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x4S39nLf002337;
        Tue, 28 May 2019 12:09:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x4S39nLf002337
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559012990;
        bh=uWT5fShwqInjaT6o22313iPswiC4Q+OA0z7Af+shI0Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uE5pe7sO92IYEusngvjUhtjKYkbTQqMHhFGF0Y3Gh67ejuWhks9yQa8A3JO+BB1m9
         ybSN1nxnJ4+B1keEi10a7whOUnsUEOLw6A9+L3AeX3/Mdtqhs0l1JKkxD0PDJt0TtP
         dm+UbE3hLoetwqrtmGW0xwxEcIZ3ueI61IfA2JbsK7rLqT7vCRVx5pPQMwDMtW0wLW
         d720F8ANoFBaD15YGQX6R4j2JY2VyJVe15bo9aHuVui3svUcIKWIf2jP3uvn8HVSXi
         sopak7rVzgNUs3GWl5EX7MtZqknskd3kTehIqaEdFbjcKOqtbZUATYWeMKRJ8+xIK5
         5UB2eumz+SLFA==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id q13so11871993vso.2;
        Mon, 27 May 2019 20:09:50 -0700 (PDT)
X-Gm-Message-State: APjAAAV8uikEKcpxAuLXociPexD3W0RibX++StEkWPPw4fHbmv0IxY+8
        iTibTumAt5uWjRh4zogHKqFcoMwV5FJuRErzrBU=
X-Google-Smtp-Source: APXvYqwMOYmrGQCdXno9xocJnA5lTaEYU9oue5phPSpivTII7bELv7Rc+FkhIOzkfs4nTWdyi3FLNNq2VlE6Eh5O9oE=
X-Received: by 2002:a67:1783:: with SMTP id 125mr51778795vsx.54.1559012988920;
 Mon, 27 May 2019 20:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190521044456.26431-1-yamada.masahiro@socionext.com>
 <20190522170848.198ccea6@endymion> <d5b1d8f4-af0a-03e7-8480-3caf593214ee@roeck-us.net>
In-Reply-To: <d5b1d8f4-af0a-03e7-8480-3caf593214ee@roeck-us.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 28 May 2019 12:09:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT6Ctms0um5LybNP9nG3fZ+cQxoDcnoqgCjr8q1aCcq0g@mail.gmail.com>
Message-ID: <CAK7LNAT6Ctms0um5LybNP9nG3fZ+cQxoDcnoqgCjr8q1aCcq0g@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (smsc47m1) fix outside array bounds warnings
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.de>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 10:25 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 5/22/19 8:08 AM, Jean Delvare wrote:
> > Hi Masahiro,
> >
> > On Tue, 21 May 2019 13:44:56 +0900, Masahiro Yamada wrote:
> >> Kbuild test robot reports outside array bounds warnings:
> >>
> >>    CC [M]  drivers/hwmon/smsc47m1.o
> >> drivers/hwmon/smsc47m1.c: In function 'fan_div_store':
> >> drivers/hwmon/smsc47m1.c:370:49: warning: array subscript [0, 2] is outside array bounds of 'u8[3]' {aka 'unsigned char[3]'} [-Warray-bounds]
> >>    tmp = 192 - (old_div * (192 - data->fan_preload[nr])
> >>                                  ~~~~~~~~~~~~~~~~~^~~~
> >> drivers/hwmon/smsc47m1.c:372:19: warning: array subscript [0, 2] is outside array bounds of 'u8[3]' {aka 'unsigned char[3]'} [-Warray-bounds]
> >>    data->fan_preload[nr] = clamp_val(tmp, 0, 191);
> >>    ~~~~~~~~~~~~~~~~~^~~~
> >> drivers/hwmon/smsc47m1.c:373:53: warning: array subscript [0, 2] is outside array bounds of 'const u8[3]' {aka 'const unsigned char[3]'} [-Warray-bounds]
> >>    smsc47m1_write_value(data, SMSC47M1_REG_FAN_PRELOAD[nr],
> >>                               ~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> >
> > These messages are pretty confusing. Subscript [0, 2] would refer to a
> > bi-dimensional array, while these are 1-dimension arrays. If [0, 2]
> > means something else, I still don't get it, because both indexes 0 and
> > 2 are perfectly within bounds of a 3-element array. So what do these
> > messages mean exactly? Looks like a bogus checker to me.
> >
> >> The index field in the SENSOR_DEVICE_ATTR_R* defines is 0, 1, or 2.
> >> However, the compiler never knows the fact that the default in the
> >> switch statement is unreachable.
> >>
> >> Reported-by: kbuild test robot <lkp@intel.com>
> >> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >> ---
> >>
> >>   drivers/hwmon/smsc47m1.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
> >> index 5f92eab24c62..e00102e05666 100644
> >> --- a/drivers/hwmon/smsc47m1.c
> >> +++ b/drivers/hwmon/smsc47m1.c
> >> @@ -364,6 +364,10 @@ static ssize_t fan_div_store(struct device *dev,
> >>              tmp |= data->fan_div[2] << 4;
> >>              smsc47m1_write_value(data, SMSC47M2_REG_FANDIV3, tmp);
> >>              break;
> >> +    default:
> >> +            WARN_ON(1);
> >> +            mutex_unlock(&data->update_lock);
> >> +            return -EINVAL;
> >>      }
> >
> > So basically the code is fine, the checker (which checker, BTW?)
> > incorrectly thinks it isn't, and you propose to add dead code to make
> > the checker happy?
> >
> > I disagree with this approach. Ideally the checker must be improved to
>
> Me too. I understand and accept that we sometimes initialize variables
> to make he compiler happy, but this goes a bit too far. We really should
> not add dead code - it creates the impression that it can be reached,
> and would live forever for no good reason.
>
> > understand that the code is correct. If that's not possible, we should
> > be allowed to annotate the code to skip that specific check on these
> > specific lines, because it has been inspected by a knowledgeable human
> > and confirmed to be correct.
> >
> Agreed.
>
> > And if that it still not "possible", then the least intrusive fix would > be to make one of the valid cases the default. But adding new code
> > which will never be executed, but must still be compiled and stored,
> > no, thank you. Another code checker could legitimately complain about
> > that actually.
> >
> > IMHO if code checkers return false positives then they are not helping
> > us and should not be used in the first place.
> >
> Checkers are always only providing guidelines and should never be taken
> at face value.
>
> In summary - NACK.
>
> Guenter
>

What you guys repeatedly called "checker" is GCC 8.

Intel's 0day bot reported this, and I was also able to reproduce the warnings
by using the kernel.org toolchain available at:
https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/x86_64-gcc-8.1.0-nolibc-sh4-linux.tar.xz


I also checked "git log --grep=Warray-bounds",
and I saw people were fixing this kind of warnings.
And, I am really annoyed by the 0day bot.

That's why I sent this patch
despite I have no interest in this driver.


Having said that, I cannot reproduce these warnings
by other compilers than sh4-linux-gcc.

So, probably these warnings are false positive.



Currently, I have 3 options I can do:

[1]  I will send an alternative patch to
     clarify the unreachable path for both compilers and humans
     without adding dead code.

  |@@ -351,6 +351,8 @@ static ssize_t fan_div_store(struct device *dev,
  |                tmp |= data->fan_div[2] << 4;
  |                smsc47m1_write_value(data, SMSC47M2_REG_FANDIV3, tmp);
  |                break;
  |+       default:
  |+               unreachable();
  |        }
  |
  |        /* Preserve fan min */

[2] I will send your feed-backs to the maintainer of 0day bot,
    and persuade him to stop reporting this.

[3] I will accept that 0day bot will continue sending this report forever.
    So, I will configure my mailer so that this report
    will immediately go to the trash box.




As I already said, I have _zero_ interest in this driver.

Only the problem I have is, I repeatedly receive annoying reports
from 0day bot, where my patch is not the root cause of the warnings at all.

Looks like you both believe the current code is OK as-is,
so I am not sure you are happy with [1].

I can try [2] first.

[3] is the last resort for me.


-- 
Best Regards
Masahiro Yamada
